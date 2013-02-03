unit frameSideline;

interface

uses 
  GCConst, GCLangUtils, GCComputers,
  StrUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, uGCSidelines;

type
  TframSideline = class(TFrame)
    lvSideline: TListView;
    editGoods: TEdit;
    lblGoods: TLabel;
    lblPrice: TLabel;
    editPrice: TEdit;
    butAdd: TButton;
    butDelete: TButton;
    butUpdate: TButton;
    panelBottom: TPanel;
    gbService: TGroupBox;
    gbServiceOptions: TGroupBox;
    cbxServiceByPrepay: TCheckBox;
    cbxServiceByPostpay: TCheckBox;
    cbxServiceNoClose: TCheckBox;
    procedure lvSidelineClick(Sender: TObject);
    procedure editGoodsChange(Sender: TObject);
    procedure editPriceChange(Sender: TObject);
    procedure butDeleteClick(Sender: TObject);
    procedure butAddClick(Sender: TObject);
    procedure butUpdateClick(Sender: TObject);
    procedure cbxServiceByPrepayClick(Sender: TObject);
    procedure cbxServiceByPostpayClick(Sender: TObject);
    procedure cbxServiceNoCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure ResetFrame;
    procedure UpdateInformation;
    procedure UpdateButtons;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
  end;

implementation

uses
  uY2KString,
  uRegistry, uRegistryOptions;
{$R *.dfm}

function TframSideline.GetID: integer;
begin
  GetID := FRAME_SIDELINE;
end;

// процедура ставит все контролы в исходные позиции
procedure TframSideline.ResetFrame;
begin
  //
end;

procedure TframSideline.UpdateButtons;
var
  i: integer;
  bExists, bExistsUpdate: boolean;
begin
  butDelete.Enabled := (lvSideline.ItemIndex <> -1)
      and (lvSideline.ItemIndex <> 0) ;
  // найдем среди товаров аналогичный введенному в поле "товар"
  bExists := false;
  for i:=0 to (Sideline.count-1) do
    if (Sideline.goods[i].name = editGoods.Text) then begin
      bExists := true;
      break;
    end;
  // разрешить обновлять только если отличается цена
  bExistsUpdate := true;
  if (bExists) then
    bExistsUpdate := (Sideline.goods[i].price <>
        StrToFloatDefWithReplace(editPrice.Text,1));

  butAdd.Enabled := ((StrLen(PChar(editGoods.Text))>0) and (StrLen(PChar(editPrice.Text))>0) and (not bExists));
  butUpdate.Enabled := butDelete.Enabled and bExistsUpdate;
end;

procedure TframSideline.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;

  lvSideline.Columns[0].Caption := translate('ServiceName');
  lvSideline.Columns[1].Caption := translate('Price');
  lvSideline.Columns[2].Caption := translate('Code');
  lblGoods.Caption := translate('ServiceName');
  lblPrice.Caption := translate('Price');
  butAdd.Caption := translate('Add');
  butUpdate.Caption := translate('Update');
  butDelete.Caption := translate('Delete');

  cbxServiceByPrepay.Checked := GRegistry.Options.ServiceByPrepay;
  cbxServiceByPostpay.Checked := GRegistry.Options.ServiceByPostpay;
  cbxServiceNoClose.Checked := GRegistry.Options.ServiceNoClose;

  UpdateInformation;
end;

procedure TframSideline.UpdateInformation;
var
  li: TListItem;
  i: integer;
begin
  lvSideline.Clear;
  Sideline.Load;
  for i:=0 to (Sideline.count-1) do begin
    li := lvSideline.Items.Add;
    li.Caption := Sideline.goods[i].name;
    li.SubItems.Add(AnsiReplaceStr(FormatFloat('0.00',Sideline.goods[i].price),',','.'));
    li.SubItems.Add(IntToStr(Sideline.goods[i].id));
  end;
  UpdateButtons;
end;

procedure TframSideline.lvSidelineClick(Sender: TObject);
begin
  if (lvSideline.ItemIndex <> -1) then begin
    editGoods.Text := lvSideline.Items[lvSideline.ItemIndex].Caption;
    editPrice.Text := lvSideline.Items[lvSideline.ItemIndex].SubItems[0];
  end;
  UpdateButtons;
end;

procedure TframSideline.editGoodsChange(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TframSideline.editPriceChange(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TframSideline.butDeleteClick(Sender: TObject);
begin
  if (lvSideline.ItemIndex <> -1) then
    Sideline.Delete(lvSideline.Items[lvSideline.ItemIndex].Caption);
  UpdateInformation;
end;

procedure TframSideline.butAddClick(Sender: TObject);
var
  g: TGoods;
begin
  g.name := editGoods.Text;
  g.price := StrToFloatDefWithReplace(editPrice.Text,1);
  editGoods.Text := '';
  editPrice.Text := '';
  Sideline.Add(g);
  UpdateInformation;
end;

procedure TframSideline.butUpdateClick(Sender: TObject);
var
  og,ng: TGoods;
begin
  og.name := lvSideline.Items[lvSideline.ItemIndex].Caption;
  ng.name := editGoods.Text;
  ng.price := StrToFloatDefWithReplace(editPrice.Text,1);
  editGoods.Text := '';
  editPrice.Text := '';
  Sideline.Update(og,ng);
  UpdateInformation;
end;

procedure TframSideline.cbxServiceByPrepayClick(Sender: TObject);
begin
  GRegistry.Options.ServiceByPrepay := cbxServiceByPrepay.Checked;
end;

procedure TframSideline.cbxServiceByPostpayClick(Sender: TObject);
begin
  GRegistry.Options.ServiceByPostpay := cbxServiceByPostpay.Checked;
end;

procedure TframSideline.cbxServiceNoCloseClick(Sender: TObject);
begin
  GRegistry.Options.ServiceNoClose := cbxServiceNoClose.Checked;
end;

end.
