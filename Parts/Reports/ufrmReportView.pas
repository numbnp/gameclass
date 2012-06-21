unit ufrmReportView;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  DB,
  Grids,
  DBGridEh,
  DBGridEhImpExp,
  PrnDbgeh,
//  uLanguagesManager,
  ufrmReport,
  uReport,
  ufrmMailSend;


type

  //
  // TfrmReportView
  //

  TfrmReportView = class(TfrmReport)
    grdReport: TDBGridEh;
    dsrcReport: TDataSource;
    pmnuReport: TPopupMenu;
    dlgSave: TSaveDialog;
    prnGrid: TPrintDBGridEh;
    pmiColumnsVisibility: TMenuItem;
    pmiColumnsVisibilitySettings: TMenuItem;
    pmiSeparator1: TMenuItem;
    pmiShowAllColumns: TMenuItem;
    pmiShowGeneralColumns: TMenuItem;
    pmiSeparator2: TMenuItem;
    procedure dsrcReportDataChange(Sender: TObject; Field: TField);
    procedure grdReportSortMarkingChanged(Sender: TObject);
    procedure OnSetColumnsVisibilityClick(Sender: TObject);
    procedure OnAllVisibleClick(Sender: TObject);
    procedure OnGeneralVisibleClick(Sender: TObject);
    procedure grdReportApplyFilter(Sender: TObject);

  private
    // fields
    FReport: TReport;

//    FLanguagesManagerLink: TLanguagesManagerLink;

    // events handlers
    procedure _OnVisibleColumnMenuItemClick(Sender: TObject);
    procedure _OnColumnsVisibilityApply(Sender: TObject);
//    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _TuneReportGrid();
    procedure _BuildPopupMenu();
    procedure _SaveSettings();
    function _FindGridColumnByTag(const AnTag: Integer): TColumnEh;
    function _FindVisibilityMenuItemByTag(const AnTag: Integer): TMenuItem;
    procedure _SetVisibility();
    function _AskReportPrintAll(var AbPrintAll: Boolean): Boolean;
    function _AskReportSaveAll(var AbSaveAll: Boolean): Boolean;
    function _AskReportExportClass(var AExportClass: TDBGridEhExportClass;
        var AstrFileName: String): Boolean;
//    procedure _SubscribeToLanguagesManagerEvents();

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // public methods
    procedure SetReport(const AReport: TReport); override;
    procedure Storage(); override;

    procedure EnableAutofilter(const AbEnable: Boolean);
    procedure SaveTable(const AbIsOpenFilesAfterSave: Boolean);
    procedure SendTable();
    procedure PrintTable();

  end; // TfrmReportView


implementation

uses
  ShellAPI,
  StdActns,
  EhLibADO,
  uReportCommon,
  uReportColumn,
  ufrmColumnsVisibility,
  ufrmPrintQuery,
  ufrmSaveQuery;

{$R *.dfm}


const
  CLASS_NAME = 'TfrmReportView';

  VISIBILITY_SUBMENU_TAG = 0;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmReportView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

//  _SubscribeToLanguagesManagerEvents();
//  _LanguageChange(Self);
  
end; // TfrmReportView.Create


destructor TfrmReportView.Destroy();
begin
 // FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmReportView.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TfrmReportView.SetReport(const AReport: TReport);
begin
  grdReport.DataSource := nil;
  FReport := AReport;
  if Assigned(AReport) then begin
    dsrcReport.DataSet := FReport.ResultDataSet;
    grdReport.DataSource := dsrcReport;
  end else begin
    dsrcReport.DataSet := nil;
    grdReport.DataSource := nil;
  end;

  _TuneReportGrid();
  _BuildPopupMenu();
end; // TfrmReportView.SetReport


procedure TfrmReportView.Storage();
begin
  _SaveSettings();
end; // TfrmReportView.Storage


