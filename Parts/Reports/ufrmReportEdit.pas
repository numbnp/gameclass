unit ufrmReportEdit;

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
  StdCtrls,
  Grids,
  ValEdit,
  ExtCtrls,
  SynEditHighlighter,
  SynHighlighterSQL,
  SynEdit,
//  uLanguagesManager,
  uReportCommon,
  uReport,
  uReportColumn,
  ufrmReport, RXSpin, ComCtrls, Menus, Vcl.Mask;


type

  //
  // TfrmReportEdit
  //

  TfrmReportEdit = class(TfrmReport)
    edtReportCode: TSynEdit;
    SynSQLSyn: TSynSQLSyn;
    pnlReportColumns: TPanel;
    splitEditor: TSplitter;
    ColumnsValueListEditor: TValueListEditor;
    lbxColumnsNames: TListBox;
    splitReportColumns: TSplitter;
    pnlColumnsList: TPanel;
    lblColumns: TStaticText;
    pnlHeader: TPanel;
    edtName: TEdit;
    edtAuthor: TEdit;
    edtVersion: TRxSpinEdit;
    lblName: TLabel;
    lblVersion: TLabel;
    lblAuthor: TLabel;
    pgctrlReportCode: TPageControl;
    tabCode: TTabSheet;
    tabDescription: TTabSheet;
    redtDescription: TRichEdit;
    PopupMenuEdit: TPopupMenu;
    mnuCopy: TMenuItem;
    mnuCut: TMenuItem;
    mnuPaste: TMenuItem;
    procedure lbxColumnsNamesClick(Sender: TObject);
    procedure edtNameChange(Sender: TObject);
    procedure ColumnsValueListEditorStringsChange(Sender: TObject);
    procedure lbxColumnsNamesDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lbxColumnsNamesDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure mnuCutClick(Sender: TObject);
    procedure mnuCopyClick(Sender: TObject);
    procedure mnuPasteClick(Sender: TObject);

  private
    // class constants
    RES_TITLE_KEY: String;
    RES_TITLE_VALUE: String;

    CPL_NAME_KEY: String;
    CPL_FIELD_KEY: String;
    CPL_ISGENERAL_KEY: String;
    CPL_AGGREGATE_FUNCTION_KEY: String;
    CPL_CHART_ROLE_KEY: String;
    CPL_CHART_DEFAULT_KEY: String;
    CPL_WIDTH_KEY: String;
    CPL_VISIBLE_KEY: String;

    CPL_YES: String;
    CPL_NO: String;

    CPL_AGGREGATE_NO: String;
    CPL_AGGREGATE_SUM: String;
    CPL_AGGREGATE_AVG: String;
    CPL_AGGREGATE_COUNT: String;

    CPL_CHART_ROLE_NO: String;
    CPL_CHART_ROLE_X: String;
    CPL_CHART_ROLE_Y: String;

    // fields
    FReport: TReport;
    FbInit: Boolean;
    FOnModifyReport: TModifyReport;

//    FLanguagesManagerLink: TLanguagesManagerLink;

    // events handlers
//    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _FillColumnsList();
    procedure _BuildColumnPropertiesList(const AReportColumn: TReportColumn);
    procedure _EnableColumnControls(const AbEnable: Boolean);
    procedure _StorageReportFields();
    procedure _StorageColumnsFields();
    procedure _SelectColumn(const AnColumnId: Integer);
    procedure _TuneColumnsValueListEditor();
//    procedure _SubscribeToLanguagesManagerEvents();

    // fire methods
    procedure _FireModifyReport();

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // public methods
    procedure SetReport(const AReport: TReport); override;
    procedure Storage(); override;

    procedure AddReportColumn(const AReportColumn: TReportColumn);
    procedure DeleteReportColumn(const AnId: Integer);
    function GetActiveColumnId(): Integer;

    

    // properties
    property OnModifyReport: TModifyReport
        read FOnModifyReport write FOnModifyReport;

  end; // TfrmReportEdit


