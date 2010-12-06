//////////////////////////////////////////////////////////////////////////////
//
// TWinhkg - класс - оболочка над функциями блокировки мыши и клавиатуры.
// Функции блокировки находятся в отдельной DLL (по умолчанию - winhkg.dll).
//
//////////////////////////////////////////////////////////////////////////////

unit uWinhkg;

interface

type

  // типы для экспортируемых из winhkg.dll функций
  TLockKeyboardProc = function (hMod: THandle): boolean; stdcall;
  TUnlockKeyboardProc = function (): boolean; stdcall;
  TLockMouseProc = function (hMod: THandle): boolean; stdcall;
  TUnlockMouseProc = function (): boolean; stdcall;
  TIsLock = function (): boolean; stdcall;
  TSetClientHandle = function (handle: THandle): boolean; stdcall;

  //
  // TWinhkg
  //

  TWinhkg = class(TObject)
  private
    // fields
    FhHookLib           : THandle;
    FLockKeyboardProc   : TLockKeyboardProc;
    FUnlockKeyboardProc : TUnlockKeyboardProc;
    FLockMouseProc      : TLockMouseProc;
    FUnlockMouseProc    : TUnlockMouseProc;
    FIsLockKeyboardProc : TIsLock;
    FIsLockMouseProc    : TIsLock;
    FSetClientHandleProc: TSetClientHandle;

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
    function LockKeyboard(): boolean;
    function LockMouse(): boolean;
    function UnlockKeyboard(): boolean;
    function UnlockMouse(): boolean;
    function IsLockKeyboard(): boolean;
    function IsLockMouse(): boolean;
    function SetClientHandle(handle:THandle):boolean;

  end; // TWinhkg

var
   GWinhkg: TWinhkg;

implementation


uses
  // system units
  Windows;

const
  // название DLL по умолчанию
  STR_WINHKG = 'winhkg.dll';

  // названия методов, экспортируемых из DLL
  STR_LOCKKEYBOARD   = 'LockKeyboard';
  STR_UNLOCKKEYBOARD = 'UnlockKeyboard';
  STR_LOCKMOUSE      = 'LockMouse';
  STR_UNLOCKMOUSE    = 'UnlockMouse';
  STR_ISLOCKKEYBOARD = 'IsLockKeyboard';
  STR_ISLOCKMOUSE    = 'IsLockMouse';
  STR_SETCLIENTHANDLE= 'SetClientHandle';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// overload
constructor TWinhkg.Create();
begin
  inherited Create();
  FstrDLLFileName := STR_WINHKG;
end; // TWinhkg.Create

// overload
constructor TWinhkg.Create(const AstrDLLFileName: string);
begin
  inherited Create();
  FstrDLLFileName := AstrDLLFileName;
end; // TWinhkg.Create

destructor TWinhkg.Destroy();
begin
  Final();
  inherited Destroy();
end; // TWinhkg.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// second level initialization / finalization

function TWinhkg.Init(): boolean;
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

end; // TWinhkg.LoadHookDll

procedure TWinhkg.Final();
begin
  if FhHookLib <> 0 then begin
    UnlockKeyboard();
    UnlockMouse();
    FreeLibrary(FhHookLib);

    FLockKeyboardProc   := nil;
    FUnlockKeyboardProc := nil;
    FLockMouseProc      := nil;
    FUnlockMouseProc    := nil;
    FIsLockKeyboardProc := nil;
    FIsLockMouseProc    := nil;
    FSetClientHandleProc    := nil;
    FhHookLib := 0;
  end;
end; // TWinhkg.FreeHookDll


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TWinhkg.LockKeyboard():boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FLockKeyboardProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FLockKeyboardProc) then
      Result := FLockKeyboardProc(FhHookLib);

end; // TWinhkg.LockKeyboard

function TWinhkg.LockMouse():boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FLockMouseProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FLockMouseProc) then
      Result := FLockMouseProc(FhHookLib);

end; // TWinhkg.LockMouse

function TWinhkg.UnlockKeyboard():boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FUnlockKeyboardProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FUnlockKeyboardProc) then
      Result := FUnlockKeyboardProc();

end; // TWinhkg.UnlockKeyboard

function TWinhkg.UnlockMouse():boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FUnlockMouseProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FUnlockMouseProc) then
      Result := FUnlockMouseProc();

end; // TWinhkg.UnlockMouse

function TWinhkg.IsLockKeyboard():boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FIsLockKeyboardProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FIsLockKeyboardProc) then
      Result := FIsLockKeyboardProc();

end; // TWinhkg.IsLockKeyboard

function TWinhkg.IsLockMouse():boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FIsLockMouseProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FIsLockMouseProc) then
      Result := FIsLockMouseProc();

end; // TWinhkg.IsLockMouse

function TWinhkg.SetClientHandle(handle:THandle):boolean;
begin
  ASSERT(FhHookLib <> 0);
  ASSERT(Assigned(FSetClientHandleProc));

  Result := FALSE;
  if FhHookLib <> 0 then
    if Assigned(FSetClientHandleProc) then
      Result := FSetClientHandleProc(handle);

end; // TWinhkg.SetClientHandle

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TWinhkg._GetProcAddress(const AstrProcName: string;
    var AptrProc: pointer): boolean;
begin
  AptrProc := GetProcAddress(FhHookLib, PChar(AstrProcName));
  Result := Assigned(AptrProc);
end; // TWinhkg._GetProcAddress

function TWinhkg._GetProcAddresses(): boolean;
begin
  Result := _GetProcAddress(STR_LOCKKEYBOARD, @FLockKeyboardProc)
      and _GetProcAddress(STR_LOCKMOUSE, @FLockMouseProc)
      and _GetProcAddress(STR_UNLOCKKEYBOARD, @FUnlockKeyboardProc)
      and _GetProcAddress(STR_UNLOCKMOUSE, @FUnlockMouseProc)
      and _GetProcAddress(STR_ISLOCKKEYBOARD, @FIsLockKeyboardProc)
      and _GetProcAddress(STR_ISLOCKMOUSE, @FIsLockMouseProc)
      and _GetProcAddress(STR_SETCLIENTHANDLE, @FSetClientHandleProc);
end; // TWinhkg._GetProcAddresses


end. ////////////////////////// end of file //////////////////////////////////
