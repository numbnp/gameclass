unit Unit1;

{$I EhLib.Inc}

//{$DEFINE EMBEDDED_LANGUAGE_RESOURCES}

{$IFDEF MSWINDOWS}
//  {$DEFINE USE_ADO_CONNECTION}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_7}
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
{$ENDIF}
{$IFDEF CIL}
  Types, System.ComponentModel, Variants, System.Runtime.InteropServices,
{$ELSE}
{$ENDIF}
{$IFDEF EH_LIB_16} Themes, {$ENDIF}
{$IFDEF USE_ADO_CONNECTION}
    ADODataDriverEh, ADODb,
{$ENDIF}
  Contnrs,
  Dialogs, Buttons, ExtCtrls, ComCtrls, ToolWin, DBGridEh, Menus,
  IniFiles, DataDriverEh, EhLibVCL,
  DBVertGridsEh, PivotGridsEh, PlannersEh,
  FrameMainGrid, FrameMasterDetail, FrameFishFact, FrameMailBox,
  EhLibMTE, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  MemTableDataEh, Db, MemTableEh, GridsEh, StdCtrls, Mask, DBCtrlsEh,
  ImgList, StdActns, ActnList, PrnDbgeh, DBAxisGridsEh, DynVarsEh,
  System.Actions, System.ImageList;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    miFile: TMenuItem;
    Splitter1: TSplitter;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    Bevel1: TBevel;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    tbPreview: TToolButton;
    PanelXEStyles: TPanel;
    DBComboBoxEh1: TDBComboBoxEh;
    PaintBox1: TPaintBox;
    stVCLStyle: TStaticText;
    ImageList1: TImageList;
    tbDivider: TToolButton;
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
    tbAbout: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    actShowObjInspector: TAction;
    miLanguage: TMenuItem;
    MemTableEh1MenuName: TWideStringField;
    MemTableEh1RefFrameClass: TRefObjectField;
    MemTableEh1RefFrame: TRefObjectField;
    SQLConnectionProviderEh1: TSQLConnectionProviderEh;
    miExit: TMenuItem;
    Help1: TMenuItem;
    miAbout: TMenuItem;
    procedure ScrollBox1Resize(Sender: TObject);
    procedure miFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
    function SQLConnectionProviderEh1ExecuteCommand(
      SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
      var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
  private
    procedure InitLanguageRes;
    procedure BuildLanguageMenu;
    procedure MenuItemSelectLanguage(Sender: TObject);
    procedure CheckActiveLanguageMi;
    procedure ResourceLanguageChanged;

    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;

  public
    Frame: TFrame;
    CurPan: TPanel;

    frMainGrid: TfrMainGrid;
    frMasterDetail: TfrMasterDetail;
    LanguageAutoselected: Boolean;
    AutoDetectMi: TMenuItem;

    UseDfmDataTablesForConnectionProvider: Boolean;
    DfmDataTablesPath: String;

{$IFDEF USE_ADO_CONNECTION}
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    ADOConnectionProviderEh2: TADOConnectionProviderEh;
    ADOConnectionProviderEh_Letters: TADOConnectionProviderEh;
    ADOConnectionProviderEh_cities10000: TADOConnectionProviderEh;
{$ENDIF}

    function TestInitXE2: Boolean;
    procedure FillFrameTopPanel(ACanvas: TCanvas; const ARect: TRect);
    procedure ScaleFontHeight(Control: TControl; M, D: Integer; SrcH, ChH: Integer);
    procedure InitDataBase;
    procedure InitConnectionProvider1;
    procedure InitConnectionProvider2;
    procedure InitConnectionProvider_Letters;
    procedure InitConnectionProvider_cities10000;

  end;

var
  Form1: TForm1;


type
  TGradientDirection = (gdHorizontal, gdVertical);

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);

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
  FramePlanner,
  FrameDataSetTextExporter,
  FrameDataSetTextImporter;

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

//function MyGradientFill; external msimg32 name 'GradientFill';

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

procedure TForm1.ScrollBox1Resize(Sender: TObject);
begin
{  SpeedBPanel1.Width := ScrollBox1.ClientWidth;
  SpeedBPanel2.Width := ScrollBox1.ClientWidth;
  SpeedBPanel3.Width := ScrollBox1.ClientWidth;
  SpeedBPanel4.Width := ScrollBox1.ClientWidth;
  SpeedBPanel5.Width := ScrollBox1.ClientWidth;
  SpeedBPanel6.Width := ScrollBox1.ClientWidth;
  SpeedBPanel7.Width := ScrollBox1.ClientWidth;
  SpeedBPanel8.Width := ScrollBox1.ClientWidth;
}
end;

procedure TForm1.miFileClick(Sender: TObject);
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

  InitDataBase;

{$IFDEF MSWINDOWS}
{$ELSE}
  tbPreview.Enabled := False;
