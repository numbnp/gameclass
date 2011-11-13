unit frmRemoteManage;

interface

uses
  frmMain, gccomputers, gcconst, GCLangutils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TformRemoteManage = class(TForm)
    lvClients: TListView;
    butClientStop: TButton;
    butUninstall: TButton;
    butReInstall: TButton;
    Panel1: TPanel;
    butOK: TButton;
    butHelp: TButton;
    butUpdate: TButton;
    pb: TProgressBar;
    tmrUpdate: TTimer;
    procedure butUpdateClick(Sender: TObject);
    procedure UpdateManageList;
    procedure tmrUpdateTimer(Sender: TObject);
    procedure butReInstallClick(Sender: TObject);
    procedure butUninstallClick(Sender: TObject);
    procedure butClientStopClick(Sender: TObject);
    procedure butHelpClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formRemoteManage: TformRemoteManage;

implementation

uses
  frmGCMessageBox,
  udmMain,
  uProtocol;

{$R *.dfm}

procedure TformRemoteManage.butUpdateClick(Sender: TObject);
var
  i,j: integer;
begin
  lvClients.Clear;

  // послать на каждую машину по MAXIMUM_LOST_PINGS пингов и STR_CMD_GETEXTENDEDINFO
  for i:=0 to (CompsCount-1) do begin
    for j:=1 to MAXIMUM_LOST_PINGS do UDPSend(Comps[i].ipaddr,STR_CMD_PING + '=0');
    UDPSend(Comps[i].ipaddr,STR_CMD_GETEXTENDEDINFO);
  end;

  for i:=1 to 25 do begin
    pb.Position := i*4;
    sleep(7);
  end;
  UpdateManageList;
end;

procedure TformRemoteManage.UpdateManageList;
var
  i: integer;
  li: TListItem;
  str: string;
begin
  if (dmMain.cnnMain = nil) then exit;
  if (Not dmMain.cnnMain.Connected) then exit;
  lvClients.Clear;
  for i:=0 to (CompsCount-1) do begin
    li := lvClients.Items.Add;
    li.Caption := Comps[i].GetStrNumber;
    li.SubItems.Insert(0,'');
    li.SubItems.Insert(1,'');
    li.SubItems.Insert(2,'');
    if (Comps[i].control) then str := 'on' else str := 'off';
    li.SubItems.Strings[0] := Comps[i].strInfoClientver;
    li.SubItems.Strings[1] := Comps[i].strInfoWinver;
    str := '';
    // 1. Клиент не установлен (комп выключен)
    if (Not Comps[i].control) or (Comps[i].strInfoClientver='...') then
     str := translate('NoLinkOrNoClient');
    // 2. Разные версии клиента и сервера (надо обновить клиента)
    if (Comps[i].control)
        and (Comps[i].strInfoClientver <> APP_VERSION)
        and ((Comps[i].strInfoClientver<>'...')) then
      str := translate('DiffClientAndServer');
    li.SubItems.Strings[2] := str;
  end;
end;

procedure TformRemoteManage.tmrUpdateTimer(Sender: TObject);
begin
  tmrUpdate.Enabled := false;
  if Not isManager then butUpdateClick(Sender)
  else
  begin
    formGCMessageBox.memoInfo.Text := translate('fnRemoteClientsManageHowTo');
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
  end;
end;

procedure TformRemoteManage.butReInstallClick(Sender: TObject);
var
  i,j: integer;
begin
  // пробежаться по всем выделенным компам, определить их IP
  // и послать по этому IP команду STR_CMD_UNINSTALL
  // затем обновить список компьютеров
  for i:=0 to (lvClients.Items.Count-1) do
    if (lvClients.Items[i].Selected) then
      for j:=0 to (CompsCount-1)do
        if (Comps[j].GetStrNumber = lvClients.Items[i].Caption)
            and (Comps[j].InstallCheckSumm <> 0)
            and (Comps[j].InstallCheckSumm = GnClientInstallFileCheckSum)
            then
           UDPSend(Comps[j].ipaddr, STR_CMD_UNINSTALL
              + '=' + BoolToStr(True));
  UpdateManageList;
end;

procedure TformRemoteManage.butUninstallClick(Sender: TObject);
var
  i,j: integer;
begin
  // пробежаться по всем выделенным компам, определить их IP
  // и послать по этому IP команду STR_CMD_UNINSTALL
  // затем обновить список компьютеров
  for i:=0 to (lvClients.Items.Count-1) do
    if (lvClients.Items[i].Selected) then
      for j:=0 to (CompsCount-1)do
        if (Comps[j].GetStrNumber = lvClients.Items[i].Caption) then
           UDPSend(Comps[j].ipaddr, STR_CMD_UNINSTALL
           + '=' + BoolToStr(False));
  UpdateManageList;
end;

procedure TformRemoteManage.butClientStopClick(Sender: TObject);
var
  i,j: integer;
begin
  // пробежаться по всем выделенным компам, определить их IP
  // и послать по этому IP команду STR_CMD_CLOSECLIENT
  // затем обновить список компьютеров
  for i:=0 to (lvClients.Items.Count-1) do
    if (lvClients.Items[i].Selected) then
      for j:=0 to (CompsCount-1)do
        if (Comps[j].GetStrNumber = lvClients.Items[i].Caption) then
           UDPSend(Comps[j].ipaddr, STR_CMD_CLOSECLIENT);

  UpdateManageList;
end;

procedure TformRemoteManage.butHelpClick(Sender: TObject);
begin
  //!
end;

procedure TformRemoteManage.FormActivate(Sender: TObject);
begin
  butHelp.Caption := translate('subHelp');
  butUpdate.Caption := translate('Update');
  butReInstall.Caption := translate('Install');
  butUninstall.Caption := translate('Uninstall');
  butClientStop.Caption := translate('StopClient');
  lvClients.Columns[0].Caption := translate('Computer');
  lvClients.Columns[1].Caption := translate('GC3ClientVersion');
  lvClients.Columns[2].Caption := translate('WindowsVersion');
  lvClients.Columns[3].Caption := translate('Comment');
  butUpdate.Enabled := Not isManager;
  butUninstall.Enabled := Not isManager;
  butClientStop.Enabled := Not isManager;
end;

end.
