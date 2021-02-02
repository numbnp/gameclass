unit Unit1;

{$I EhLib.Inc}

{$DEFINE EMBEDDED_LANGUAGE_RESOURCES}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_7}
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
{$ENDIF}
{$IFDEF CIL}
  System.ComponentModel, Variants, System.Runtime.InteropServices,
{$ELSE}
{$ENDIF}
{$IFDEF EH_LIB_16} Themes, {$ENDIF}
  EhLibImages, Types, ActiveX,
  DBGridEhImpExp, XlsMemFilesEh, ShellAPI, DBGridEhXlsMemFileExporters,
  Dialogs, Buttons, ExtCtrls, ComCtrls, ToolWin, DBGridEh, Menus,
  IniFiles, DataDriverEh, ADODataDriverEh, EhLibVCL,
  DBVertGridsEh, PivotGridsEh, PlannersEh,  
  FrameMainGrid, FrameMasterDetail, FrameFishFact, FrameMailBox,
  EhLibMTE, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  MemTableDataEh, Db, MemTableEh, GridsEh, StdCtrls, Mask, DBCtrlsEh,
  ImgList, StdActns, ActnList, PrnDbgeh, DBAxisGridsEh, DynVarsEh;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Exit1: TMenuItem;
    miAbout: TMenuItem;
    Splitter1: TSplitter;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    Bevel1: TBevel;
    ADOConnectionProviderEh2: TADOConnectionProviderEh;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    PanelXEStyles: TPanel;
    DBComboBoxEh1: TDBComboBoxEh;
    PaintBox1: TPaintBox;
    stVCLStyle: TStaticText;
    ImageList16: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ActionList1: TActionList;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    actPreview: TAction;
    PrintDBGridEh1: TPrintDBGridEh;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    actExit: TAction;
    actAbout: TAction;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    actShowObjInspector: TAction;
    miLanguage: TMenuItem;
    MemTableEh1MenuName: TWideStringField;
    MemTableEh1RefFrameClass: TRefObjectField;
    MemTableEh1RefFrame: TRefObjectField;
    actRightToLeft: TAction;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    actExportToExcel: TAction;
    ImageList32: TImageList;
    ImageList24: TImageList;
    ToolButton15: TToolButton;
    actExportToTextFile: TAction;
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure ToolBar1CustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure miAboutClick(Sender: TObject);
    procedure ADOConnectionProviderEh2InlineConnectionBeforeConnect(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure DBComboBoxEh1Change(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure actPreviewExecute(Sender: TObject);
    procedure MemTableEh1AfterScroll(DataSet: TDataSet);
    procedure actExitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actShowObjInspectorExecute(Sender: TObject);
    procedure actRightToLeftExecute(Sender: TObject);
    procedure actRightToLeftUpdate(Sender: TObject);
    procedure actExportToExcelExecute(Sender: TObject);
    procedure actExportToTextFileExecute(Sender: TObject);
  private
    procedure InitLanguageRes;
    procedure BuildLanguageMenu;
    procedure MenuItemSelectLanguage(Sender: TObject);
    procedure CheckActiveLanguageMi;
    procedure ResourceLanguageChanged;

    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;

  protected
    procedure CreateWnd; override;
  public
    Frame: TFrame;
    CurPan: TPanel;

    frMainGrid: TfrMainGrid;
    frMasterDetail: TfrMasterDetail;
    LanguageAutoselected: Boolean;
    AutoDetectMi: TMenuItem;

    function TestInitXE2: Boolean;
    procedure FillFrameTopPanel(ACanvas: TCanvas; const ARect: TRect);
    procedure ScaleFontHeight(Control: TControl; M, D: Integer; SrcH, ChH: Integer);
{$IFDEF EH_LIB_27} //XE10.4
    procedure ScaleForPPI(NewPPI: Integer); override;
{$ENDIF}
  end;

var
  Form1: TForm1;


type
  TGradientDirection = (gdHorizontal, gdVertical);

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);

function IsOLEObjectAvailable(const ClassName: string): Boolean;

implementation

{$R *.dfm}

uses ObjectInspectorEh, FormAbout,
{$IFDEF EMBEDDED_LANGUAGE_RESOURCES}
  EhLibEmbeddedLangConsts,
{$ENDIF}
  LanguageResManEh, EhLibLangConsts, AppLangConsts,
  FrameTreeView,
  FrameEditControls,
  FrameRowDetailPanel,
  FrameDataGrouping,
  FrameBackgroundImages,
  FrameRowAsPanel,
  FrameLiveRestructure,
  FrameWorkingWithHugeData,
  FrameMemTableSaveLoad,
  FrameImportExport,
  FrameSearchPanel,
  FrameVertGrid,
  FrameDropDownForms,
  FrameEditControls2,
  FramePivotGrid,
  FrameCellDataIsLink,
  FrameCellButtons,
  FramePlanner,
  FrameDataSetTextExporter,
  FrameDataSetTextImporter,
  UnitDBGridEhTextExportOptions,
  UnitXlsxExportOptions;

type

  TMyTriVertex = packed record
    x: Longint;
    y: Longint;
    Red: Word;
    Green: Word;
    Blue: Word;
    Alpha: Word;
  end;

function MyGradientFill(DC: HDC; var Vertex: TMyTriVertex;
  NumVertex: ULONG; Mesh: Pointer; NumMesh, Mode: ULONG): BOOL; stdcall; external msimg32 name 'GradientFill';

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);
const
  cGradientDirections: array[TGradientDirection] of Cardinal =
    (GRADIENT_FILL_RECT_H, GRADIENT_FILL_RECT_V);