//  tbPreview.Visible := False;
//  tbDivider.Visible := False;
//  ToolBar1.RemoveControl(tbPreview);
{$ENDIF}

  DBGridEh1.Font.Color := clNavy;

  frMainGrid := TfrMainGrid.Create(Self);
  frMainGrid.Parent := Panel1;
  Frame := frMainGrid;

  DataSource1.OnDataChange := nil;
  MemTableEh1.First;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrMainGrid);
  MemTableEh1RefFrame.Value := Frame;
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrMasterDetail);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrEditControls);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrEditControls2);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrFishFact);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrVertGrid);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrCellDataIsLink);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrFrameDropDownForms);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrRowDetailPanel);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrRowAsPanel);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrTreeView);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrDataGrouping);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrBackgroundImages);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrSearchPanel);
  MemTableEh1.Post;

{$IFDEF FULLDATA}
  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrMailBox);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrImportExport);
  MemTableEh1.Post;
{$ELSE}
  MemTableEh1.Next;
  MemTableEh1.Delete;
  MemTableEh1.Delete;
  MemTableEh1.Prior;
{$ENDIF}

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(0); //MemTableEh
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrMemTableSaveLoad); //SaveLoadData
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrLiveRestructure);
  MemTableEh1.Post;

{$IFDEF FULLDATA}
  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrWorkingWithHugeData);
  MemTableEh1.Post;
{$ELSE}
  MemTableEh1.Next;
  MemTableEh1.Delete;
  MemTableEh1.Prior;
{$ENDIF}

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrPivotGrid);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrPlanner);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(0); //DataSet
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrDataSetExporter);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := __TObject(TfrDataSetImporter);
  MemTableEh1.Post;

  MemTableEh1.First;
  DataSource1.OnDataChange := DataSource1DataChange;

  InitLanguageRes;
  BuildLanguageMenu;
end;

procedure TForm1.InitDataBase;
begin
  InitConnectionProvider1;
  InitConnectionProvider2;
end;

procedure TForm1.InitConnectionProvider1;
var
  FilePath: String;
begin
{$IFDEF USE_ADO_CONNECTION}
  ADOConnectionProviderEh1 := TADOConnectionProviderEh.Create(Self);
  ADOConnectionProviderEh1.InlineConnection.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data '+
    'Source=%PROJECT_PATH%\..\Data\DBTest.mdb;Persist Security Info=False';
  ADOConnectionProviderEh1.InlineConnection.Mode := cmShareDenyNone;
  ADOConnectionProviderEh1.InlineConnection.Provider := 'Microsoft.Jet.OLEDB.4.0';
  ADOConnectionProviderEh1.ServerType := 'MSAccess';
