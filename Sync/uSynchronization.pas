unit uSynchronization;

interface

uses
  Windows,
  ADODB;

type

  //
  // TSynchronization
  //

  TSynchronization = class(TObject)
  private
    // fields
    FhCheckingThread: THandle;
    FnTimeOut: Integer;

    // threads methods
    procedure _DoChecking();
    function _TryConnect(const AcnnMain: TADOConnection;
        const AstrServerName: String): Boolean;
    procedure _Syncronize(const AcnnMain: TADOConnection);
    procedure _SyncronizeServers(
        const AcnnSource: TADOConnection;
        const AstrDestinationServerName: String;
        const AnDestinationServerId: Int64);
    procedure _Beep;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure StartChecking();
    procedure StopChecking();

  end; // TSynchronization
var
   Synchronization: TSynchronization;

implementation

uses
  Types,
  // system units
  SysUtils,
  uDebugLog,
  uSQLTools,
  uLocalServer,
  Classes,
  ufrmLogon,
  uSyncConst,
  uSyncOptions,
  Math,
  uGCDBTools,
  udmMain,
  Activex;

const
  TIMEOUT = 6000; // пауза в попытках синхронизации


// метод используется для прерывания цикла ожидания событий
// см. описание API-функции QueueUserAPC
procedure ExitThreadAPC(AdwParam: DWORD); stdcall;
begin
end; // ExitThreadAPC


// по идее это должна быть метод класса, но при попытке запустить
// метод класса в отдельном потоке приложение подвисает
// в варианте с глобальной функцией все работате нормально
function DoChecking(Ap: TSynchronization): DWORD;
begin
  Ap._DoChecking();
  Result := 0;
end; // DoPrintersNotifies


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TSynchronization

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TSynchronization.Create();
begin
  inherited Create();

  FhCheckingThread := 0;
  FnTimeOut := TIMEOUT;
end; // TSynchronization.Create


destructor TSynchronization.Destroy();
begin
  inherited Destroy();
end; // TSynchronization.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TSynchronization.StartChecking();
var
  nThreadId: cardinal;
begin
  FhCheckingThread := BeginThread(
      nil, 0, @DoChecking, Pointer(Self), 0, nThreadId);
  ASSERT(FhCheckingThread <> INVALID_HANDLE_VALUE);
end; // TSynchronization.StartThreads


procedure TSynchronization.StopChecking();
begin
  if (FhCheckingThread <> INVALID_HANDLE_VALUE)
      and (FhCheckingThread <> 0) then begin
    QueueUserAPC(@ExitThreadAPC, FhCheckingThread, 0);
    Debug.Trace5('wait...');
    WaitForSingleObject(FhCheckingThread, INFINITE);
    Debug.Trace5('wait complete!');
    CloseHandle(FhCheckingThread);
  end;
end; // TSynchronization.StopThreads

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// threads methods

procedure TSynchronization._DoChecking();
var
  dwWaitStatus: DWORD;
  cnnMain: TADOConnection;
begin
  CoInitialize(Nil);
  while(TRUE) do begin
  try
    Debug.Trace5('DoChecking');
    cnnMain := TADOConnection.Create(Nil);
    if _TryConnect(cnnMain, ReadLocalServerName) then begin
      Debug.Trace5('_TryConnect');
      Options.SetConnection(cnnMain);
      Options.Load;
      Debug.Trace5('Options.Load');
      Debug.Level := IfThen(Options.General.DebugLog.Value, 9, 0);
      if Options.General.SyncInterval.Value > 0 then
        FnTimeOut  := Options.General.SyncInterval.Value * 60000;
      _Syncronize(cnnMain);
    end;
    cnnMain.Close;
    FreeAndNil(cnnMain);
  except
    on e: Exception do begin
      Debug.Trace0('_DoChecking Error! ' + e.Message);
    end;
  end;
    dwWaitStatus := SleepEx(FnTimeOut, TRUE);
    if (WAIT_IO_COMPLETION = dwWaitStatus) then begin
      CoUninitialize;
      break;
    end;
  end;
end; // TSynchronization._DoChecking

function TSynchronization._TryConnect(const AcnnMain: TADOConnection;
    const AstrServerName: String): Boolean;
var
  lstErrors: TStringList;
  nError: Integer;
  bConnected: Boolean;
begin
  Result := False;
  Debug.Trace5('Before ADOConnect: <' + AstrServerName + '>');
  if Assigned(AcnnMain) then begin
    lstErrors := TStringList.Create;
    if ADOConnect(AcnnMain, lstErrors, nError, True,
        AstrServerName, DEF_DBNAME, DB_USER, DB_PASSWORD) then begin
      Debug.Trace5('ADOConnect successfull!!');
      Result := True;
    end else begin
      Debug.Trace0('_TryConnect error:' + lstErrors.Text);
    if ReadBeepOnFailedConnect then
        _Beep;
      FreeAndNil(lstErrors);
    end;
    FreeAndNil(lstErrors);
  end;
end; // TfrmMain._SubscribeToOptionsEvents

