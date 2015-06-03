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
  DataDriverEh, ADODataDriverEh, EhLibVCL,

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
    About1: TMenuItem;
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
    ToolButton1: TToolButton;
    PanelXEStyles: TPanel;
    DBComboBoxEh1: TDBComboBoxEh;
    PaintBox1: TPaintBox;
    StaticText1: TStaticText;
    ImageList1: TImageList;
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
    procedure ScrollBox1Resize(Sender: TObject);
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
    procedure About1Click(Sender: TObject);
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
  private
  public
    Frame: TFrame;
    CurPan: TPanel;

    frMainGrid: TfrMainGrid;
    frMasterDetail: TfrMasterDetail;

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

uses ObjectInspectorEh, FormAbout, FrameTreeView, FrameEditControls,
  FrameRowDetailPanel, FrameDataGrouping, FrameBackgroundImages, FrameRowAsPanel,
  FrameLiveRestructure, FrameWorkingWithHugeData, FrameMemTableSaveLoad,
  FrameImportExport, FrameSearchPanel, FrameVertGrid, FrameDropDownForms,
  FrameEditControls2;

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
//  Align := alClient;

  PanelXEStyles.Visible := TestInitXE2;


  DBGridEh1.Font.Color := clNavy;
  
  frMainGrid := TfrMainGrid.Create(Self);
  frMainGrid.Parent := Panel1;
  Frame := frMainGrid;
//  CurPan := SpeedBPanel1;

//  SpeedBPanel1.Color :=  ApproximateColor(clBtnShadow, clBtnFace, 170);
//  SpeedBPanel2.Color := clBtnShadow;
//  Edit1.Text := Frame21.Text;
  DataSource1.OnDataChange := nil;
  MemTableEh1.First;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrMainGrid);
  MemTableEh1RefFrame.Value := Frame;
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrMasterDetail);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrEditControls);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrEditControls2);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFishFact);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrVertGrid);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrFrameDropDownForms);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrRowDetailPanel);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrRowAsPanel);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrTreeView);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrDataGrouping);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrBackgroundImages);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrSearchPanel);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrMailBox);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrImportExport);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := nil; //MemTableEh
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrMemTableSaveLoad); //SaveLoadData
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrLiveRestructure);
  MemTableEh1.Post;

  MemTableEh1.Next;
  MemTableEh1.Edit;
  TRefObjectField(MemTableEh1.FieldByName('RefFrameClass')).Value := TObject(TfrWorkingWithHugeData);
  MemTableEh1.Post;

  MemTableEh1.First;
  DataSource1.OnDataChange := DataSource1DataChange;
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
    if Frame is TfrEditControls then TfrEditControls(Frame).UpdateLabels;
    OldFrame.Parent := nil;
    Panel1.Update;
  end;
end;

procedure TForm1.About1Click(Sender: TObject);
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
  actPreview.Enabled := (ActiveControl is TCustomDBGridEh);
  actExit.Enabled := True;
end;

procedure TForm1.actPreviewExecute(Sender: TObject);
begin
  if ActiveControl is TCustomDBGridEh then
  begin
    PrintDBGridEh1.DBGridEh := TDBGridEh(ActiveControl);
    PrintDBGridEh1.Preview;
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

initialization
  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DefFontData.Name := 'Tahoma';
//  DBGridEhDebugDraw := True;
//  DefFontData.Height := 20;
end.
