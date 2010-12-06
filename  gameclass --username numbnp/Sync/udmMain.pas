unit udmMain;

interface

uses
  SysUtils, Classes, ADODB, DB;

type
  TdmMain = class(TDataModule)
    cnnMain: TADOConnection;
    dstUserName: TADOQuery;
    dstUserNameValue: TStringField;
    dsrcSyncServersSelect: TDataSource;
    dstSyncServersSelect: TADOStoredProc;
    cnnDestination: TADOConnection;
    dstClubName: TADOQuery;
    dstClubNameValue: TStringField;
    dstSyncServersInsert: TADOStoredProc;
    dstSyncServersDelete: TADOStoredProc;
    dstSyncServersUpdate: TADOStoredProc;
    dstAccountsSelect: TADOStoredProc;
    dstAccountsSync: TADOStoredProc;
    dstAccountsHistorySelect: TADOStoredProc;
    dstAccountsHistorySync: TADOStoredProc;
    dstAccountsInsert: TADOStoredProc;
    dstAccountsUpdate: TADOStoredProc;
    dstAccountsHistoryInsert: TADOStoredProc;
    dstIsManager: TADOQuery;
    cmdAccountsDelete: TADOCommand;
    cmdAccountsHistoryDelete: TADOCommand;
    dstGetSyncServerIdByName: TADOQuery;
  public
    function GetClubName(AcnnServer: TADOConnection): String;
    function GetUserName(AcnnServer: TADOConnection): String;
    function IsManager(AcnnServer: TADOConnection): Boolean;
  end;

var
  dmMain: TdmMain;

implementation

{$R *.dfm}

function TdmMain.GetClubName(AcnnServer: TADOConnection): String;
begin
  Result := '';
  if Assigned(AcnnServer) and AcnnServer.Connected then
    try
      dstClubName.Connection := AcnnServer;
      dstClubName.Open;
      Result := dstClubName.FieldValues['Value'];
      dstClubName.Close;
    except
    end;
end;

function TdmMain.GetUserName(AcnnServer: TADOConnection): String;
begin
  Result := '';
  if Assigned(AcnnServer) and AcnnServer.Connected then
    try
      dstUserName.Connection := AcnnServer;
      dstUserName.Open;
      Result := dstUserName.FieldValues['Value'];
      dstUserName.Close;
    except
    end;
end;

function TdmMain.IsManager(AcnnServer: TADOConnection): Boolean;
begin
  Result := False;
  if Assigned(AcnnServer) and AcnnServer.Connected then
    try
      dstIsManager.Connection := AcnnServer;
      dstIsManager.Open;
      Result := (dstIsManager.FieldValues['value'] <> 0);
      dstIsManager.Close;
    except
    end;
end;

end.
