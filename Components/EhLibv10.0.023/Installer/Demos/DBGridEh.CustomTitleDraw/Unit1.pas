unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh, Types,
  ObjectInspectorEh,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL, Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    DataSource1: TDataSource;
    mtQuery1: TMemTableEh;
    mtQuery1VNo: TFloatField;
    mtQuery1VName: TStringField;
    mtQuery1PNo: TFloatField;
    mtQuery1PDescription: TStringField;
    mtQuery1PCost: TCurrencyField;
    mtQuery1IQty: TIntegerField;
    mtQuery1VName1: TStringField;
    mtQuery1VPreferred: TBooleanField;
    qrVendors: TMemTableEh;
    PopupMenu1: TPopupMenu;
    M11: TMenuItem;
    M21: TMenuItem;
    DBGridEh2: TDBGridEh;
    Button2: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    FStyleNum: Integer;
    procedure DBGridEh1GetMultiTitleParams(Grid: TCustomDBGridEh; Params: TDBGridDrawTitleCellParamsEh);
    procedure DBGridEh1DrawTitleCell(Grid: TCustomDBGridEh; ACanvas: TCanvas; const ARect: TRect; Params:  TDBGridDrawTitleCellParamsEh; var Processed: Boolean);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  SetEhLibDebugDraw(False);
end;

procedure TForm1.DBGridEh1GetMultiTitleParams(Grid: TCustomDBGridEh;
  Params: TDBGridDrawTitleCellParamsEh);
var
  ForeInsideRect: TRect;
begin
  if (Params.Column = nil) then
  begin
    if (Params.MultiTitleNode <> nil) and
       (Params.MultiTitleNode.Text = 'Vendor of parts') then
    begin
      Params.Font.Size := 12;
      Params.Color := $007DBEFF;
      Params.SecondColor := $000080FF;

      ForeInsideRect := Params.ForeInsideRect;
      ForeInsideRect.Left := ForeInsideRect.Left + 20;
      Params.ForeInsideRect := ForeInsideRect;
    end else
    begin
      Params.Color := $007DBEFF;
    end;
    Params.Font.Style := [fsBold];
  end;
end;

procedure TForm1.DBGridEh1DrawTitleCell(Grid: TCustomDBGridEh; ACanvas: TCanvas;
  const ARect: TRect; Params: TDBGridDrawTitleCellParamsEh;
  var Processed: Boolean);
var
  ForeInsideRect: TRect;
  CustomRect: TRect;
begin
  if Params.MultiTitleNode = nil then Exit;
  if Params.MultiTitleNode.Text = 'Vendor of parts' then
  begin
    Grid.DrawTitleCellBackground(ACanvas, ARect, Params);
    ForeInsideRect := Params.ForeInsideRect;
    CustomRect := Params.ForeInsideRect;
    ForeInsideRect.Left := ForeInsideRect.Left + 20;
    CustomRect.Right := ForeInsideRect.Left;
    Params.ForeInsideRect := ForeInsideRect;
    Grid.DrawTitleCellForeground(ACanvas, ARect, Params);
    ACanvas.Pen.Color := clRed;
    ACanvas.Rectangle(CustomRect);
    ACanvas.Polyline([Point(CustomRect.Left, CustomRect.Top), Point(CustomRect.Right-1, CustomRect.Bottom-1)]);
    ACanvas.Polyline([Point(CustomRect.Left, CustomRect.Bottom-1), Point(CustomRect.Right, CustomRect.Top)]);
    Processed := True;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGridEh1.OnGetTitleParams := DBGridEh1GetMultiTitleParams;
  DBGridEh1.OnDrawTitleCell := DBGridEh1DrawTitleCell;
  DBGridEh1.GridLineParams.HorzEmptySpaceStyle := deshExtendGridWideSpaceEh;
  FStyleNum := 1;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  case FStyleNum of
    1:
      begin
        DBGridEh1.TitleParams.MultiTitle := True;
        DBGridEh1.TitleParams.BorderInFillStyle := False;
        DBGridEh1.Flat := True;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    2:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

    3:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    4:
      begin
        DBGridEh1.Flat := True;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

    5:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstThemedEh; //, cfstSolidEh, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    6:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstThemedEh; //, cfstSolidEh, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

    7:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstSolidEh; //, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    8:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstSolidEh; // cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

    9:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstGradientEh;
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    10:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstGradientEh;
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

//    DBGridEh1.TitleParams.BorderInFillStyle := True;

    11:
      begin
        DBGridEh1.TitleParams.BorderInFillStyle := True;

        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstThemedEh; //, cfstSolidEh, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    12:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstThemedEh; //, cfstSolidEh, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

    13:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstSolidEh; //, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    14:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstSolidEh; // cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

    15:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstGradientEh;
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    16:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstGradientEh;
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := 17;
      end;

// MultiTItle = False
    17:
      begin
        DBGridEh1.TitleParams.MultiTitle := False;
        DBGridEh1.TitleParams.BorderInFillStyle := True;

        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstThemedEh; //, cfstSolidEh, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    18:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstThemedEh; //, cfstSolidEh, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

    19:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstSolidEh; //, cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    20:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstSolidEh; // cfstGradientEh
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;

    21:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh + [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstGradientEh;
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := FStyleNum + 1;
      end;
    22:
      begin
        DBGridEh1.Flat := False;
        DBGridEh1.OptionsEh := DBGridEh1.OptionsEh - [dghFixed3D];
        DBGridEh1.TitleParams.FillStyle := cfstGradientEh;
        Button2.Caption := ' Style is ' + IntToStr(FStyleNum);
        FStyleNum := 1;
      end;

  end;
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