implementation

uses
  gccomputers,
  System.Types;
{$R *.dfm}


const
  CLASS_NAME = 'TfrmReportEdit';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmReportEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  RES_TITLE_KEY := 'Key';
  RES_TITLE_VALUE := 'Value';

  CPL_NAME_KEY := 'Íàçâàíèå';
  CPL_FIELD_KEY := 'Ïîëå îò÷åòà';
  CPL_ISGENERAL_KEY := 'Îñíîâíîå';
  CPL_AGGREGATE_FUNCTION_KEY := 'Àããðåãàòíàÿ îïåðàöèÿ';
  CPL_CHART_ROLE_KEY := 'Ðîëü íà äèàãðàììå';
  CPL_CHART_DEFAULT_KEY := 'Ïî óìîë÷àíèþ íà äèàãðàììå';
  CPL_WIDTH_KEY := 'Øèðèíà';
  CPL_VISIBLE_KEY := 'Îòîáðàæàòü';

  CPL_YES := 'ÄÀ';
  CPL_NO := 'ÍÅÒ';

  CPL_AGGREGATE_NO := 'ÍÅ ÇÀÄÀÍÀ';
  CPL_AGGREGATE_SUM := 'ÑÓÌÌÀ';
  CPL_AGGREGATE_AVG := 'ÑÐÅÄÍÅÅ';
  CPL_AGGREGATE_COUNT := 'ÊÎËÈ×ÅÑÒÂÎ';

  CPL_CHART_ROLE_NO := 'ÍÅ ÇÀÄÀÍÀ';
  CPL_CHART_ROLE_X := 'X - ÊÎÎÐÄÈÍÀÒÀ';
  CPL_CHART_ROLE_Y := 'Y - ÊÎÎÐÄÈÍÀÒÀ';

  FOnModifyReport := nil;

//  _SubscribeToLanguagesManagerEvents();
//  _LanguageChange(Self);

//  _BuildColumnPropertiesList();

end; // TfrmReportEdit.Create


destructor TfrmReportEdit.Destroy();
begin
//  FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmReportEdit.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TfrmReportEdit.SetReport(const AReport: TReport);
begin
  FbInit := TRUE;

  try
    FReport := AReport;

    if not Assigned(FReport) then begin
      exit;
    end;

    edtName.Text := AReport.ReportName;
    edtName.Enabled := not AReport.Invariable;
    edtReportCode.Lines.Text := AReport.Code;
    edtReportCode.ReadOnly := AReport.Invariable;
    edtAuthor.Text := AReport.Author;
    edtAuthor.Enabled := not AReport.Invariable;
    edtVersion.Value := AReport.Version;
    edtVersion.Enabled := not AReport.Invariable;
    redtDescription.Text := AReport.Description;
    redtDescription.ReadOnly := AReport.Invariable;
    ColumnsValueListEditor.Enabled := not AReport.Invariable;

    _FillColumnsList();
    ColumnsValueListEditor.Enabled := IsManager and not FReport.Invariable;
  finally
    FbInit := FALSE;
  end;

end; // TfrmReportEdit.SetReport


procedure TfrmReportEdit.Storage();
begin
  _StorageReportFields();
  _StorageColumnsFields();
end; // TfrmReportEdit.Storage


procedure TfrmReportEdit.AddReportColumn(const AReportColumn: TReportColumn);
begin
  if Assigned(FReport.ReportColumns.FindById(AReportColumn.UID)) then begin
    lbxColumnsNames.AddItem(AReportColumn.ColumnName, AReportColumn);
    lbxColumnsNames.Selected[lbxColumnsNames.Count - 1] := TRUE;
    _BuildColumnPropertiesList(AReportColumn);
    _EnableColumnControls({TRUE}not FReport.Invariable);
  end;
end; // TfrmReportEdit.AddReportColumn


