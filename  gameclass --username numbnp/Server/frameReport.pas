unit frameReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, VCFI, Grids, DBGridEh, StdCtrls, ComCtrls, ExtCtrls, ToolWin,
  DB, ADODB, Menus;

type
  TframReport = class(TFrame)
    tbarReports: TToolBar;
    tbCurrentReport: TToolButton;
    tbLastSessions: TToolButton;
    Panel: TPanel;
    pnlFilter: TPanel;
    lblBeginTime: TLabel;
    lblEndTime: TLabel;
    dtpBeginDate: TDateTimePicker;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    cbAllRecords: TCheckBox;
    dtpBeginTime: TDateTimePicker;
    pcReport: TPageControl;
    tabRichEdit: TTabSheet;
    reditReport: TRichEdit;
    tabGrid: TTabSheet;
    gridReport: TDBGridEh;
    tabVtChar: TTabSheet;
    cbFilter: TCheckBox;
    datasrcReport: TDataSource;
    datasetReport: TADODataSet;
    pmnuReports: TPopupMenu;
    miSaveAs: TMenuItem;
    dlgSave: TSaveDialog;
    procedure tbCurrentReportClick(Sender: TObject);
    procedure tbLastSessionsClick(Sender: TObject);
    procedure cbFilterClick(Sender: TObject);
    procedure gridReportApplyFilter(Sender: TObject);
    procedure tbCustomClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure tbLastSessionsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FbEnableFilter : boolean;    // признак включения фильра таблицы
    procedure _SetFilter();
    procedure SetEnableFilter(const AbEnableFilter : boolean);
  public
    { Public declarations }
    property EnableFilter : boolean read FbEnableFilter
        write SetEnableFilter;
    procedure RedrawLanguage;
    procedure RedrawCustomReportsButtons;
    procedure ResetFilterTime;
    procedure SetReportsButtonDown(AButton:TToolButton);
  end;

implementation

uses GCFunctions, frmMain, GCcommon, DateUtils, EhLibADO, GCLangUtils, 
  GCComputers, DBGridEhImpExp,
  uVirtualTime, udmMain;
{$R *.dfm}

procedure TframReport.tbCurrentReportClick(Sender: TObject);
var
  i: integer;
begin
  SetReportsButtonDown(TToolButton(Sender));
  pnlFilter.Visible := False;
  pcReport.ActivePage := tabRichEdit;
  MakeCurrentReport(reditReport.Lines);
end;

procedure TframReport.tbLastSessionsClick(Sender: TObject);
var
  dtBegin: TDateTime;
  dtEnd: TDateTime;
  i: integer;
begin
  dtBegin := DateOf(dtpBeginDate.DateTime) +  TimeOf(dtpBeginTime.DateTime);
  //Для оператора не далее двух суток
  if (not isManager) and (IncDay(GetVirtualTime,-2) >= dtBegin) then begin
    dtBegin := IncDay(GetVirtualTime,-2);
    dtpBeginDate.DateTime := DateOf(dtBegin);
    dtpBeginTime.DateTime := TimeOf(dtBegin);
  end;

  SetReportsButtonDown(TToolButton(Sender));
  datasetReport.Active := False;
  dtEnd := GetVirtualTime;
  datasetReport.Connection := dmMain.cnnMain;
  datasetReport.CommandText := 'exec spgc_repDetails @begin='''+
     DateTimeToSql(DateOf(dtpBeginDate.DateTime)+TimeOf(dtpBeginTime.DateTime))+''', @end='''+
     DateTimeToSql(dtEnd)+''', @OperatorName='''', @compNumber=0';
  dtpEndDate.DateTime := DateOf(dtEnd);
  dtpEndTime.DateTime := TimeOf(dtEnd);
  datasetReport.Active := True;
  pnlFilter.Visible := True;
  pcReport.ActivePage := tabGrid;
  lblBeginTime.Enabled := True;
  dtpBeginDate.Enabled := True;
  dtpBeginTime.Enabled := True;
  lblEndTime.Enabled := False;
  dtpEndDate.Enabled := False;
  dtpEndTime.Enabled := False;
  cbAllRecords.Enabled := False;
  gridReport.DataSource.DataSet.Last;
  gridReport.SetFocus;
end;

procedure TframReport.cbFilterClick(Sender: TObject);
begin
  EnableFilter := cbFilter.Checked;
end;

procedure TframReport.SetEnableFilter(const AbEnableFilter : boolean);
begin
  FbEnableFilter := AbEnableFilter;
  gridReport.STFilter.Visible := FbEnableFilter;
  _SetFilter();
end; // TframReport.SetEnableFilter

// применить или очистить фильтр таблицы
procedure TframReport._SetFilter();
begin
  if FbEnableFilter then
    gridReport.DefaultApplyFilter()
  else
    gridReport.DataSource.DataSet.Filter := '';
end; // TframReport._SetFilter

procedure TframReport.gridReportApplyFilter(Sender: TObject);
begin
  gridReport.DefaultApplyFilter();
end;

procedure TframReport.RedrawLanguage;
begin
  tbCurrentReport.Caption := translate('tbCurrentReport');
  tbLastSessions.Caption := translate('tbLastSessions');
end;

procedure AddButtons(ToolBar: ComCtrls.TToolBar; Const ButtonCaptions: array of String);
var
  I: Integer;
