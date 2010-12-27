unit ufrmOperatorOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uRegistry, GClangutils;

type
  TfrmOperatorOpt = class(TForm)
    FontDialog: TFontDialog;
    gbMainOptions: TGroupBox;
    pnlTableFont: TPanel;
    btTableFont: TButton;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    btBlocked: TButton;
    pnlBlocked: TPanel;
    pnlnotBusy: TPanel;
    btnotBusy: TButton;
    pnlAuthenticated: TPanel;
    btAuthenticated: TButton;
    pnlReserve: TPanel;
    btReserve: TButton;
    pnlAccupied: TPanel;
    btAccupied: TButton;
    pnlPrevented: TPanel;
    btPrevented: TButton;
    butCancel: TButton;
    butOK: TButton;
    btTableColor: TButton;
    ColorDialog: TColorDialog;
    btBlockedColor: TButton;
    btnotBusyColor: TButton;
    btAuthenticatedColor: TButton;
    btReserveColor: TButton;
    btAccupiedColor: TButton;
    btPreventedColor: TButton;
    procedure btTableFontClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btBlockedClick(Sender: TObject);
    procedure btnotBusyClick(Sender: TObject);
    procedure btAuthenticatedClick(Sender: TObject);
    procedure btReserveClick(Sender: TObject);
    procedure btAccupiedClick(Sender: TObject);
    procedure btPreventedClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure butOKClick(Sender: TObject);
    procedure btTableColorClick(Sender: TObject);
    procedure btBlockedColorClick(Sender: TObject);
    procedure btnotBusyColorClick(Sender: TObject);
    procedure btAuthenticatedColorClick(Sender: TObject);
    procedure btReserveColorClick(Sender: TObject);
    procedure btAccupiedColorClick(Sender: TObject);
    procedure btPreventedColorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOperatorOpt: TfrmOperatorOpt;

implementation

{$R *.dfm}

procedure TfrmOperatorOpt.btTableFontClick(Sender: TObject);
begin
   FontDialog.Font.Assign(pnlTableFont.Font );
   if not FontDialog.Execute then exit;
   pnlTableFont.Font.Assign(FontDialog.Font);

end;

procedure TfrmOperatorOpt.FormActivate(Sender: TObject);
begin
  // Загружаем шрифт
  pnlTableFont.Font.Assign(GRegistry.UserInterface.TableFont);
  pnlBlocked.Font.Assign(GRegistry.UserInterface.BlockedFont);
  pnlnotBusy.Font.Assign(GRegistry.UserInterface.NotBusyFont);
  pnlAuthenticated.Font.Assign(GRegistry.UserInterface.AuthenticatedFont);
  pnlReserve.Font.Assign(GRegistry.UserInterface.ReserveFont);
  pnlAccupied.Font.Assign(GRegistry.UserInterface.AccupiedFont);
  pnlPrevented.Font.Assign(GRegistry.UserInterface.PreventedFont);

  // Переводим на выбранный язык
  pnlBlocked.Caption := translate('Blocked');
  pnlnotBusy.Caption := translate('notBusy');
  pnlAuthenticated.Caption := translate('Authenticated');
  pnlReserve.Caption := translate('Reserve');
  pnlAccupied.Caption := translate('Accupied');
  pnlPrevented.Caption := translate('Prevented');

  butCancel.Caption := translate('butCancel');
  butOK.Caption := translate('butOK');

  btTableColor.Caption := translate('btColor');
  btTableFont.Caption := translate('btFont');

  btBlockedColor.Caption := translate('btColor');
  btnotBusyColor.Caption := translate('btColor');
  btAuthenticatedColor.Caption := translate('btColor');
  btReserveColor.Caption := translate('btColor');
  btAccupiedColor.Caption := translate('btColor');
  btPreventedColor.Caption := translate('btColor');

  btBlocked.Caption := translate('btFont');
  btnotBusy.Caption := translate('btFont');
  btAuthenticated.Caption := translate('btFont');
  btReserve.Caption := translate('btFont');
  btAccupied.Caption := translate('btFont');
  btPrevented.Caption := translate('btFont');

end;

