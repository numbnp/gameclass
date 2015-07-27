//////////////////////////////////////////////////////////////////////////////
//
// TProcUtils - класс - оболочка над функциями блокировки мыши и клавиатуры.
// Функции блокировки находятся в отдельной DLL (по умолчанию - ProcUtils.dll).
//
//////////////////////////////////////////////////////////////////////////////

unit uProcUtils;

interface

uses
  Classes,
  uProcessesDescriptions;

type

  // типы для экспортируемых из ProcUtils.dll функций
  TGetProcessHandleProc = function (const AstrProcessName: PChar
      ): THandle; stdcall;
  TIsProcessFoundProc = function (const AstrProcessName: PChar;
      const AstrExplorerProcessName: PChar): Boolean; stdcall;
  TProcessReportProc = procedure (const AbRescanProcess: Boolean;
    var AstrRunnedProcessList: PChar;
    var AstrTerminatedProcessList: PChar); stdcall;
  TKillTaskProc = function (const AstrTaskList: PChar;
        const AbExclude: Boolean = False): Boolean; stdcall;
  TGetTasksListProc = function (const AstrExclusionsList: PChar
      ): PChar; stdcall;
  TGetProcessFileNameProc = function (AnHandle: THandle): PChar; stdcall;

  //
  // TProcUtils
  //

  TProcUtils = class(TObject)
  private
    // fields
    FhHookLib               : THandle;
    FGetProcessHandleProc   : TGetProcessHandleProc;
    FIsProcessFoundProc     : TIsProcessFoundProc;
    FProcessReportProc        : TProcessReportProc;
    FKillTaskProc           : TKillTaskProc;
    FGetTasksListProc       : TGetTasksListProc;
    FGetProcessFileNameProc : TGetProcessFileNameProc;

    FstrDLLFileName     : string;

    // private helper methods
    function _GetProcAddress(const AstrProcName: string;
        var AptrProc: pointer): boolean;
    function _GetProcAddresses(): boolean;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrDLLFileName: string); overload;
    destructor Destroy(); override;

    // second level initialization / finalization
    function Init(): boolean;
    procedure Final();

    // public methods
    function GetProcessHandle(const AstrProcessName: String): THandle;
    function IsProcessFound(const AstrProcessName: String;
        const AstrExplorerProcessName: String): Boolean;
    procedure ProcessReport(const AbRescanProcess: Boolean;
        var AlstRunnedProcess: TStringList;
        var AlstTerminatedProcess: TStringList);
    function KillTask(const AstrTaskList: String;
        const AbExclude: Boolean = False): Boolean;
    function GetTasksList(const AExclusions: array of String): String;
    function GetProcessFileName(AnHandle: THandle): String;
  end; // TProcUtils

var
   GProcUtils: TProcUtils;

implementation


uses
  // system units
  SysUtils,
  Windows,
  uY2KCommon,
  uY2KString;

const
  // название DLL по умолчанию
  STR_PROCUTILS = 'ProcUtils.dll';

  // названия методов, экспортируемых из DLL
   STR_GETPROCESSHANDLEPROC = 'GetProcessHandle';
   STR_ISPROCESSFOUNDPROC = 'IsProcessFound';
   STR_PROCESSREPORTPROC = 'ProcessReport';
   STR_KILLTASKPROC = 'KillTask';
   STR_GETTASKSLISTPROC = 'GetTasksList';
   STR_GETPROCESSFILENAMEPROC = 'GetProcessFileName';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// overload
constructor TProcUtils.Create();
begin
  inherited Create();
  FstrDLLFileName := ExtractFilePath(ParamStr(0)) + STR_PROCUTILS;
end; // TProcUtils.Create

// overload
constructor TProcUtils.Create(const AstrDLLFileName: string);
begin
  inherited Create();
  FstrDLLFileName := AstrDLLFileName;
end; // TProcUtils.Create

destructor TProcUtils.Destroy();
begin
  Final();
  inherited Destroy();
end; // TProcUtils.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// second level initialization / finalization

function TProcUtils.Init(): boolean;
begin
  // выгружаем загруженную раньше библиотеку
  Final();

  FhHookLib := LoadLibrary(PChar(FstrDLLFileName));
  Result := (FhHookLib <> 0);

  if Result then begin
    Result := _GetProcAddresses();
    if not Result then
      Final();
  end;

