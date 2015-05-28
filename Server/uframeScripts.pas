unit uframeScripts;

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
  ExtCtrls, Mask,  RxToolEdit;

type
  TframeScripts = class(TFrame)
    cbxSessionScript: TCheckBox;
    gbExternalScripts: TGroupBox;
    gbTabs: TGroupBox;
    Panel1: TPanel;
    editSessionScriptPath: TFilenameEdit;
    gbSessionScript: TGroupBox;
    cbxSessionScriptHideWindow: TCheckBox;
    GroupBox1: TGroupBox;
    cbxServerScript: TCheckBox;
    editServerScriptPath: TFilenameEdit;
    cbxServerScriptHideWindow: TCheckBox;
    GroupBox2: TGroupBox;
    gbClient: TGroupBox;
    cbxClient: TCheckBox;
    editClientPath: TFilenameEdit;
    cbxClientHideWindow: TCheckBox;
    cbxClientSynchronizeFile: TCheckBox;
    procedure cbxSessionScriptClick(Sender: TObject);
    procedure cbxSessionScriptKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editSessionScriptPathChange(Sender: TObject);
    procedure cbxSessionScriptHideWindowClick(Sender: TObject);
    procedure cbxSessionScriptHideWindowKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure cbxClientClick(Sender: TObject);
    procedure cbxClientHideWindowClick(Sender: TObject);
    procedure editClientPathChange(Sender: TObject);
    procedure cbxClientSynchronizeFileClick(Sender: TObject);
    procedure cbxServerScriptClick(Sender: TObject);
    procedure cbxServerScriptHideWindowClick(Sender: TObject);
    procedure editServerScriptPathChange(Sender: TObject);
  private
    { Private declarations }
    procedure ResetFrame;
    // private helper methods
    procedure _AfterControlDataChange(const AbDoDesign: Boolean = False);

    procedure _cbxSessionScriptChange;
    procedure _cbxSessionHideWindow;

  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
    procedure DoDesign;
  end;

implementation
{$R *.dfm}
uses
  gcconst,
  uRegistry, uRegistryScripts;

var
   GbFrameScriptsLock: Boolean = False;

function TframeScripts.GetID: integer;
begin
  GetID := FRAME_SCRIPTS;
end;

procedure TframeScripts.DoDesign;
begin
  GbFrameScriptsLock := True;
  // Блокировка
  cbxSessionScript.Checked := GRegistry.Scripts.OnSession;
  cbxSessionScriptHideWindow.Enabled := cbxSessionScript.Checked;
  editSessionScriptPath.Enabled := cbxSessionScript.Checked;
  cbxSessionScriptHideWindow.Checked := GRegistry.Scripts.OnSessionHideWindow;
  editSessionScriptPath.FileName := GRegistry.Scripts.OnSessionPath;

  cbxServerScript.Checked := GRegistry.Scripts.OnServer;
  cbxServerScriptHideWindow.Enabled := cbxServerScript.Checked;
  editServerScriptPath.Enabled := cbxServerScript.Checked;
  cbxServerScriptHideWindow.Checked := GRegistry.Scripts.OnServerHideWindow;
  editServerScriptPath.FileName := GRegistry.Scripts.OnServerPath;


  cbxClient.Checked := GRegistry.Scripts.OnClient;
  cbxClientHideWindow.Enabled := cbxClient.Checked;
  editClientPath.Enabled := cbxClient.Checked;
  cbxClientHideWindow.Checked := GRegistry.Scripts.OnClientHideWindow;
  editClientPath.FileName := GRegistry.Scripts.OnClientPath;
  cbxClientSynchronizeFile.Checked := GRegistry.Scripts.OnClientSynchronizeFile;
  GbFrameScriptsLock := False;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeScripts.ResetFrame;
begin
  DoDesign;
end;

procedure TframeScripts.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
//  gb.Caption := translate('gbNotofocation');
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TframeScripts._AfterControlDataChange(const AbDoDesign: Boolean = False);
begin
  if AbDoDesign then
    DoDesign;
  GbFrameScriptsLock := False;
end;

procedure TframeScripts._cbxSessionScriptChange;
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnSession := cbxSessionScript.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeScripts._cbxSessionHideWindow;
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnSessionHideWindow := cbxSessionScriptHideWindow.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeScripts.cbxSessionScriptClick(Sender: TObject);
begin
  _cbxSessionScriptChange;
end;

procedure TframeScripts.cbxSessionScriptKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  _cbxSessionScriptChange;
end;

procedure TframeScripts.editSessionScriptPathChange(Sender: TObject);
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnSessionPath := editSessionScriptPath.FileName;
  _AfterControlDataChange;
end;

procedure TframeScripts.cbxSessionScriptHideWindowClick(Sender: TObject);
begin
  _cbxSessionHideWindow;
end;

procedure TframeScripts.cbxSessionScriptHideWindowKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  _cbxSessionHideWindow;
end;

procedure TframeScripts.cbxClientClick(Sender: TObject);
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnClient := cbxClient.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeScripts.cbxClientHideWindowClick(Sender: TObject);
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnClientHideWindow := cbxClientHideWindow.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeScripts.editClientPathChange(Sender: TObject);
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnClientPath := editClientPath.FileName;
  _AfterControlDataChange;
end;

procedure TframeScripts.cbxClientSynchronizeFileClick(Sender: TObject);
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnClientSynchronizeFile := cbxClientSynchronizeFile.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeScripts.cbxServerScriptClick(Sender: TObject);
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnServer := cbxServerScript.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeScripts.cbxServerScriptHideWindowClick(Sender: TObject);
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnServerHideWindow := cbxServerScriptHideWindow.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeScripts.editServerScriptPathChange(Sender: TObject);
begin
  if GbFrameScriptsLock then exit;  GbFrameScriptsLock := True;;
  GRegistry.Scripts.OnServerPath := editServerScriptPath.FileName;
  _AfterControlDataChange;
end;

end.
