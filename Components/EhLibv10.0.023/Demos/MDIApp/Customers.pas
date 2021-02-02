unit Customers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, MemTableDataEh, Db, ADODB, DataDriverEh, Menus,
  ADODataDriverEh, MemTableEh, GridsEh, DBGridEh, ExtCtrls, StdCtrls,
  ComCtrls, DBCtrls, DBGridEhToolCtrls;

type
  TfCustomers = class(TForm)
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    mtCust: TMemTableEh;
    ddrCust: TADODataDriverEh;
    dsCust: TDataSource;
    rgRowPanel: TRadioGroup;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGridEh2: TDBGridEh;
    dsOrders: TDataSource;
    mtOrders: TMemTableEh;
    ddrOrders: TADODataDriverEh;
    DBNavigator1: TDBNavigator;
    procedure rgRowPanelClick(Sender: TObject);
    procedure DBGridEh1BuildIndicatorTitleMenu(Grid: TCustomDBGridEh;
      var PopupMenu: TPopupMenu);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCustomers: TfCustomers;

implementation

uses MAIN;
{$R *.dfm}

procedure TfCustomers.rgRowPanelClick(Sender: TObject);
begin
  DBGridEh1.RowPanel.Active := (rgRowPanel.ItemIndex = 0);
end;

procedure TfCustomers.DBGridEh1BuildIndicatorTitleMenu(
  Grid: TCustomDBGridEh; var PopupMenu: TPopupMenu);
begin
  Grid.DefaultBuildIndicatorTitleMenu(PopupMenu);
end;

procedure TfCustomers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCustomers.FormDestroy(Sender: TObject);
begin
  fCustomers := nil;
end;

procedure TfCustomers.FormCreate(Sender: TObject);
begin
  mtCust.Open;
  mtOrders.Open;
end;

end.