procedure TfrmReportView.EnableAutofilter(const AbEnable: Boolean);
begin
  grdReport.STFilter.Visible := AbEnable;
  if not AbEnable then begin
    grdReport.ClearFilter();
    grdReport.DefaultApplyFilter();
  end;
end; // TfrmReportView.EnableAutofilter


procedure TfrmReportView.SaveTable(const AbIsOpenFilesAfterSave: Boolean);
var
  ExportClass: TDBGridEhExportClass;
  bSaveAll: Boolean;
  strFileName: String;
begin
  if not Assigned(FReport) then begin
    Exit;
  end;

  if not _AskReportSaveAll({out}bSaveAll) then begin
    Exit;
  end;

  if _AskReportExportClass({out}ExportClass, {out}strFileName) then begin
    SaveDBGridEhToExportFile(ExportClass, grdReport,
        strFileName, bSaveAll);
    if AbIsOpenFilesAfterSave then begin
      ShellExecute(0, 'open', PChar(strFileName), nil, nil, SW_SHOWNORMAL);
    end;
  end;
end; // TfrmReportView.SaveTable

procedure TfrmReportView.SendTable();
var
  ExportClass: TDBGridEhExportClass;
  bSaveAll: Boolean;
  strFileName: String;
begin
  if not Assigned(FReport) then begin
    Exit;
  end;
  strFileName := GetEnvironmentVariable('TEMP') + '\pm_' + FReport.ReportName + '.html';
  ExportClass := TDBGridEhExportAsHTML;
  bSaveAll := True;
  SaveDBGridEhToExportFile(ExportClass, grdReport, strFileName, bSaveAll);
  //ShellExecute(0, 'open', PChar(strFileName), nil, nil, SW_SHOWNORMAL);
  frmMailSend.repFileName := strFileName;
  frmMailSend.ShowModal;

end; // TfrmReportView.SaveTable

procedure TfrmReportView.PrintTable();
var
  bPrintAll: Boolean;
begin
  if not Assigned(FReport) then begin
    Exit;
  end;

  if not _AskReportPrintAll(bPrintAll) then begin
    Exit;
  end;

  if bPrintAll then begin
    grdReport.ExecuteAction(TEditSelectAll.Create(Self));
  end;

  if prnGrid.PrinterSetupDialog() then begin
    prnGrid.Preview();
  end;
end; // TfrmReportView.PrintTable


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmReportView.dsrcReportDataChange(Sender: TObject;
  Field: TField);
begin
  grdReport.SumList.Deactivate(FALSE);
end; // TfrmReportView.dsrcReportDataChange


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmReportView.grdReportSortMarkingChanged(Sender: TObject);
var
  Bookmark: TBookmark;
begin
  Bookmark := grdReport.DataSource.DataSet.GetBookmark();
  try
    grdReport.DefaultApplySorting();
    grdReport.DataSource.DataSet.GotoBookmark(Bookmark);
  finally
    grdReport.DataSource.DataSet.FreeBookmark(Bookmark);
  end;
end; // TfrmReportView.grdReportSortMarkingChanged


procedure TfrmReportView._OnVisibleColumnMenuItemClick(Sender: TObject);
var
  nTag: Integer;
  col: TColumnEh;
  ReportColumn: TReportColumn;
begin
  ASSERT(Assigned(Sender));
  ASSERT(Sender is TMenuItem);

  if Sender is TMenuItem then begin
    nTag := (Sender as TMenuItem).Tag;

    col := _FindGridColumnByTag(nTag);
    ASSERT(Assigned(col));
    if Assigned(col) then begin
      col.Visible := (Sender as TMenuItem).Checked;
    end;

    ReportColumn := FReport.ReportColumns.FindById(nTag);
    ASSERT(Assigned(ReportColumn));
    if Assigned(ReportColumn) then begin
      ReportColumn.Visible := (Sender as TMenuItem).Checked;
    end;

  end;

end; // TfrmReportView._OnVisibleColumnMenuItemClick