var
  StartColor, EndColor: Cardinal;
  Vertexes: array[0..1] of TMyTriVertex;
  GradientRect: TGradientRect;
begin
  StartColor := ColorToRGB(AStartColor);
  EndColor := ColorToRGB(AEndColor);

  Vertexes[0].x := ARect.Left;
  Vertexes[0].y := ARect.Top;
  Vertexes[0].Red := GetRValue(StartColor) shl 8;
  Vertexes[0].Blue := GetBValue(StartColor) shl 8;
  Vertexes[0].Green := GetGValue(StartColor) shl 8;
  Vertexes[0].Alpha := 0;

  Vertexes[1].x := ARect.Right;
  Vertexes[1].y := ARect.Bottom;
  Vertexes[1].Red := GetRValue(EndColor) shl 8;
  Vertexes[1].Blue := GetBValue(EndColor) shl 8;
  Vertexes[1].Green := GetGValue(EndColor) shl 8;
  Vertexes[1].Alpha := 0;

  GradientRect.UpperLeft := 0;
  GradientRect.LowerRight := 1;

  MyGradientFill(ACanvas.Handle, Vertexes[0], 2, @GradientRect, 1, cGradientDirections[Direction]);
end;

procedure InitLangDir;
begin
  if FileExists(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+LanguageResourcesFolder+'\EhLibLangConsts.ENU.dfm') then
    LanguageResourcesFolder := LanguageResourcesFolder
  else if FileExists(ExtractFilePath(ParamStr(0))+'..'+LanguageResourcesFolder+'\EhLibLangConsts.ENU.dfm') then
    LanguageResourcesFolder := '\..'+LanguageResourcesFolder
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..'+LanguageResourcesFolder+'\EhLibLangConsts.ENU.dfm') then
    LanguageResourcesFolder := '\..\..'+LanguageResourcesFolder
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ScaleFontHeight(Control: TControl; M, D: Integer; SrcH, ChH: Integer);
begin
//  if Control.ParentFont
end;

function TForm1.TestInitXE2: Boolean;
{$IFDEF EH_LIB_16}
var
  sa: TArray<string>;
  i: Integer;
begin
  Result := True;
  sa := TStyleManager.StyleNames;
  for I := 0 to Length(sa)-1 do
    DBComboBoxEh1.Items.Add(sa[i]);
  DBComboBoxEh1.ItemIndex := 0;
end;
{$ELSE}
begin
  Result := False;
end;
{$ENDIF}