procedure TSynchronization._Syncronize(const AcnnMain: TADOConnection);
begin
  LogInsert(AcnnMain, 1, MSG_SYNC_CONNECTED + FOR_SYNCHRONIZATION
      + AS_SOURCE);
  with dmMain do begin
    try
      with dstSyncServersSelect do begin
        Connection := AcnnMain;
        Open;
        while not Eof do begin
          Debug.Trace5('Before _SyncronizeServers ' + FieldValues['Name']);
          _SyncronizeServers(AcnnMain, FieldValues['Name'], FieldValues['id']);
          Debug.Trace5('After _SyncronizeServers ' + FieldValues['Name']);
          Next;
        end;
        Close;
      end;
    except
    end;
  end;
  LogInsert(AcnnMain, 1, MSG_SYNC_DISCONNECTED + FOR_SYNCHRONIZATION
      + AS_SOURCE);
end;

procedure TSynchronization._SyncronizeServers(
    const AcnnSource: TADOConnection;
    const AstrDestinationServerName: String;
    const AnDestinationServerId: Int64);
var
  cnnDestinationServer: TADOConnection;
  bSuccess: Boolean;
begin
  try
    cnnDestinationServer := TADOConnection.Create(Nil);
  except
    on E: Exception do Debug.Trace5('TADOConnection.Create'
        + E.Message);
  end;

  if _TryConnect(cnnDestinationServer, AstrDestinationServerName) then begin
    LogInsert(cnnDestinationServer, 1, MSG_SYNC_CONNECTED + FOR_SYNCHRONIZATION
        + AS_DESTINATION);
    Debug.Trace5('LogInsert ' + AstrDestinationServerName);
    with dmMain do begin
      try
        dstAccountsSync.Connection := AcnnSource;
        dstAccountsUpdate.Connection := cnnDestinationServer;
        with dstAccountsSelect do begin
          Parameters.FindParam('@idSyncServer').Value := AnDestinationServerId;
          Connection := AcnnSource;
          Open;
          First;
          Debug.Trace5('dstAccountsSelect '
              + IntToStr(dstAccountsSelect.RecordCount));
          while not Eof do begin
            try
              AcnnSource.BeginTrans;
              cnnDestinationServer.BeginTrans;
            except
              on E: Exception do Debug.Trace5('dstAccountsSelect Trans E'
                  + E.Message);
            end;
            Debug.Trace5('dstAccountsSelect Trans Started');
            try
            dstAccountsUpdate.Parameters.FindParam('@guid').Value :=
                dstAccountsSelect.FieldValues['guid'];
            dstAccountsUpdate.Parameters.FindParam('@name').Value :=
                dstAccountsSelect.FieldValues['name'];
            dstAccountsUpdate.Parameters.FindParam('@password').Value :=
                dstAccountsSelect.FieldValues['password'];
            dstAccountsUpdate.Parameters.FindParam('@email').Value :=
                dstAccountsSelect.FieldValues['email'];
            dstAccountsUpdate.Parameters.FindParam('@phone').Value :=
                dstAccountsSelect.FieldValues['phone'];
            dstAccountsUpdate.Parameters.FindParam('@photo').Value :=
                dstAccountsSelect.FieldValues['photo'];
            dstAccountsUpdate.Parameters.FindParam('@seccodes').Value :=
                dstAccountsSelect.FieldValues['seccodes'];
            dstAccountsUpdate.Parameters.FindParam('@isenabled').Value :=
                dstAccountsSelect.FieldValues['isenabled'];
            dstAccountsUpdate.Parameters.FindParam('@isblocked').Value :=
                dstAccountsSelect.FieldValues['isblocked'];
            dstAccountsUpdate.Parameters.FindParam('@isprivileged').Value :=
                dstAccountsSelect.FieldValues['isprivileged'];
            dstAccountsUpdate.Parameters.FindParam('@isdeleted').Value :=
                dstAccountsSelect.FieldValues['isdeleted'];
            dstAccountsUpdate.Parameters.FindParam('@privilegedDiscount').Value :=
                dstAccountsSelect.FieldValues['privilegedDiscount'];
            dstAccountsUpdate.Parameters.FindParam('@zeroBalance').Value :=
                dstAccountsSelect.FieldValues['zeroBalance'];
            dstAccountsUpdate.Parameters.FindParam('@summary').Value :=
                dstAccountsSelect.FieldValues['summary'];
            dstAccountsUpdate.Parameters.FindParam('@address').Value :=
                dstAccountsSelect.FieldValues['address'];
            dstAccountsUpdate.Parameters.FindParam('@memo').Value :=
                dstAccountsSelect.FieldValues['memo'];
            dstAccountsUpdate.Parameters.FindParam('@updated').Value :=
                dstAccountsSelect.FieldValues['updated'];
            dstAccountsUpdate.Parameters.FindParam('@PeriodOfValidity').Value :=
                dstAccountsSelect.FieldValues['PeriodOfValidity'];
            dstAccountsUpdate.Parameters.FindParam('@ExpirationDate').Value :=
                dstAccountsSelect.FieldValues['ExpirationDate'];
            dstAccountsUpdate.Parameters.FindParam('@assigntarif').Value :=
                dstAccountsSelect.FieldValues['assigntarif'];
            dstAccountsUpdate.Parameters.FindParam('@userlevel').Value :=
                dstAccountsSelect.FieldValues['userlevel'];
            dstAccountsUpdate.Parameters.FindParam('@force_tariff').Value :=
                dstAccountsSelect.FieldValues['force_tariff'];
            dstAccountsUpdate.Parameters.FindParam('@referal').Value :=
                dstAccountsSelect.FieldValues['referal'];
            dstAccountsUpdate.Parameters.FindParam('@username').Value :=
                dstAccountsSelect.FieldValues['username'];
            dstAccountsUpdate.Parameters.FindParam('@uname').Value :=
                dstAccountsSelect.FieldValues['uname'];
            dstAccountsUpdate.Parameters.FindParam('@uotch').Value :=
                dstAccountsSelect.FieldValues['uotch'];

            dstAccountsSync.Parameters.FindParam('@idSyncServer').Value :=
                AnDestinationServerId;
            dstAccountsSync.Parameters.FindParam('@guid').Value :=
                dstAccountsSelect.FieldValues['guid'];

            except
              on E: Exception do Debug.Trace5('dstAccountsSelect Param E'
                  + E.Message);
            end;
            bSuccess := True;
            try
              dstAccountsUpdate.ExecProc;
              dstAccountsSync.ExecProc;
            except
              bSuccess := False;
            end;
            if bSuccess then begin
              AcnnSource.CommitTrans;
              cnnDestinationServer.CommitTrans;
              Debug.Trace5('dstAccountsSelect Trans CommitTrans');
            end else begin
              AcnnSource.RollbackTrans;
              cnnDestinationServer.RollbackTrans;
              Debug.Trace5('dstAccountsSelect Trans RollbackTrans');
            end;
            Next;
          end;
          Close;
        end;
        dstAccountsHistorySync.Connection := AcnnSource;
        dstAccountsHistoryInsert.Connection := cnnDestinationServer;
        with dstAccountsHistorySelect do begin
          Parameters.FindParam('@idSyncServer').Value := AnDestinationServerId;
          Connection := AcnnSource;
          Open;
          First;
          Debug.Trace5('dstAccountsHistorySelect '
              + IntToStr(dstAccountsHistorySelect.RecordCount));
          while not Eof do begin
            try
              AcnnSource.BeginTrans;
              cnnDestinationServer.BeginTrans;
            except
              on E: Exception do Debug.Trace5('dstAccountsHistorySelect Trans E'
                  + E.Message);
            end;
            Debug.Trace5('dstAccountsHistorySelect Trans Started');
            dstAccountsHistoryInsert.Parameters.FindParam('@guid').Value :=
                dstAccountsHistorySelect.FieldValues['guid'];
            dstAccountsHistoryInsert.Parameters.FindParam('@guidAccounts').Value :=
                dstAccountsHistorySelect.FieldValues['guidAccounts'];
            dstAccountsHistoryInsert.Parameters.FindParam('@moment').Value :=
                dstAccountsHistorySelect.FieldValues['moment'];
            dstAccountsHistoryInsert.Parameters.FindParam('@what').Value :=
                dstAccountsHistorySelect.FieldValues['what'];
            dstAccountsHistoryInsert.Parameters.FindParam('@summa').Value :=
                dstAccountsHistorySelect.FieldValues['summa'];
            dstAccountsHistoryInsert.Parameters.FindParam('@comment').Value :=
                dstAccountsHistorySelect.FieldValues['comment'];
           dstAccountsHistoryInsert.Parameters.FindParam(
               '@initialization').Value := 0;
            dstAccountsHistorySync.Parameters.FindParam('@idSyncServer').Value :=
                AnDestinationServerId;
            dstAccountsHistorySync.Parameters.FindParam('@guid').Value :=
                dstAccountsHistorySelect.FieldValues['guid'];

            bSuccess := True;
            try
              dstAccountsHistoryInsert.ExecProc;
              dstAccountsHistorySync.ExecProc;
            except
              bSuccess := False;
            end;
            if bSuccess then begin
              AcnnSource.CommitTrans;
              cnnDestinationServer.CommitTrans;
              Debug.Trace5('dstAccountsHistorySelect Trans CommitTrans');
            end else begin
              AcnnSource.RollbackTrans;
              cnnDestinationServer.RollbackTrans;
              Debug.Trace5('dstAccountsHistorySelect Trans RollbackTrans');
          end;
            Next;
          end;
          Close;
        end;
      except
      end;
    end;
    LogInsert(cnnDestinationServer, 1, MSG_SYNC_DISCONNECTED + FOR_SYNCHRONIZATION
        + AS_DESTINATION);
  end;
  cnnDestinationServer.Close;
  FreeAndNil(cnnDestinationServer);
end;

procedure TSynchronization._Beep;
var
  f,l,p: integer;
begin
  f := 600;
  l := 200;
  Windows.Beep(f,l);
  f := 300;
  l := 10;
  Windows.Beep(f,l);
  f := 150;
  l := 300;
  Windows.Beep(f,l);

end;

end.
