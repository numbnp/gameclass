//////////////////////////////////////////////////////////////////////////////
//
// TUGConfig - класс - оболочка над функциями блокировки мыши и клавиатуры.
// Функции блокировки находятся в отдельной DLL (по умолчанию - winhkg.dll).
//
//////////////////////////////////////////////////////////////////////////////

unit uUGConfig;

interface

uses
  Types;


const
  UG_SOCKET_ERROR	    			= -2147220904;
  UG_ALREADY_CONNECTED  		= -2147220902;
  UG_AUTHORIZATION_FAILED		= -2147220901;
  UG_INCOMPATIBLE_VERSION		= -2147220900;
  UG_NOT_CONNECTED		    	= -2147220899;
  UG_USER_NOT_FOUND		    	= -2147220898;

type

  TUGRegistrationInfo = record
		dwVersionHigh: DWORD;
		dwVersionLow: DWORD;
		szRegisteredName: array [0..255] of Char;
		bRegistered: Boolean;
		tExpiryDate: Longint;
  end;

  TUAuthType = (
	  auth_ip = 1,
  	auth_ip_mac,
  	auth_ip_mac_top_up_card,
  	auth_ip_range,
  	auth_http,
  	auth_ad,
  	auth_ad_simple,
  	auth_login,
    auth_local
  );


  // типы для экспортируемых из ug_config.dll функций
  TUGInitializeProc = function (hEventConnect: THandle;
      hEventData: THandle): HRESULT; stdcall;
  TUGGetLastSocketErrorProc = function (): DWORD ; stdcall;
  TUGGetLastErrorProc = function (pszErrorDescription: PChar;
      nStringSize: Integer): HRESULT; stdcall;
  TUGConnectProc = function (pszHostName: PChar; nPort: Word;
      pszUserName: PChar; pszPassword: PChar): HRESULT; stdcall;
  TUGConnectResultProc = function (
      var info: TUGRegistrationInfo): HRESULT; stdcall;
  TUGDisconnectProc = procedure (); stdcall;
  TUGLoadUserInfoProc = function (): HRESULT; stdcall;
  TUGGetUserInfoByIDProc = function (dwUserID: DWORD; pszUserInfo: PChar;
      var nBufferSize: Integer): HRESULT; stdcall;
  TUGGetUserInfoByNameProc = function (lpszUserName: PChar; pszUserInfo: PChar;
      var nBufferSize: Integer): HRESULT; stdcall;
  TUGEnumUsersProc = function (var dwPosition: DWORD; pszUserInfo: PChar;
      var nBufferSize: Integer): HRESULT; stdcall;
  TUGReloadConfigProc = function (): HRESULT; stdcall;
  TUGSaveConfigProc = function (): HRESULT; stdcall;
  TUGDeleteUserProc = function (dwUserID: DWORD): HRESULT; stdcall;
  TUGEditUserProc = function (lpszUserInfo: PChar): HRESULT; stdcall;
  TUGLoadUserStatProc = function (lpszUserName: PChar): HRESULT; stdcall;
  TUGGetUserStatProc = procedure (var dwRecv: Int64; var dwSent: Int64;
      var fCost: Double; var fBalance: Double); stdcall;
  TUGSetUserBalanceProc = function (lpszUserName: PChar; fBalance: Double;
      bAddExisting: Boolean): HRESULT; stdcall;


  //
  // TUGConfig
  //

  TUGConfig = class(TObject)
  protected
    // fields
    FhLibrary:               THandle;
    FhConnectEvent:          THandle;
    FhDataEvent:             THandle;
    FInitializeProc:         TUGInitializeProc;
    FGetLastSocketErrorProc: TUGGetLastSocketErrorProc ;
    FGetLastErrorProc:       TUGGetLastErrorProc;
    FConnectProc:            TUGConnectProc;
    FConnectResultProc:      TUGConnectResultProc;
    FDisconnectProc:         TUGDisconnectProc;
    FLoadUserInfoProc:       TUGLoadUserInfoProc;
    FGetUserInfoByIDProc:    TUGGetUserInfoByIDProc;
    FGetUserInfoByNameProc:  TUGGetUserInfoByNameProc;
    FEnumUsersProc:          TUGEnumUsersProc;
    FReloadConfigProc:       TUGReloadConfigProc;
    FSaveConfigProc:         TUGSaveConfigProc;
    FDeleteUserProc:         TUGDeleteUserProc;
    FEditUserProc:           TUGEditUserProc;
    FLoadUserStatProc:       TUGLoadUserStatProc;
    FGetUserStatProc:        TUGGetUserStatProc;
    FSetUserBalanceProc:     TUGSetUserBalanceProc;
    FstrDLLFileName: String;
    FbConnected: Boolean;
    FbLoadInfo: Boolean;

    // private helper methods
    function _GetProcAddress(const AstrProcName: string;
        var AptrProc: pointer): boolean;
    function _GetProcAddresses(): boolean;
    function _GetActive: Boolean;

    // second level initialization / finalization
    function Init(): boolean;
    procedure Final();
    function WaitForEvent(const AhEvent: THandle;
        const AnTimeOut: Integer = 5000): Boolean;
    function Initialize(hEventConnect: THandle;
        hEventData: THandle): HRESULT;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrDLLFileName: string); overload;
    constructor Create(const AstrDLLFileName: String;
        const AstrName: String;
        const AstrPassword: String); overload;
    destructor Destroy(); override;

    function WaitForConnectEvent: Boolean;
    function WaitForDataEvent: Boolean;

    // public methods
    function Logon(const AstrName: String; const AstrPassword: String;
        var AstrErrorMessage: String): Boolean;
    function GetLastError: String; overload;
    function LoadUserInfo(var AstrErrorMessage: String): Boolean; overload;
    function ReloadUserInfo(var AstrErrorMessage: String): Boolean;
    function EditUser(const AstrUserInfo: String;
        var AstrErrorMessage: String): Boolean; overload;
    function GetUserInfoByName(AstrUserName: String; var AstrUserInfo: String;
        var AstrErrorMessage: String): Boolean; overload;
    function GetUserStat(AstrUserName: String; var AnRecv: Cardinal;
        var AnSent: Cardinal; var AfCost: Double; var AfBalance: Double;
        var AstrErrorMessage: String): Boolean; overload;
    function SetUserBalance(AstrUserName: String;
        const AfBalance: Double; const AbAddExisting: Boolean;
        var AstrErrorMessage: String): Boolean; overload;


    function GetLastSocketError(): DWORD ;
    function GetLastError(pszErrorDescription: PChar;
        nStringSize: Integer): HRESULT; overload;
    function Connect(pszHostName: PChar; nPort: Word;
        pszUserName: PChar; pszPassword: PChar): HRESULT;
    function ConnectResult(
        var info: TUGRegistrationInfo): HRESULT;
    procedure Disconnect();
    function LoadUserInfo(): HRESULT; overload;
    function GetUserInfoByID(dwUserID: DWORD; pszUserInfo: PChar;
        var nBufferSize: Integer): HRESULT;
    function GetUserInfoByName(lpszUserName: PChar; pszUserInfo: PChar;
        var nBufferSize: Integer): HRESULT; overload;
    function EnumUsers(var dwPosition: DWORD; pszUserInfo: PChar;
        var nBufferSize: Integer): HRESULT;
    function ReloadConfig(): HRESULT;
    function SaveConfig(): HRESULT;
    function DeleteUser(dwUserID: DWORD): HRESULT;
    function EditUser(lpszUserInfo: PChar): HRESULT; overload;
    function LoadUserStat(lpszUserName: PChar): HRESULT;
    procedure GetUserStat(var dwRecv: Int64; var dwSent: Int64;
        var fCost: Double; var fBalance: Double); overload;
    function SetUserBalance(lpszUserName: PChar; fBalance: Double;
        bAddExisting: Boolean): HRESULT; overload;

    // properties
    property Active: Boolean
      read _GetActive;
    property Connected: Boolean
      read FbConnected;

  end; // TUGConfig