procedure TForm1.FillFrameTopPanel(ACanvas: TCanvas; const ARect: TRect);
begin
  GradientFillCanvas(ACanvas,
    ApproximateColor(StyleServices.GetSystemColor(clBtnFace), StyleServices.GetSystemColor(clWindow), 170),
    StyleServices.GetSystemColor(clBtnFace),
    ARect, gdVertical);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PanelXEStyles.Visible := TestInitXE2;


  DBGridEh1.Font.Color := clNavy;

  frMainGrid := TfrMainGrid.Create(Self);
  frMainGrid.Parent := Panel1;
  Frame := frMainGrid;

  InitLanguageRes;
  BuildLanguageMenu;

  DataSource1.OnDataChange := DataSource1DataChange;

  if (UseRightToLeftAlignment) then
      FlipChildren(True);
end;

procedure TForm1.ADOConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb';

  ADOConnectionProviderEh1.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

procedure TForm1.ADOConnectionProviderEh2InlineConnectionBeforeConnect(
  Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\BioLife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\BioLife.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\BioLife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\BioLife.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\BioLife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\BioLife.mdb';

  ADOConnectionProviderEh2.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if Frame = frMasterDetail then Exit;
  if frMasterDetail = nil then
    frMasterDetail := TfrMasterDetail.Create(Self);
  Frame.Parent := nil;
  Frame := frMasterDetail;
  Frame.Parent := Panel1;

//  SpeedBPanel2.Color := CurPan.Color;
  CurPan.Color := clBtnFace;
//  CurPan := SpeedBPanel2;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if Frame = frMainGrid then Exit;
  if frMainGrid = nil then
    frMainGrid := TfrMainGrid.Create(Self);
  Frame.Parent := nil;
  Frame := frMainGrid;
  Frame.Parent := Panel1;

//  SpeedBPanel1.Color := CurPan.Color;
  CurPan.Color := clBtnFace;
//  CurPan := SpeedBPanel1;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  ShowMessage('To Do');
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  ShowMessage('To Do');
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  ShowMessage('To Do');
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  ShowMessage('To Do');
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  ShowMessage('To Do');
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
  ShowMessage('To Do');
end;

procedure TForm1.ToolBar1CustomDraw(Sender: TToolBar; const ARect: TRect;
  var DefaultDraw: Boolean);
begin
  GradientFillCanvas(Sender.Canvas, ApproachToColorEh(clWindow, $00D6D6D6, 30),
    ApproachToColorEh($00D6D6D6, clWindow, 30), ARect, gdVertical);
end;

procedure TForm1.DBComboBoxEh1Change(Sender: TObject);
begin
{$IFDEF EH_LIB_16}
  TStyleManager.TrySetStyle(DBComboBoxEh1.Items[DBComboBoxEh1.ItemIndex]);
{$ENDIF}
end;

procedure TForm1.DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if gdSelected in State then
    AFont.Style := [fsBold];
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
var
  AClass: TWinControlClass;
  AFrame: TWinControl;
  Rec: TMemoryRecordEh;
  OldFrame :TFrame;
begin
  if MemTableEh1RefFrame.Value = nil then
  begin
    if MemTableEh1RefFrameClass.Value = nil then
    begin
      MemTableEh1.InstantReadEnter(MemTableEh1.InstantReadCurRow+1);
      Rec := MemTableEh1.Rec;
      if MemTableEh1RefFrame.Value = nil then
      begin
        AClass := TWinControlClass(MemTableEh1RefFrameClass.Value);
        AFrame := AClass.Create(Self);
      end else
        AFrame := TWinControl(MemTableEh1RefFrame.Value);
      MemTableEh1.InstantReadLeave;
      DataSource1.OnDataChange := nil;
      MemTableEh1.Edit;
      MemTableEh1RefFrame.Value := AFrame;
      MemTableEh1.Post;
      DataSource1.OnDataChange := DataSource1DataChange;
      if VarIsNull(Rec.DataValues['RefFrame', dvvValueEh]) then
        Rec.DataValues['RefFrame', dvvValueEh] := RefObjectToVariant(MemTableEh1RefFrame.Value);

//      ShowMessage('To Do')
    end else
    begin
      DataSource1.OnDataChange := nil;
      MemTableEh1.Edit;
      MemTableEh1RefFrame.Value := TWinControlClass(MemTableEh1RefFrameClass.Value).Create(Self);
      MemTableEh1.Post;
      DataSource1.OnDataChange := DataSource1DataChange;
    end;
  end;

  OldFrame := Frame;
//  Frame.Parent := nil;
  if (MemTableEh1RefFrame.Value <> nil) and (MemTableEh1RefFrame.Value <> Frame) then
  begin
    Frame := TFrame(MemTableEh1RefFrame.Value);
    Frame.Parent := Panel1;
    Frame.Align := alClient;
    if Frame is TfrEditControls then TfrEditControls(Frame).UpdateLabels;
    OldFrame.Parent := nil;
    Panel1.Update;
  end;
end;

procedure TForm1.miAboutClick(Sender: TObject);
begin
  ShowAboutForm;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  Height := Height - 1;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  Height := Height + 1;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TForm1.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  actPreview.Enabled :=
    (ActiveControl is TCustomDBGridEh) or
    (ActiveControl is TCustomDBVertGridEh) or
    (ActiveControl is TCustomPlannerViewEh) or
    (ActiveControl is TPivotGridEh);
    
  actExportToExcel.Enabled :=
    (ActiveControl is TCustomDBGridEh);
  actExportToTextFile.Enabled :=
    (ActiveControl is TCustomDBGridEh);

  actExit.Enabled := True;
end;

procedure TForm1.actPreviewExecute(Sender: TObject);
begin
  if ActiveControl is TCustomDBGridEh then
  begin
    PrintDBGridEh1.DBGridEh := TDBGridEh(ActiveControl);
    PrintDBGridEh1.Preview;
  end else if ActiveControl is TCustomDBVertGridEh then
  begin
    TCustomDBVertGridEh(ActiveControl).PrintService.Preview;
  end else if ActiveControl is TCustomPlannerViewEh then
  begin
    TCustomPlannerViewEh(ActiveControl).PlannerControl.PrintService.Preview;
  end else if ActiveControl is TPivotGridEh then
  begin
    TPivotGridEh(ActiveControl).PrintService.Preview;
  end;
end;

function IsOLEObjectAvailable(const ClassName: string): Boolean;
var
  ClassID: TCLSID;
begin
  Result := Succeeded(CLSIDFromProgID(PWideChar(WideString(ClassName)),
    ClassID));
end;

procedure TForm1.actExportToExcelExecute(Sender: TObject);
var
  Grid: TDBGridEh;
  Path: String;
  FileName: String;
  ExportOptions: TDBGridEhXlsMemFileExportOptions;
begin
  Grid := TDBGridEh(ActiveControl);

  if (FormXlsxExportOptions = nil) then
    FormXlsxExportOptions := TFormXlsxExportOptions.Create(Application);

  if (FormXlsxExportOptions.ShowModal <> mrOk) then Exit;

  GetDir(0, Path);
  FileName := Path + '\DBGridEhAsXlsx.Xlsx';

  ExportOptions := TDBGridEhXlsMemFileExportOptions.Create;
  ExportOptions.IsExportSelecting := False;
  ExportOptions.IsExportTitle := FormXlsxExportOptions.cbExportTitle.Checked;
  ExportOptions.IsExportFooter := FormXlsxExportOptions.cbExportFooter.Checked;
  ExportOptions.IsExportFontFormat := FormXlsxExportOptions.cbFontFormat.Checked;
  ExportOptions.IsExportFillColor := FormXlsxExportOptions.cbFillColors.Checked;
  ExportOptions.IsCreateAutoFilter := FormXlsxExportOptions.cbAutoFilter.Checked;
  ExportOptions.IsExportFreezeZones := FormXlsxExportOptions.cbFreezeTitleRow.Checked;
  ExportOptions.IsFooterSumsAsFormula := FormXlsxExportOptions.cbSumsAsFormula.Checked;
  ExportOptions.IsExportDisplayFormat := FormXlsxExportOptions.cbDisplayFormat.Checked;
  ExportOptions.IsExportDataGrouping := FormXlsxExportOptions.cbDataGrouping.Checked;
  ExportOptions.SheetName := FormXlsxExportOptions.EditSheetName.Text;

  if FormXlsxExportOptions.cbGridCaption.Checked then
  begin
    ExportOptions.GridHeaderText := FormXlsxExportOptions.EditCaption.Text;
    ExportOptions.GridHeaderFont := Grid.Font;
    ExportOptions.GridHeaderFont.Size := 24;
  end;

  if FormXlsxExportOptions.cbSubcation.Checked then
  begin
    ExportOptions.GridFooterText := FormXlsxExportOptions.EditSubcaption.Text
  end;

  ExportDBGridEhToXlsx(Grid, FileName, ExportOptions);

  ExportOptions.Free;

  if IsOLEObjectAvailable('Excel.Application') then
  begin
    ShellExecute(Handle, nil, PChar(FileName), nil, nil, SW_SHOWNORMAL)
  end else
  begin
    ShowMessage('Looks like MS Excel is not installed.');
    ShellExecute(0, nil, PChar('explorer.exe'), PChar('/select,' + FileName), nil, SW_SHOWNORMAL)
  end;
end;

procedure TForm1.actExportToTextFileExecute(Sender: TObject);
var
  Grid: TDBGridEh;
  Path: string;
  FileName: string;
  ExportOptions: TDBGridEhTextExportOptions;
  eForm: TFormDBGridEhTextExportOptions;
begin
  Grid := TDBGridEh(ActiveControl);

  if (FormDBGridEhTextExportOptions = nil) then
    FormDBGridEhTextExportOptions := TFormDBGridEhTextExportOptions.Create(Application);

  if (FormDBGridEhTextExportOptions.ShowModal <> mrOk) then Exit;

  eForm := FormDBGridEhTextExportOptions;
  ExportOptions := TDBGridEhTextExportOptions.Create;

  ExportOptions.IsExportTitle := eForm.CheBoxExportTitle.Checked;
  ExportOptions.IsExportFooter := eForm.CheBoxExportFooter.Checked;
  ExportOptions.Encoding := eForm.GetEncoding;
  ExportOptions.WriteBOM := eForm.CheBoxWriteBOM.Checked;
  ExportOptions.QuoteChar := eForm.GetTextQuoteChar;
  ExportOptions.CellDelimiter := eForm.GetCellDelimiter;
  ExportOptions.LineDelimiter := eForm.GetLineDelimiter;
  ExportOptions.TrailingLineDelimiter := eForm.CheBoxTrailingLineDelimiter.Checked;
  ExportOptions.UseEditFormat := eForm.GetUseEditFormat;

  GetDir(0,Path);
  FileName := Path + '\DBGridEh1Export.Txt';

  SaveDBGridEhToTextFile(Grid, FileName, ExportOptions);
  ExportOptions.Free;

  ShellExecute(Handle, nil, PChar(FileName), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.actRightToLeftExecute(Sender: TObject);
begin
  if not UseRightToLeftAlignment then
    Application.BidiMode := bdRightToLeft
  else
    Application.BidiMode := bdLeftToRight;
  FlipChildren(True);
end;

procedure TForm1.actRightToLeftUpdate(Sender: TObject);
begin
  TAction(Sender).Checked := BidiMode = bdRightToLeft;
end;

procedure TForm1.MemTableEh1AfterScroll(DataSet: TDataSet);
begin
//  if @DataSource1.OnDataChange <> nil then
//    if MemTableEh1.FieldByName('MenuName').AsString = 'MemTableEh' then
//      MemTableEh1.Next;
end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.actAboutExecute(Sender: TObject);
begin
  ShowAboutForm;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    actShowObjInspectorExecute(Sender);
end;

procedure TForm1.actShowObjInspectorExecute(Sender: TObject);
var
  FormBounds: TRect;
begin
  FormBounds := Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height);
  if FormBounds.Right > Screen.DesktopRect.Right then
    OffsetRect(FormBounds, Screen.DesktopRect.Right - FormBounds.Right, 0);
  ShowObjectInspectorForm(ActiveControl, FormBounds);
end;

procedure TForm1.InitLanguageRes;
var
  IniFile: TIniFile;
  StoredLanguage: String;
  AutoLang: String;
  FileName: String;
begin
{$IFDEF EMBEDDED_LANGUAGE_RESOURCES}
  LanguageResourceManagerEh.ResourcePlacement := lrpEmbeddedEh;
  LanguageResourceManagerEh.LoadListOfAvailableLanguages('TEhLibLanguageConsts');
{$ELSE}
  LanguageResourceManagerEh.ResourcePlacement := lrpExternalEh;
  LanguageResourceManagerEh.LoadListOfAvailableLanguages('EhLibLangConsts');
{$ENDIF}

  FileName := Copy(ParamStr(0), 1, Length(ParamStr(0))-4) + '.Ini';
  IniFile := TIniFile.Create(FileName);
  StoredLanguage := IniFile.ReadString('LanguageResources', 'ActiveLanguage', '');
  if (StoredLanguage <> '') and (LanguageResourceManagerEh.IndexOfLanguage(StoredLanguage) >= 0) then
    LanguageResourceManagerEh.ActiveLanguageAbbr := StoredLanguage
  else
  begin
    AutoLang := LanguageResourceManagerEh.AutoselectLanguage();
    if AutoLang <> '' then
      LanguageResourceManagerEh.ActiveLanguageAbbr := AutoLang;
    LanguageAutoselected := True;
  end;
  IniFile.Free;
end;

procedure TForm1.BuildLanguageMenu;
var
  i: Integer;
  ln: String;
  mi: TMenuItem;
begin
  for i := 0 to LanguageResourceManagerEh.LanguageList.Count-1 do
  begin
    ln := LanguageResourceManagerEh.LanguageList[i];
//{$IFDEF EH_LIB_12}
//{$ELSE}
//    if not ((ln = 'ENU') or (ln = 'RUS') or (ln = 'UKR')) then
//      Continue;
//{$ENDIF}
    mi := TMenuItem.Create(Self);
    mi.Caption := LanguageResourceManagerEh.GetNativeLanguageName(ln) + ' ('+ln+')';
    mi.Tag := 1;
    mi.OnClick := MenuItemSelectLanguage;
    mi.AutoHotkeys := maManual;
    miLanguage.Add(mi);
  end;

  AutoDetectMi := TMenuItem.Create(Self);
  AutoDetectMi.Caption := 'Auto';
  AutoDetectMi.Tag := 0;
  AutoDetectMi.OnClick := MenuItemSelectLanguage;
  AutoDetectMi.AutoHotkeys := maManual;
  AutoDetectMi.Caption := 'Auto (' + LanguageResourceManagerEh.AutoselectLanguage() + ')';
  if LanguageAutoselected then
    AutoDetectMi.Checked := True;
  miLanguage.Add(AutoDetectMi);

  miLanguage.InsertNewLineBefore(AutoDetectMi);

  //WriteEhLibConstsToMemo;
  //LanguageResourceManagerEh.AddLocalizableObject(Self, Self.ClassName, 'Unit1', 'ENU');
  CheckActiveLanguageMi;
  ResourceLanguageChanged;
end;

procedure TForm1.MenuItemSelectLanguage(Sender: TObject);
var
  //ln: TLanguageResourceItem;
  IniFile: TIniFile;
  lnName: String;
begin
  if (Sender as TMenuItem).Tag = 1 then
    lnName := (Sender as TMenuItem).Caption
  else
    lnName := '';
  lnName := StringReplace(lnName, '&', '', [rfReplaceAll, rfIgnoreCase]);
  lnName := Copy(lnName, Length(lnName)-3, 3);

//  ln := (Sender as TMenuItem).Tag;
//  if (ln = nil)
//    then lnName := ''
//    else lnName := ln.LanguageAbbr;

  IniFile := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\Project1.Ini');
  IniFile.WriteString('LanguageResources', 'ActiveLanguage', lnName);

  if lnName = '' then
  begin
    LanguageResourceManagerEh.ActiveLanguageAbbr := LanguageResourceManagerEh.AutoselectLanguage();
    LanguageAutoselected := True;
  end else
  begin
    LanguageResourceManagerEh.ActiveLanguageAbbr := lnName;
    LanguageAutoselected := False;
  end;
  Invalidate;
  CheckActiveLanguageMi;
end;

procedure TForm1.CheckActiveLanguageMi();
var
  i: Integer;
  ln: String;
begin
  for i := 0 to miLanguage.Count-1 do
  begin
    if miLanguage.Items[i].Tag = 1 then
    begin
      ln := StringReplace(miLanguage.Items[i].Caption, '&', '', [rfReplaceAll, rfIgnoreCase]);
      ln := Copy(ln, Length(ln)-3, 3);
    end else
      ln := '';
    if LanguageAutoselected and (ln = '') then
      miLanguage.Items[i].Checked := True
    else if not LanguageAutoselected and (ln = LanguageResourceManagerEh.ActiveLanguageAbbr) then
      miLanguage.Items[i].Checked := True
    else
      miLanguage.Items[i].Checked := False;
  end;
end;

procedure TForm1.CreateWnd;
begin
  inherited CreateWnd;
end;

{$IFDEF EH_LIB_27} //XE10.4
procedure TForm1.ScaleForPPI(NewPPI: Integer);
var
  ScaleValue: Integer;
begin
  inherited ScaleForPPI(NewPPI);
  ScaleValue := Trunc(16 * ScaleFactor);
  if (ScaleValue >= 32) then
  begin
    ActionList1.Images := ImageList32;
    ToolBar1.Images := ImageList32;
  end
  else if (ScaleValue >= 24) then
  begin
    ActionList1.Images := ImageList24;
    ToolBar1.Images := ImageList24;
  end else
  begin
    ActionList1.Images := ImageList16;
    ToolBar1.Images := ImageList16;
  end;
end;
{$ENDIF}

procedure TForm1.ResourceLanguageChanged;
begin
  Caption := ApplicationLanguageConsts.Caption + '. ' + EhLibVerInfo + ' ' + EhLibBuildInfo;;

  StatusBar1.SimpleText := ApplicationLanguageConsts.StatusBarInfo;
  miLanguage.Caption := ApplicationLanguageConsts.MenuLanguage;
  Exit1.Caption := ApplicationLanguageConsts.MenuExit;
  miAbout.Caption := ApplicationLanguageConsts.MenuAbout;
  stVCLStyle.Caption := ApplicationLanguageConsts.VCLStyle;

  MemTableEh1.DisableControls;

  while not MemTableEh1.Eof do
  begin
    MemTableEh1.Delete;
  end;

  MemTableEh1.Append;

  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuMainGrid;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrMainGrid);
  MemTableEh1RefFrame.Value := Frame;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuMasterDetail;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrMasterDetail);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuEditControls;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrEditControls);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuEditConrols2;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrEditControls2);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuFishFact;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFishFact);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuVerticalGrid;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrVertGrid);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuCellDataIsLink;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrCellDataIsLink);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuCellButtons;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrCellButtons);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuDropDownForms;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFrameDropDownForms);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuRowDetailPanel;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrRowDetailPanel);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuRowAsPanel;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrRowAsPanel);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuTreeView;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrTreeView);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuDataGrouping;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrDataGrouping);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuBackgroundImages;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrBackgroundImages);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuSearchPanel;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrSearchPanel);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuMailBox;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrMailBox);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuImportExport;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrImportExport);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '' + ApplicationLanguageConsts.VertMenuMemTableEh;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := nil; //MemTableEh
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuSaveLoadData;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrMemTableSaveLoad); //SaveLoadData
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuLiveRestructure;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrLiveRestructure);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuWorkingWithHugeData;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrWorkingWithHugeData);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '' + ApplicationLanguageConsts.VertMenuPivotGrid;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrPivotGrid);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '' + ApplicationLanguageConsts.VertMenuPlanner;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrPlanner);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '' + ApplicationLanguageConsts.VertMenuDataSet;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := nil; //DataSet
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuExportToTextFile;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrDataSetExporter);
  MemTableEh1.Post;

  MemTableEh1.Append;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuImportFromTextFile;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrDataSetImporter);
  MemTableEh1.Post;

  MemTableEh1.First;
  MemTableEh1.EnableControls;
end;

procedure TForm1.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

initialization
  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
  InitLangDir;

//  System.ReportMemoryLeaksOnShutdown := True;
//  SetEhLibDebugDraw(True);
end.
