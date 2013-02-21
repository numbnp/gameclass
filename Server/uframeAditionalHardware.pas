unit uframeAditionalHardware;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TframeAditionalHardware = class(TFrame)
    pageCardReaders: TPageControl;
    pnlCardReaders: TPanel;
    gbCardReaders: TGroupBox;
    lblPort: TLabel;
    cbPort: TComboBox;
    cbxEnableCardReaders: TCheckBox;
    butTest: TButton;
    procedure cbxEnableCardReadersClick(Sender: TObject);
    procedure cbPortChange(Sender: TObject);
    procedure butTestClick(Sender: TObject);
  private
    FbControlsEnabled: Boolean;
    procedure ResetFrame;
    procedure DoDesign;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

procedure EnterHardCodeLocal (code:string); stdcall;

implementation

{$R *.dfm}

uses
    uClientOptions,
  gcconst,
  gccomputers,
  uRegistry,
  uRegistryOptions,
  uRegistryInterface,
  uY2KString,
  uTariffication, uRegistryControlCommands, uRegistryCardReader,
  GClangutils,StdConvs, uComPort, uCardReader;

{ TframeAditionalHardware }

procedure TframeAditionalHardware.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;

  DoDesign;
end;

procedure TframeAditionalHardware.DisableControls;
begin
  FbControlsEnabled := False;
end;

procedure TframeAditionalHardware.DoDesign;
var
  i:integer;
begin

  for i:=0 to gbCardReaders.ControlCount - 1 do
    gbCardReaders.Controls [i].Enabled := GRegistry.CardReader.Enabled;

  if cbPort.Items.Count =0 then
  begin
    cbPort.Text := 'no';
    cbPort.Enabled := False;
  end;

end;

procedure TframeAditionalHardware.EnableControls;
begin
  FbControlsEnabled := True;
end;

function TframeAditionalHardware.GetID: integer;
begin
  GetID := FRAME_ADITIONALHARDWARE;
end;

procedure TframeAditionalHardware.ResetFrame;
begin
  DisableControls;
  cbxEnableCardReaders.Checked := GRegistry.CardReader.Enabled;
  ReadComportList(cbPort.Items);
  if cbPort.Items.Count =0 then
  begin
    cbPort.Text := 'no';
    cbPort.Enabled := False;
  end else
    cbPort.Text := GRegistry.CardReader.ComPort;
  EnableControls;
end;

procedure TframeAditionalHardware.cbxEnableCardReadersClick(
  Sender: TObject);
begin
  if not FbControlsEnabled then exit;
  DisableControls;
  GRegistry.CardReader.Enabled := cbxEnableCardReaders.Checked;
  DoDesign;
  EnableControls;
end;

procedure TframeAditionalHardware.cbPortChange(Sender: TObject);
begin
  GRegistry.CardReader.ComPort := cbPort.Text;
end;

procedure TframeAditionalHardware.butTestClick(Sender: TObject);
begin
  try
    CardReader:= TCardReader.Create;
    CardReader.PortName := GRegistry.CardReader.ComPort;
    CardReader.StopAfterReadCode := false;
    CardReader.CallBackReadCodeProc := @EnterHardCodeLocal;
    CardReader.Start;
  except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

procedure EnterHardCodeLocal (code:string);
begin
  ShowMessage('Enter code: '+code);
end;

end.
