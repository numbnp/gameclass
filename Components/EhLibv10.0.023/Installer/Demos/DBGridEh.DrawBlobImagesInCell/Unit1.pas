unit Unit1;

{$I EHLIB.INC}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, MemTableDataEh, Db, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, XPMan, GridsEh, DBGridEh, MemTableEh,
{$IFDEF EH_LIB_5}  EhLibJPegImage, {$ENDIF}
{$IFDEF EH_LIB_11} EhLibGIFImage,  {$ENDIF}
{$IFDEF EH_LIB_12} EhLibPNGImage, {$ENDIF}
  StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    MemTableEh1Format: TStringField;
    MemTableEh1Image: TGraphicField;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    DataSource1: TDataSource;
    XPManifest1: TXPManifest;
    Image1: TImage;
    BitBtn1: TBitBtn;
    procedure DBGridEh1Columns1EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGridEh1Columns1AdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses PicEditDlg;

procedure TForm1.DBGridEh1Columns1AdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
  AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
  var Params: TColCellParamsEh; var Processed: Boolean);
var
  DrawTextRect: TRect;
  S: String;
  H: Integer;
  BrushStyle: TBrushStyle;
begin
  Sender.DefaultDrawColumnDataCell(Cell, AreaCell, Column, ARect, Params);
  Processed := True;
  Sender.Canvas.Font := Sender.FieldColumns['Format'].Font;
  if gdFocused in Params.State then
    Sender.Canvas.Font.Color := clHighlightText;
  DrawTextRect := ARect;
  Inc(DrawTextRect.Left, 10);
  Inc(DrawTextRect.Top, 10);
  S := Sender.FieldColumns['Format'].DisplayText;
  H := Sender.Canvas.TextHeight(S);
  if DrawTextRect.Top + H < DrawTextRect.Bottom  then
  begin
    BrushStyle := Sender.Canvas.Brush.Style;
    Sender.Canvas.Brush.Style := bsClear;
    Sender.Canvas.TextRect(DrawTextRect, DrawTextRect.Left, DrawTextRect.Top, S);
    Sender.Canvas.Brush.Style := BrushStyle;
  end;
end;

procedure TForm1.DBGridEh1Columns1EditButtonClick(Sender: TObject;
  var Handled: Boolean);
var
  Field: TField;
  Pic: TPicture;
//  ms: TMemoryStream;
begin
  if DBGridEh1.SelectedField <> nil then
  begin
    Field := DBGridEh1.SelectedField;
    if Field.DataType in [ftGraphic] then
    begin
      Pic := TPicture.Create;
      try
      try
        Pic.Assign(Field);
      except
        on EInvalidGraphic do
        else raise;
      end;

{        TBlobField(Field).SaveToStream(ms);
        ms.Position := 0;
        (Pic as IStreamPersist).LoadFromStream(ms);}
        if EditPicture(Pic) then
        begin
          Field.DataSet.Edit;
{          ms.Clear;
          (Pic as IStreamPersist).SaveToStream(ms);
          ms.Position := 0;
          TBlobField(Field).LoadFromStream(ms);}
          Field.Assign(Pic.Graphic);
        end;
      finally
        Pic.Free;
//        ms.Free;
      end;
    end;
  end;
//  if (DBGridEh1.Columns[i].Field <> nil) and
//     (DBGridEh1.Columns[i].Field.DataType in [ftMemo, ftGraphic, ftFmtMemo{$IFDEF EH_LIB_10}, ftWideMemo {$ENDIF}]) then
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  APic: TPicture;
begin
//  APic := TPicture.Create;
//  APic.Assign(MemTableEh1Image);
  try
    APic := DBGridEh1.FieldColumns['Image'].GetPictureFromBlobField;
  except
    on EInvalidGraphic do APic := TPicture.Create;
    else raise;
  end;
  if EditPicture(APic) then
  begin
    MemTableEh1Image.DataSet.Edit;
    MemTableEh1Image.Assign(APic.Graphic);
    if APic.Graphic <> nil then
      MemTableEh1Format.AsString := APic.Graphic.ClassName;
    MemTableEh1Image.DataSet.Post;
  end;

  APic.Free
//  Image2.Picture.Assign(Image1.Picture);
//  MemTableEh1Image.DataSet.Edit;

//  MemTableEh1Image.LoadFromFile('delphixe.gif');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  DBGridEhDebugDraw := True;
end;

end.