implementation


uses
  // system units
  Windows,
  Forms,
  SysUtils,
  uDebugLog;

const
  // название DLL по умолчанию
  STR_DLL_NAME = 'ug_config.dll';

  // названия методов, экспортируемых из DLL
  STR_UG_DISCONNECT = 'UG_Disconnect';
  STR_UG_INITIALIZE = 'UG_Initialize';
  STR_UG_GETLASTSOCKETERROR = 'UG_GetLastSocketError';
  STR_UG_GETLASTERROR = 'UG_GetLastError';
  STR_UG_CONNECT = 'UG_Connect';
  STR_UG_CONNECTRESULT = 'UG_ConnectResult';
  STR_UG_LOADUSERINFO = 'UG_LoadUserInfo';
  STR_UG_ENUMUSERS = 'UG_EnumUsers';
  STR_UG_GETUSERINFOBYID = 'UG_GetUserInfoByID';
  STR_UG_GETUSERINFOBYNAME = 'UG_GetUserInfoByName';
  STR_UG_RELOADCONFIG = 'UG_ReloadConfig';
  STR_UG_SAVECONFIG = 'UG_SaveConfig';
  STR_UG_DELETEUSER = 'UG_DeleteUser';
  STR_UG_EDITUSER = 'UG_EditUser';
  STR_UG_GETUSERSTAT = 'UG_GetUserStat';
  STR_UG_LOADUSERSTAT = 'UG_LoadUserStat';
  STR_UG_SETUSERBALANCE = 'UG_SetUserBalance';

  BUF_SIZE = 4096;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// overload