procedure TfrmOperatorOpt.btBlockedClick(Sender: TObject);
begin
  FontDialog.Font.Assign(pnlBlocked.Font );
  if not FontDialog.Execute then exit;
  pnlBlocked.Font.Assign(FontDialog.Font);
end;

procedure TfrmOperatorOpt.btnotBusyClick(Sender: TObject);
begin
  FontDialog.Font.Assign(pnlnotBusy.Font );
  if not FontDialog.Execute then exit;
  pnlnotBusy.Font.Assign(FontDialog.Font);
end;

procedure TfrmOperatorOpt.btAuthenticatedClick(Sender: TObject);
begin
  FontDialog.Font.Assign(pnlAuthenticated.Font );
  if not FontDialog.Execute then exit;
  pnlAuthenticated.Font.Assign(FontDialog.Font);
end;

procedure TfrmOperatorOpt.btReserveClick(Sender: TObject);
begin
  FontDialog.Font.Assign(pnlReserve.Font );
  if not FontDialog.Execute then exit;
  pnlReserve.Font.Assign(FontDialog.Font);
end;

procedure TfrmOperatorOpt.btAccupiedClick(Sender: TObject);
begin
  FontDialog.Font.Assign(pnlAccupied.Font );
  if not FontDialog.Execute then exit;
  pnlAccupied.Font.Assign(FontDialog.Font);
end;

procedure TfrmOperatorOpt.btPreventedClick(Sender: TObject);
begin
  FontDialog.Font.Assign(pnlPrevented.Font );
  if not FontDialog.Execute then exit;
  pnlPrevented.Font.Assign(FontDialog.Font);
end;

procedure TfrmOperatorOpt.butCancelClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmOperatorOpt.butOKClick(Sender: TObject);
begin

  GRegistry.UserInterface.TableFont := pnlTableFont.Font;
  GRegistry.UserInterface.BlockedFont := pnlBlocked.Font;
  GRegistry.UserInterface.NotBusyFont := pnlnotBusy.Font;
  GRegistry.UserInterface.AuthenticatedFont := pnlAuthenticated.Font;
  GRegistry.UserInterface.ReserveFont := pnlReserve.Font;
  GRegistry.UserInterface.AccupiedFont := pnlAccupied.Font;
  GRegistry.UserInterface.PreventedFont := pnlPrevented.Font;
  ModalResult := mrOk;
end;

procedure TfrmOperatorOpt.btTableColorClick(Sender: TObject);
begin
  ColorDialog.Color := pnlTableFont.Font.Color;
  if not ColorDialog.Execute then exit;
  pnlTableFont.Font.Color := ColorDialog.Color;
end;

procedure TfrmOperatorOpt.btBlockedColorClick(Sender: TObject);
begin
  ColorDialog.Color := pnlBlocked.Font.Color;
  if not ColorDialog.Execute then exit;
  pnlBlocked.Font.Color := ColorDialog.Color;
end;

procedure TfrmOperatorOpt.btnotBusyColorClick(Sender: TObject);
begin
  ColorDialog.Color := pnlnotBusy.Font.Color;
  if not ColorDialog.Execute then exit;
  pnlnotBusy.Font.Color := ColorDialog.Color;
end;

procedure TfrmOperatorOpt.btAuthenticatedColorClick(Sender: TObject);
begin
  ColorDialog.Color := pnlAuthenticated.Font.Color;
  if not ColorDialog.Execute then exit;
  pnlAuthenticated.Font.Color := ColorDialog.Color;
end;

procedure TfrmOperatorOpt.btReserveColorClick(Sender: TObject);
begin
  ColorDialog.Color := pnlReserve.Font.Color;
  if not ColorDialog.Execute then exit;
  pnlReserve.Font.Color := ColorDialog.Color;
end;

procedure TfrmOperatorOpt.btAccupiedColorClick(Sender: TObject);
begin
  ColorDialog.Color := pnlAccupied.Font.Color;
  if not ColorDialog.Execute then exit;
  pnlAccupied.Font.Color := ColorDialog.Color;
end;

procedure TfrmOperatorOpt.btPreventedColorClick(Sender: TObject);
begin
  ColorDialog.Color := pnlPrevented.Font.Color;
  if not ColorDialog.Execute then exit;
  pnlPrevented.Font.Color := ColorDialog.Color;
end;

end.
