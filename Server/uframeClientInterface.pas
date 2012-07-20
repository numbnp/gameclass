unit uframeClientInterface;

interface

uses
  GCConst, GCLangUtils, uProtocol, GCComputers, GCCommon,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, frmInstallLogin, Mask, ToolEdit;

type
  TframeClientInterface = class(TFrame)
    gbMessages: TGroupBox;
    lblURLTop: TLabel;
    edtURLCompFree: TEdit;
    lblURLCompFree: TLabel;
    edtURLTop: TEdit;
    lblURLAccount: TLabel;
    cbxUseSounds: TCheckBox;
    lblURLAgreement: TLabel;
    edtURLAccount: TEdit;
    edtURLAgreement: TEdit;
    cbxUseBaloons: TCheckBox;
    cbxUseTextMessage: TCheckBox;
    edtUseTextMessageMin: TEdit;
    lblUseTextMessage: TLabel;
    gbNotofocation: TGroupBox;
    gbOther: TGroupBox;
    cbxAgreement: TCheckBox;
    cbxShowSmallInfo: TCheckBox;
    cbxUseTextMessageBlinking: TCheckBox;
    lblBracket: TLabel;
    Label1: TLabel;
    edtURLLogonCompFree: TEdit;
    cbxShutdownButton: TCheckBox;
    procedure edtURLCompFreeChange(Sender: TObject);
    procedure edtURLTopChange(Sender: TObject);
    procedure edtUseTextMessageMinChange(Sender: TObject);
    procedure cbxUseSoundsClick(Sender: TObject);
    procedure cbxUseBaloonsClick(Sender: TObject);
    procedure cbxUseTextMessageClick(Sender: TObject);
    procedure edtURLAccountChange(Sender: TObject);
    procedure edtURLAgreementChange(Sender: TObject);
    procedure cbxAgreementClick(Sender: TObject);
    procedure cbxShowSmallInfoClick(Sender: TObject);
    procedure cbxUseTextMessageBlinkingClick(Sender: TObject);
    procedure edtURLLogonCompFreeChange(Sender: TObject);
    procedure cbxShutdownButtonClick(Sender: TObject);
  private
    { Private declarations }
//    FbUnblockPasswordNotChanged: Boolean;
    procedure ResetFrame;
    procedure DoDesign;
    // private helper methods
//    procedure _BeforeControlDataChange;
    procedure _AfterControlDataChange(const AbDoDesign: Boolean = False);

  public
    procedure Save;
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
  end;

implementation
{$R *.dfm}
uses
  uClientOptions,
  uClientOptionsConst,
  uCoder,
  uRegistry;

var
   GbFormGC3ClientLock: Boolean = False;

procedure TframeClientInterface.Save;
begin
  GClientOptions.Save;
end;

function TframeClientInterface.GetID: integer;
begin
  GetID := FRAME_CLIENT_INTERFACE;
end;

procedure TframeClientInterface.DoDesign;
begin
  GbFormGC3ClientLock := True;
  // Other
  cbxShowSmallInfo.Checked := GClientOptions.ShowSmallInfo;
  cbxShutdownButton.Checked := GClientOptions.ShutdownButton;

  // Оповещения
  cbxUseSounds.Checked := GClientOptions.UseSounds;
  cbxUseBaloons.Checked := GClientOptions.UseBaloons;
  cbxUseTextMessage.Checked := GClientOptions.UseTextMessage;
  cbxUseTextMessageBlinking.Enabled := GClientOptions.UseTextMessage;
  cbxUseTextMessageBlinking.Checked := GClientOptions.UseTextMessageBlinking;
  edtUseTextMessageMin.Enabled := GClientOptions.UseTextMessage;
  edtUseTextMessageMin.Text := IntToStr(GClientOptions.UseTextMessageMin);

  // Внешний вид
  cbxAgreement.Checked := GClientOptions.Agreement;
  lblURLAgreement.Enabled := GClientOptions.Agreement;
  edtURLAgreement.Enabled := GClientOptions.Agreement;
  edtURLCompFree.Text := GClientOptions.URLCompFree;
  edtURLTop.Text := GClientOptions.URLTop;
  edtURLAccount.Text := GClientOptions.URLLogonHelp;
  edtURLAgreement.Text := GClientOptions.URLAgreement;
  GbFormGC3ClientLock := False;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeClientInterface.ResetFrame;
begin
//  optClientLoad;
  GClientOptions.Load;
  DoDesign;
end;