constructor TUGConfig.Create();
begin
  Create(STR_DLL_NAME);
end; // TUGConfig.Create

// overload
constructor TUGConfig.Create(const AstrDLLFileName: String);
begin
  inherited Create;
  FstrDLLFileName := AstrDLLFileName;
  FbConnected := False;
  FbLoadInfo := False;
  Init;
end; // TUGConfig.Create

constructor TUGConfig.Create(const AstrDLLFileName: String;
    const AstrName: String;
    const AstrPassword: String);
var
  strErr: String;
begin
  Create(AstrDLLFileName);
  Logon(AstrName, AstrPassword, strErr);
end; // TUGConfig.Create

destructor TUGConfig.Destroy();
begin
  Final;
  inherited Destroy;
end; // TUGConfig.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// second level initialization / finalization

function TUGConfig.Init(): boolean;
var
  hRes: HRESULT;
begin
  // выгружаем загруженную раньше библиотеку
  Final;
  FhLibrary := LoadLibrary(PChar(FstrDLLFileName));
  Result := (FhLibrary <> 0);
  if Result then begin
    Result := _GetProcAddresses();
    if not Result then
      Final();
    FhConnectEvent := CreateEvent(Nil, False, False, Nil);
    FhDataEvent := CreateEvent(Nil, False, False, Nil);
    hRes := Initialize(FhConnectEvent, FhDataEvent);
    Result := (hRes = S_OK);
  end;
end; // TUGConfig.LoadHookDll

procedure TUGConfig.Final();
begin
  if FhLibrary <> 0 then begin
    FreeLibrary(FhLibrary);
    FInitializeProc := Nil;
    FGetLastSocketErrorProc := Nil;
    FGetLastErrorProc := Nil;
    FConnectProc := Nil;
    FConnectResultProc := Nil;
    FDisconnectProc := Nil;
    FLoadUserInfoProc := Nil;
    FGetUserInfoByIDProc := Nil;
    FGetUserInfoByNameProc := Nil;
    FEnumUsersProc := Nil;
    FReloadConfigProc := Nil;
    FSaveConfigProc := Nil;
    FDeleteUserProc := Nil;
    FEditUserProc := Nil;
    FLoadUserStatProc := Nil;
    FGetUserStatProc := Nil;
    FSetUserBalanceProc := Nil;
    FhLibrary := 0;
  end;
end; // TUGConfig.FreeHookDll


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods
function TUGConfig.Initialize(hEventConnect: THandle;
    hEventData: THandle): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FInitializeProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FInitializeProc) then
      Result := FInitializeProc(hEventConnect, hEventData);
end; // TUGConfig.

function TUGConfig.GetLastSocketError(): DWORD ;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetLastSocketErrorProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FGetLastSocketErrorProc) then
      Result := FGetLastSocketErrorProc();
