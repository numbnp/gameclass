unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DB, ADODB,
  StdCtrls, GridsEh, DBGridEh;

type
  TFrame4 = class(TFrame)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
    Text: String;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

{ TFrame4 }

constructor TFrame4.Create(AOwner: TComponent);
var
  FilePath: String;
begin
  inherited Create(AOwner);

  if FileExists(ExtractFilePath(ParamStr(0))+'\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\DBTest.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\DBTest.mdb';

  ADOTable1.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
  ADOTable1.Open;

  Text := 'Search Panel with ADO DataSet. Filtering in a selected area is not supported.';
end;

end.