procedure TfrmReportEdit.DeleteReportColumn(const AnId: Integer);
var
  i: Integer;
  ReportColumn: TReportColumn;
begin
  for i := 0 to lbxColumnsNames.Count - 1 do begin
    ReportColumn := TReportColumn(lbxColumnsNames.Items.Objects[i]);
    if ReportColumn.UID = AnId then begin
      lbxColumnsNames.Items.Delete(i);
      break;
    end;
  end;
  if lbxColumnsNames.Count > 0 then begin
    _SelectColumn(0);
  end;
end; // TfrmReportEdit.DeleteReportColumn


function TfrmReportEdit.GetActiveColumnId(): Integer;
var
  nActiveItemIndex: Integer;
begin
  if lbxColumnsNames.Count = 0 then begin
    Result := 0;
    exit;
  end;

  nActiveItemIndex := lbxColumnsNames.ItemIndex;
  Result := TReportColumn(lbxColumnsNames.Items.Objects[nActiveItemIndex]).UID;

end; // TfrmReportEdit.GetActiveColumnId


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmReportEdit.lbxColumnsNamesClick(Sender: TObject);
var
  nActiveItemIndex: Integer;
  ReportColumn: TReportColumn;
begin
  FbInit := TRUE;
  nActiveItemIndex := lbxColumnsNames.ItemIndex;
  ReportColumn := TReportColumn(lbxColumnsNames.Items.Objects[nActiveItemIndex]);
  _BuildColumnPropertiesList(ReportColumn);
  FbInit := FALSE;
end; // TfrmReportEdit.lbxColumnsNamesClick


procedure TfrmReportEdit.edtNameChange(Sender: TObject);
begin
  if Assigned(FReport) and not FbInit then begin
    FReport.ReportName := edtName.Text;
    _FireModifyReport();
  end;
end; // TfrmReportEdit.edtNameChange


procedure TfrmReportEdit.ColumnsValueListEditorStringsChange(
  Sender: TObject);
var
  ReportColumn: TReportColumn;
begin
  if lbxColumnsNames.Count = 0 then begin
    exit;
  end;

  if not FbInit then begin
    lbxColumnsNames.Items[lbxColumnsNames.ItemIndex] :=
        ColumnsValueListEditor.Values[CPL_NAME_KEY];
    ReportColumn := TReportColumn(
        lbxColumnsNames.Items.Objects[lbxColumnsNames.ItemIndex]);
    ReportColumn.ColumnName := ColumnsValueListEditor.Values[CPL_NAME_KEY];
    ReportColumn.Field := ColumnsValueListEditor.Values[CPL_FIELD_KEY];
    ReportColumn.IsGeneral := (CompareText(
        ColumnsValueListEditor.Values[CPL_ISGENERAL_KEY], CPL_YES) = 0);
    ReportColumn.ChartDefault := (CompareText(
        ColumnsValueListEditor.Values[CPL_CHART_DEFAULT_KEY], CPL_YES) = 0);
    ReportColumn.Width := StrToIntDef(
        ColumnsValueListEditor.Values[CPL_WIDTH_KEY], 64);
    ReportColumn.Visible := (CompareText(
        ColumnsValueListEditor.Values[CPL_VISIBLE_KEY], CPL_YES) = 0);

    if CompareText(ColumnsValueListEditor.Values[CPL_AGGREGATE_FUNCTION_KEY],
        CPL_AGGREGATE_SUM) = 0 then begin
      ReportColumn.AggregateFunction := Aggregate_Sum;
    end else if CompareText(ColumnsValueListEditor.Values[CPL_AGGREGATE_FUNCTION_KEY],
        CPL_AGGREGATE_AVG) = 0 then begin
      ReportColumn.AggregateFunction := Aggregate_Avg;
    end else if CompareText(ColumnsValueListEditor.Values[CPL_AGGREGATE_FUNCTION_KEY],
        CPL_AGGREGATE_COUNT) = 0 then begin
      ReportColumn.AggregateFunction := Aggregate_Count;
    end else begin
      ReportColumn.AggregateFunction := Aggregate_None;
    end;

    if CompareText(ColumnsValueListEditor.Values[CPL_CHART_ROLE_KEY],
        CPL_CHART_ROLE_X) = 0 then begin
      ReportColumn.ChartRole := ChartRole_X;
    end else if CompareText(ColumnsValueListEditor.Values[CPL_CHART_ROLE_KEY],
        CPL_CHART_ROLE_Y) = 0 then begin
      ReportColumn.ChartRole := ChartRole_Y;
    end else begin
      ReportColumn.ChartRole := ChartRole_None;
    end;

  end;

