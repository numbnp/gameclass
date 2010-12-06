//////////////////////////////////////////////////////////////////////////////
//
// TServiceManager - класс управления службами WinNT.
// Построен как singleton. Доступ к методам осуществляется
// посредством вызова: TServiceManager.Instance().
// Например: TServiceManager.Instance().IsRunning('samplesrv').
//
//////////////////////////////////////////////////////////////////////////////

unit uServiceManager;

interface

uses
  // system units
  Windows,
  WinSvc,
  // project units
  uY2KCommon;


type

  //
  // TServiceManager
  //

  TServiceManager = class(TObject)
  private
    // private helper methods
    function _WaitStopService(const AhService: SC_Handle): Integer;


  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    class function AccessInstance(
        const ARequest: TSingletonOperation): TServiceManager;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // class methods
    class function Instance(): TServiceManager;
    class procedure ReleaseInstance();

    // public methods
    function StartService(const AstrCompName: String;
        const AstrService: String): Integer; overload;
    function StartService(const AstrService: String): Integer; overload;

    function StopService(const AstrCompName: String;
        const AstrService: String): Integer; overload;
    function StopService(const AstrService: String): Integer; overload;

    function RestartService(const AstrCompName: String;
        const AstrService: String): Integer; overload;
    function RestartService(const AstrService: String): Integer; overload;

    function GetServiceStatus(const AstrCompName: String;
        const AstrService: String): DWord; overload;
    function GetServiceStatus(const AstrService: String): DWord; overload;

    function IsRunning(const AstrCompName: String;
        const AstrService: String): Boolean; overload;
    function IsRunning(const AstrService: String): Boolean; overload;

    function IsStopped(const AstrCompName: String;
        const AstrService: String): Boolean; overload;
    function IsStopped(const AstrService: String): Boolean; overload;

  end; // TServiceManager


implementation

uses
  // system uits
  SysUtils;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TServiceManager.Create();
begin
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));
end; // TServiceManager.Create


constructor TServiceManager.CreateInstance();
begin
  inherited Create();
end; // TServiceManager.CreateInstance


destructor TServiceManager.Destroy();
begin
  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  inherited Destroy();

end; // TServiceManager.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// class methods

// Exceptions: EAssertionFailed
class function TServiceManager.AccessInstance(
    const ARequest: TSingletonOperation): TServiceManager;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TServiceManager = nil;
begin
  case ARequest of
    SinglOper_Access: begin
      // do nothing
    end;

    SinglOper_Create: begin
      if not Assigned(FInstance) then begin
        FInstance := CreateInstance();
      end;
    end;

    SinglOper_Destroy: begin
      FInstance := nil;
    end;

    else begin
      ASSERT(FALSE,
          Format('Illegal request %d in AccessInstance', [Ord(ARequest)]));
    end;
  end;

  Result := FInstance;

{$WRITEABLECONST OFF}
end; // TServiceManager.AccessInstance


class function TServiceManager.Instance(): TServiceManager;
begin
  Result := AccessInstance(SinglOper_Create);
end; // THardwareManager.Instance


class procedure TServiceManager.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // THardwareManager.ReleaseInstance


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TServiceManager.StartService(const AstrCompName: String;
    const AstrService: String): Integer;
var
  hSCManager: SC_Handle;
  hService: SC_Handle;
  // В данной версии предусмотрен запуск службы только без параметров,
  // но Delphi не позволяет передавать nil в качестве var-параметра,
  // поэтому введена переменная pcArgs.
  pcArgs: PChar;
begin
  Result := 0;

  hSCManager := OpenSCManager(PChar(AstrCompName), nil, SC_MANAGER_CONNECT);
  if (hSCManager <> NULL_HANDLE) then begin
    hService := OpenService(hSCManager, PChar(AstrService), SERVICE_START);
    // if service installed
    if (hService <> NULL_HANDLE) then begin
      if not WinSvc.StartService(hService, 0, pcArgs) then begin

        Result := GetLastError();
      end;
      CloseServiceHandle(hService);
    end else begin
      Result := GetLastError();
    end;
    CloseServiceHandle(hSCManager);
  end else begin
    Result := GetLastError();
  end;

end; // TServiceManager.StartService


function TServiceManager.StartService(
    const AstrService: String): Integer;
begin
  Result := StartService('', AstrService);
end; // TServiceManager.StartService


function TServiceManager.StopService(const AstrCompName: String;
    const AstrService: String): Integer;
var
  hSCManager: SC_Handle;
  hService: SC_Handle;
  ServiceStatus: TServiceStatus;
begin
  Result := 0;

  hSCManager := OpenSCManager(PChar(AstrCompName), nil, SC_MANAGER_CONNECT);
  if (hSCManager <> NULL_HANDLE) then begin
    hService := OpenService(hSCManager, PChar(AstrService), SERVICE_STOP);
    // if Service installed
    if (hService <> NULL_HANDLE) then begin
      if not ControlService(
          hService, SERVICE_CONTROL_STOP, ServiceStatus) then begin

        Result := GetLastError();
      end;
      CloseServiceHandle(hService);
    end else begin
      Result := GetLastError();
    end;
    CloseServiceHandle(hSCManager);
  end else begin
    Result := GetLastError();
  end;

end; // TServiceManager.StopService


function TServiceManager.StopService(
    const AstrService: String): Integer;
begin
  Result := StopService('', AstrService);
end; // TServiceManager.StopService


function TServiceManager.RestartService(const AstrCompName: String;
    const AstrService: String): Integer;
var
  hSCManager: SC_Handle;
  hService: SC_Handle;
  ServiceStatus: TServiceStatus;
  // В данной версии предусмотрен запуск службы только без параметров,
  // но Delphi не позволяет передавать nil в качестве var-параметра,
  // поэтому введена переменная pcArgs.
  pcArgs: PChar;