procedure TfrmReportView._OnColumnsVisibilityApply(Sender: TObject);
begin
  _SetVisibility();
end; // TfrmReportView._OnColumnsVisibilityApply


procedure TfrmReportView.OnSetColumnsVisibilityClick(Sender: TObject);
var
  frmColumnsVisibility: TfrmColumnsVisibility;
begin
  frmColumnsVisibility := TfrmColumnsVisibility.Create(
      Self, FReport.ReportColumns);
  try
    frmColumnsVisibility.OnApply := _OnColumnsVisibilityApply;
    frmColumnsVisibility.ShowModal();
  finally
    FreeAndNil(frmColumnsVisibility);
  end;
end; // TfrmReportView.OnSetColumnsVisibilityClick


procedure TfrmReportView.OnAllVisibleClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to FReport.ReportColumns.Count - 1 do begin
    FReport.ReportColumns[i].Visible := TRUE;
  end;
  _SetVisibility();
end; // TfrmReportView.OnAllVisibleClick


procedure TfrmReportView.OnGeneralVisibleClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to FReport.ReportColumns.Count - 1 do begin
    FReport.ReportColumns[i].Visible := FReport.ReportColumns[i].IsGeneral;
  end;
  _SetVisibility();
end; // TfrmReportView.OnGeneralVisibleClick


{procedure TfrmReportView._LanguageChange(ASender: TObject);
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, TMenuItem(pmiColumnsVisibility));
    GetString(CLASS_NAME, TMenuItem(pmiColumnsVisibilitySettings));
    GetString(CLASS_NAME, TMenuItem(pmiShowAllColumns));
    GetString(CLASS_NAME, TMenuItem(pmiShowGeneralColumns));
  end;
end; // TfrmReportView._LanguageChange
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmReportView._TuneReportGrid();
const
  FORMAT_FOR_SUM = '"Sum: "#.##';
  FORMAT_FOR_AVG = '"Avg: "#.##';
  FORMAT_FOR_COUNT = '"Count: "#.#';
var
  i: Integer;
  Column: TColumnEh;
begin
  grdReport.FooterRowCount := 0;
  grdReport.Columns.Clear();

  if not Assigned(FReport) then begin
    exit;
  end;

  FReport.ReportColumns.SortByOrder();
  for i := 0 to FReport.ReportColumns.Count - 1 do begin
    Column := grdReport.Columns.Add();
    Column.Tag := FReport.ReportColumns[i].UID;
    Column.Title.Caption := FReport.ReportColumns[i].ColumnName;
    Column.Title.TitleButton := TRUE;
    Column.FieldName := FReport.ReportColumns[i].Field;
    Column.Width := FReport.ReportColumns[i].Width;
    if FReport.ReportColumns[i].AggregateFunction <> Aggregate_None then begin
      if not grdReport.SumList.Active then begin
        grdReport.FooterRowCount := 1
      end;
      if FReport.ReportColumns[i].AggregateFunction = Aggregate_Sum then begin
        Column.Footer.DisplayFormat := FORMAT_FOR_SUM;
        Column.Footer.ValueType := fvtSum;
      end else if FReport.ReportColumns[i].AggregateFunction = Aggregate_Avg then begin
        Column.Footer.DisplayFormat := FORMAT_FOR_AVG;
        Column.Footer.ValueType := fvtAvg;
      end else if FReport.ReportColumns[i].AggregateFunction = Aggregate_Count then begin
        Column.Footer.DisplayFormat := FORMAT_FOR_COUNT;
        Column.Footer.ValueType := fvtCount;
      end else begin
        Column.Footer.ValueType := fvtNon;
        ASSERT(FALSE, 'Unknown aggregate!');
      end;
    end;
    Column.Visible := FReport.ReportColumns[i].Visible;
  end;

  for i := 0 to grdReport.Columns.Count - 1 do begin

    grdReport.Columns.Items[i].Title.TitleButton := TRUE;
  end;

  if grdReport.FooterRowCount > 0 then begin
    grdReport.SumList.Activate(TRUE);
  end;

