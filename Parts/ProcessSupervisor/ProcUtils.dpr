////////////////////////////////////////////////////////////////////////////////
// Библиотека содержит все функции использующие вызовы Process32First
// для того, чтобы идиотский антивирус NOD32 не считал сервис неизвестным
// вирусом.
//
////////////////////////////////////////////////////////////////////////////////
library ProcUtils;

uses
  Classes,
  Windows,
  SysUtils,
  Tlhelp32,
  uProcessesDescriptions in 'uProcessesDescriptions.pas',
  uY2KCommon in '..\Y2KCommon\uY2KCommon.pas',
  uY2KString in '..\Y2KCommon\uY2KString.pas',
  uDebugLog in '..\Debug\uDebugLog.pas';

var
  FstrTasksList: String;
  FstrProcessFileName: String;
  FstrRunnedProcessList: String;
  FstrTerminatedProcessList: String;
  FCurrentProcess: TProcessesDescriptions;

{$R *.res}
function _IsProcessesInList(const AstrProcessFileName: String;
    const AlstProcessList: TStringList): Boolean;
var
  strProcessFileName : string;
begin
  strProcessFileName := ExtractFileName(AstrProcessFileName);
  Result := (AlstProcessList.IndexOf(strProcessFileName) <> -1)
      or (AlstProcessList.IndexOf(AstrProcessFileName) <> -1);
end; // _IsEqualProcessesFileNames

function GetProcessHandle(const AstrProcessName: PChar): THandle; cdecl; export;
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessName: String;
  bIsProcessPresent: Boolean;
begin
  //Debug.Trace1('GetProcessHandle Begin');
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
  //Debug.Trace1('GetProcessHandle End');
end;


function IsProcessFound(const AstrProcessName: PChar;
    const AstrExplorerProcessName: PChar): Boolean; cdecl; export;
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessName: String;
  bIsProcessPresent: Boolean;
  hExplorerProcess: THandle;
  hProcess: THandle;
  hToken: THandle;
  hExplorerToken: THandle;

begin
  //Debug.Trace1('IsProcessFound Begin');
  Result := False;

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

      hProcess := GetProcessHandle(PChar(strProcessName));
      if hProcess <> 0 then begin
        if OpenProcessToken(hProcess, TOKEN_QUERY, hToken) then begin
          hExplorerProcess := GetProcessHandle(AstrExplorerProcessName);
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

      Result := True;
      break;
    end;

    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);

  end; // while
  CloseHandle(hSnapshot);
  //Debug.Trace1('IsProcessFound End');
end;

function _ScanProcess(var ACurrentProcess: TProcessesDescriptions
    ): Boolean;
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessName: String;
  bIsProcessPresent: Boolean;
  nFoundIndex: integer;

begin
  //Debug.Trace1('ScanProcess Begin');
  Result := FALSE;

  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;
  ProcessEntry32.dwSize := sizeof(ProcessEntry32);
  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin
    strProcessName := ExtractFileName(ProcessEntry32.szExeFile);
    nFoundIndex := ACurrentProcess.FindByName(strProcessName);
    if nFoundIndex = PROCESS_DESCRIPTION_NOT_FOUND then begin
      with ACurrentProcess.Add() do begin
        Name := strProcessName;
        ExeFile := ProcessEntry32.szExeFile;
      end;
    end;

    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);
  end; // while
  CloseHandle(hSnapshot);
  Result := True;
  //Debug.Trace1('ScanProcess End');
end;

function KillTask(const AstrTaskList: PChar;
    const AbExclude: Boolean = False): Boolean; cdecl; export;
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
  Debug.Trace0('List:' + AstrTaskList);
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin
    if  _IsProcessesInList(
        ProcessEntry32.szExeFile, lstTaskList) xor AbExclude then begin
      Debug.Trace0(ProcessEntry32.szExeFile);

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

