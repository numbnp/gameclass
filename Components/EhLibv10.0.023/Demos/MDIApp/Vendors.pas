unit Vendors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, ComCtrls, GridsEh, DBGridEh, DBCtrls,
  StdCtrls, ExtCtrls, DBGridEhToolCtrls, ToolCtrlsEh;

type
  TfVendors = class(TForm)
    Panel1: TPanel;
    rgRowPanel: TRadioGroup;
    DBNavigator1: TDBNavigator;
    DBGridEh1: TDBGridEh;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGridEh2: TDBGridEh;
    mtVend: TMemTableEh;
    ddrVend: TADODataDriverEh;
    dsVend: TDataSource;
    dsParts: TDataSource;
    mtParts: TMemTableEh;
    ddrParts: TADODataDriverEh;
    procedure rgRowPanelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fVendors: TfVendors;

implementation

uses Main;
{$R *.dfm}

procedure TfVendors.rgRowPanelClick(Sender: TObject);
begin
  DBGridEh1.RowPanel.Active := (rgRowPanel.ItemIndex = 0);
end;

procedure TfVendors.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfVendors.FormDestroy(Sender: TObject);
begin
  fVendors := nil;
end;

procedure TfVendors.FormCreate(Sender: TObject);
begin
  mtVend.Open;
  mtParts.Open;
end;

end.
