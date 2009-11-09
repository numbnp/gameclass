unit uTaskKill;

interface

uses
  uTaskKillConst;

// снять задачу
function KillTask(const AstrTaskList: String;
    const AbExclude: Boolean = False): Boolean;

// получить список задач
function GetTasksList(): string; overload;

// получить список задач, не включая задачи из списка AExclusions
function GetTasksList(const AExclusions: array of string): string; overload;


implementation
uses
{$IFDEF MSWINDOWS}
  Windows,
  Tlhelp32,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
  uClientOptions,
{$ENDIF}
  Types,
  Classes,
  StrUtils,
  SysUtils,
  uY2KCommon,
  uY2KString,
  uDebugLog;


{$IFDEF MSWINDOWS}
function _IsProcessesInList(const AstrProcessFileName: String;
    const AlstProcessList: TStringList): Boolean;
var
  strProcessFileName : string;
begin
  strProcessFileName := ExtractFileName(AstrProcessFileName);
  Result := (AlstProcessList.IndexOf(strProcessFileName) <> -1)
      or (AlstProcessList.IndexOf(AstrProcessFileName) <> -1);
end; // _IsEqualProcessesFileNames


// снять задачу
function KillTask(const AstrTaskList: String;
    const AbExclude: Boolean = False): Boolean;
const
  PROCESS_TERMINATE = $0001;
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  hProcess: THandle;
  bIsProcessPresent: boolean;
  lstTaskList: TStringList;
begin
  Result := FALSE;
  lstTaskList := TStringList.Create;
  lstTaskList.Text := AstrTaskList;
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin
    if  _IsProcessesInList(
        ProcessEntry32.szExeFile, lstTaskList) xor AbExclude then begin

      hProcess := OpenProcess(
          PROCESS_TERMINATE, FALSE, ProcessEntry32.th32ProcessID);
      if hProcess <> NULL_HANDLE then begin
        Result := TerminateProcess(hProcess, 0);
        CloseHandle(hProcess);
      end;
    end;
    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);
  end;

  CloseHandle(hSnapshot);
  FreeAndNil(lstTaskList);
end; // KillTask


function GetTasksList(): string;
begin
  Result := GetTasksList([]);
end; // GetTasksList


function GetTasksList(const AExclusions: array of string): string;
const
  STR_DIVIDER = '/';

var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessFileName: string;
  strTasksList: string;
  bIsProcessPresent: boolean;
begin
  Result := '';

  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  strTasksList := '';
  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin
    strProcessFileName := ExtractFileName(ProcessEntry32.szExeFile);
    if not FindStringInArray(
        strProcessFileName, AExclusions, FALSE) then begin

      if length(strTasksList) > 0 then begin
        strTasksList := strTasksList + STR_DIVIDER;
      end;
      strTasksList := strTasksList + strProcessFileName;

    end;
    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);
  end; // while

  CloseHandle(hSnapshot);

  Result := strTasksList;

end; // GetTasksList
{$ENDIF}

{$IFDEF LINUX}
// снять задачу
function KillTask(const AstrTaskList: String;
    const AbExclude: Boolean = False): Boolean;
var
  strCommand: String;
begin
  if AbExclude then
    strCommand := 'killall ' + ''
  else
    strCommand := 'killall ' + AstrTaskList;
  Libc.system(PChar(strCommand));
  Result := True;
end; // KillTask

function GetTasksList(): String;
begin
  Result := GetTasksList([]);
end; // GetTasksList


function GetTasksList(const AExclusions: array of string): string;
const
  STR_DIVIDER = '/';
  PROCESS_FILE_NAME = 'process.lst';
var
  strProcessFileName: string;
  strTasksList: string;
  bIsProcessPresent: boolean;
  fProcess: TextFile;
  strFileName: String;
begin
  Result := '';
  strTasksList := '';
  strFileName := ExtractFilePath(ParamStr(0)) + PROCESS_FILE_NAME;
  Libc.system('ps -A -o comm>' + PROCESS_FILE_NAME);
  AssignFile(fProcess, PROCESS_FILE_NAME);
  Reset(fProcess);
  while not Eof(fProcess) do begin
    Readln(fProcess, strProcessFileName);
    strProcessFileName := AnsiReplaceStr(strProcessFileName, '/0', '');
    if not FindStringInArray(
        strProcessFileName, AExclusions, False)
        and not (Pos(STR_DIVIDER + strProcessFileName + STR_DIVIDER,
        STR_DIVIDER + strTasksList + STR_DIVIDER) > 0) then begin
      if Length(strTasksList) > 0 then begin
        strTasksList := strTasksList + STR_DIVIDER;
      end;
      strTasksList := strTasksList + strProcessFileName;
    end;
  end;
  CloseFile(fProcess);
  Result := strTasksList;
end; // GetTasksList
{$ENDIF}

end.
