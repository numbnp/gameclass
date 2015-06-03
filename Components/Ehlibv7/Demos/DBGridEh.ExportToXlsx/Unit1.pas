unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ShellAPI,
  Grids, MemTableDataEh, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DBGridEhImpExp,
  DynVarsEh, Db, MemTableEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MTE: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh: TDBGridEh;
    Button3: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGridEhColumns4GetCellParams(Sender: TObject; EditMode: Boolean;
      Params: TColCellParamsEh);
  private
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Path:string;
begin
  GetDir(0,Path);
  ExportDBGridEhToXlsx(DBGridEh,Path+'\File1.xlsx',[]);
  ShowMessage('Export is finished');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Path:string;
begin
  GetDir(0,Path);
  ShellExecute(Handle, nil, PChar(Path + '\File1.xlsx'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.DBGridEhColumns4GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if TColumnEh(Sender).Field.AsFloat > 10000000 then
    Params.Font.Style := Params.Font.Style + [fsBold];
end;

end.
