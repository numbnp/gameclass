unit frameHardware;

interface

uses
  GCConst, GCLangUtils, GCComputers, GCCommon,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls;

type
  TframHardware = class(TFrame)
    cbHWEnabled: TCheckBox;
    memo: TMemo;
    procedure cbHWEnabledClick(Sender: TObject);
  private
    { Private declarations }
    procedure ResetFrame;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
  end;

implementation

uses
  uRegistry,
  uRegistryModules,
  URegistration;

{$R *.dfm}

function TframHardware.GetID: integer;
begin
  GetID := FRAME_HARDWARE;
end;

// процедура ставит все контролы в исходные позиции
procedure TframHardware.ResetFrame;
begin
  if Registration.HardwareControl then begin
    cbHWEnabled.Checked := GRegistry.Modules.Hardware.Active;
    cbHWEnabled.Enabled := true;
    memo.Text := translate('infoModuleActivateOn');
  end
  else begin
    cbHWEnabled.Checked := false;
    cbHWEnabled.Enabled := false;
    memo.Text := translate('infoModuleActivateOff');
  end;
end;

procedure TframHardware.Activate(ID: integer);
begin
  cbHWEnabled.Caption := translate('cbHardwareActivate');
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
end;


procedure TframHardware.cbHWEnabledClick(Sender: TObject);
begin
  GRegistry.Modules.Hardware.Active := cbHWEnabled.Checked;
end;

end.