end; // TfrmReportEdit.ColumnsValueListEditorStringsChange


{procedure TfrmReportEdit._LanguageChange(ASender: TObject);
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, TLabel(lblName));
    GetString(CLASS_NAME, TLabel(lblVersion));
    GetString(CLASS_NAME, TLabel(lblAuthor));
    GetString(CLASS_NAME, TLabel(lblColumns));
    GetString(CLASS_NAME, TTabSheet(tabCode));
    GetString(CLASS_NAME, TTabSheet(tabDescription));
    GetString(CLASS_NAME, 'RES_TITLE_KEY', '', RES_TITLE_KEY);
    GetString(CLASS_NAME, 'RES_TITLE_VALUE', '', RES_TITLE_VALUE);
    GetString(CLASS_NAME, 'CPL_NAME_KEY', '', CPL_NAME_KEY);
    GetString(CLASS_NAME, 'CPL_FIELD_KEY', '', CPL_FIELD_KEY);
    GetString(CLASS_NAME, 'CPL_ISGENERAL_KEY', '', CPL_ISGENERAL_KEY);
    GetString(CLASS_NAME, 'CPL_AGGREGATE_FUNCTION_KEY', '', CPL_AGGREGATE_FUNCTION_KEY);
    GetString(CLASS_NAME, 'CPL_CHART_ROLE_KEY', '', CPL_CHART_ROLE_KEY);
    GetString(CLASS_NAME, 'CPL_CHART_DEFAULT_KEY', '', CPL_CHART_DEFAULT_KEY);
    GetString(CLASS_NAME, 'CPL_WIDTH_KEY', '', CPL_WIDTH_KEY);
    GetString(CLASS_NAME, 'CPL_VISIBLE_KEY', '', CPL_VISIBLE_KEY);
    GetString(CLASS_NAME, 'CPL_YES', '', CPL_YES);
    GetString(CLASS_NAME, 'CPL_NO', '', CPL_NO);
    GetString(CLASS_NAME, 'CPL_AGGREGATE_NO', '', CPL_AGGREGATE_NO);
    GetString(CLASS_NAME, 'CPL_AGGREGATE_SUM', '', CPL_AGGREGATE_SUM);
    GetString(CLASS_NAME, 'CPL_AGGREGATE_AVG', '', CPL_AGGREGATE_AVG);
    GetString(CLASS_NAME, 'CPL_AGGREGATE_COUNT', '', CPL_AGGREGATE_COUNT);
    GetString(CLASS_NAME, 'CPL_CHART_ROLE_NO', '', CPL_CHART_ROLE_NO);
    GetString(CLASS_NAME, 'CPL_CHART_ROLE_X', '', CPL_CHART_ROLE_X);
    GetString(CLASS_NAME, 'CPL_CHART_ROLE_Y', '', CPL_CHART_ROLE_Y);
  end;
  _TuneColumnsValueListEditor();
end; // TfrmReportEdit._LanguageChange
}

//////////////////////////////////////////////////////////////////////////////
// drag & drop events

procedure TfrmReportEdit.lbxColumnsNamesDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = lbxColumnsNames)
      and (Sender = lbxColumnsNames);
