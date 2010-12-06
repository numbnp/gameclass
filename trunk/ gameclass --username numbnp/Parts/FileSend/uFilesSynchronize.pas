unit uFilesSynchronize;

interface

procedure SyncFile(const AnComputerIndex: Integer);

implementation

uses
  SysUtils,
  gcconst,
  gccomputers,
  uRegistry,
  uFileSender,
  uFilesSynchronizeConst,
  uProtocol,
  frmMain;

var
  GFileSender: TFileSender;

procedure SendFile(const AstrIPAddress: String;
    const AstrSendedFilePath: String;
    const AstrReceivedFileName: String);
begin
  if Assigned(GFileSender) then begin
    GFileSender.StopSendThread();
  end;
  FreeAndNil(GFileSender);
  GFileSender := TFileSender.Create;
  GFileSender.Host := AstrIPAddress;
  GFileSender.Port := FILE_RECEIVER_PORT;
  GFileSender.SendedFilePath := AstrSendedFilePath;
  GFileSender.ReceivedFileName := AstrReceivedFileName;
  GFileSender.StartSendThread;
end;

procedure SyncFile(const AnComputerIndex: Integer);
begin
  if (isManager) then
    exit;
  if Comps[AnComputerIndex].RealyPingable then begin
    if GRegistry.Scripts.OnClientSynchronizeFile
        and (Comps[AnComputerIndex].ScriptCheckSumm
        <> GnClientScriptFileCheckSum) then begin
      SendFile(Comps[AnComputerIndex].ipaddr, GRegistry.Scripts.OnClientPath,
          ExtractFileName(GRegistry.Scripts.OnClientPath));
    end else if (GRegistry.Options.InstallPath <> '')
        and (GnClientInstallFileCheckSum <> 0)
        and (Comps[AnComputerIndex].InstallCheckSumm
        <> GnClientInstallFileCheckSum) then begin
      SendFile(Comps[AnComputerIndex].ipaddr, GRegistry.Options.InstallPath,
          FILE_INSTALL_FILENAME_DEF)
    end else if GRegistry.Options.AutoInstall
        and (Comps[AnComputerIndex].InstallCheckSumm <> 0)
        and (Comps[AnComputerIndex].InstallCheckSumm
        = GnClientInstallFileCheckSum)
        and (Comps[AnComputerIndex].strInfoClientver <> APP_VERSION) then begin
      UDPSend(Comps[AnComputerIndex].ipaddr,
          STR_CMD_BLOCKED);
      UDPSend(Comps[AnComputerIndex].ipaddr,
          STR_CMD_UNINSTALL
          + '=' + BoolToStr(True));

    end;
  end;
end;

initialization
  GFileSender := Nil;

end.
