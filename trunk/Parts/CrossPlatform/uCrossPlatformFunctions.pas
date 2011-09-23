//////////////////////////////////////////////////////////////////////////////
//
// Модуль кроссплатформенных функций общего назначения
//
// большая часть взята из Y2KCommon
//
//////////////////////////////////////////////////////////////////////////////
unit uCrossPlatformFunctions;

interface

uses
  // system units
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  Types;

const
  // NT Defined Privileges
  // в SDK они описаны в WinNT.h, для Delphi пришлось определять самому
  SE_CREATE_TOKEN_NAME        = 'SeCreateTokenPrivilege';
  SE_ASSIGNPRIMARYTOKEN_NAME  = 'SeAssignPrimaryTokenPrivilege';
  SE_LOCK_MEMORY_NAME         = 'SeLockMemoryPrivilege';
  SE_INCREASE_QUOTA_NAME      = 'SeIncreaseQuotaPrivilege';
  SE_UNSOLICITED_INPUT_NAME   = 'SeUnsolicitedInputPrivilege';
  SE_MACHINE_ACCOUNT_NAME     = 'SeMachineAccountPrivilege';
  SE_TCB_NAME                 = 'SeTcbPrivilege';
  SE_SECURITY_NAME            = 'SeSecurityPrivilege';
  SE_TAKE_OWNERSHIP_NAME      = 'SeTakeOwnershipPrivilege';
  SE_LOAD_DRIVER_NAME         = 'SeLoadDriverPrivilege';
  SE_SYSTEM_PROFILE_NAME      = 'SeSystemProfilePrivilege';
  SE_SYSTEMTIME_NAME          = 'SeSystemtimePrivilege';
  SE_PROF_SINGLE_PROCESS_NAME = 'SeProfileSingleProcessPrivilege';
  SE_INC_BASE_PRIORITY_NAME   = 'SeIncreaseBasePriorityPrivilege';
  SE_CREATE_PAGEFILE_NAME     = 'SeCreatePagefilePrivilege';
  SE_CREATE_PERMANENT_NAME    = 'SeCreatePermanentPrivilege';
  SE_BACKUP_NAME              = 'SeBackupPrivilege';
  SE_RESTORE_NAME             = 'SeRestorePrivilege';
  SE_SHUTDOWN_NAME            = 'SeShutdownPrivilege';
  SE_DEBUG_NAME               = 'SeDebugPrivilege';
  SE_AUDIT_NAME               = 'SeAuditPrivilege';
  SE_SYSTEM_ENVIRONMENT_NAME  = 'SeSystemEnvironmentPrivilege';
  SE_CHANGE_NOTIFY_NAME       = 'SeChangeNotifyPrivilege';
  SE_REMOTE_SHUTDOWN_NAME     = 'SeRemoteShutdownPrivilege';
  SE_UNDOCK_NAME              = 'SeUndockPrivilege';
  SE_SYNC_AGENT_NAME          = 'SeSyncAgentPrivilege';
  SE_ENABLE_DELEGATION_NAME   = 'SeEnableDelegationPrivilege';
  SE_MANAGE_VOLUME_NAME       = 'SeManageVolumePrivilege';

// функция проверки доступа к файлу
function IsAccessToFilePermit(const AstrFileName: string;
    const AdwAccessRights: DWORD): boolean;

// получить системную директорию Windows
function GetSystemDir(): String;

// получить директорию Windows
function GetWinDir(): string;

// проверить ядро ОС
function IsWinNT(): boolean;

// перегрузить систему
procedure SystemRestart;

// выключить систему
procedure SystemShutdown;

// завершить сеанс
procedure SystemLogoff;

// выполнить произвольную команду
procedure ExecuteCommandLine (eCommandLine: string);

function ExecAndWait(const FileName, Params: ShortString;
    const WinState: Word): boolean; export;

function EnablePrivilege(const AstrEnabledPrivilege: string;
    const AbEnable: boolean = TRUE): boolean;

function GetTempDir: String;

implementation

uses
{$IFDEF MSWINDOWS}
  Tlhelp32,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
  uClientOptions,
{$ENDIF}
  StrUtils,
  SysUtils,
  uY2KCommon,
  uY2KString,
  uDebugLog;


{$IFDEF MSWINDOWS}
// Result: TRUE - доступ разрешен
//        FALSE - доступ запрещен
function IsAccessToFilePermit(const AstrFileName: string;
    const AdwAccessRights: DWORD): boolean;
var
  hFile: THandle;
begin
  hFile := CreateFile(PChar(AstrFileName),
      AdwAccessRights, 0, nil, OPEN_EXISTING, 0, 0);

  Result := hFile <> INVALID_HANDLE_VALUE;

  if hFile <> INVALID_HANDLE_VALUE then begin
    CloseHandle(hFile);
  end;