end; // TfrmReportEdit.lbxColumnsNamesDragOver


procedure TfrmReportEdit.lbxColumnsNamesDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  nOldIndex: Integer;
  nNewIndex: Integer;
begin
  if (Sender = lbxColumnsNames) then begin
    nOldIndex := lbxColumnsNames.ItemIndex;
    nNewIndex := lbxColumnsNames.ItemAtPos(Point(X, Y), FALSE);
    if (nOldIndex >= 0) and (nNewIndex >= 0) then begin
      // êîððåêòèðóåì nNewIndex äëÿ ïåðåìåùåíèÿ â êîíåö ñïèñêà
      if nNewIndex > lbxColumnsNames.Items.Count - 1 then begin
        nNewIndex := lbxColumnsNames.Items.Count - 1;
      end;
      lbxColumnsNames.Items.Move(nOldIndex, nNewIndex);
      FbInit := TRUE;
      _SelectColumn(nNewIndex);
      FbInit := FALSE;
    end;
  end;
end; // TfrmReportEdit.lbxColumnsNamesDragDrop


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmReportEdit._StorageColumnsFields();
var
  i: Integer;
  ReportColumn: TReportColumn;
begin
  for i := 0 to lbxColumnsNames.Count - 1 do begin
    ReportColumn := (lbxColumnsNames.Items.Objects[i] as TReportColumn);
    ReportColumn.OrderIndex := i;
  end;
end; // TfrmReportEdit._StorageColumnsFields


procedure TfrmReportEdit._FillColumnsList();
var
  i: Integer;
  ReportColumn: TReportColumn;
begin
  lbxColumnsNames.Clear();

  if not Assigned(FReport) then begin
    exit;
  end;

  for i := 0 to FReport.ReportColumns.Count - 1 do begin
    lbxColumnsNames.AddItem(FReport.ReportColumns[i].ColumnName,
        FReport.ReportColumns[i]);
  end;

  if lbxColumnsNames.Count > 0 then begin
    _EnableColumnControls(TRUE);
    lbxColumnsNames.Selected[0] := TRUE;
    ReportColumn := TReportColumn(lbxColumnsNames.Items.Objects[0]);
    _BuildColumnPropertiesList(ReportColumn);
  end else begin
    _EnableColumnControls(FALSE);
  end;

end; // TfrmReportEdit._FillColumnsList


procedure TfrmReportEdit._BuildColumnPropertiesList(
    const AReportColumn: TReportColumn);