end; // TUGConfig.

function TUGConfig.GetLastError(pszErrorDescription: PChar;
    nStringSize: Integer): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetLastErrorProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FGetLastErrorProc) then
      Result := FGetLastErrorProc(pszErrorDescription, nStringSize);
end; // TUGConfig.

function TUGConfig.Connect(pszHostName: PChar; nPort: Word;
    pszUserName: PChar; pszPassword: PChar): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FConnectProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FConnectProc) then
      Result := FConnectProc(pszHostName, nPort, pszUserName, pszPassword);
end; // TUGConfig.

function TUGConfig.ConnectResult(
    var info: TUGRegistrationInfo): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FConnectResultProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FConnectResultProc) then
      Result := FConnectResultProc(info);
end; // TUGConfig.

procedure TUGConfig.Disconnect();
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FDisconnectProc));

  if FhLibrary <> 0 then
    if Assigned(FDisconnectProc) then
      FDisconnectProc();
  FbConnected := False;
  FbLoadInfo := False;  
end; // TUGConfig.

function TUGConfig.LoadUserInfo(): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FLoadUserInfoProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FLoadUserInfoProc) then
      Result := FLoadUserInfoProc();
end; // TUGConfig.

function TUGConfig.GetUserInfoByID(dwUserID: DWORD; pszUserInfo: PChar;
    var nBufferSize: Integer): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetUserInfoByIDProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FGetUserInfoByIDProc) then
      Result := FGetUserInfoByIDProc(dwUserID, pszUserInfo, nBufferSize);
end; // TUGConfig.

function TUGConfig.GetUserInfoByName(lpszUserName: PChar; pszUserInfo: PChar;
    var nBufferSize: Integer): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetUserInfoByNameProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FGetUserInfoByNameProc) then
      Result := FGetUserInfoByNameProc(lpszUserName, pszUserInfo, nBufferSize);
end; // TUGConfig.

function TUGConfig.EnumUsers(var dwPosition: DWORD; pszUserInfo: PChar;
    var nBufferSize: Integer): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FEnumUsersProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FEnumUsersProc) then
      Result := FEnumUsersProc(dwPosition, pszUserInfo, nBufferSize);
end; // TUGConfig.

function TUGConfig.ReloadConfig(): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FReloadConfigProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FReloadConfigProc) then
      Result := FReloadConfigProc();
end; // TUGConfig.

function TUGConfig.SaveConfig(): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FSaveConfigProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FSaveConfigProc) then
      Result := FSaveConfigProc();
end; // TUGConfig.

function TUGConfig.DeleteUser(dwUserID: DWORD): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FDeleteUserProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FDeleteUserProc) then
      Result := FDeleteUserProc(dwUserID);
end; // TUGConfig.

function TUGConfig.EditUser(lpszUserInfo: PChar): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FEditUserProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FEditUserProc) then
      Result := FEditUserProc(lpszUserInfo);
end; // TUGConfig.

function TUGConfig.LoadUserStat(lpszUserName: PChar): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FLoadUserStatProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FLoadUserStatProc) then
      Result := FLoadUserStatProc(lpszUserName);
end; // TUGConfig.

procedure TUGConfig.GetUserStat(var dwRecv: Int64; var dwSent: Int64;
    var fCost: Double; var fBalance: Double);
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetUserStatProc));

  if FhLibrary <> 0 then
    if Assigned(FGetUserStatProc) then
      FGetUserStatProc(dwRecv, dwSent, fCost, fBalance);
end; // TUGConfig.

function TUGConfig.SetUserBalance(lpszUserName: PChar; fBalance: Double;
    bAddExisting: Boolean): HRESULT;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FSetUserBalanceProc));

  Result := S_FALSE;
  if FhLibrary <> 0 then
    if Assigned(FSetUserBalanceProc) then
      Result := FSetUserBalanceProc(lpszUserName, fBalance, bAddExisting);
end; // TUGConfig.


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TUGConfig._GetProcAddress(const AstrProcName: string;
    var AptrProc: pointer): boolean;