end; // IsAccessToFilePermit


function GetSystemDir(): String;
const
  // По информации из MSDN, максимальный размер буфера
  // для функции GetSystemDirectory равен MAX_PATH + 1
  MAX_PATH_FOR_SYS_DIR = MAX_PATH + 1;
var
  pcSystemDir: PChar;
begin
  Result := '';

  try
    GetMem(pcSystemDir, MAX_PATH_FOR_SYS_DIR);
    try
      FillMemory(pcSystemDir, MAX_PATH_FOR_SYS_DIR, 0);
      GetSystemDirectory(pcSystemDir, MAX_PATH_FOR_SYS_DIR);
      Result := String(pcSystemDir);
    finally
      FreeMem(pcSystemDir);
    end;
  except
    ASSERT(FALSE, 'GetSystemDir error!');
  end;

end; // GetSystemDir


function GetWinDir(): String;
var
  pcWindowsDir: PChar;
begin
  Result := '';

  try
    GetMem(pcWindowsDir, MAX_PATH);
    try
      FillMemory(pcWindowsDir, MAX_PATH, 0);
      GetWindowsDirectory(pcWindowsDir, MAX_PATH);
      Result := String(pcWindowsDir)
    finally
      FreeMem(pcWindowsDir);
    end;
  except
    ASSERT(FALSE, 'GetWinDir error!');
  end;

end; // GetWinDir


function IsWinNT(): boolean;
var
  ver: TOSVersionInfo;
  bIsSuccess: boolean;
begin
  ver.dwOSVersionInfoSize := sizeof(ver);
  bIsSuccess := GetVersionEx(ver);
  if bIsSuccess then begin
    Result := (ver.dwPlatformId = VER_PLATFORM_WIN32_NT)
  end else begin
    Result := FALSE;
  end;
end; // IsWinNT


procedure ExitWindows(const AwFlags: word);
var
  wFlags: Word;
begin
  wFlags := AwFlags;

  if IsWinNT() then begin
    if AwFlags = (EWX_SHUTDOWN or EWX_FORCE) then begin
      wFlags := EWX_POWEROFF or EWX_FORCE;
    end;
  end;

  ExitWindowsEx(wFlags, 0);
end; // RebootSystem

// перегрузить систему
procedure SystemRestart;
begin
  ExitWindows(EWX_REBOOT or EWX_FORCE);
end;

// выключить систему
procedure SystemShutdown;
begin
  ExitWindows(EWX_SHUTDOWN or EWX_FORCE);
end;

// завершить сеанс
procedure SystemLogoff;
begin
  ExitWindows(EWX_LOGOFF or EWX_FORCE);
end;

// выполнить произвольную команду
procedure ExecuteCommandLine (eCommandLine: string);
begin
end;

function EnablePrivilege(const AstrEnabledPrivilege: string;
    const AbEnable: boolean = TRUE): boolean;
var
  hProcess: THandle;
  hProcessToken: THandle;
  nProcessId: dword;
  nLuid: TLargeInteger;
  priv: TOKEN_PRIVILEGES;
  bAdjustedPriv: boolean;
  nReturnLength: cardinal;
  dwError: dword;
begin
  Result := FALSE;

  if not IsWinNT() then begin
    Exit;
  end;

  nProcessId := GetCurrentProcessId();
  hProcess := OpenProcess(PROCESS_ALL_ACCESS, FALSE, nProcessId);
  if hProcess <> NULL_HANDLE then begin
    if OpenProcessToken(hProcess,
        TOKEN_QUERY or TOKEN_ADJUST_PRIVILEGES, hProcessToken) then begin

      if LookupPrivilegeValue(nil,
          PChar(AstrEnabledPrivilege), nLuid) then begin

        priv.PrivilegeCount := 1;
        if AbEnable then begin
          priv.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        end;

        priv.Privileges[0].Luid := nLuid;

        bAdjustedPriv := AdjustTokenPrivileges(hProcessToken,
            FALSE, priv, 0, nil, nReturnLength);
        if bAdjustedPriv then begin
          dwError := GetLastError();
          if dwError = ERROR_SUCCESS then begin
            Result := TRUE;
          end;
        end;

      end;
      CloseHandle(hProcessToken);
    end;
    CloseHandle(hProcess);
  end;

end; // EnablePrivilege


function ExecAndWait(const FileName, Params: ShortString;
    const WinState: Word): boolean; export;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: ShortString;
