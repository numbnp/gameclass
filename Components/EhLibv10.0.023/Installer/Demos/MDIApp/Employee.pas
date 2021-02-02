unit Employee;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, ComCtrls, GridsEh, DBGridEh, DBCtrls,
  StdCtrls, ExtCtrls, DBGridEhToolCtrls;

type
  TfEmployee = class(TForm)
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    gridEmp: TDBGridEh;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGridEh2: TDBGridEh;
    mtEmp: TMemTableEh;
    ddrEmp: TADODataDriverEh;
    dsEmp: TDataSource;
    dsOrders: TDataSource;
    mtOrders: TMemTableEh;
    ddrOrders: TADODataDriverEh;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fEmployee: TfEmployee;

implementation

uses Main;

{$R *.dfm}

procedure TfEmployee.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfEmployee.FormDestroy(Sender: TObject);
begin
  fEmployee := nil;
end;

procedure TfEmployee.FormCreate(Sender: TObject);
begin
  mtEmp.Open;
  mtOrders.Open;
end;

end.