begin
  FbInit := TRUE;

  ColumnsValueListEditor.Strings.Clear();

  ColumnsValueListEditor.InsertRow(CPL_NAME_KEY, AReportColumn.ColumnName, TRUE);

  ColumnsValueListEditor.InsertRow(CPL_FIELD_KEY, AReportColumn.Field, TRUE);

  ColumnsValueListEditor.InsertRow(CPL_ISGENERAL_KEY, CPL_YES, TRUE);
  ColumnsValueListEditor.ItemProps[CPL_ISGENERAL_KEY].EditStyle := esPickList;
  ColumnsValueListEditor.ItemProps[CPL_ISGENERAL_KEY].PickList.Add(CPL_YES);
  ColumnsValueListEditor.ItemProps[CPL_ISGENERAL_KEY].PickList.Add(CPL_NO);
  if AReportColumn.IsGeneral then begin
    ColumnsValueListEditor.Values[CPL_ISGENERAL_KEY] := CPL_YES;
  end else begin
    ColumnsValueListEditor.Values[CPL_ISGENERAL_KEY] := CPL_NO;
  end;

  ColumnsValueListEditor.InsertRow(CPL_AGGREGATE_FUNCTION_KEY, CPL_AGGREGATE_NO, TRUE);
  ColumnsValueListEditor.ItemProps[CPL_AGGREGATE_FUNCTION_KEY].EditStyle := esPickList;
  ColumnsValueListEditor.ItemProps[CPL_AGGREGATE_FUNCTION_KEY].PickList.Add(CPL_AGGREGATE_NO);
  ColumnsValueListEditor.ItemProps[CPL_AGGREGATE_FUNCTION_KEY].PickList.Add(CPL_AGGREGATE_SUM);
  ColumnsValueListEditor.ItemProps[CPL_AGGREGATE_FUNCTION_KEY].PickList.Add(CPL_AGGREGATE_AVG);
  ColumnsValueListEditor.ItemProps[CPL_AGGREGATE_FUNCTION_KEY].PickList.Add(CPL_AGGREGATE_COUNT);
  if AReportColumn.AggregateFunction = Aggregate_None then begin
    ColumnsValueListEditor.Values[CPL_AGGREGATE_FUNCTION_KEY] := CPL_AGGREGATE_NO;
  end else if AReportColumn.AggregateFunction = Aggregate_Sum then begin
    ColumnsValueListEditor.Values[CPL_AGGREGATE_FUNCTION_KEY] := CPL_AGGREGATE_SUM;
  end else if AReportColumn.AggregateFunction = Aggregate_Avg then begin
    ColumnsValueListEditor.Values[CPL_AGGREGATE_FUNCTION_KEY] := CPL_AGGREGATE_AVG;
  end else if AReportColumn.AggregateFunction = Aggregate_Count then begin
    ColumnsValueListEditor.Values[CPL_AGGREGATE_FUNCTION_KEY] := CPL_AGGREGATE_COUNT;
  end else begin
    ASSERT(FALSE, 'Unknown Aggregate Function!');
    ColumnsValueListEditor.Values[CPL_AGGREGATE_FUNCTION_KEY] := CPL_AGGREGATE_NO;
  end;

  ColumnsValueListEditor.InsertRow(CPL_CHART_ROLE_KEY, CPL_CHART_ROLE_NO, TRUE);
  ColumnsValueListEditor.ItemProps[CPL_CHART_ROLE_KEY].EditStyle := esPickList;
  ColumnsValueListEditor.ItemProps[CPL_CHART_ROLE_KEY].PickList.Add(CPL_CHART_ROLE_NO);
  ColumnsValueListEditor.ItemProps[CPL_CHART_ROLE_KEY].PickList.Add(CPL_CHART_ROLE_X);
  ColumnsValueListEditor.ItemProps[CPL_CHART_ROLE_KEY].PickList.Add(CPL_CHART_ROLE_Y);
  if AReportColumn.ChartRole = ChartRole_None then begin
    ColumnsValueListEditor.Values[CPL_CHART_ROLE_KEY] := CPL_CHART_ROLE_NO;
  end else if AReportColumn.ChartRole = ChartRole_X then begin
    ColumnsValueListEditor.Values[CPL_CHART_ROLE_KEY] := CPL_CHART_ROLE_X;
  end else if AReportColumn.ChartRole = ChartRole_Y then begin
    ColumnsValueListEditor.Values[CPL_CHART_ROLE_KEY] := CPL_CHART_ROLE_Y;
  end else begin
    ASSERT(FALSE, 'U~known Chart Role!');
    ColumnsValueListEditor.Values[CPL_CHART_ROLE_KEY] := CPL_CHART_ROLE_NO;
  end;

  ColumnsValueListEditor.InsertRow(CPL_CHART_DEFAULT_KEY, CPL_NO, TRUE);
  ColumnsValueListEditor.ItemProps[CPL_CHART_DEFAULT_KEY].EditStyle := esPickList;
  ColumnsValueListEditor.ItemProps[CPL_CHART_DEFAULT_KEY].PickList.Add(CPL_YES);
  ColumnsValueListEditor.ItemProps[CPL_CHART_DEFAULT_KEY].PickList.Add(CPL_NO);
  if AReportColumn.ChartDefault then begin
    ColumnsValueListEditor.Values[CPL_CHART_DEFAULT_KEY] := CPL_YES;
  end else begin
    ColumnsValueListEditor.Values[CPL_CHART_DEFAULT_KEY] := CPL_NO;
  end;

  ColumnsValueListEditor.InsertRow(CPL_WIDTH_KEY, IntToStr(AReportColumn.Width), TRUE);

  ColumnsValueListEditor.InsertRow(CPL_VISIBLE_KEY, CPL_YES, TRUE);
  ColumnsValueListEditor.ItemProps[CPL_VISIBLE_KEY].EditStyle := esPickList;
  ColumnsValueListEditor.ItemProps[CPL_VISIBLE_KEY].PickList.Add(CPL_YES);
  ColumnsValueListEditor.ItemProps[CPL_VISIBLE_KEY].PickList.Add(CPL_NO);
  if AReportColumn.Visible then begin
    ColumnsValueListEditor.Values[CPL_VISIBLE_KEY] := CPL_YES;
  end else begin
    ColumnsValueListEditor.Values[CPL_VISIBLE_KEY] := CPL_NO;
  end;

  FbInit := FALSE;
  
