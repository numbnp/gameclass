unit Unit1;

{$I EhLib.Inc}

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
  Dialogs, Buttons, ExtCtrls, ComCtrls, ToolWin, DBGridEh, Menus,
  DataDriverEh, ADODataDriverEh, EhLibVCL, BaseFrame,

  EhLibMTE, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  MemTableDataEh, Db, MemTableEh, GridsEh, StdCtrls, Mask, DBCtrlsEh,
  ImgList, StdActns, ActnList, PrnDbgeh, DynVarsEh, 
  DBAxisGridsEh;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Exit1: TMenuItem;
    Splitter1: TSplitter;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    MemTableEh1MenuName: TStringField;
    MemTableEh1RefFrameClass: TRefObjectField;
    MemTableEh1RefFrame: TRefObjectField;
    DBGridEh1: TDBGridEh;
    Bevel1: TBevel;
    ADOConnectionProviderEh2: TADOConnectionProviderEh;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
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
    PanelXEStyles: TPanel;
    PaintBox1: TPaintBox;
    DBComboBoxEh1: TDBComboBoxEh;
    StaticText1: TStaticText;
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
    procedure ToolBar1CustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ADOConnectionProviderEh2InlineConnectionBeforeConnect(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure DBComboBoxEh1Change(Sender: TObject);
  private
  public
    Frame: TFrame;
    CurPan: TPanel;

    function TestInitXE2: Boolean;
    procedure FillFrameTopPanel(ACanvas: TCanvas; const ARect: TRect);
    procedure ScaleFontHeight(Control: TControl; M, D: Integer; SrcH, ChH: Integer);
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

uses FrameOne,
     FrameTwo,
     FrameThree,
     FrameFour,
     FrameOptions;

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

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ScaleFontHeight(Control: TControl; M, D: Integer; SrcH, ChH: Integer);
begin
end;

procedure TForm1.FillFrameTopPanel(ACanvas: TCanvas; const ARect: TRect);
begin
  GradientFillCanvas(ACanvas,
    ApproximateColor(StyleServices.GetSystemColor(clBtnFace), StyleServices.GetSystemColor(clWindow), 170),
    StyleServices.GetSystemColor(clBtnFace),
    ARect, gdVertical);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGridEh1.Font.Color := clNavy;
  PanelXEStyles.Visible := TestInitXE2;

  DataSource1.OnDataChange := nil;
  MemTableEh1.First;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFrameOne);
  MemTableEh1RefFrame.Value := Frame;
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFrameTwo);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFrameThree);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFrameFour);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFrameOptions);
  MemTableEh1.Post;

  MemTableEh1.First;
  DataSource1.OnDataChange := DataSource1DataChange;
  DataSource1DataChange(nil, nil);
end;

procedure TForm1.ADOConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\PlannerDB.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\PlannerDB.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\PlannerDB.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\PlannerDB.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\PlannerDB.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\PlannerDB.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\Data\PlannerDB.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\Data\PlannerDB.mdb'
  else
    ShowMessage('PlannerDB.mdb is not found');

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

procedure TForm1.ToolBar1CustomDraw(Sender: TToolBar; const ARect: TRect;
  var DefaultDraw: Boolean);
begin
  GradientFillCanvas(Sender.Canvas, ApproachToColorEh(clWindow, $00D6D6D6, 30),
    ApproachToColorEh($00D6D6D6, clWindow, 30), ARect, gdVertical);
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if MemTableEh1RefFrame.Value = nil then
  begin
    begin
      if MemTableEh1RefFrameClass.Value = nil then Exit;
      DataSource1.OnDataChange := nil;
      MemTableEh1.Edit;
      MemTableEh1RefFrame.Value := TWinControlClass(MemTableEh1RefFrameClass.Value).Create(Self);
      MemTableEh1.Post;
      DataSource1.OnDataChange := DataSource1DataChange;
    end;
  end;

  if Frame <> nil then
    Frame.Parent := nil;
  if MemTableEh1RefFrame.Value <> nil then
  begin
    Frame := TFrame(MemTableEh1RefFrame.Value);
    Frame.Align := alClient;
    Frame.Parent := Panel1;
    if Frame is TMyBaseFrame then
      TMyBaseFrame(Frame).UpdateSettings;

//    if Frame is TfrEditControls then TfrEditControls(Frame).UpdateLabels;
  end;
end;

procedure TForm1.DBComboBoxEh1Change(Sender: TObject);
begin
{$IFDEF EH_LIB_16}
  TStyleManager.TrySetStyle(DBComboBoxEh1.Items[DBComboBoxEh1.ItemIndex]);
{$ENDIF}
end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Close;
end;

initialization
  DBGridEhDefaultStyle.IsDrawFocusRect := False;
//  DefFontData.Name := 'Tahoma';
//  SetEhLibDebugDraw(True);
end.