begin

  // если служба остановлена, то просто стартуем ее
  if IsStopped(AstrCompName, AstrService) then begin
    Result := StartService(AstrCompName, AstrService);
    Exit;
  end;

  hSCManager := OpenSCManager(PChar(AstrCompName), nil, SC_MANAGER_CONNECT);
  if (hSCManager <> NULL_HANDLE) then begin
    hService := OpenService(hSCManager, PChar(AstrService),
        SERVICE_QUERY_STATUS or SERVICE_START or SERVICE_STOP);
    // if Service installed
    if (hService <> NULL_HANDLE) then begin

      if ControlService(
          hService, SERVICE_CONTROL_STOP, ServiceStatus) then begin

        Result := _WaitStopService(hService);
        if Result = 0 then begin
          if not WinSvc.StartService(hService, 0, pcArgs) then begin
            Result := GetLastError();
          end;
        end;

      end else begin
        Result := GetLastError();
      end;

      CloseServiceHandle(hService);

    end else begin
      Result := GetLastError();
    end;

    CloseServiceHandle(hSCManager);

  end else begin
    Result := GetLastError();
  end;

end; // TServiceManager.RestartService


function TServiceManager.RestartService(const AstrService: String): Integer;
begin
  Result := RestartService('', AstrService);
end; // TServiceManager.RestartService


function TServiceManager.GetServiceStatus(const AstrCompName: String;
    const AstrService: String): DWord;
// Return values:
// -1 = Error opening service
// 1 = SERVICE_STOPPED
// 2 = SERVICE_START_PENDING
// 3 = SERVICE_STOP_PENDING
// 4 = SERVICE_RUNNING
// 5 = SERVICE_CONTINUE_PENDING
// 6 = SERVICE_PAUSE_PENDING
// 7 = SERVICE_PAUSED
var
  hSCManager: SC_Handle;
  hService: SC_Handle;
  ServiceStatus: TServiceStatus;
begin
  Result := DWORD(-1);

  hSCManager := OpenSCManager(PChar(AstrCompName), nil, SC_MANAGER_CONNECT);
  if (hSCManager <> NULL_HANDLE) then begin
    hService := OpenService(hSCManager,
        PChar(AstrService), SERVICE_QUERY_STATUS);
    // if Service installed
    if (hService <> NULL_HANDLE) then begin
      if (QueryServiceStatus(hService, ServiceStatus)) then begin
        Result := ServiceStatus.dwCurrentState;
      end;
      CloseServiceHandle(hService);
    end;
    CloseServiceHandle(hSCManager);
  end;
end; // TServiceManager.GetServiceStatus


function TServiceManager.GetServiceStatus(
    const AstrService: String): DWord;
begin
  Result := GetServiceStatus('', AstrService);
end; // TServiceManager.GetServiceStatus


function TServiceManager.IsRunning(const AstrCompName: String;
    const AstrService: String): Boolean;
begin
  Result := (SERVICE_RUNNING = GetServiceStatus(AstrCompName, AstrService));
end; // TServiceManager.IsRunning


function TServiceManager.IsRunning(
    const AstrService: String): Boolean;
begin
  Result := IsRunning('', AstrService);
end; // TServiceManager.IsRunning


function TServiceManager.IsStopped(const AstrCompName: String;
    const AstrService: String): Boolean;
begin
  Result := (SERVICE_STOPPED = GetServiceStatus(AstrCompName, AstrService));
end; // TServiceManager.IsStopped


function TServiceManager.IsStopped(
    const AstrService: String): Boolean;
begin
  Result := IsStopped('', AstrService);
end; // TServiceManager.IsStopped


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TServiceManager._WaitStopService(
    const AhService: SC_Handle): Integer;
const
  MIN_WAIT_TIME = 1 * SECONDS;
  MAX_WAIT_TIME = 10 * SECONDS;
var
  dwWaitTime: DWord;
  dwStartTickCount: DWord;
  dwOldCheckPoint: DWord;
  ServiceStatus: TServiceStatus;
begin
  Result := 0;

  if QueryServiceStatus(AhService, ServiceStatus) then begin

    dwStartTickCount := GetTickCount();
    dwOldCheckPoint := ServiceStatus.dwCheckPoint;

    while (ServiceStatus.dwCurrentState = SERVICE_STOP_PENDING) do begin
      // Рекомендация из MSDN:
      // брать для ожидания одну десятую от dwWaitHint,
      // но не меньше 1 секунды и не больше 10 секунд.
      dwWaitTime := ServiceStatus.dwWaitHint div 10;
      if (dwWaitTime < MIN_WAIT_TIME) then begin
        dwWaitTime := MIN_WAIT_TIME;
      end else if (dwWaitTime > MAX_WAIT_TIME) then begin
        dwWaitTime := MAX_WAIT_TIME;
      end;

      Sleep(dwWaitTime);

      if not QueryServiceStatus(AhService, ServiceStatus) then begin
        Result := GetLastError();
        break;
      end;

      if (ServiceStatus.dwCheckPoint > dwOldCheckPoint ) then begin
        // The service is making progress.
        dwStartTickCount := GetTickCount();
        dwOldCheckPoint := ServiceStatus.dwCheckPoint;
      end else if ((GetTickCount() - dwStartTickCount) >
          ServiceStatus.dwWaitHint) then begin
        break;
      end;

    end; // while

  end else begin
    Result := GetLastError();
  end;

end; // TServiceManager._WaitStopService


initialization

finalization

  TServiceManager.ReleaseInstance();

end.