end; // TProcUtils.LoadHookDll

procedure TProcUtils.Final();
begin
  if FhHookLib <> 0 then begin
    FreeLibrary(FhHookLib);

    FGetProcessHandleProc   := nil;
    FIsProcessFoundProc     := nil;
    FProcessReportProc        := nil;
    FKillTaskProc           := nil;
    FGetTasksListProc       := nil;
    FGetProcessFileNameProc := nil;
    FhHookLib := 0;
  end;
end; // TProcUtils.FreeHookDll


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TProcUtils.GetProcessHandle(const AstrProcessName: String): THandle;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FGetProcessHandleProc));

  Result := NULL_HANDLE;
  if FhHookLib <> 0 then
    if Assigned(FGetProcessHandleProc) then
      Result := FGetProcessHandleProc(PChar(AstrProcessName));

end; // TProcUtils.GetProcessHandle

function TProcUtils.IsProcessFound(const AstrProcessName: String;
      const AstrExplorerProcessName: String): Boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FIsProcessFoundProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FIsProcessFoundProc) then
      Result := FIsProcessFoundProc(PChar(AstrProcessName),
          PChar(AstrExplorerProcessName));

end; // TProcUtils.IsProcessFound

procedure TProcUtils.ProcessReport(const AbRescanProcess: Boolean;
    var AlstRunnedProcess: TStringList;
    var AlstTerminatedProcess: TStringList);
var
  strRunnedProcessList: PChar;
  strTerminatedProcessList: PChar;
begin
//  ASSERT(FhHookLib <> 0);
//  ASSERT(Assigned(FProcessReportProc));

  if FhHookLib <> 0 then
    if Assigned(FProcessReportProc) then begin
      FProcessReportProc(AbRescanProcess, strRunnedProcessList,
          strTerminatedProcessList);
      AlstRunnedProcess.Text := strRunnedProcessList;
      AlstTerminatedProcess.Text := strTerminatedProcessList;
    end;
end; // TProcUtils.ProcessReport

function TProcUtils.KillTask(const AstrTaskList: String;
    const AbExclude: Boolean = False): Boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FKillTaskProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FKillTaskProc) then
      Result := FKillTaskProc(PChar(AstrTaskList), AbExclude);

end; // TProcUtils.KillTask

function TProcUtils.GetTasksList(const AExclusions: array of String): String;
var
  strExclusionsList: String;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FGetTasksListProc));

  Result := '';
  strExclusionsList := ArrayToParameters(AExclusions);
  if FhHookLib <> 0 then
    if Assigned(FGetTasksListProc) then
      Result := FGetTasksListProc(PChar(strExclusionsList));

end; // TProcUtils.GetTasksList

function TProcUtils.GetProcessFileName(AnHandle: THandle): String;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FGetProcessFileNameProc));

  Result := '';
  if FhHookLib <> 0 then
    if Assigned(FGetProcessFileNameProc) then
      Result := FGetProcessFileNameProc(AnHandle);

end; // TProcUtils.GetProcessFileName

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TProcUtils._GetProcAddress(const AstrProcName: string;
    var AptrProc: pointer): boolean;
begin
  AptrProc := GetProcAddress(FhHookLib, PChar(AstrProcName));
  Result := Assigned(AptrProc);
end; // TProcUtils._GetProcAddress

function TProcUtils._GetProcAddresses(): boolean;
begin
  Result := _GetProcAddress(STR_GETPROCESSHANDLEPROC, @FGetProcessHandleProc)
      and _GetProcAddress(STR_ISPROCESSFOUNDPROC, @FIsProcessFoundProc)
      and _GetProcAddress(STR_PROCESSREPORTPROC, @FProcessReportProc)
      and _GetProcAddress(STR_KILLTASKPROC, @FKillTaskProc)
      and _GetProcAddress(STR_GETTASKSLISTPROC, @FGetTasksListProc)
      and _GetProcAddress(STR_GETPROCESSFILENAMEPROC, @FGetProcessFileNameProc);
end; // TProcUtils._GetProcAddresses


end. ////////////////////////// end of file //////////////////////////////////
