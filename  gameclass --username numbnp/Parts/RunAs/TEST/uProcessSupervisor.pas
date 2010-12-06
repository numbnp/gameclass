//////////////////////////////////////////////////////////////////////////////
//
// Класс слежения за процессами.
//
// Если заданный процесс отсутсвует в списке процессов,
// то этот процесс запускается заново.
//
//////////////////////////////////////////////////////////////////////////////

unit uProcessSupervisor;

interface

uses
  // system units
  Windows,
  // project units
  uProcessesDescriptions,
  uY2KRunAs;


type

  //
  // TProcessSupervisor
  //

  TProcessSupervisor = class(TObject)
  private
    // fields
    FhSupervisorThread: THandle;
    FProcessesDescriptions: TProcessesDescriptions;

    // threads methods
    procedure _DoSupervision();

    // private helper methods
    procedure _CheckAndRunProcesses();
    procedure _ExecuteApp(const AstrExeFile: String);
    function _IsProcessFound(const AstrProcessName: string): boolean;
    function _GetProcessHandle(const AstrProcessName: String): THandle;
    function _GetThreadId(const AdwProcessId: DWORD): DWORD;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure StartSupervision();
    procedure StopSupervision();

    procedure AddProcessInfo(
        const AstrName: string; const AstrExeFile: string);
    procedure RemoveProcessInfo(const AstrName: string);
    procedure ClearProcessInfo();

  end; // TProcessSupervisor


implementation

uses
  // system units
  SysUtils,
  ShellApi,
  Tlhelp32,
  Dialogs,
  // project units
  uDebugLog;


const
  TIMEOUT_DEF = 15000; // пауза в опросе процессов


// метод используется для прерывания цикла ожидания событий
// см. описание API-функции QueueUserAPC
procedure ExitThreadAPC(AdwParam: DWORD); stdcall;
begin
//
end; // ExitThreadAPC


// по идее это должна быть метод класса, но при попытке запустить
// метод класса в отдельном потоке приложение подвисает
// в варианте с глобальной функцией все работате нормально
function DoSupervision(Ap: TProcessSupervisor): DWORD;
begin
  Ap._DoSupervision();
  Result := 0;
end; // DoPrintersNotifies


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TProcessSupervisor

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TProcessSupervisor.Create();
begin
  inherited Create();

  FhSupervisorThread := 0;
  FProcessesDescriptions := TProcessesDescriptions.Create();

end; // TProcessSupervisor.Create


destructor TProcessSupervisor.Destroy();
begin
  FreeAndNil(FProcessesDescriptions);
  inherited Destroy();
end; // TProcessSupervisor.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TProcessSupervisor.StartSupervision();
var
  nThreadId: cardinal;
begin
  ASSERT(Assigned(FProcessesDescriptions));

  FhSupervisorThread := BeginThread(
      nil, 0, @DoSupervision, Pointer(Self), 0, nThreadId);
  ASSERT(FhSupervisorThread <> INVALID_HANDLE_VALUE);

end; // TProcessSupervisor.StartThreads


procedure TProcessSupervisor.StopSupervision();
begin
  ASSERT(Assigned(FProcessesDescriptions));

  if (FhSupervisorThread <> INVALID_HANDLE_VALUE)
      and (FhSupervisorThread <> 0) then begin
    QueueUserAPC(@ExitThreadAPC, FhSupervisorThread, 0);
    Debug.Trace0('wait...');
    WaitForSingleObject(FhSupervisorThread, INFINITE);
    Debug.Trace0('wait complete!');    
    CloseHandle(FhSupervisorThread);
  end;

end; // TProcessSupervisor.StopThreads


procedure TProcessSupervisor.AddProcessInfo(
    const AstrName: string; const AstrExeFile: string);
var
  nFoundIndex: integer;
begin
  ASSERT(Assigned(FProcessesDescriptions));

  nFoundIndex := FProcessesDescriptions.FindByName(AstrName);
  if nFoundIndex = PROCESS_DESCRIPTION_NOT_FOUND then begin
    with FProcessesDescriptions.Add() do begin
      Name := AstrName;
      ExeFile := AstrExeFile;
    end;
  end;

