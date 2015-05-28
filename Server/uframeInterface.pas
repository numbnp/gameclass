unit uframeInterface;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  ExtCtrls, Mask, RxToolEdit;

type
  TframeInterface = class(TFrame)
    gbCommon: TGroupBox;
    cbxActivateMessageTab: TCheckBox;
    cbxDontHideIntoSysTray: TCheckBox;
    gbStartSession: TGroupBox;
    cbxHideSessionChartWithoutReserve: TCheckBox;
    cbxMultiActionsLimitedControl: TCheckBox;
    cbxAutoSelectDefaultTarif: TCheckBox;
    procedure cbxDontHideIntoSysTrayClick(Sender: TObject);
    procedure cbxActivateMessageTabClick(Sender: TObject);
    procedure cbxMultiActionsLimitedControlClick(Sender: TObject);
    procedure cbxHideSessionChartWithoutReserveClick(Sender: TObject);
    procedure cbxAutoSelectDefaultTarifClick(Sender: TObject);
  private
    FbControlsEnabled: Boolean;
    procedure ResetFrame;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
    procedure DoDesign;
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

implementation
{$R *.dfm}
uses
  gcconst,
  uRegistry, uRegistryInterface;

function TframeInterface.GetID: integer;
begin
  GetID := FRAME_INTERFACE;
end;

procedure TframeInterface.DoDesign;
begin
  FbControlsEnabled := False;
  // Блокировка
  cbxDontHideIntoSysTray.Checked := GRegistry.UserInterface.DontHideIntoSysTray;
  cbxActivateMessageTab.Checked := GRegistry.UserInterface.ActivateMessageTab;
  cbxMultiActionsLimitedControl.Checked :=
      not GRegistry.UserInterface.MultiActionsFullControl;
  cbxHideSessionChartWithoutReserve.Checked :=
      GRegistry.UserInterface.HideSessionChartWithoutReserve;
  cbxAutoSelectDefaultTarif.Checked :=
      GRegistry.Options.AutoSelectDefaultTarif;  
  FbControlsEnabled := True;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeInterface.ResetFrame;
begin
  DoDesign;
end;

procedure TframeInterface.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
//  gb.Caption := translate('gbNotofocation');
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods
procedure TframeInterface.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TframeInterface.DisableControls;
begin
  FbControlsEnabled := False;
end;

procedure TframeInterface.cbxDontHideIntoSysTrayClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.UserInterface.DontHideIntoSysTray :=
      cbxDontHideIntoSysTray.Checked;
end;

procedure TframeInterface.cbxActivateMessageTabClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.UserInterface.ActivateMessageTab :=
      cbxActivateMessageTab.Checked;
end;

procedure TframeInterface.cbxMultiActionsLimitedControlClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.UserInterface.MultiActionsFullControl :=
      not cbxMultiActionsLimitedControl.Checked;
end;

procedure TframeInterface.cbxHideSessionChartWithoutReserveClick(
  Sender: TObject);
begin
  if not ControlsEnabled then exit;
  GRegistry.UserInterface.HideSessionChartWithoutReserve :=
      cbxHideSessionChartWithoutReserve.Checked;
end;

procedure TframeInterface.cbxAutoSelectDefaultTarifClick(Sender: TObject);
begin
  GRegistry.Options.AutoSelectDefaultTarif := cbxAutoSelectDefaultTarif.Checked;
end;

end.