//  ADOConnectionProviderEh1.OnExecuteCommand := ADOConnectionProviderEh1ExecuteCommand;
  ADOConnectionProviderEh1.InlineConnectionBeforeConnect := ADOConnectionProviderEh1InlineConnectionBeforeConnect;

  UseDfmDataTablesForConnectionProvider := False;
  FilePath := '';
  if FileExists(ExtractFilePath(ParamStr(0))+'\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb';

  if FilePath <> '' then
  begin
    ADOConnectionProviderEh1.InlineConnection.ConnectionString :=
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
      'Data Source=' + FilePath + ';'+
      'Mode=Share Deny None;Jet OLEDB:System database="";';
  end else
{$ENDIF}

  begin
    if FileExists(ExtractFilePath(ParamStr(0))+'table_Vendors.dfm') then
      FilePath := ExtractFilePath(ParamStr(0))+'table_Vendors.dfm'
    else if FileExists(ExtractFilePath(ParamStr(0))+'..\DfmData\table_Vendors.dfm') then
      FilePath := ExtractFilePath(ParamStr(0))+'..\DfmData\table_Vendors.dfm'
    else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\DfmData\table_Vendors.dfm') then
      FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\DfmData\table_Vendors.dfm';

    if FilePath <> '' then
    begin
      DfmDataTablesPath := ExtractFilePath(FilePath);
      UseDfmDataTablesForConnectionProvider := True;
    end else
      raise Exception.Create('Can''t find data Files');
  end;
end;

procedure TForm1.InitConnectionProvider2;
{$IFDEF USE_ADO_CONNECTION}
var
  FilePath: String;
{$ENDIF}
begin
{$IFDEF USE_ADO_CONNECTION}

  ADOConnectionProviderEh2 := TADOConnectionProviderEh.Create(Self);
  ADOConnectionProviderEh2.InlineConnection.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data '+
    'Source=%PROJECT_PATH%\..\Data\BioLife.mdb;Persist Security Info=False';
  ADOConnectionProviderEh2.InlineConnection.Mode := cmShareDenyNone;
  ADOConnectionProviderEh2.InlineConnection.Provider := 'Microsoft.Jet.OLEDB.4.0';
  ADOConnectionProviderEh2.ServerType := 'MSAccess';
//  ADOConnectionProviderEh1.OnExecuteCommand := ADOConnectionProviderEh1ExecuteCommand;
//  ADOConnectionProviderEh2.InlineConnectionBeforeConnect := ADOConnectionProviderEh1InlineConnectionBeforeConnect;

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
{$ENDIF}
end;

procedure TForm1.InitConnectionProvider_Letters;
{$IFDEF USE_ADO_CONNECTION}
var
  FilePath: String;
{$ENDIF}
begin
{$IFDEF USE_ADO_CONNECTION}
  ADOConnectionProviderEh_Letters := TADOConnectionProviderEh.Create(Self);

  ADOConnectionProviderEh_Letters.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\Data\Letters.mdb;Persist Security Info=False';
  ADOConnectionProviderEh_Letters.InlineConnection.Mode := cmShareDenyNone;
  ADOConnectionProviderEh_Letters.InlineConnection.Provider := 'Microsoft.Jet.OLEDB.4.0';
  ADOConnectionProviderEh_Letters.ServerType := 'MSAccess';
    //ADOConnectionProviderEh_Letters.InlineConnectionBeforeConnect = ADOConnectionProviderEh_LettersInlineConnectionBeforeConnect

  if FileExists(ExtractFilePath(ParamStr(0))+'\Letters.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\Letters.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\Letters.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\Letters.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\Letters.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\Letters.mdb';

  ADOConnectionProviderEh_Letters.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
{$ENDIF}
end;

procedure TForm1.InitConnectionProvider_cities10000;
{$IFDEF USE_ADO_CONNECTION}
var
  FilePath: String;
{$ENDIF}
begin
{$IFDEF USE_ADO_CONNECTION}
  ADOConnectionProviderEh_cities10000 := TADOConnectionProviderEh.Create(Self);

  ADOConnectionProviderEh_cities10000.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%PROJECT_PATH%\..\Data\cities10000.mdb;Persist Security Info=False';
  ADOConnectionProviderEh_cities10000.InlineConnection.Mode := cmShareDenyNone;
  ADOConnectionProviderEh_cities10000.InlineConnection.Provider := 'Microsoft.Jet.OLEDB.4.0';
  ADOConnectionProviderEh_cities10000.ServerType := 'MSAccess';
    //ADOConnectionProviderEh_Letters.InlineConnectionBeforeConnect = ADOConnectionProviderEh_LettersInlineConnectionBeforeConnect

  if FileExists(ExtractFilePath(ParamStr(0))+'\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\cities10000.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb';

  ADOConnectionProviderEh_cities10000.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
{$ENDIF}
end;


function TForm1.SQLConnectionProviderEh1ExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
var
  TableName: String;
  mteReaded: TMemTableEh;
begin
  Result := 0;
  if UseDfmDataTablesForConnectionProvider and (SQLDataDriver.SelectCommand = Command) then
  begin
    TableName := SQLDataDriver.SpecParams.Values['table'];
    if TableName <> '' then
    begin
      mteReaded := TMemTableEh.Create(nil);
      mteReaded.LoadFromFile(DfmDataTablesPath + TableName + '.dfm');
      mteReaded.Open;
      Cursor := mteReaded;
      FreeOnEof := True;
      Processed := True;
    end;
  end
{$IFDEF USE_ADO_CONNECTION}
  else
    Result := ADOConnectionProviderEh1.DefaultExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);
{$ENDIF}
end;

procedure TForm1.ADOConnectionProviderEh1InlineConnectionBeforeConnect(
  Sender: TObject);
begin
//
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
    if __Int(MemTableEh1RefFrameClass.Value) = 0 then
    begin
      MemTableEh1.InstantReadEnter(MemTableEh1.InstantReadCurRow+1);
      Rec := MemTableEh1.Rec;
      if MemTableEh1RefFrame.Value = nil then
      begin
        AClass := TWinControlClass(__Int(MemTableEh1RefFrameClass.Value));
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
      MemTableEh1RefFrame.Value := TWinControlClass(__Int(MemTableEh1RefFrameClass.Value)).Create(Self);
      MemTableEh1.Post;
      DataSource1.OnDataChange := DataSource1DataChange;
    end;
  end;

  OldFrame := Frame;
//  Frame.Parent := nil;
  if (MemTableEh1RefFrame.Value <> nil) and (MemTableEh1RefFrame.Value <> Frame) then
  begin
    //Frame := TFrame(__Int(MemTableEh1RefFrame.Value));
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
  IniFileName: String;
  IniFilePath: String;
begin
{$IFDEF EMBEDDED_LANGUAGE_RESOURCES}
  LanguageResourceManagerEh.ResourcePlacement := lrpEmbeddedEh;
  LanguageResourceManagerEh.LoadListOfAvailableLanguages('TEhLibLanguageConsts');
{$ELSE}
  LanguageResourceManagerEh.ResourcePlacement := lrpExternalEh;
  LanguageResourceManagerEh.LoadListOfAvailableLanguages('EhLibLangConsts');
{$ENDIF}

  {$IFDEF MSWINDOWS}
  IniFilePath := ExtractFileDir(ParamStr(0));
  IniFileName := IniFilePath + PathDelim + 'Project1.Ini';
  {$ELSE}
  IniFilePath := ExtractFileDir(ParamStr(0)) + PathDelim + '..' + PathDelim + 'Project1.Ini';
  IniFileName := IniFilePath + PathDelim + 'Project1.Ini';
  {$ENDIF}
  IniFile := TIniFile.Create(IniFileName);
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
  FreeAndNil(IniFile);
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
  IniFileName: String;
  IniFilePath: String;
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

  {$IFDEF MSWINDOWS}
  IniFilePath := ExtractFileDir(ParamStr(0));
  IniFileName := IniFilePath + PathDelim + 'Project1.Ini';
  {$ELSE}
  IniFilePath := ExtractFileDir(ParamStr(0)) + PathDelim + '..' + PathDelim + 'Project1.Ini';
  ForceDirectories(IniFilePath);
  IniFileName := IniFilePath + PathDelim + 'Project1.Ini';
  {$ENDIF}
  IniFile := TIniFile.Create(IniFileName);
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
  FreeAndNil(IniFile);
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

procedure TForm1.ResourceLanguageChanged;
begin
  Caption := ApplicationLanguageConsts.Caption;
  StatusBar1.SimpleText := ApplicationLanguageConsts.StatusBarInfo;
//  File1.Caption := ApplicationLanguageConsts.MenuFile;
  miLanguage.Caption := ApplicationLanguageConsts.MenuLanguage;
  miExit.Caption := ApplicationLanguageConsts.MenuExit;
  miAbout.Caption := ApplicationLanguageConsts.MenuAbout;
  stVCLStyle.Caption := ApplicationLanguageConsts.VCLStyle;
  //DBGridEh1.FieldColumns['Name'].Title.Caption := ApplicationLanguageConsts.DBGridEh1ColumnName_Caption;
  //DBGridEh1.FieldColumns['Capital'].Title.Caption := ApplicationLanguageConsts.DBGridEh1ColumnCapital_Caption;
  //DBGridEh1.FieldColumns['Continent'].Title.Caption := ApplicationLanguageConsts.DBGridEh1ColumnContinent_Caption;
  //DBGridEh1.FieldColumns['Area'].Title.Caption := ApplicationLanguageConsts.DBGridEh1ColumnArea_Caption;
  //DBGridEh1.FieldColumns['Population'].Title.Caption := ApplicationLanguageConsts.DBGridEh1ColumnPopulation_Caption;
  //Button4.Caption := EhLibLanguageConsts.Preview;
  //Button5.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_Caption;

  MemTableEh1.DisableControls;
  MemTableEh1.RecNo := 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuMainGrid;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuMasterDetail;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuEditControls;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuEditConrols2;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuFishFact;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuVerticalGrid;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuCellDataIsLink;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuDropDownForms;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuRowDetailPanel;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuRowAsPanel;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuTreeView;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuDataGrouping;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuBackgroundImages;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuSearchPanel;
  MemTableEh1.Post;

{$IFDEF FULLDATA}
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuMailBox;
  MemTableEh1.Post;

  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuImportExport;
  MemTableEh1.Post;
{$ELSE}
{$ENDIF}

  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '' + ApplicationLanguageConsts.VertMenuMemTableEh;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuSaveLoadData;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuLiveRestructure;
  MemTableEh1.Post;

{$IFDEF FULLDATA}
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuWorkingWithHugeData;
  MemTableEh1.Post;
{$ELSE}
{$ENDIF}

  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '' + ApplicationLanguageConsts.VertMenuPivotGrid;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '' + ApplicationLanguageConsts.VertMenuPlanner;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '' + ApplicationLanguageConsts.VertMenuDataSet;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuExportToTextFile;
  MemTableEh1.Post;
  MemTableEh1.RecNo := MemTableEh1.RecNo + 1;
  MemTableEh1.Edit;
  MemTableEh1.FieldValues['MenuName'] := '   ' + ApplicationLanguageConsts.VertMenuImportFromTextFile;

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
{$IFDEF MSWINDOWS}
  DefFontData.Name := 'Tahoma';
{$ELSE}
{$ENDIF}
  InitLangDir;

  System.ReportMemoryLeaksOnShutdown := True;

//  SetEhLibDebugDraw(True);
end.
