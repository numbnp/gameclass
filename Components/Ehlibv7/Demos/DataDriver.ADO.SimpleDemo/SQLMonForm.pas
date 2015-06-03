unit SQLMonForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, GridsEh, DBGridEh, MemTableEh, DataDriverEh,
  ADODataDriverEh, ADODB, DBAxisGridsEh;

type
  TfSQLMon = class(TForm)
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AppendSQLInfo(Command: TCustomSQLCommandEh);
  end;

var
  fSQLMon: TfSQLMon;

implementation

{$R *.dfm}

{ TfSQLMon }

procedure TfSQLMon.AppendSQLInfo(Command: TCustomSQLCommandEh);
var
  ap: TParameters;
  i: Integer;
  s, ps: String;
begin
  MemTableEh1.Append;
  MemTableEh1['SQLText'] := Command.FinalCommandText.Text;
  if Command is TADOCommandEh then
  begin
    ap := TADOCommandEh(Command).Parameters;
    for i := 0 to ap.Count-1 do
    begin
      if VarIsNull(ap[i].Value)
        then ps := '<Null>'
        else ps := VarToStr(ap[i].Value);
      s := s + '[' + ap[i].Name + ']=' + ps + sLineBreak;
    end;
    MemTableEh1['Params'] := s;
  end;
  MemTableEh1.Post;
end;

end.
