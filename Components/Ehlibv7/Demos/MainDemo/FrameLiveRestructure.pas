unit FrameLiveRestructure;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Themes, EhLibVCL,
  Dialogs, StdCtrls, ExtCtrls, DBGridEh, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, GridsEh, MemTableDataEh, Db, MemTableEh, DBAxisGridsEh;

type
  TfrLiveRestructure = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Panel2: TPanel;
    DBGridEh1: TDBGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    Button1: TButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function GetFieldUnicName(InitName: String): String;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

constructor TfrLiveRestructure.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;
  if Form1.PixelsPerInch <> 96 then
    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrLiveRestructure.PaintBox1Paint(Sender: TObject);
begin
  GradientFillCanvas(PaintBox1.Canvas,
    ApproximateColor(StyleServices.GetSystemColor(clBtnFace), StyleServices.GetSystemColor(clWindow), 170),
    StyleServices.GetSystemColor(clBtnFace),
//    $00D6D6D6,
    Rect(0, 0, PaintBox1.Width, PaintBox1.Height), gdVertical);
end;

procedure TfrLiveRestructure.Button1Click(Sender: TObject);
var
  NewStruct: TMTDataStructEh;
  bf: TMTStringDataFieldEh;
begin
  NewStruct := MemTableEh1.RecordsView.MemTableData.DataStruct.BeginRestructure;

  bf := TMTStringDataFieldEh(NewStruct.CreateField(TMTStringDataFieldEh));
  bf.FieldName := GetFieldUnicName('StringField');

  MemTableEh1.RecordsView.MemTableData.DataStruct.EndRestructure(NewStruct, True);
end;

function TfrLiveRestructure.GetFieldUnicName(InitName: String): String;
var
  i: Integer;
begin
  i := 1;
  while True do
  begin
    Result := InitName + IntToStr(i);
    if MemTableEh1.RecordsView.MemTableData.DataStruct.FindField(Result) <> nil then
      Inc(i)
    else
      Break;
  end;
end;

end.