begin
  AptrProc := GetProcAddress(FhLibrary, PChar(AstrProcName));
  Result := Assigned(AptrProc);
end; // TUGConfig._GetProcAddress

function TUGConfig._GetProcAddresses(): boolean;
begin
  Result := _GetProcAddress(STR_UG_DISCONNECT, @FDisconnectProc)
        and _GetProcAddress(STR_UG_INITIALIZE, @FInitializeProc)
        and _GetProcAddress(STR_UG_GETLASTSOCKETERROR, @FGetLastSocketErrorProc)
        and _GetProcAddress(STR_UG_GETLASTERROR, @FGetLastErrorProc)
        and _GetProcAddress(STR_UG_CONNECT, @FConnectProc)
        and _GetProcAddress(STR_UG_CONNECTRESULT, @FConnectResultProc)
        and _GetProcAddress(STR_UG_LOADUSERINFO, @FLoadUserInfoProc)
        and _GetProcAddress(STR_UG_ENUMUSERS, @FEnumUsersProc)
        and _GetProcAddress(STR_UG_GETUSERINFOBYID, @FGetUserInfoByIDProc)
        and _GetProcAddress(STR_UG_GETUSERINFOBYNAME, @FGetUserInfoByNameProc)
        and _GetProcAddress(STR_UG_RELOADCONFIG, @FReloadConfigProc)
        and _GetProcAddress(STR_UG_SAVECONFIG, @FSaveConfigProc)
        and _GetProcAddress(STR_UG_DELETEUSER, @FDeleteUserProc)
        and _GetProcAddress(STR_UG_EDITUSER, @FEditUserProc)
        and _GetProcAddress(STR_UG_GETUSERSTAT, @FGetUserStatProc)
        and _GetProcAddress(STR_UG_LOADUSERSTAT, @FLoadUserStatProc)
        and _GetProcAddress(STR_UG_SETUSERBALANCE, @FSetUserBalanceProc);
end; // TUGConfig._GetProcAddresses

function TUGConfig._GetActive: Boolean;
begin
  Result := (FhLibrary <> 0) and Assigned(FSetUserBalanceProc);
end;


function TUGConfig.WaitForEvent(const AhEvent: THandle;
    const AnTimeOut: Integer = 5000): Boolean;
var
	msg: TMsg;
	nCount: Integer;
begin
	Result := False;
  nCount := 100;
	while(nCount > 0) do begin
		Application.ProcessMessages;
		if (WaitForSingleObject(AhEvent, AnTimeOut div 100)
        = WAIT_OBJECT_0) then begin
			Result := True;
      break;
    end;
		Dec(nCount);
	end;
end;

function TUGConfig.WaitForConnectEvent: Boolean;
begin
  Result := WaitForEvent(FhConnectEvent);
end;

function TUGConfig.WaitForDataEvent: Boolean;
begin
  Result := WaitForEvent(FhDataEvent);
end;

function TUGConfig.Logon(const AstrName: String;
  const AstrPassword: String; var AstrErrorMessage: String): Boolean;
var
  hRes: HRESULT;
  info: TUGRegistrationInfo;
begin
  Result := False;
  AstrErrorMessage := 'Невозможно загрузить ug_config.dll!';
  if not Active then
    exit;
  if Connected then
    Disconnect;
  AstrErrorMessage := 'Ошибка подключения!';
  try
    hRes := Connect('127.0.0.1', 2345, PChar(AstrName), PChar(AstrPassword));
//    hRes := Connect('192.168.1.4', 2345, PChar(AstrName), PChar(AstrPassword));
  except
    on e: Exception do begin
      Debug.Trace0('Logon exception:' + e.Message);
      Exit;
    end;
  end;
  if (hRes <> S_OK) then begin
    if (hRes = UG_SOCKET_ERROR) then
      AstrErrorMessage := 'Ошибка подключения '
          + IntToStr(GetLastSocketError()) + '!';
    exit;
  end;
  if not WaitForConnectEvent then
    exit;
  hRes := ConnectResult(info);
  if (hRes <> S_OK) then begin
    case (hRes) of
      UG_INCOMPATIBLE_VERSION:
        AstrErrorMessage := 'Несовместимая версия ug_config.dll!';
      UG_AUTHORIZATION_FAILED:
        AstrErrorMessage := 'Неправильное имя или пароль!';
      UG_SOCKET_ERROR:
        AstrErrorMessage := 'Ошибка подключения '
            + IntToStr(GetLastSocketError()) + '!';
    end;
    exit;
  end;
  Result := True;
  FbConnected := Result;
  if Result then
    AstrErrorMessage := 'Подключение выполнено успешно!';