function GetTasksList(const AstrExclusionsList: PChar): PChar; cdecl; export;
const
  STR_DIVIDER = '/';
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  strProcessFileName: string;
  bIsProcessPresent: boolean;
  strExclusionsList: String;
begin
  //Debug.Trace1('GetTasksList Begin');
  FstrTasksList := '';
  strExclusionsList := AstrExclusionsList;

  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Result := '';
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  FstrTasksList := '';
  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin
    strProcessFileName := ExtractFileName(ProcessEntry32.szExeFile);
//    if not FindStringInArray(
//        strProcessFileName, AExclusions, FALSE) then begin
    if not FindParamInString(
        strProcessFileName, strExclusionsList, False) then begin

      if length(FstrTasksList) > 0 then begin
        FstrTasksList := FstrTasksList + STR_DIVIDER;
      end;
      FstrTasksList := FstrTasksList + strProcessFileName;

    end;
    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);
  end; // while

  CloseHandle(hSnapshot);

  Result := PChar(FstrTasksList);
  //Debug.Trace1('GetTasksList End');
end;

function GetProcessFileName(AnHandle: THandle): PChar; cdecl; export;
var
  ProcessEntry32: TProcessEntry32;
  hSnapshot: THandle;
  bIsProcessPresent: Boolean;
begin
  //Debug.Trace1('GetProcessFileName Begin');
  FstrProcessFileName := '';

  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then begin
    Result := '';
    Exit;
  end;

  ProcessEntry32.dwSize := sizeof(ProcessEntry32);

  bIsProcessPresent := Process32First(hSnapshot, ProcessEntry32);
  while bIsProcessPresent do begin

    if (ProcessEntry32.th32ProcessID=AnHandle) then begin
      FstrProcessFileName := ExtractFileName(ProcessEntry32.szExeFile);
      break;
    end;
    bIsProcessPresent := Process32Next(hSnapshot, ProcessEntry32);
  end; // while
  CloseHandle(hSnapshot);
  Result := PChar(FstrProcessFileName);
  //Debug.Trace1('GetProcessFileName End');
end;

procedure ProcessReport(const AbRescanProcess: Boolean;
    var AstrRunnedProcessList: PChar;
    var AstrTerminatedProcessList: PChar); cdecl; export;
var
  CurrentProcess: TProcessesDescriptions;
  i: Integer;
  lstRunnedProcess: TStringList;
  lstTerminatedProcess: TStringList;
begin
  lstRunnedProcess := TStringList.Create;
  lstTerminatedProcess := TStringList.Create;
  CurrentProcess := TProcessesDescriptions.Create();
  _ScanProcess(CurrentProcess);
  for i := 0 to CurrentProcess.Count - 1 do
    if (AbRescanProcess or (FCurrentProcess.FindByName(
        CurrentProcess.Items[i].Name) = PROCESS_DESCRIPTION_NOT_FOUND)) then
      lstRunnedProcess.Add(CurrentProcess.Items[i].ExeFile);
  if not AbRescanProcess then
    for i := 0 to FCurrentProcess.Count - 1 do
      if (CurrentProcess.FindByName(
        FCurrentProcess.Items[i].Name) = PROCESS_DESCRIPTION_NOT_FOUND) then
      lstTerminatedProcess.Add(FCurrentProcess.Items[i].ExeFile);
  FreeAndNil(FCurrentProcess);
  FCurrentProcess := CurrentProcess;
  FstrRunnedProcessList := lstRunnedProcess.Text;
  FstrTerminatedProcessList := lstTerminatedProcess.Text;
  lstRunnedProcess.Free;
  lstTerminatedProcess.Free;
  AstrRunnedProcessList := PChar(FstrRunnedProcessList);
  AstrTerminatedProcessList := PChar(FstrTerminatedProcessList);
end;



exports
  GetProcessHandle,
  IsProcessFound,
  ProcessReport,
  KillTask,
  GetTasksList,
  GetProcessFileName;

begin
//  Debug.Level := 1;
  FCurrentProcess := TProcessesDescriptions.Create();
end.