end; // TProcessSupervisor.AddProcessInfo


procedure TProcessSupervisor.RemoveProcessInfo(const AstrName: string);
var
  nFoundIndex: integer;
begin
  ASSERT(Assigned(FProcessesDescriptions));

  nFoundIndex := FProcessesDescriptions.FindByName(AstrName);
  if nFoundIndex <> PROCESS_DESCRIPTION_NOT_FOUND then begin
    FProcessesDescriptions.Delete(nFoundIndex);
  end;

end; // TProcessSupervisor.RemoveProcessInfo


procedure TProcessSupervisor.ClearProcessInfo();
begin
  ASSERT(Assigned(FProcessesDescriptions));

  FProcessesDescriptions.Clear();

end; // TProcessSupervisor.ClearProcessInfo


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// threads methods

procedure TProcessSupervisor._DoSupervision();
var
  dwWaitStatus: DWORD;
begin
  while(TRUE) do begin
    dwWaitStatus := SleepEx(TIMEOUT_DEF, TRUE);

    Debug.Trace0('TIMEOUT_DEF');

    if (WAIT_IO_COMPLETION = dwWaitStatus) then begin
      Debug.Trace0('WAIT_IO_COMPLETION');
      break;
    end;

    _CheckAndRunProcesses();
  end;
end; // TProcessSupervisor._DoSupervision


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TProcessSupervisor._CheckAndRunProcesses();
var
  bIsProcessFound: Boolean;
  i: Integer;
begin
  Debug.Trace0('_CheckAndRunProcesses started!');
  Debug.Trace0('FProcessesDescriptions.Count = '
      + IntToStr(FProcessesDescriptions.Count));
  for i := 0 to FProcessesDescriptions.Count - 1 do begin
    bIsProcessFound := _IsProcessFound(FProcessesDescriptions[i].Name);
    if not bIsProcessFound then begin
      if FileExists(FProcessesDescriptions[i].ExeFile) then begin
        _ExecuteApp(FProcessesDescriptions[i].ExeFile);
      end;
    end;
  end;
end; // TProcessSupervisor._CheckAndRunProcesses


procedure TProcessSupervisor._ExecuteApp(const AstrExeFile: String);
var
  hProcess: THandle;
  hToken: THandle;
  hNewToken: THandle;
  StartupInfo: TStartupInfo;
  ProcessInformation: TProcessInformation;
begin
//  ShellExecute(0, 'open', PChar(AstrExeFile), nil, nil, SW_SHOW);

//  if 0 <> StartInteractiveClientProcess('y2k', '', 'quit',
//      AstrExeFile, TRUE) then begin
//
//    MessageDlg(IntToStr(GetLastError()), mtError, [mbOK], 0);
//
//  end;


  hProcess := _GetProcessHandle('explorer.exe');
  if hProcess <> 0 then begin
    if OpenProcessToken(hProcess,
        TOKEN_QUERY or TOKEN_DUPLICATE or TOKEN_IMPERSONATE,
        hToken) then begin
      if DuplicateTokenEx(hToken, MAXIMUM_ALLOWED, nil,
          SecurityImpersonation, TokenPrimary, hNewToken) then begin
        if hToken <> INVALID_HANDLE_VALUE then begin
          if 0 <> StartInteractiveClientProcess(hNewToken, AstrExeFile, TRUE) then begin
            MessageDlg('StartInteractiveClientProcess error: ' + IntToStr(GetLastError()), mtError, [mbOK], 0);
          end;
          CloseHandle(hToken);
        end;
      end else begin
        MessageDlg('DuplicateToken error:' + IntToStr(GetLastError()), mtError, [mbOK], 0);
      end;
    end;
  end;

end; // TProcessSupervisor._ExecuteApp


function TProcessSupervisor._GetProcessHandle(
    const AstrProcessName: String): THandle;
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessName: String;
  bIsProcessPresent: Boolean;