end;

function TUGConfig.LoadUserInfo(var AstrErrorMessage: String): Boolean;
begin
  if not FbLoadInfo then
    FbLoadInfo := ReloadUserInfo(AstrErrorMessage);
  Result := FbLoadInfo;
end;

function TUGConfig.ReloadUserInfo(var AstrErrorMessage: String): Boolean;
begin
  Result := False;
  if Connected then begin
    if (LoadUserInfo = S_OK)
        and WaitForDataEvent then begin
      Result := True;
    end else
      AstrErrorMessage := 'Ошибка вызова LoadUserInfo: '
          + GetLastError;
  end;
end;

function TUGConfig.EditUser(const AstrUserInfo: String;
    var AstrErrorMessage: String): Boolean;
begin
  Result := False;
  if LoadUserInfo(AstrErrorMessage) then begin
    if (EditUser(PChar(AstrUserInfo)) = S_OK)
        and WaitForDataEvent then begin
      Result := True;
    end else
      AstrErrorMessage := 'Ошибка вызова EditUser:[' + AstrUserInfo
          + ']: ' + GetLastError;
  end;
end;

function TUGConfig.GetUserInfoByName(AstrUserName: String;
    var AstrUserInfo: String; var AstrErrorMessage: String): Boolean;
var
  hRes: HRESULT;
  nSize: Integer;
  buf: array [0 .. BUF_SIZE] of Char;
begin
  Result := False;
  if LoadUserInfo(AstrErrorMessage) then begin
    nSize := BUF_SIZE;
    if (GetUserInfoByName(PChar(AstrUserName), buf, nSize) = S_OK) then begin
      AstrUserInfo := buf;
      Result := True;
    end else
      AstrErrorMessage := 'Ошибка вызова GetUserInfoByName[' + AstrUserName
          + ']: ' + GetLastError;
  end;
end;

function TUGConfig.GetUserStat(AstrUserName: String; var AnRecv: Cardinal;
    var AnSent: Cardinal; var AfCost: Double; var AfBalance: Double;
    var AstrErrorMessage: String): Boolean;
var
  hRes: HRESULT;
  nRecv, nSent: Int64;
begin
  Result := False;
  if LoadUserInfo(AstrErrorMessage) then begin
    if (LoadUserStat(PChar(AstrUserName)) = S_OK)
        and WaitForDataEvent then begin
      GetUserStat(nRecv, nSent, AfCost, AfBalance);
      AnRecv := nRecv;
      AnSent := nSent;
      Result := True;
    end else
      AstrErrorMessage := 'Ошибка вызова LoadUserStat: '
          + GetLastError;
  end;
end;

function TUGConfig.SetUserBalance(AstrUserName: String;
    const AfBalance: Double; const AbAddExisting: Boolean;
    var AstrErrorMessage: String): Boolean;
var
  hRes: HRESULT;
  nRecv, nSent: Int64;
begin
  Result := False;
  if LoadUserInfo(AstrErrorMessage) then begin
    if (SetUserBalance(PChar(AstrUserName), AfBalance, AbAddExisting) = S_OK)
        and WaitForDataEvent then begin
      Result := True;
    end else
      AstrErrorMessage := 'Ошибка вызова LoadUserStat:[' + AstrUserName
          + ']: ' + GetLastError;
  end;
end;

function TUGConfig.GetLastError: String;
var
  buf: Array [0..1024] of Char;
  nSize: Integer;
begin
  Result := '';
  nSize := sizeof(buf);
  if (GetLastError(buf, nSize) = S_OK) then
    Result := buf;
end;


end. ////////////////////////// end of file //////////////////////////////////