begin
  { Помещаем имя файла между кавычками,
  с соблюдением всех пробелов в именах Win9x }
    CmdLine := '"' + Filename + '" ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    cb := SizeOf(TStartupInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
  end;
  Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
  { Ожидаем завершения приложения }
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    { Free the Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end; //ExecAndWait

function GetTempDir: String;
var
  Buf: array[0..1023] of Char;
begin
  SetString(Result, Buf, GetTempPath(Sizeof(Buf)-1, Buf));
end;
{$ENDIF}

{$IFDEF LINUX}
// Result: TRUE - доступ разрешен
//        FALSE - доступ запрещен
function IsAccessToFilePermit(const AstrFileName: string;
    const AdwAccessRights: DWORD): boolean;
var
  hFile: THandle;
begin
  Result := False;
{
  hFile := CreateFile(PChar(AstrFileName),
      AdwAccessRights, 0, nil, OPEN_EXISTING, 0, 0);

  Result := hFile <> INVALID_HANDLE_VALUE;

  if hFile <> INVALID_HANDLE_VALUE then begin
    CloseHandle(hFile);
  end;
}
end; // IsAccessToFilePermit


function GetSystemDir(): String;
const
  // По информации из MSDN, максимальный размер буфера
  // для функции GetSystemDirectory равен MAX_PATH + 1
  MAX_PATH_FOR_SYS_DIR = MAX_PATH + 1;
var
  pcSystemDir: PChar;
begin
  Result := '';
{
  try
    GetMem(pcSystemDir, MAX_PATH_FOR_SYS_DIR);
    try
      FillMemory(pcSystemDir, MAX_PATH_FOR_SYS_DIR, 0);
      GetSystemDirectory(pcSystemDir, MAX_PATH_FOR_SYS_DIR);
      Result := String(pcSystemDir);
    finally
      FreeMem(pcSystemDir);
    end;
  except
    ASSERT(FALSE, 'GetSystemDir error!');
  end;
}
end; // GetSystemDir


function GetWinDir(): String;
var
  pcWindowsDir: PChar;
begin
  Result := '';
{
  try
    GetMem(pcWindowsDir, MAX_PATH);
    try
      FillMemory(pcWindowsDir, MAX_PATH, 0);
      GetWindowsDirectory(pcWindowsDir, MAX_PATH);
      Result := String(pcWindowsDir)
    finally
      FreeMem(pcWindowsDir);
    end;
  except
    ASSERT(FALSE, 'GetWinDir error!');
  end;
}
end; // GetWinDir


function IsWinNT(): boolean;
begin
  Result := False;
end; // IsWinNT

// перегрузить систему
procedure SystemRestart;
var
  strCommand: String;
begin
  strCommand := './scripts/gcreboot';
  ExecuteCommandLine(strCommand);
//  ExitWindows(EWX_REBOOT or EWX_FORCE);
end;

// выключить систему
procedure SystemShutdown;
var
  strCommand: String;
begin
  strCommand := './scripts/gcpoweroff';
  ExecuteCommandLine(strCommand);
//  ExitWindows(EWX_SHUTDOWN or EWX_FORCE);
end;

// завершить сеанс
procedure SystemLogoff;
var
  strCommand: String;
begin
{  if Length(GClientOptions.KDEUser) > 0 then begin
    strCommand := ' dcop --all-sessions --user '
        + GClientOptions.KDEUser
        + ' ksmserver ksmserver logout 0 0 0';
    strCommand := './scripts/gclogoff';
    Libc.system(PChar(strCommand));
  end;
}
  strCommand := './scripts/gclogoff';
  ExecuteCommandLine(strCommand);
end;

// выполнить произвольную команду
procedure ExecuteCommandLine (eCommandLine: string);
//var
//  strCommand: String;
begin
//  strCommand := eCommandLine;
  Debug.Trace0('Command_execute:' + eCommandLine);
  Libc.system(PChar(eCommandLine));
end;

function ExecAndWait(const FileName, Params: ShortString;
    const WinState: Word): boolean; export;
var
//  StartInfo: TStartupInfo;
//  ProcInfo: TProcessInformation;
  CmdLine: ShortString;
begin
{
  //  Помещаем имя файла между кавычками,
  //  с соблюдением всех пробелов в именах Win9x
    CmdLine := '"' + Filename + '" ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    cb := SizeOf(TStartupInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
  end;
  Result := CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo);
  // Ожидаем завершения приложения
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    // Free the Handles
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
}
  Result := False;
end; //ExecAndWait

function EnablePrivilege(const AstrEnabledPrivilege: string;
    const AbEnable: boolean = TRUE): boolean;
begin
  Result := FALSE;
end; // EnablePrivilege

function GetTempDir: String;
begin
  Result := '/tmp/';
end;

{$ENDIF}

end.
