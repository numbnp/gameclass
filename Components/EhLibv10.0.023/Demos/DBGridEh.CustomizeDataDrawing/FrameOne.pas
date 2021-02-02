unit FrameOne;

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
  TfrFrameOne = class(TFrame)
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
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrFrameOne.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
  DBGridEh1.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 170);

  DBGridEh1.FooterParams.Font.Style := [fsBold];
end;

procedure TfrFrameOne.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameOne.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if mtQuery1State.AsString = 'CA' then
    AFont.Style := [fsBold];
end;

end.
