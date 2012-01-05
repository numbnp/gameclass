unit ufrmReports;

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
  ExtCtrls,
  VirtualTrees,
  ActnList,
  ComCtrls,
  ToolWin,
  ImgList,
  Menus,
  StdCtrls,
  ActiveX,
//  uLanguagesManager,
  uReportCommon,
  uReport,
  uReportManager,
  uReportFormsManager;


type

  //
  // TfrmReports
  //

  TfrmReports = class(TForm)
    tvReportsNavigator: TVirtualStringTree;
    splitNavigator: TSplitter;
    pnlReport: TPanel;
    tbarReports: TToolBar;
    tbtnConstructor: TToolButton;
    actlstReports: TActionList;
    actConstructor: TAction;
    imglstReports: TImageList;
    tbarMainSeparator1: TToolButton;
    tbtnShowGrid: TToolButton;
    tbtnShowChart: TToolButton;
    actShowGrid: TAction;
    actShowChart: TAction;
    tbarMainSeparator2: TToolButton;
    tbtnChart3D: TToolButton;
    actChartBar: TAction;
    actChartArea: TAction;
    actChartPie: TAction;
    actChartLine: TAction;
    actChart3D: TAction;
    actChartPoint: TAction;
    tbtnChartRandomColors: TToolButton;
    actChartRandomColors: TAction;
    tbarFilter: TToolBar;
    tbarMainSeparator3: TToolButton;
    tbarAutofilter: TToolButton;
    actAutofilter: TAction;
    actEnableDTFilter: TAction;
    tbtnDTFilter: TToolButton;
    tbtnChartStyle: TToolButton;
    pmnuChartStyle: TPopupMenu;
    pmiChartBar: TMenuItem;
    pmiChartArea: TMenuItem;
    pmiChartPie: TMenuItem;
    pmiChartLine: TMenuItem;
    pmiChartPoint: TMenuItem;
    dtpBeginDate: TDateTimePicker;
    dtpBeginTime: TDateTimePicker;
    tbtnSetTimeInterval: TToolButton;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    pmnuTimeIntervals: TPopupMenu;
    pmiDTToday: TMenuItem;
    pmiDTYesterday: TMenuItem;
    pmiDTCurrentWeek: TMenuItem;
    pmiDTCurrentMonth: TMenuItem;
    pmiDTCurrentQuarter: TMenuItem;
    pmiDTLast30Days: TMenuItem;
    pmiDTCurrentYear: TMenuItem;
    pmiDTQuarters: TMenuItem;
    pmiDTQuarter1: TMenuItem;
    pmiDTQuarter2: TMenuItem;
    pmiDTQuarter3: TMenuItem;
    pmiDTQuarter4: TMenuItem;
    pmiDTLast7Days: TMenuItem;
    pmiDTAll: TMenuItem;
    N1: TMenuItem;
    cbxAll: TCheckBox;
    tbarMainSeparator4: TToolButton;
    tbtnAddReport: TToolButton;
    tbtnDeleteReport: TToolButton;
    tbarMainSeparator5: TToolButton;
    tbtnAddColumn: TToolButton;
    tbtnDeleteColumn: TToolButton;
    actAddReport: TAction;
    actDeleteReport: TAction;
    actAddColumn: TAction;
    actDeleteColumn: TAction;
    lblDivider: TStaticText;
    actDTAll: TAction;
    actDTToday: TAction;
    actDTYesterday: TAction;
    actDTLast7Days: TAction;
    actDTLast30Days: TAction;
    actDTCurrentWeek: TAction;
    actDTCurrentMonth: TAction;
    actDTCurrentYear: TAction;
    actDTQuarter1: TAction;
    actDTQuarter2: TAction;
    actDTQuarter3: TAction;
    actDTQuarter4: TAction;
    actDTCurrentQuarter: TAction;
    btnDTApplyFilter: TToolButton;
    lblDivider2: TStaticText;
    actDTApplyFilter: TAction;
    actAddFolder: TAction;
    tbtnAddFolder: TToolButton;
    tbtnSaveTable: TToolButton;
    actSaveToFile: TAction;
    btnExportReport: TToolButton;
    tbtnImportReport: TToolButton;
    tbarMainSeparator6: TToolButton;
    actExportReport: TAction;
    actImportReport: TAction;
    tbarMainSeparator7: TToolButton;
    actPrint: TAction;
    tbtnPrint: TToolButton;
    pmnuNavigator: TPopupMenu;
    pmnuConstructor: TMenuItem;
    pmnuAddFolder: TMenuItem;
    pmnuAddReport: TMenuItem;
    pmnuDeleteReport: TMenuItem;
    NavigatorMenuSeparator1: TMenuItem;
    procedure actConstructorExecute(Sender: TObject);
    procedure tvReportsNavigatorGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure tvReportsNavigatorFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure tvReportsNavigatorInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure tvReportsNavigatorChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure tvReportsNavigatorGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure actShowReportViewExecute(Sender: TObject);
    procedure actlstReportsUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure tvReportsNavigatorLoadNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Stream: TStream);
    procedure tvReportsNavigatorSaveNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Stream: TStream);
    procedure actChartStyleExecute(Sender: TObject);
    procedure actChart3DExecute(Sender: TObject);
    procedure actChartRandomColorsExecute(Sender: TObject);
    procedure actAutofilterExecute(Sender: TObject);
    procedure actEnableDTFilterExecute(Sender: TObject);
    procedure actAddReportExecute(Sender: TObject);
    procedure actDeleteReportExecute(Sender: TObject);
    procedure actAddColumnExecute(Sender: TObject);
    procedure actDeleteColumnExecute(Sender: TObject);
    procedure actDTExecute(Sender: TObject);
    procedure cbxAllClick(Sender: TObject);
    procedure actDTApplyFilterExecute(Sender: TObject);
    procedure actAddFolderExecute(Sender: TObject);
    procedure tvReportsNavigatorDragAllowed(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure tvReportsNavigatorDragOver(Sender: TBaseVirtualTree;
      Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
      Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure tvReportsNavigatorDragDrop(Sender: TBaseVirtualTree;
      Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
      Shift: TShiftState; Pt: TPoint; var Effect: Integer;
      Mode: TDropMode);
    procedure actExportReportExecute(Sender: TObject);
    procedure actImportReportExecute(Sender: TObject);
    procedure actSaveToFileExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);

  private
    // fields
    FReportManager: TReportManager;
    FReportManagerLink: TReportManagerLink;

    FReportFormsManager: TReportFormsManager;

    FbActiveReportIsFolder: Boolean;

    FbReorderNeeded: Boolean;

//    FLanguagesManagerLink: TLanguagesManagerLink;

    // events hanflers
    procedure _ReportManagerSetActiveReport(
        const ASender: TObject; const AActiveReport: TReport);
    procedure _ReportManagerDeleteReport(
        const ASender: TObject; const AnDeleteReportId: Integer);
    procedure _ReportFormsManagerChangeReport(
        const ASender: TObject; const AnReportId: Integer);
    procedure _ReportFormsManagerModifyReport(const ASender: TObject);
//    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _BuildReportsTree();
    procedure _BuildTree(
        const AnodParent: PVirtualNode; const AnParent: Integer);
    procedure _SetActiveReport(const AnId: Integer);
    procedure _ResetActiveReport();
    procedure  _ChangeView();
    procedure _SelectFirstReport();
    procedure _SelectReport(const AnReportId: Integer);
    procedure _TuneFilterToolbar();
    function _GetReportParameters(): TReportParameters;
    function _GetNewReportParentId(): Integer;
    procedure _AddReportToTree(const AnParentId: Integer;
        const AReport: TReport);
    procedure _DeleteReportFromTree(const AnId: Integer);
    function _FindNodeById(const AnId: Integer): PVirtualNode;
    procedure _AddReport(const AbIsFolder: Boolean);
    procedure _ReorderReports();
    procedure _RefreshSubtree(const AnParentId: Integer);
//    procedure _SubscribeToLanguagesManagerEvents();

  public
    // constructor / destructor
    constructor Create(const AOwner: TComponent;
        const AReportManager: TReportManager); reintroduce;
    destructor Destroy(); override;
    procedure InitData;
    procedure DisableReports;
    procedure SetBackColor(AColor: TColor);
    procedure SetFont(const AFont: TFont);

  end; // TfrmReports


implementation

uses
  DateUtils,
  uTimeShift,
  uTimeInterval,
  uReportColumn,
  uVirtualTime,
  gccomputers;

{$R *.dfm}

const
  CLASS_NAME = 'TfrmReports';

  CHART_BAR_IMAGE_INDEX = 14;
  CHART_AREA_IMAGE_INDEX = 15;
  CHART_PIE_IMAGE_INDEX = 16;
  CHART_LINE_IMAGE_INDEX = 17;
  CHART_POINT_IMAGE_INDEX = 18;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmReports.Create(const AOwner: TComponent;
    const AReportManager: TReportManager);
begin
  inherited Create(AOwner);

  tvReportsNavigator.NodeDataSize := SizeOf(TReportData);

  FbActiveReportIsFolder := FALSE;

  FbReorderNeeded := FALSE;

  FReportManager := AReportManager;

end;

procedure TfrmReports.InitData;
begin
  FReportManager.InitData;
  tbarReports.Enabled := True;
  tbarFilter.Enabled := True;
  actConstructor.Enabled := IsManager;

  _BuildReportsTree();

  FReportManagerLink := TReportManagerLink.Create(FReportManager);
  FReportManagerLink.OnSetActiveReport := _ReportManagerSetActiveReport;
  FReportManagerLink.OnDeleteReport := _ReportManagerDeleteReport;

  FReportFormsManager := TReportFormsManager.Create(pnlReport);
  FReportFormsManager.OnChangeReport := _ReportFormsManagerChangeReport;
  FReportFormsManager.OnModifyReport := _ReportFormsManagerModifyReport;

  actDTAll.Execute();

  _SelectFirstReport();

//  _SubscribeToLanguagesManagerEvents();
//  _LanguageChange(Self);

end; // TfrmReports.Create

procedure TfrmReports.DisableReports;
begin
  tbarReports.Enabled := False;
  tbarFilter.Enabled := False;
  if Assigned(FReportFormsManager) then
    FReportFormsManager.HideAll;
  FreeAndNil(FReportManagerLink);
  FreeAndNil(FReportFormsManager);
  tvReportsNavigator.BeginUpdate();
  try
    tvReportsNavigator.Clear();
  finally
    tvReportsNavigator.EndUpdate();
  end;
end; // TfrmReports.Create

procedure TfrmReports.SetBackColor(AColor: TColor);
begin
  dtpBeginDate.Color := AColor;
  dtpBeginTime.Color := AColor;
  dtpEndDate.Color := AColor;
  dtpEndTime.Color := AColor;
  tvReportsNavigator.Color := AColor;
  if Assigned(FReportFormsManager) then
    FReportFormsManager.SetBackColor(AColor);
end; // TfrmReports.Create

procedure TfrmReports.SetFont(const AFont: TFont);
begin
  dtpBeginDate.Font := AFont;
  dtpBeginTime.Font := AFont;
  dtpEndDate.Font := AFont;
  dtpEndTime.Font := AFont;
  tvReportsNavigator.Font := AFont;
  if Assigned(FReportFormsManager) then
    FReportFormsManager.SetFont(AFont);
end; // TfrmReports.Create

destructor TfrmReports.Destroy();
begin
  if FbReorderNeeded then begin
    _ReorderReports();
  end;

  FreeAndNil(FReportManagerLink);

  FreeAndNil(FReportFormsManager);

//  FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmReports.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

//////////////////////////////////////////////////////////////////////////////
// action events

procedure TfrmReports.actConstructorExecute(Sender: TObject);
begin
  FReportFormsManager.ResetActiveReport();
  _ChangeView();
end; // TfrmReports.actConstructorExecute


procedure TfrmReports.actShowReportViewExecute(Sender: TObject);
begin
  if (Sender = actShowGrid) or (Sender = actShowChart) then begin
    _ChangeView();
  end else begin
    ASSERT(FALSE, 'Unknown sender!');
  end;
end; // TfrmReports.actShowReportViewExecute


procedure TfrmReports.actChartStyleExecute(Sender: TObject);
const
  DEFAULT_REPORT_CHART_STYLE = ReportChartStyle_Bar;
var
  ReportChartStyle: TReportChartStyle;
begin
  if Sender = actChartBar then begin
    ReportChartStyle := ReportChartStyle_Bar;
  end else if Sender = actChartArea then begin
    ReportChartStyle := ReportChartStyle_Area;
  end else if Sender = actChartPie then begin
    ReportChartStyle := ReportChartStyle_Pie;
  end else if Sender = actChartLine then begin
    ReportChartStyle := ReportChartStyle_Line;
  end else if Sender = actChartPoint then begin
    ReportChartStyle := ReportChartStyle_Point;
  end else begin
    ASSERT(FALSE, 'Unknown sender!');
    ReportChartStyle := DEFAULT_REPORT_CHART_STYLE;
  end;
  FReportFormsManager.SetChartStyle(ReportChartStyle);
end; // TfrmReports.actChartStyleExecute


procedure TfrmReports.actChart3DExecute(Sender: TObject);
begin
  FReportFormsManager.SetChart3D(actChart3D.Checked);
end; // TfrmReports.actChart3DExecute


procedure TfrmReports.actChartRandomColorsExecute(Sender: TObject);
begin
  FReportFormsManager.SetChartRandomColors(actChartRandomColors.Checked);
end; // TfrmReports.actChartRandomColorsExecute


procedure TfrmReports.actAutofilterExecute(Sender: TObject);
begin
  FReportFormsManager.EnableAutofilter(actAutofilter.Checked);
end; // TfrmReports.actAutofilterExecute


procedure TfrmReports.actEnableDTFilterExecute(Sender: TObject);
begin
// not execute
end; // TfrmReports.actDTFilterExecute


procedure TfrmReports.actDTExecute(Sender: TObject);
var
  DTI: TTimeInterval;
begin
  cbxAll.Checked := (Sender = actDTAll);

  if Sender = actDTAll then begin
    SetDefaultDTI(DefaultDTI_All, DTI);
  end else if Sender = actDTToday then begin
    SetDefaultDTI(DefaultDTI_Today, DTI);
  end else if Sender = actDTYesterday then begin
    SetDefaultDTI(DefaultDTI_Yesterday, DTI);
  end else if Sender = actDTLast7Days then begin
    SetDefaultDTI(DefaultDTI_Last7Days, DTI);
  end else if Sender = actDTLast30Days then begin
    SetDefaultDTI(DefaultDTI_Last30Days, DTI);
  end else if Sender = actDTCurrentWeek then begin
    SetDefaultDTI(DefaultDTI_CurrentWeek, DTI);
  end else if Sender = actDTCurrentMonth then begin
    SetDefaultDTI(DefaultDTI_CurrentMonth, DTI);
  end else if Sender = actDTCurrentQuarter then begin
    SetDefaultDTI(DefaultDTI_CurrentQuarter, DTI);
  end else if Sender = actDTCurrentYear then begin
    SetDefaultDTI(DefaultDTI_CurrentYear, DTI);
  end else if Sender = actDTQuarter1 then begin
    SetDefaultDTI(DefaultDTI_Quarter1, DTI);
  end else if Sender = actDTQuarter2 then begin
    SetDefaultDTI(DefaultDTI_Quarter2, DTI);
  end else if Sender = actDTQuarter3 then begin
    SetDefaultDTI(DefaultDTI_Quarter3, DTI);
  end else if Sender = actDTQuarter4 then begin
    SetDefaultDTI(DefaultDTI_Quarter4, DTI);
  end else begin
    ASSERT(FALSE, 'Unknown sender!');
    SetDefaultDTI(DefaultDTI_All, DTI);
  end;

  dtpBeginDate.Date := DateOf(DTI.dtBegin);
  dtpBeginTime.Time := TimeOf(DTI.dtBegin);
  dtpEndDate.Date := DateOf(DTI.dtEnd);
  dtpEndTime.Time := TimeOf(DTI.dtEnd);

end; // TfrmReports.actDTExecute


procedure TfrmReports.actDTApplyFilterExecute(Sender: TObject);
begin
  _ResetActiveReport();
end; // TfrmReports.actDTApplyFilterExecute


procedure TfrmReports.actAddReportExecute(Sender: TObject);
begin
  _AddReport(FALSE);
  _ReorderReports();
end; // TfrmReports.actAddReportExecute


procedure TfrmReports.actAddFolderExecute(Sender: TObject);
begin
  _AddReport(TRUE);
  _ReorderReports();
end; // TfrmReports.actAddFolderExecute


procedure TfrmReports.actDeleteReportExecute(Sender: TObject);
var
  ActiveReport: TReport;
begin
  ActiveReport := FReportManager.GetActiveReport();
  if Assigned(ActiveReport) then begin
    _DeleteReportFromTree(ActiveReport.UID);
    FReportManager.DeleteReport(ActiveReport.UID);
//    _ReorderReports();
    _SelectFirstReport();    
  end;
end; // TfrmReports.actDeleteReportExecute


procedure TfrmReports.actAddColumnExecute(Sender: TObject);
var
  Report: TReport;
  ReportColumn: TReportColumn;
begin
  Report := FReportManager.GetActiveReport();
  if Assigned(Report) then begin
    ReportColumn := FReportManager.NewReportColumn(Report);
    if Assigned(ReportColumn) then begin
      FReportFormsManager.AddReportColumn(ReportColumn);
    end;
  end;
end; // TfrmReports.actAddColumnExecute


procedure TfrmReports.actDeleteColumnExecute(Sender: TObject);
var
  nActiveColumnId: Integer;
  ActiveReport: TReport;
begin
  ActiveReport := FReportManager.GetActiveReport();
  nActiveColumnId := FReportFormsManager.GetActiveColumnId();
  if Assigned(ActiveReport) and (nActiveColumnId > 0) then begin
    FReportFormsManager.DeleteReportColumn(nActiveColumnId);
    FReportManager.DeleteReportColumn(ActiveReport, nActiveColumnId);
  end;

end; // TfrmReports.actDeleteColumnExecute


procedure TfrmReports.actExportReportExecute(Sender: TObject);
var
  strExportFile: String;
  dlgSave: TSaveDialog;
  Report: TReport;
begin
  dlgSave := TSaveDialog.Create(Self);
  try
    dlgSave.DefaultExt := 'xml';
    dlgSave.Filter := 'XML (*.xml)|*.xml';
    if dlgSave.Execute() then begin
      strExportFile := dlgSave.FileName;
      Report := FReportManager.GetActiveReport();
      if Assigned(Report) then begin
        FReportManager.ExportReports([Report.UID], strExportFile);
      end;
    end;
  finally
    FreeAndNil(dlgSave);
  end;
end; // TfrmReports.actExportReportExecute


procedure TfrmReports.actImportReportExecute(Sender: TObject);
var
  strImportFile: String;
  dlgOpen: TOpenDialog;
//  Report: TReport;
  nParentId: Integer;
begin
  dlgOpen := TOpenDialog.Create(Self);
  try
    dlgOpen.DefaultExt := 'xml';
    dlgOpen.Filter := 'XML (*.xml)|*.xml';
    if dlgOpen.Execute() then begin
      strImportFile := dlgOpen.FileName;
      if FileExists(strImportFile) then begin
        nParentId := _GetNewReportParentId();
        FReportManager.ImportReports(strImportFile, nParentId);
        _RefreshSubtree(nParentId);
        _ReorderReports();
      end;
    end;
  finally
    FreeAndNil(dlgOpen);
  end;
end; // TfrmReports.actImportReportExecute


procedure TfrmReports.actSaveToFileExecute(Sender: TObject);
begin
  FReportFormsManager.SaveToFile();
end; // TfrmReports.actSaveTableExecute


procedure TfrmReports.actPrintExecute(Sender: TObject);
begin
  FReportFormsManager.Print();
end; // TfrmReports.actPrintExecute


procedure TfrmReports.actlstReportsUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  bChartActive: Boolean;
begin
  actShowGrid.Visible := not actConstructor.Checked;
  actShowChart.Visible := not actConstructor.Checked;
  tbarMainSeparator2.Visible := not actConstructor.Checked;

  actAddReport.Visible := actConstructor.Checked;
  actAddFolder.Visible := actConstructor.Checked;
  actDeleteReport.Visible := actConstructor.Checked;
  actAddColumn.Visible := actConstructor.Checked;
  actDeleteColumn.Visible := actConstructor.Checked;
  tbarMainSeparator5.Visible := actConstructor.Checked;
  actExportReport.Visible := actConstructor.Checked;
  actImportReport.Visible := actConstructor.Checked;
  tbarMainSeparator6.Visible := actConstructor.Checked;

  NavigatorMenuSeparator1.Visible := actConstructor.Checked;

  bChartActive := (not actConstructor.Checked) and actShowChart.Checked;

  tbtnChartStyle.Visible := bChartActive;
  actChart3D.Visible := bChartActive;
  actChartRandomColors.Visible := bChartActive;
  tbarMainSeparator3.Visible := FALSE;

  actAutofilter.Visible := (not actConstructor.Checked) and actShowGrid.Checked;
  actEnableDTFilter.Visible := (not actConstructor.Checked) and actShowGrid.Checked;
  actSaveToFile.Visible := not actConstructor.Checked;
  actPrint.Visible := not actConstructor.Checked;
  tbarMainSeparator7.Visible := not actConstructor.Checked;

  tbarFilter.Visible := actEnableDTFilter.Checked
      and (not actConstructor.Checked);

  if actChartBar.Checked then begin
    tbtnChartStyle.ImageIndex := CHART_BAR_IMAGE_INDEX;
  end else if actChartArea.Checked then begin
    tbtnChartStyle.ImageIndex := CHART_AREA_IMAGE_INDEX;
  end else if actChartPie.Checked then begin
    tbtnChartStyle.ImageIndex := CHART_PIE_IMAGE_INDEX;
  end else if actChartLine.Checked then begin
    tbtnChartStyle.ImageIndex := CHART_LINE_IMAGE_INDEX;
  end else if actChartPoint.Checked then begin
    tbtnChartStyle.ImageIndex := CHART_POINT_IMAGE_INDEX;
  end else begin
    ASSERT(FALSE);
  end;

end; // TfrmReports.actlstReportsUpdate


//////////////////////////////////////////////////////////////////////////////
// tree events

procedure TfrmReports.tvReportsNavigatorInitNode(Sender: TBaseVirtualTree;
    ParentNode, Node: PVirtualNode;
    var InitialStates: TVirtualNodeInitStates);
var
  ptrData: PReportData;
begin
  ptrData := Sender.GetNodeData(Node);
  ptrData.Caption := '';
end; // TfrmReports.tvReportsNavigatorInitNode


procedure TfrmReports.tvReportsNavigatorFreeNode(Sender: TBaseVirtualTree;
    Node: PVirtualNode);
var
  ptrData: PReportData;
begin
  ptrData := Sender.GetNodeData(Node);
  if Assigned(ptrData) then begin
    ptrData.Caption := '';
  end;
end; // TfrmReports.tvReportsNavigatorFreeNode


procedure TfrmReports.tvReportsNavigatorGetText(Sender: TBaseVirtualTree;
    Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
    var CellText: WideString);
var
  ptrData: PReportData;
begin
  ptrData := Sender.GetNodeData(Node);
  if Assigned(ptrData) then begin
    CellText := ptrData.Caption;
  end;
end; // TfrmReports.tvReportsNavigatorGetText


procedure TfrmReports.tvReportsNavigatorGetImageIndex(
    Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
    Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  ptrData: PReportData;
begin
  if (Kind in [ikNormal, ikSelected ]) then begin
    ptrData := Sender.GetNodeData(Node);
    if Assigned(ptrData) then begin
      if ptrData^.IsFolder then begin
        ImageIndex := 0;
      end else begin
        ImageIndex := 1;
      end;
    end;
    Ghosted := FALSE;
  end;
end; // TfrmReports.tvReportsNavigatorGetImageIndex


procedure TfrmReports.tvReportsNavigatorLoadNode(Sender: TBaseVirtualTree;
    Node: PVirtualNode; Stream: TStream);
var
  ptrNodeData: PReportData;
begin
  ptrNodeData := Sender.GetNodeData(Node);
  if Assigned(ptrNodeData) then begin
    Stream.Read(ptrNodeData^, SizeOf(TReportData));
  end;
end; // TfrmReports.tvReportsNavigatorLoadNode


procedure TfrmReports.tvReportsNavigatorSaveNode(Sender: TBaseVirtualTree;
    Node: PVirtualNode; Stream: TStream);
var
  ptrNodeData: PReportData;
begin
  ptrNodeData := Sender.GetNodeData(Node);
  if Assigned(ptrNodeData) then begin
    Stream.Write(ptrNodeData^, SizeOf(TReportData));
  end;
end; // TfrmReports.tvReportsNavigatorSaveNode


procedure TfrmReports.tvReportsNavigatorChange(Sender: TBaseVirtualTree;
    Node: PVirtualNode);
var
  ptrNodeData: PReportData;
begin
  if Assigned(Node) then begin
    ptrNodeData := tvReportsNavigator.GetNodeData(Node);
    _SetActiveReport(ptrNodeData^.id);
  end;
end; // TfrmReports.tvReportsNavigatorChange


//////////////////////////////////////////////////////////////////////////////
// drag & drop events

procedure TfrmReports.tvReportsNavigatorDragAllowed(
    Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
    var Allowed: Boolean);
begin
  Allowed := (Sender = tvReportsNavigator);
end; // TfrmReports.tvReportsNavigatorDragAllowed


procedure TfrmReports.tvReportsNavigatorDragOver(Sender: TBaseVirtualTree;
    Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
    Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  Accept := TRUE;
end; // TfrmReports.tvReportsNavigatorDragOver


procedure TfrmReports.tvReportsNavigatorDragDrop(Sender: TBaseVirtualTree;
    Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
    Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  Attachmode: TVTNodeAttachMode;
  Nodes: TNodeArray;
  i: Integer;
  ptrNodeData: PReportData;
begin
  Nodes := nil;

  case Mode of
    dmAbove: begin
      AttachMode := amInsertBefore;
    end;
    dmOnNode: begin
      AttachMode := amAddChildLast;
    end;
    dmBelow: begin
      AttachMode := amInsertAfter;
    end;
    else begin
      AttachMode := amNowhere;
    end;
  end;

  if Source = tvReportsNavigator then begin
    Effect := DROPEFFECT_MOVE;
    Nodes := tvReportsNavigator.GetSortedSelection(TRUE);
    ptrNodeData := Sender.GetNodeData(Sender.DropTargetNode);
    if Assigned(ptrNodeData) then begin
      if ptrNodeData^.IsFolder or (AttachMode <> amAddChildLast) then begin
        for i := 0 to High(Nodes) do begin
          tvReportsNavigator.MoveTo(Nodes[i], Sender.DropTargetNode, AttachMode, FALSE);
        end;
        Sender.Expanded[Sender.DropTargetNode] := TRUE;
        FbReorderNeeded := TRUE;
      end;
    end;
  end;

end; // TfrmReports.tvReportsNavigatorDragDrop


//////////////////////////////////////////////////////////////////////////////
// other events

procedure TfrmReports.cbxAllClick(Sender: TObject);
begin
  if cbxAll.Checked then begin
    actDTAll.Execute();
  end;
  _TuneFilterToolbar();
end; // TfrmReports.cbxAllClick


procedure TfrmReports._ReportManagerSetActiveReport(
    const ASender: TObject; const AActiveReport: TReport);
begin
  if AActiveReport.IsFolder then begin
    FReportFormsManager.SetActiveFolder(
        AActiveReport, tvReportsNavigator, tvReportsNavigator.FocusedNode);
  end else begin
    FReportFormsManager.SetActiveReport(AActiveReport);
  end;
  _SelectReport(AActiveReport.UID);
  _ChangeView();
end; // TfrmReports._ReportManagerSetActiveReport


procedure TfrmReports._ReportManagerDeleteReport(
    const ASender: TObject; const AnDeleteReportId: Integer);
begin
  FReportFormsManager.ReportDeleted(AnDeleteReportId);
end; // TfrmReports._ReportManagerDeleteReport


procedure TfrmReports._ReportFormsManagerChangeReport(
    const ASender: TObject; const AnReportId: Integer);
begin
  _SetActiveReport(AnReportId);
end; // TfrmReports._ReportFormsManagerChangeReport


procedure TfrmReports._ReportFormsManagerModifyReport(
    const ASender: TObject);
var
  ptrFocusedNode: PVirtualNode;
  ptrNodeData: PReportData;
  ActiveReport: TReport;
begin
  ptrFocusedNode := tvReportsNavigator.FocusedNode;
  if Assigned(ptrFocusedNode) then begin
    ptrNodeData := tvReportsNavigator.GetNodeData(ptrFocusedNode);
    if Assigned(ptrNodeData) then begin
      ActiveReport := FReportManager.GetActiveReport();
      if Assigned(ActiveReport) then begin
        ptrNodeData^.Caption := ActiveReport.ReportName;
        tvReportsNavigator.InvalidateNode(ptrFocusedNode);
      end;
    end;
  end;
end; // TfrmReports._ReportFormsManagerModifyReport

{
procedure TfrmReports._LanguageChange(ASender: TObject);
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, TCheckBox(cbxAll));
    GetString(CLASS_NAME, TAction(actConstructor));
    GetString(CLASS_NAME, TAction(actShowGrid));
    GetString(CLASS_NAME, TAction(actShowChart));
    GetString(CLASS_NAME, TAction(actAddReport));
    GetString(CLASS_NAME, TAction(actDeleteReport));
    GetString(CLASS_NAME, TAction(actAddColumn));
    GetString(CLASS_NAME, TAction(actDeleteColumn));
    GetString(CLASS_NAME, TAction(actAddFolder));
    GetString(CLASS_NAME, TAction(actExportReport));
    GetString(CLASS_NAME, TAction(actImportReport));
    GetString(CLASS_NAME, TAction(actAutofilter));
    GetString(CLASS_NAME, TAction(actEnableDTFilter));
    GetString(CLASS_NAME, TAction(actDTAll));
    GetString(CLASS_NAME, TAction(actDTToday));
    GetString(CLASS_NAME, TAction(actDTYesterday));
    GetString(CLASS_NAME, TAction(actDTLast7Days));
    GetString(CLASS_NAME, TAction(actDTLast30Days));
    GetString(CLASS_NAME, TAction(actDTCurrentWeek));
    GetString(CLASS_NAME, TAction(actDTCurrentMonth));
    GetString(CLASS_NAME, TAction(actDTCurrentQuarter));
    GetString(CLASS_NAME, TAction(actDTCurrentYear));
    GetString(CLASS_NAME, TAction(actDTQuarter1));
    GetString(CLASS_NAME, TAction(actDTQuarter2));
    GetString(CLASS_NAME, TAction(actDTQuarter3));
    GetString(CLASS_NAME, TAction(actDTQuarter4));
    GetString(CLASS_NAME, TAction(actDTApplyFilter));
    GetString(CLASS_NAME, TAction(actSaveToFile));
    GetString(CLASS_NAME, TAction(actPrint));
    GetString(CLASS_NAME, TAction(actChartBar));
    GetString(CLASS_NAME, TAction(actChartArea));
    GetString(CLASS_NAME, TAction(actChartPie));
    GetString(CLASS_NAME, TAction(actChartLine));
    GetString(CLASS_NAME, TAction(actChartPoint));
    GetString(CLASS_NAME, TAction(actChart3D));
    GetString(CLASS_NAME, TAction(actChartRandomColors));
    GetString(CLASS_NAME, TMenuItem(pmiDTQuarters));
  end;
end; // TfrmReports._LanguageChange
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmReports._BuildReportsTree();
begin
  tvReportsNavigator.BeginUpdate();
  try
    tvReportsNavigator.Clear();
    _BuildTree(nil, 0);
  finally
    tvReportsNavigator.EndUpdate();
  end;
end; // TfrmReports._BuildReportsTree


// recursive tree building
procedure TfrmReports._BuildTree(const AnodParent: PVirtualNode;
    const AnParent: Integer);
var
  ptrReportData: PReportData;
  ptrNode: PVirtualNode;
  i: Integer;
begin
  for i := 0 to FReportManager.Reports.Count - 1 do begin
    if FReportManager.Reports[i].ParentId = AnParent then begin
      if Assigned(AnodParent) then begin
        tvReportsNavigator.ChildCount[AnodParent] :=
            tvReportsNavigator.ChildCount[AnodParent] + 1;
        ptrNode := tvReportsNavigator.GetLast(AnodParent);
      end else begin
        tvReportsNavigator.RootNodeCount :=
            tvReportsNavigator.RootNodeCount + 1;
        ptrNode := tvReportsNavigator.GetLast();
      end;

      ASSERT(Assigned(ptrNode));
      ptrReportData := tvReportsNavigator.GetNodeData(ptrNode);
      ASSERT(Assigned(ptrReportData));
      ptrReportData^.id := FReportManager.Reports[i].UID;
      ptrReportData^.Caption := FReportManager.Reports[i].ReportName;
      ptrReportData^.IsFolder := FReportManager.Reports[i].IsFolder;

      _BuildTree(ptrNode, FReportManager.Reports[i].UID);

    end;
  end;

end; // TfrmReports._BuildTree


procedure TfrmReports._SetActiveReport(const AnId: Integer);
var
  ReportParameters: TReportParameters;
begin
  ReportParameters := _GetReportParameters();
  FReportManager.SetActiveReport(AnId, ReportParameters);
end; // TfrmReports._SetActiveReport


procedure TfrmReports._ResetActiveReport();
var
  ptrFocusedNode: PVirtualNode;
  ptrNodeData: PReportData;
begin
  ptrFocusedNode := tvReportsNavigator.FocusedNode;
  if Assigned(ptrFocusedNode) then begin
    ptrNodeData := tvReportsNavigator.GetNodeData(ptrFocusedNode);
    if Assigned(ptrNodeData) then begin
      _SetActiveReport(ptrNodeData^.id);
    end;
  end;
end; // TfrmReports._ResetActiveReport


procedure TfrmReports._ChangeView();
begin
  if actConstructor.Checked and IsManager then begin
    FReportFormsManager.ShowForm(rftEdit);
  end else begin
    if actShowGrid.Checked then begin
      FReportFormsManager.ShowForm(rftGrid);
    end else begin
      FReportFormsManager.ShowForm(rftChart);
    end;
  end;
end; // TfrmReports._ChangeView


procedure TfrmReports._SelectFirstReport();
var
  ptrNode: PVirtualNode;
begin
  ptrNode := tvReportsNavigator.GetFirstVisible();
  if Assigned(ptrNode) then begin
    tvReportsNavigator.FocusedNode := ptrNode;
    tvReportsNavigator.Selected[ptrNode] := TRUE;
  end;
end; // TfrmReports._SelectFirstReport


procedure TfrmReports._SelectReport(const AnReportId: Integer);
var
  ptrNode: PVirtualNode;
  ptrData: PReportData;
begin
  ptrNode := tvReportsNavigator.GetFirst();
  while Assigned(ptrNode) do begin
    ptrData := tvReportsNavigator.GetNodeData(ptrNode);
    if ptrData^.id = AnReportId then begin
      tvReportsNavigator.FocusedNode := ptrNode;
      tvReportsNavigator.Selected[ptrNode] := TRUE;
    end;
    ptrNode := tvReportsNavigator.GetNext(ptrNode);
  end;
end; // TfrmReports._SelectReport


procedure TfrmReports._TuneFilterToolbar();
begin
  dtpBeginDate.Enabled := not cbxAll.Checked;
  dtpBeginTime.Enabled := not cbxAll.Checked;
  dtpEndDate.Enabled := not cbxAll.Checked;
  dtpEndTime.Enabled := not cbxAll.Checked;
end; // TfrmReports._TuneFilterToolbar


function TfrmReports._GetReportParameters(): TReportParameters;
var
  ReportParameters: TReportParameters;
begin
  ReportParameters.dtCurrent := GetVirtualTime;
  ReportParameters.dtBegin :=
      DateOf(dtpBeginDate.DateTime) + TimeOf(dtpBeginTime.DateTime);
  ReportParameters.dtEnd :=
      DateOf(dtpEndDate.DateTime) + TimeOf(dtpEndTime.DateTime);
  ReportParameters.dtCurrentShiftBegin := GetCurrentShiftBegin(ReportParameters.dtCurrent);
  ReportParameters.dtPrevShiftBegin := GetCurrentShiftBegin(ReportParameters.dtCurrentShiftBegin);
  ReportParameters.dtPrevShiftEnd := ReportParameters.dtCurrentShiftBegin;
  Result := ReportParameters;
end; // TfrmReports._GetReportParameters


function TfrmReports._GetNewReportParentId(): Integer;
var
  ActiveReport: TReport;
begin
  Result := 0;
  ActiveReport := FReportManager.GetActiveReport();
  if Assigned(ActiveReport) then begin
    if ActiveReport.IsFolder then begin
      Result := ActiveReport.UID;
    end else begin
      Result := ActiveReport.ParentId;
    end;
  end;
end; // TfrmReports._GetNewReportParentId


procedure TfrmReports._AddReportToTree(const AnParentId: Integer;
    const AReport: TReport);
var
  ptrNode: PVirtualNode;
  ptrNodeData: PReportData;
begin
  ptrNode := _FindNodeById(AnParentId);
  if Assigned(ptrNode) then begin
    tvReportsNavigator.ChildCount[ptrNode] :=
        tvReportsNavigator.ChildCount[ptrNode] + 1;
    ptrNode := tvReportsNavigator.GetLast(ptrNode);
  end else begin
    tvReportsNavigator.RootNodeCount :=
        tvReportsNavigator.RootNodeCount + 1;
    ptrNode := tvReportsNavigator.GetLast;
  end;
  ASSERT(Assigned(ptrNode));

  ptrNodeData := tvReportsNavigator.GetNodeData(ptrNode);
  ASSERT(Assigned(ptrNodeData));

  ptrNodeData^.id := AReport.UID;
  ptrNodeData^.Caption := AReport.ReportName;
  ptrNodeData^.IsFolder := AReport.IsFolder;

  tvReportsNavigator.InvalidateNode(ptrNode); 

end; // TfrmReports._AddReportToTree


procedure TfrmReports._DeleteReportFromTree(const AnId: Integer);
var
  ptrNode: PVirtualNode;
begin
  ptrNode := _FindNodeById(AnId);
  if Assigned(ptrNode) then begin
    tvReportsNavigator.BeginUpdate();
    try
      tvReportsNavigator.DeleteNode(ptrNode, False);
    finally
      tvReportsNavigator.EndUpdate();    
    end;
  end;
end; // TfrmReports._DeleteReportFromTree


function TfrmReports._FindNodeById(const AnId: Integer): PVirtualNode;
var
  ptrNode: PVirtualNode;
  ptrNodeData: PReportData;
begin
  Result := nil;
  ptrNode := tvReportsNavigator.GetFirst();
  while Assigned(ptrNode) do begin
    ptrNodeData := tvReportsNavigator.GetNodeData(ptrNode);
    ASSERT(Assigned(ptrNodeData));
    if Assigned(ptrNodeData) then begin
      if ptrNodeData^.id = AnId then begin
        Result := ptrNode;
        break;
      end;
    end;
    ptrNode := tvReportsNavigator.GetNext(ptrNode);
  end;
end; // TfrmReports._FindNodeById


procedure TfrmReports._AddReport(const AbIsFolder: Boolean);
var
  Report: TReport;
  nParentId: Integer;
begin
  nParentId := _GetNewReportParentId();
  Report := FReportManager.NewReport(nParentId, AbIsFolder);
  if Assigned(Report) then begin
    _AddReportToTree(nParentId, Report);
    _SelectReport(Report.UID);
  end;
end; // TfrmReports._AddReport


procedure TfrmReports._ReorderReports();
var
  Reports: TReportList;
  Report: TReport;
  ptrNode: PVirtualNode;
  ptrNodeData: PReportData;
  ptrParentNode: PVirtualNode;
  ptrParentNodeData: PReportData;
  i: Integer;
begin
  Reports := FReportManager.Reports;
  if Reports.Count = 0 then begin
    exit;
  end;

  ptrNode := tvReportsNavigator.GetFirst();
  i := 0;
  while Assigned(ptrNode) do begin
    ptrNodeData := tvReportsNavigator.GetNodeData(ptrNode);
    if Assigned(ptrNodeData) then begin
      Report := Reports.FindByUID(ptrNodeData^.id);
      Report.OrderIndex := i;

      Report.ParentId := 0;
      ptrParentNode := ptrNode.Parent;
      if Assigned(ptrParentNode) then begin
        ptrParentNodeData := tvReportsNavigator.GetNodeData(ptrParentNode);
        if Assigned(ptrParentNodeData) then begin
          Report.ParentId := ptrParentNodeData^.id;
        end;
      end;

      Report.Save(FALSE);
    end;
    inc(i);
    ptrNode := tvReportsNavigator.GetNext(ptrNode);
  end;

  FbReorderNeeded := FALSE;

end; // TfrmReports._ReorderReports


procedure TfrmReports._RefreshSubtree(const AnParentId: Integer);
var
  ptrNode: PVirtualNode;
//  ptrNodeData: PReportData;
  i: Integer;
  Report: TReport;
begin
  for i := 0 to FReportManager.Reports.Count - 1 do begin
    Report := FReportManager.Reports[i];
    if Report.ParentId = AnParentId then begin
      ptrNode := _FindNodeById(Report.UID);
      if not Assigned(ptrNode) then begin
        _AddReportToTree(AnParentId, Report);
      end;
    end;
  end;
end; // TfrmReports._RefreshSubtree


{procedure TfrmReports._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmReports._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');

  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmReports._SubscribeToLanguagesManagerEvents
}

end.