begin
  Result := 0;

  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin
    strProcessName := ExtractFileName(ProcessEntry32.szExeFile);
    if CompareText(
        AstrProcessName, strProcessName) = 0 then begin

      Result := OpenProcess(
          PROCESS_QUERY_INFORMATION, FALSE, ProcessEntry32.th32ProcessID);
      if Result = INVALID_HANDLE_VALUE then begin
        Result := 0;
      end;
      break;
    end;
    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);
  end; // while

  CloseHandle(hSnapshot);

end; // TProcessSupervisor._GetProcessHandle


function TProcessSupervisor._GetThreadId(
    const AdwProcessId: DWORD): DWORD;
const
  DESKTOP_DESIRED_ACCESS = READ_CONTROL
      or WRITE_DAC
      or DESKTOP_WRITEOBJECTS
      or DESKTOP_READOBJECTS;
var
  ThreadEntry32: TThreadEntry32;
  hSnapshot: THandle;
  bIsThreadPresent: Boolean;
begin
  Result := 0;

  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;

  ThreadEntry32.dwSize := sizeof(ThreadEntry32);

  bIsThreadPresent := Thread32First(hSnapshot, ThreadEntry32);
  while bIsThreadPresent do begin

    if ThreadEntry32.th32OwnerProcessID = AdwProcessId then begin
      Result := ThreadEntry32.th32ThreadID;
    end;

    bIsThreadPresent := Thread32Next(hSnapshot, ThreadEntry32);
  end; // while

  CloseHandle(hSnapshot);

end; // TProcessSupervisor._GetThreadId


function TProcessSupervisor._IsProcessFound(
    const AstrProcessName: String): Boolean;
const
  DESKTOP_DESIRED_ACCESS = READ_CONTROL
      or WRITE_DAC
      or DESKTOP_WRITEOBJECTS
      or DESKTOP_READOBJECTS;
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessName: String;
  bIsProcessPresent: Boolean;
  hThreadDesktop: THandle;
  hCurrentDesktop: THandle;
  hExplorerProcess: THandle;
  hProcess: THandle;
  dwThreadId: DWORD;
  hToken: THandle;
  hExplorerToken: THandle;
begin
  Debug.Trace0('_IsProcessFound started!');

  Result := FALSE;

  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin

    strProcessName := ExtractFileName(ProcessEntry32.szExeFile);

    if CompareText(
        AstrProcessName, strProcessName) = 0 then begin

      Debug.Trace0(AstrProcessName + ' found!');

      hProcess := _GetProcessHandle(strProcessName);
      if hProcess <> 0 then begin
        if OpenProcessToken(hProcess, TOKEN_QUERY, hToken) then begin

          hExplorerProcess := _GetProcessHandle('explorer.exe');
          if hExplorerProcess <> 0 then begin
            if OpenProcessToken(hExplorerProcess,
                TOKEN_QUERY, hExplorerToken) then begin
              if hExplorerToken <> INVALID_HANDLE_VALUE then begin

                CloseHandle(hExplorerToken);
              end;
            end;
          end;

          CloseHandle(hToken);

        end;
      end;

      Result := TRUE;
      break;

      // Получаем интерактивный десктоп.
//      hCurrentDesktop := OpenDesktop(
//          'default', 0, FALSE, DESKTOP_DESIRED_ACCESS);

//      dwThreadId := _GetThreadId(ProcessEntry32.th32ProcessID);
//      Debug.Trace0('dwThreadId = ' + IntToStr(dwThreadId));

//      if dwThreadId <> 0 then begin
//        hThreadDesktop := GetThreadDesktop(ProcessEntry32.th32ProcessID);
//        if hThreadDesktop = 0 then begin
//          Debug.Trace0('GetThreadDesktop error! ' + IntToStr(GetLastError()));
//        end;
//        Debug.Trace0('hCurrentDesktop = ' + IntToStr(hCurrentDesktop));
//        Debug.Trace0('hThreadDesktop = ' + IntToStr(hThreadDesktop));
//        if hCurrentDesktop = hThreadDesktop then begin
//          Result := TRUE;
//          break;
//        end;

//      end;

//      if hCurrentDesktop <> 0 then begin
//        CloseDesktop(hCurrentDesktop);
//      end;

    end;

    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);

  end; // while

  CloseHandle(hSnapshot);

end; // TProcessSupervisor._IsProcessFound



end.
