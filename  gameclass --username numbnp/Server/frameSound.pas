unit frameSound;

interface

uses
  GCConst, GCLangUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls;

type
  TframeSound = class(TFrame)
    gbSounds: TGroupBox;
    cbSoundNegativeBalance: TCheckBox;
    cbSoundLostLink: TCheckBox;
    gbAction: TGroupBox;
    cbSwitchToGC3Win: TCheckBox;
    cbxSoundGuestSession: TCheckBox;
    procedure cbSoundNegativeBalanceClick(Sender: TObject);
    procedure cbSoundLostLinkClick(Sender: TObject);
    procedure cbSwitchToGC3WinClick(Sender: TObject);
    procedure cbxSoundGuestSessionClick(Sender: TObject);
  private
    { Private declarations }
    procedure ResetFrame;
  public
    function GetID: integer;
    procedure Activate(ID: integer); 
    { Public declarations }
  end;

implementation

Uses
  gccomputers,
  gccommon,
  uRegistry, uRegistryInterface;

{$R *.dfm}

function TframeSound.GetID: integer;
begin
  GetID := FRAME_SOUNDS;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeSound.ResetFrame;
begin
  gbSounds.Caption := translate('sound_lbl1');
  cbSoundNegativeBalance.Caption := translate('sound_cbSoundNegativeBalance');
  cbSoundLostLink.Caption := translate('sound_cbControlOff');
  gbAction.Caption := translate('gbAction');
  cbSwitchToGC3Win.Caption := translate('cbActivateWin');
  cbSoundNegativeBalance.Checked := GRegistry.UserInterface.SoundNegativeBalance;
  cbSoundLostLink.Checked := GRegistry.UserInterface.SoundLostLink;
  cbSwitchToGC3Win.Checked := GRegistry.UserInterface.SwitchToGC3Win;
end;

procedure TframeSound.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
end;


procedure TframeSound.cbSoundNegativeBalanceClick(Sender: TObject);
begin
  GRegistry.UserInterface.SoundNegativeBalance := cbSoundNegativeBalance.Checked;
end;

procedure TframeSound.cbSoundLostLinkClick(Sender: TObject);
begin
  GRegistry.UserInterface.SoundLostLink := cbSoundLostLink.Checked;
end;

procedure TframeSound.cbSwitchToGC3WinClick(Sender: TObject);
begin
  GRegistry.UserInterface.SwitchToGC3Win := cbSwitchToGC3Win.Checked;
end;

procedure TframeSound.cbxSoundGuestSessionClick(Sender: TObject);
begin
  GRegistry.UserInterface.SoundGuestSession := cbxSoundGuestSession.Checked;
end;

end.