end; // TfrmReportEdit._BuildColumnPropertiesList


procedure TfrmReportEdit._EnableColumnControls(const AbEnable: Boolean);
begin
  if not AbEnable then begin
    lbxColumnsNames.Clear();
    ColumnsValueListEditor.Strings.Clear();
  end;

  lbxColumnsNames.Enabled := AbEnable;
  ColumnsValueListEditor.Enabled := AbEnable;

end; // TfrmReportEdit._EnableColumnControls


procedure TfrmReportEdit._StorageReportFields();
begin
  if Assigned(FReport) then begin
    FReport.ReportName := edtName.Text;
    FReport.Code := edtReportCode.Text;
    FReport.Author := edtAuthor.Text;
    FReport.Version := Trunc(edtVersion.Value);
    FReport.Description := redtDescription.Text;
  end;
end; // TfrmReportEdit._StorageReportFields


procedure TfrmReportEdit._SelectColumn(const AnColumnId: Integer);
var
  ReportColumn: TReportColumn;
begin
  lbxColumnsNames.Selected[AnColumnId] := TRUE;
  ReportColumn := TReportColumn(lbxColumnsNames.Items.Objects[AnColumnId]);
  _BuildColumnPropertiesList(ReportColumn);
end; // TfrmReportEdit._SelectColumn


procedure TfrmReportEdit._TuneColumnsValueListEditor();
begin
  ASSERT(ColumnsValueListEditor.TitleCaptions.Count >= 2);

  if ColumnsValueListEditor.TitleCaptions.Count >= 2 then begin
    ColumnsValueListEditor.TitleCaptions[0] := RES_TITLE_KEY;
    ColumnsValueListEditor.TitleCaptions[1] := RES_TITLE_VALUE;
  end;

  _FillColumnsList();

  ColumnsValueListEditor.Invalidate();

end; // TfrmReportEdit._TuneColumnsValueListEditorTitles


{procedure TfrmReportEdit._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmReportEdit._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');

  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmReportEdit._SubscribeToLanguagesManagerEvents
}

//////////////////////////////////////////////////////////////////////////////
// fire methods

procedure TfrmReportEdit._FireModifyReport();
begin
  if Assigned(OnModifyReport) then begin
    OnModifyReport(Self);
  end;
end; // TfrmReportEdit._FireModifyReport

procedure TfrmReportEdit.mnuCutClick(Sender: TObject);
begin
  inherited;
  edtReportCode.CutToClipboard; 
end;

procedure TfrmReportEdit.mnuCopyClick(Sender: TObject);
begin
  inherited;
  edtReportCode.CopyToClipboard;
end;

procedure TfrmReportEdit.mnuPasteClick(Sender: TObject);
begin
  inherited;
  edtReportCode.PasteFromClipboard; 
end;

end.
