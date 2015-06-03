unit FrameTwo;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls;

type
  TfrFrameTwo = class(TFrame)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    DataSource1: TDataSource;
    mtQuery1: TMemTableEh;
    ddrData1: TADODataDriverEh;
    qrVendors: TMemTableEh;
    ddrVendors: TADODataDriverEh;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    mtQuery1VendorNo: TAutoIncField;
    mtQuery1VendorName: TWideStringField;
    mtQuery1Address1: TWideStringField;
    mtQuery1Address2: TWideStringField;
    mtQuery1City: TWideStringField;
    mtQuery1State: TWideStringField;
    mtQuery1Zip: TWideStringField;
    mtQuery1Country: TWideStringField;
    mtQuery1Phone: TWideStringField;
    mtQuery1FAX: TWideStringField;
    mtQuery1Preferred: TBooleanField;
    Label2: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure DBGridEh1Columns2GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1Columns1GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrameTwo }

constructor TfrFrameTwo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
  DBGridEh1.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 170);

  DBGridEh1.FooterParams.Font.Style := [fsBold];
end;

procedure TfrFrameTwo.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameTwo.DBGridEh1Columns2GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if mtQuery1State.AsString = 'CA' then
  begin
    Params.Font.Style := [fsBold];
    Params.ReadOnly := True;
  end else if mtQuery1State.AsString = 'NY' then
  begin
    Params.TextEditing := False;
    Params.Font.Color := clMedGray;
  end;
end;

procedure TfrFrameTwo.DBGridEh1Columns1GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  Params.ReadOnly := True;
  Params.TextEditing := False;
  if mtQuery1State.AsString = 'CA' then
  begin
    Params.Text := Params.Text + ' (Name is ReadOnly)';
  end else if mtQuery1State.AsString = 'NY' then
  begin
    Params.Text := Params.Text + ' (Name is not Editable)';
  end;
end;

end.