end; // TfrmReportView._TuneReportGrid


procedure TfrmReportView._BuildPopupMenu();
var
  i: Integer;
  mi: TMenuItem;
begin
  // to remove items for each column 
  for i := pmiColumnsVisibility.Count - 1 downto 0 do begin
    if (pmiColumnsVisibility.Items[i] <> pmiColumnsVisibilitySettings)
        and (pmiColumnsVisibility.Items[i] <> pmiSeparator1)
        and (pmiColumnsVisibility.Items[i] <> pmiShowAllColumns)
        and (pmiColumnsVisibility.Items[i] <> pmiShowGeneralColumns)
        and (pmiColumnsVisibility.Items[i] <> pmiSeparator2) then begin
      pmiColumnsVisibility.Remove(pmiColumnsVisibility.Items[i]);
    end;
  end;

  if not Assigned(FReport) then begin
    exit;
  end;

  pmiColumnsVisibility.Visible := FReport.ReportColumns.Count > 0;

  if FReport.ReportColumns.Count > 0 then begin

    for i := 0 to FReport.ReportColumns.Count - 1 do begin
      mi := TMenuItem.Create(pmnuReport);
      mi.Caption := FReport.ReportColumns[i].ColumnName;
      mi.AutoCheck := TRUE;
      mi.Tag := FReport.ReportColumns[i].UID;
      mi.Checked := FReport.ReportColumns[i].Visible;
      mi.OnClick := _OnVisibleColumnMenuItemClick;
      pmiColumnsVisibility.Add(mi);
    end;

  end;

end; // TfrmReportView._AddColumnInfoToPopupMenu


procedure TfrmReportView._SaveSettings();
var
  ReportColumns: TReportColumnList;
  ReportColumn: TReportColumn;
  i: Integer;  
begin
  if not Assigned(FReport) then begin
    exit;
  end;

  ReportColumns := FReport.ReportColumns;
  if not Assigned(ReportColumns) then begin
    exit;
  end;

  for i := 0 to grdReport.Columns.Count - 1 do begin
    ReportColumn := ReportColumns.FindById(grdReport.Columns[i].Tag);
    if Assigned(ReportColumn) then begin
      ReportColumn.Visible := grdReport.Columns[i].Visible;
      ReportColumn.Width := grdReport.Columns[i].Width;
      ReportColumn.OrderIndex := i;
    end;
  end;

end; // TfrmReportView._SaveSettings


function TfrmReportView._FindGridColumnByTag(
    const AnTag: Integer): TColumnEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to grdReport.Columns.Count - 1 do begin
    if grdReport.Columns[i].Tag = AnTag then begin
      Result := grdReport.Columns[i];
      break;
    end;
  end;
end; // TfrmReportView._FindGridColumnByTag


function TfrmReportView._FindVisibilityMenuItemByTag(
    const AnTag: Integer): TMenuItem;
var
  i: Integer;
  miVisibilitySubmenu: TMenuItem;
begin
  Result := nil;

  miVisibilitySubmenu := nil;
  for i := 0 to pmnuReport.Items.Count - 1 do begin
    if pmnuReport.Items[i].Tag = VISIBILITY_SUBMENU_TAG then begin
      miVisibilitySubmenu := pmnuReport.Items[i];
      break;
    end;
  end;

  if Assigned(miVisibilitySubmenu) then begin
    for i := 0 to miVisibilitySubmenu.Count - 1 do begin
      if miVisibilitySubmenu.Items[i].Tag = AnTag then begin
        Result := miVisibilitySubmenu.Items[i];
        break;
      end;
    end;
  end;

end; // TfrmReportView._FindVisibilityMenuItemByTag


procedure TfrmReportView._SetVisibility();
var
  i: Integer;
  col: TColumnEh;
  mi: TMenuItem;