begin
  for I := 0 to High(ButtonCaptions) do
    begin
      with TToolButton.Create(ToolBar) do
      begin
        Parent := ToolBar;
        Caption := ButtonCaptions[I];
        if (ButtonCaptions[I] = '|') then
          Style := tbsSeparator
        else
          Style := tbsButton;
        Wrap := True;
      end;
    end;
end;


procedure TframReport.RedrawCustomReportsButtons;
var
  ToolBar: ComCtrls.TToolBar;
  i : Integer;
begin
  //Deleting custom
  for i:=tbarReports.ButtonCount-1 downto 0 do
      tbarReports.Buttons[i].Free;
  with TToolButton.Create(tbarReports) do begin
    Parent := tbarReports;
    Caption :=  translate('tbLastSessions');;
    Style := tbsButton;
    OnClick := tbLastSessionsClick;
    OnMouseDown := tbLastSessionsMouseDown;
  //  AutoSize := False;
    Wrap := True;
    Enabled := (dmMain.cnnMain <> nil);
    AllowAllUp := True;
    Grouped := True;
    Style := tbsCheck;
  end;
  with TToolButton.Create(tbarReports) do begin
    Parent := tbarReports;
    Caption := translate('tbCurrentReport');
    Style := tbsButton;
    OnClick := tbCurrentReportClick;
  //  AutoSize := False;
    Wrap := True;
    Enabled := (dmMain.cnnMain <> nil);
    AllowAllUp := True;
    Grouped := True;
    Style := tbsCheck;
  end;
  if IsManager and (GCustomReports.Count > 0) then begin
    //Add Separator
    with TToolButton.Create(tbarReports) do begin
      Parent := tbarReports;
      Style := tbsSeparator;
      Wrap := True;
      AutoSize := True;
    end;
    //Add custom reports
    for i:=GCustomReports.Count-1 downto 0 do
      with TToolButton.Create(tbarReports) do begin
        Parent := tbarReports;
        Caption := GCustomReports.Items[i].Name;
        Style := tbsButton;
        OnClick := tbCustomClick;
        AutoSize := False;
        Wrap := True;
        AllowAllUp := True;
        Grouped := True;
        Style := tbsCheck;
      end;
    formMain.frameReport.lblBeginTime.Enabled := True;
    formMain.frameReport.lblEndTime.Enabled := True;
    formMain.frameReport.cbAllRecords.Enabled := False;
    pnlFilter.Visible := True;
    dtpBeginDate.Enabled := True;
    dtpBeginTime.Enabled := True;
    dtpEndDate.Enabled := True;
    dtpEndTime.Enabled := True;
  end;
end;

procedure TframReport.tbCustomClick(Sender: TObject);
var
  n,i: integer;
begin
  SetReportsButtonDown(TToolButton(Sender));
  n := GCustomReports.Index(TToolButton(Sender).Caption);
    if (n <> -1) then
      GCustomReports.Items[n].Execute;
end;

procedure TframReport.SetReportsButtonDown(AButton:TToolButton);
var
  i: integer;
begin
  for i:=0 to tbarReports.ButtonCount-1 do begin
    tbarReports.Buttons[i].AllowAllUp := False;

    if (tbarReports.Buttons[i] = AButton) then
      tbarReports.Buttons[i].Down := True
    else
      tbarReports.Buttons[i].Down := False;
  end;
end;

procedure TframReport.ResetFilterTime;
var
  dt: TDateTime;
begin
  dt := GetVirtualTime;
  dtpEndDate.DateTime := dt;
  dtpEndTime.DateTime := RecodeTime(dt,23,59,59,99);
  dtpBeginDate.DateTime := IncDay(dt,-7);
  dtpBeginTime.DateTime := RecodeTime(dtpBeginDate.DateTime,0,0,0,0);
end;

procedure TframReport.miSaveAsClick(Sender: TObject);
var
  ExpClass    : TDBGridEhExportClass;
  Ext         : string;
  grdActive   : TDBGridEh;
begin
  grdActive := gridReport;

    dlgSave.FileName := 'gc_' + grdActive.Name;
    if dlgSave.Execute() then begin
      case dlgSave.FilterIndex of
        1: begin
          ExpClass := TDBGridEhExportAsText;
          Ext := 'txt';
        end;
        2: begin
          ExpClass := TDBGridEhExportAsCSV;
          Ext := 'csv';
        end;
        3: begin
          ExpClass := TDBGridEhExportAsHTML;
          Ext := 'htm';
        end;
        4: begin
          ExpClass := TDBGridEhExportAsRTF;
          Ext := 'rtf';
        end;
        5: begin
          ExpClass := TDBGridEhExportAsXLS;
          Ext := 'xls';
        end;
      else
        ExpClass := nil; Ext := '';
      end; // case
      if ExpClass <> nil then begin
        if UpperCase(copy(dlgSave.FileName, length(dlgSave.FileName) - 2, 3))
            <> UpperCase(Ext) then
          dlgSave.FileName := dlgSave.FileName + '.' + Ext;
        SaveDBGridEhToExportFile(ExpClass, grdActive,
             dlgSave.FileName, TRUE);
      end; // if
    end; // if

end;

procedure TframReport.tbLastSessionsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  dtBegin: TDateTime;
  dtEnd: TDateTime;
begin
  if not TToolButton(Sender).Down then begin
    dtBegin := IncHour(GetVirtualTime,-12);
    dtpBeginDate.DateTime := DateOf(dtBegin);
    dtpBeginTime.DateTime := TimeOf(dtBegin);
    tbLastSessionsClick(Sender);
  end;
end;

end.