procedure TframeClientInterface.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;

  gbMessages.Caption := translate('gbMessages');
  gbNotofocation.Caption := translate('gbNotofocation');
  gbOther.Caption := translate('gbOther');

  cbxShowSmallInfo.Caption := translate('cbxShowSmallInfo');

  cbxUseSounds.Caption := translate('cbxUseSounds');
  cbxUseBaloons.Caption := translate('cbxUseBaloons');
  cbxUseTextMessage.Caption := translate('cbxUseTextMessage');
  lblUseTextMessage.Caption := translate('lblUseTextMessage');

  lblURLCompFree.Caption := translate('lblURLCompFree');
  lblURLTop.Caption := translate('lblURLTop');
  lblURLAccount.Caption := translate('lblURLAccount');
  cbxAgreement.Caption := translate('cbxAgreement');
  lblURLAgreement.Caption := translate('lblURLAgreement');

end;
////////////////////////////////////////////////////////////////////////////////
//   Оповещения
////////////////////////////////////////////////////////////////////////////////
procedure TframeClientInterface.cbxUseSoundsClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;
  GClientOptions.UseSounds := cbxUseSounds.Checked;
  _AfterControlDataChange;
end;

procedure TframeClientInterface.cbxUseBaloonsClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;
  GClientOptions.UseBaloons := cbxUseBaloons.Checked;
  _AfterControlDataChange;
end;

procedure TframeClientInterface.cbxUseTextMessageClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;
  GClientOptions.UseTextMessage := cbxUseTextMessage.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeClientInterface.edtUseTextMessageMinChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;
  GClientOptions.UseTextMessageMin := StrToIntDef(edtUseTextMessageMin.Text, 10);
  if (GClientOptions.UseTextMessageMin <= 0) then begin
    GClientOptions.UseTextMessageMin := DEF_USE_TEXT_MESSAGE_MIN;
    edtUseTextMessageMin.Text := IntToStr(GClientOptions.UseTextMessageMin);
  end;
  _AfterControlDataChange;
end;

////////////////////////////////////////////////////////////////////////////////
//   Внешний вид
////////////////////////////////////////////////////////////////////////////////

procedure TframeClientInterface.edtURLCompFreeChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  if (Length(edtURLCompFree.Text) = 0) then
    edtURLCompFree.Text := DEF_URL_COMP_FREE;
  GClientOptions.URLCompFree := edtURLCompFree.Text;
  _AfterControlDataChange(True);
end;

procedure TframeClientInterface.edtURLTopChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  if (Length(edtURLTop.Text) = 0) then
    edtURLTop.Text := DEF_URL_TOP;
  GClientOptions.URLTop := edtURLTop.Text;
  _AfterControlDataChange(True);
end;

procedure TframeClientInterface.edtURLAccountChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  if (Length(edtURLAccount.Text) = 0) then
    edtURLAccount.Text := DEF_URL_ACCOUNT;
  GClientOptions.URLLogonHelp := edtURLAccount.Text;
  _AfterControlDataChange(True);
end;

procedure TframeClientInterface.edtURLAgreementChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  if (Length(edtURLAgreement.Text) = 0) then
    edtURLAgreement.Text := DEF_URL_AGREEMENT;
  GClientOptions.URLAgreement := edtURLAgreement.Text;
  _AfterControlDataChange(True);
end;

procedure TframeClientInterface.cbxAgreementClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  GClientOptions.Agreement := cbxAgreement.Checked;
  _AfterControlDataChange(True);
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TframeClientInterface._AfterControlDataChange(const AbDoDesign: Boolean = False);
begin
  if AbDoDesign then
    DoDesign;
  GClientOptions.Save(True);
  GbFormGC3ClientLock := False;
end;

procedure TframeClientInterface.cbxShowSmallInfoClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
   GClientOptions.ShowSmallInfo :=   cbxShowSmallInfo.Checked;
  _AfterControlDataChange;
end;

procedure TframeClientInterface.cbxUseTextMessageBlinkingClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;
  GClientOptions.UseTextMessageBlinking := cbxUseTextMessageBlinking.Checked;
  _AfterControlDataChange;
end;

procedure TframeClientInterface.edtURLLogonCompFreeChange(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;  GbFormGC3ClientLock := True;;
  if (Length(edtURLLogonCompFree.Text) = 0) then
    edtURLLogonCompFree.Text := DEF_URL_LOGON_COMP_FREE;
  GClientOptions.URLLogonCompFree := edtURLLogonCompFree.Text;
  _AfterControlDataChange(True);
end;

procedure TframeClientInterface.cbxShutdownButtonClick(Sender: TObject);
begin
  if GbFormGC3ClientLock then exit;
  GbFormGC3ClientLock := True;
  GClientOptions.ShutdownButton :=   cbxShutdownButton.Checked;
  _AfterControlDataChange;
end;

end.
