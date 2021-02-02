unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_7} XPMan, {$ENDIF}
{$IFDEF CIL}
  Types, System.ComponentModel, Variants, System.Runtime.InteropServices,
{$ELSE}
{$ENDIF}
{$IFDEF EH_LIB_16} Themes, {$ENDIF}
  Dialogs, Buttons, ExtCtrls, ComCtrls, ToolWin, DBGridEh, Menus,
  DataDriverEh, ADODataDriverEh, EhLibVCL,

  EhLibMTE, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  MemTableDataEh, Db, MemTableEh, GridsEh, StdCtrls, Mask, DBCtrlsEh,
  ImgList, StdActns, ActnList, PrnDbgeh;

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
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
    procedure ToolBar1CustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ADOConnectionProviderEh2InlineConnectionBeforeConnect(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure DBGridEh1AdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
  private
  public
    Frame: TFrame;
    CurPan: TPanel;

    procedure FillFrameTopPanel(ACanvas: TCanvas; const ARect: TRect);
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

uses FrameOne, FrameTwo, FrameThree;

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

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
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

  MemTableEh1.First;
  DataSource1.OnDataChange := DataSource1DataChange;
  DataSource1DataChange(nil, nil);
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
    Frame.Parent := Panel1;
//    if Frame is TfrEditControls then TfrEditControls(Frame).UpdateLabels;
  end;
end;

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.DBGridEh1AdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
var
  OffsetRect: TRect;
  NewRect: TRect;
begin
  OffsetRect := ARect;
  OffsetRect.Right := ARect.Left + 10;
  Sender.Canvas.FillRect(OffsetRect);

  NewRect := ARect;
  NewRect.Left := NewRect.Left + 10;
  Sender.DefaultDrawColumnDataCell(Cell, AreaCell, Column, NewRect, Params);
  Processed := True;
end;

initialization
  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