begin
  for i := 0 to FReport.ReportColumns.Count - 1 do begin
    col := _FindGridColumnByTag(FReport.ReportColumns[i].UID);
    if Assigned(col) then begin
      col.Visible := FReport.ReportColumns[i].Visible;
    end;

    mi := _FindVisibilityMenuItemByTag(FReport.ReportColumns[i].UID);
    if Assigned(mi) then begin
      mi.Checked := FReport.ReportColumns[i].Visible;
    end;

  end;

end; // TfrmReportView._SetVisibility


// result: TRUE - признак PrintAll выбран успешно
//        FALSE - признак PrintAll не выбран
function TfrmReportView._AskReportPrintAll(var AbPrintAll: Boolean): Boolean;
begin
  AbPrintAll := FALSE;
  Result := FALSE;
  if (grdReport.SelectedRows.Count = 0) and
      (grdReport.Selection.SelectionType <> gstAll) then begin
    AbPrintAll := TRUE;
    Result := TRUE;
  end else begin
    with TfrmPrintQuery.Create(Self) do begin
      try
        if ShowModal() = mrOk then begin
          AbPrintAll := rgrpPrintQueries.ItemIndex = 0;
          Result := TRUE;
        end;
      finally
        Free();
      end;
    end; // with
  end;
end; // TfrmReportView._AskReportPrintAll


// result: TRUE - признак SaveAll выбран успешно
//        FALSE - признак SaveAll не выбран
function TfrmReportView._AskReportSaveAll(var AbSaveAll: Boolean): Boolean;
begin
  AbSaveAll := FALSE;
  Result := FALSE;
  if (grdReport.SelectedRows.Count = 0) and
      (grdReport.Selection.SelectionType <> gstAll) then begin
    AbSaveAll := TRUE;
    Result := TRUE;
  end else begin
    with TfrmSaveQuery.Create(Self) do begin
      try
        if ShowModal() = mrOk then begin
          AbSaveAll := rgrpSaveQueries.ItemIndex = 0;
          Result := TRUE;
        end;
      finally
        Free();
      end;
    end; // with
  end;
end; // TfrmReportView._AskReportSaveAll


// result: TRUE - ExportClass выбран успешно
//        FALSE - ExportClass не выбран
function TfrmReportView._AskReportExportClass(
    var AExportClass: TDBGridEhExportClass;
    var AstrFileName: String): Boolean;
var
  strExt: string;
begin
  Result := FALSE;
  dlgSave.FileName := 'pm_' + FReport.ReportName;
  if dlgSave.Execute() then begin
    case dlgSave.FilterIndex of
      1: begin
        AExportClass := TDBGridEhExportAsHTML;
        strExt       := 'htm';
      end;
      2: begin
        AExportClass := TDBGridEhExportAsRTF;
        strExt       := 'rtf';
      end;
      3: begin
        AExportClass := TDBGridEhExportAsXLS;
        strExt       := 'xls';
      end;
      4: begin
        AExportClass := TDBGridEhExportAsText;
        strExt       := 'txt';
      end;
      5: begin
        AExportClass := TDBGridEhExportAsCSV;
        strExt       := 'csv';
      end;
      else begin
        AExportClass := nil;
        strExt       := '';
      end;
    end; // case

    ASSERT(AExportClass <> nil);
    if AExportClass <> nil then begin
      AstrFileName := dlgSave.FileName;
      if UpperCase(copy(dlgSave.FileName, length(dlgSave.FileName) - 2, 3))
          <> UpperCase(strExt) then
        AstrFileName := AstrFileName + '.' + strExt;
      Result := TRUE;
    end; // if
  end; // if

end; // TfrmReportView._AskReportExportClass()


{procedure TfrmReportView._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmReportView._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');

  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmReportView._SubscribeToLanguagesManagerEvents
}

procedure TfrmReportView.grdReportApplyFilter(Sender: TObject);
begin
  grdReport.DefaultApplyFilter();
end;

end.
