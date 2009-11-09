unit RS_APILib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 23.05.2007 13:31:38 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\Runpad Shell\rs_api.dll (1)
// LIBID: {02988454-DBAC-48B9-A8A2-85AEE4E2486F}
// LCID: 0
// Helpfile: 
// HelpString: RS_API 2.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TRunpadShell) : Server C:\Program Files\Runpad Shell\rs_api.dll contains no icons
//   Error creating palette bitmap of (TRunpadShell2) : Server C:\Program Files\Runpad Shell\rs_api.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  RS_APILibMajorVersion = 1;
  RS_APILibMinorVersion = 0;

  LIBID_RS_APILib: TGUID = '{02988454-DBAC-48B9-A8A2-85AEE4E2486F}';

  IID_IRunpadShell: TGUID = '{0CBC0D60-02DB-434D-99C0-003702C65934}';
  CLASS_RunpadShell: TGUID = '{D7346301-B73F-4A94-ABE6-234A0D49521D}';
  IID_IRunpadShell2: TGUID = '{548856D7-555A-445B-BDEB-EEE491A14C39}';
  CLASS_RunpadShell2: TGUID = '{D163EEE3-540A-48DA-9009-C194588263B9}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum __MIDL_IRunpadShell_0001
type
  __MIDL_IRunpadShell_0001 = TOleEnum;
const
  RSS_OFF = $00000000;
  RSS_TURNEDON = $00000001;
  RSS_ACTIVE = $00000003;
  RSS_INVALID = $FFFFFFFF;

// Constants for enum __MIDL_IRunpadShell_0003
type
  __MIDL_IRunpadShell_0003 = TOleEnum;
const
  RSF_SHELL = $00000000;
  RSF_DESKTOP = $00000001;
  RSF_BG = $00000002;
  RSF_RULES = $00000003;
  RSF_USERFOLDER = $00000004;
  RSF_VIPFOLDER = $00000005;

// Constants for enum __MIDL_IRunpadShell_0005
type
  __MIDL_IRunpadShell_0005 = TOleEnum;
const
  RSA_SHOWPANEL = $00000000;
  RSA_MINIMIZEALLWINDOWS = $00000001;
  RSA_KILLALLTASKS = $00000002;
  RSA_RESTOREVMODE = $00000003;
  RSA_UPDATEDESKTOP = $00000004;
  RSA_CLOSECHILDWINDOWS = $00000005;
  RSA_SWITCHTOUSERMODE = $00000006;
  RSA_TURNMONITORON = $00000007;
  RSA_TURNMONITOROFF = $00000008;
  RSA_ENDVIPSESSION = $00000009;
  RSA_RUNPROGRAMDISABLE = $0000000A;
  RSA_RUNPROGRAMENABLE = $0000000B;
  RSA_LOGOFF = $0000000C;
  RSA_LOGOFFFORCE = $0000000D;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IRunpadShell = interface;
  IRunpadShell2 = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  RunpadShell = IRunpadShell;
  RunpadShell2 = IRunpadShell2;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  wireHWND = ^_RemotableHandle; 

  RSHELLSTATE = __MIDL_IRunpadShell_0001; 

  __MIDL_IWinTypes_0009 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: Integer);
  end;

  _RemotableHandle = packed record
    fContext: Integer;
    u: __MIDL_IWinTypes_0009;
  end;

  RSHELLFOLDER = __MIDL_IRunpadShell_0003; 
  RSHELLACTION = __MIDL_IRunpadShell_0005; 

// *********************************************************************//
// Interface: IRunpadShell
// Flags:     (0)
// GUID:      {0CBC0D60-02DB-434D-99C0-003702C65934}
// *********************************************************************//
  IRunpadShell = interface(IUnknown)
    ['{0CBC0D60-02DB-434D-99C0-003702C65934}']
    function GetShellState(out pState: RSHELLSTATE): HResult; stdcall;
    function GetShellExecutable(lpszExePath: PChar; cbPathLen: LongWord; out lpdwPID: LongWord): HResult; stdcall;
    function TurnShell(bNewState: Integer): HResult; stdcall;
    function GetShellMode(out lpdwFlags: LongWord): HResult; stdcall;
    function IsShellOwnedWindow(var hWnd: _RemotableHandle; out lpbOwned: Integer): HResult; stdcall;
    function GetFolderPath(dwFolderType: RSHELLFOLDER; lpszPath: PChar; cbPathLen: LongWord): HResult; stdcall;
    function GetMachineNumber(out lpdwNum: LongWord): HResult; stdcall;
    function GetCurrentSheet(lpszName: PChar; cbNameLen: LongWord): HResult; stdcall;
    function EnableSheets(lpszName: PChar; bEnable: Integer): HResult; stdcall;
    function RegisterClient(lpszClientName: PChar; lpszClientPath: PChar; dwFlags: LongWord): HResult; stdcall;
    function ShowInfoMessage(lpszText: PChar; dwFlags: LongWord): HResult; stdcall;
    function DoSingleAction(dwAction: RSHELLACTION): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRunpadShell2
// Flags:     (0)
// GUID:      {548856D7-555A-445B-BDEB-EEE491A14C39}
// *********************************************************************//
  IRunpadShell2 = interface(IUnknown)
    ['{548856D7-555A-445B-BDEB-EEE491A14C39}']
    function GetShellState(out pState: RSHELLSTATE): HResult; stdcall;
    function GetShellExecutable(lpszExePath: PChar; cbPathLen: LongWord; out lpdwPID: LongWord): HResult; stdcall;
    function TurnShell(bNewState: Integer): HResult; stdcall;
    function GetShellMode(out lpdwFlags: LongWord): HResult; stdcall;
    function IsShellOwnedWindow(var hWnd: _RemotableHandle; out lpbOwned: Integer): HResult; stdcall;
    function GetFolderPath(dwFolderType: RSHELLFOLDER; lpszPath: PChar; cbPathLen: LongWord): HResult; stdcall;
    function GetMachineNumber(out lpdwNum: LongWord): HResult; stdcall;
    function GetCurrentSheet(lpszName: PChar; cbNameLen: LongWord): HResult; stdcall;
    function EnableSheets(lpszName: PChar; bEnable: Integer): HResult; stdcall;
    function RegisterClient(lpszClientName: PChar; lpszClientPath: PChar; dwFlags: LongWord): HResult; stdcall;
    function ShowInfoMessage(lpszText: PChar; dwFlags: LongWord): HResult; stdcall;
    function DoSingleAction(dwAction: RSHELLACTION): HResult; stdcall;
    function VipLogin(lpszLogin: PChar; lpszPassword: PChar; bWait: Integer): HResult; stdcall;
    function VipRegister(lpszLogin: PChar; lpszPassword: PChar; bWait: Integer): HResult; stdcall;
    function VipLogout(bWait: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoRunpadShell provides a Create and CreateRemote method to          
// create instances of the default interface IRunpadShell exposed by              
// the CoClass RunpadShell. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRunpadShell = class
    class function Create: IRunpadShell;
    class function CreateRemote(const MachineName: string): IRunpadShell;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRunpadShell
// Help String      : RunpadShell Class
// Default Interface: IRunpadShell
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TRunpadShellProperties= class;
{$ENDIF}
  TRunpadShell = class(TOleServer)
  private
    FIntf:        IRunpadShell;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TRunpadShellProperties;
    function      GetServerProperties: TRunpadShellProperties;
{$ENDIF}
    function      GetDefaultInterface: IRunpadShell;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IRunpadShell);
    procedure Disconnect; override;
    function GetShellState(out pState: RSHELLSTATE): HResult;
    function GetShellExecutable(lpszExePath: PChar; cbPathLen: LongWord; out lpdwPID: LongWord): HResult;
    function TurnShell(bNewState: Integer): HResult;
    function GetShellMode(out lpdwFlags: LongWord): HResult;
    function IsShellOwnedWindow(var hWnd: _RemotableHandle; out lpbOwned: Integer): HResult;
    function GetFolderPath(dwFolderType: RSHELLFOLDER; lpszPath: PChar; cbPathLen: LongWord): HResult;
    function GetMachineNumber(out lpdwNum: LongWord): HResult;
    function GetCurrentSheet(lpszName: PChar; cbNameLen: LongWord): HResult;
    function EnableSheets(lpszName: PChar; bEnable: Integer): HResult;
    function RegisterClient(lpszClientName: PChar; lpszClientPath: PChar; dwFlags: LongWord): HResult;
    function ShowInfoMessage(lpszText: PChar; dwFlags: LongWord): HResult;
    function DoSingleAction(dwAction: RSHELLACTION): HResult;
    property DefaultInterface: IRunpadShell read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TRunpadShellProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TRunpadShell
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TRunpadShellProperties = class(TPersistent)
  private
    FServer:    TRunpadShell;
    function    GetDefaultInterface: IRunpadShell;
    constructor Create(AServer: TRunpadShell);
  protected
  public
    property DefaultInterface: IRunpadShell read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoRunpadShell2 provides a Create and CreateRemote method to          
// create instances of the default interface IRunpadShell2 exposed by              
// the CoClass RunpadShell2. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRunpadShell2 = class
    class function Create: IRunpadShell2;
    class function CreateRemote(const MachineName: string): IRunpadShell2;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRunpadShell2
// Help String      : RunpadShell2 Class
// Default Interface: IRunpadShell2
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TRunpadShell2Properties= class;
{$ENDIF}
  TRunpadShell2 = class(TOleServer)
  private
    FIntf:        IRunpadShell2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TRunpadShell2Properties;
    function      GetServerProperties: TRunpadShell2Properties;
{$ENDIF}
    function      GetDefaultInterface: IRunpadShell2;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IRunpadShell2);
    procedure Disconnect; override;
    function GetShellState(out pState: RSHELLSTATE): HResult;
    function GetShellExecutable(lpszExePath: PChar; cbPathLen: LongWord; out lpdwPID: LongWord): HResult;
    function TurnShell(bNewState: Integer): HResult;
    function GetShellMode(out lpdwFlags: LongWord): HResult;
    function IsShellOwnedWindow(var hWnd: _RemotableHandle; out lpbOwned: Integer): HResult;
    function GetFolderPath(dwFolderType: RSHELLFOLDER; lpszPath: PChar; cbPathLen: LongWord): HResult;
    function GetMachineNumber(out lpdwNum: LongWord): HResult;
    function GetCurrentSheet(lpszName: PChar; cbNameLen: LongWord): HResult;
    function EnableSheets(lpszName: PChar; bEnable: Integer): HResult;
    function RegisterClient(lpszClientName: PChar; lpszClientPath: PChar; dwFlags: LongWord): HResult;
    function ShowInfoMessage(lpszText: PChar; dwFlags: LongWord): HResult;
    function DoSingleAction(dwAction: RSHELLACTION): HResult;
    function VipLogin(lpszLogin: PChar; lpszPassword: PChar; bWait: Integer): HResult;
    function VipRegister(lpszLogin: PChar; lpszPassword: PChar; bWait: Integer): HResult;
    function VipLogout(bWait: Integer): HResult;
    property DefaultInterface: IRunpadShell2 read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TRunpadShell2Properties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TRunpadShell2
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TRunpadShell2Properties = class(TPersistent)
  private
    FServer:    TRunpadShell2;
    function    GetDefaultInterface: IRunpadShell2;
    constructor Create(AServer: TRunpadShell2);
  protected
  public
    property DefaultInterface: IRunpadShell2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoRunpadShell.Create: IRunpadShell;
begin
  Result := CreateComObject(CLASS_RunpadShell) as IRunpadShell;
end;

class function CoRunpadShell.CreateRemote(const MachineName: string): IRunpadShell;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RunpadShell) as IRunpadShell;
end;

procedure TRunpadShell.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D7346301-B73F-4A94-ABE6-234A0D49521D}';
    IntfIID:   '{0CBC0D60-02DB-434D-99C0-003702C65934}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRunpadShell.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IRunpadShell;
  end;
end;

procedure TRunpadShell.ConnectTo(svrIntf: IRunpadShell);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRunpadShell.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRunpadShell.GetDefaultInterface: IRunpadShell;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TRunpadShell.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TRunpadShellProperties.Create(Self);
{$ENDIF}
end;

destructor TRunpadShell.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TRunpadShell.GetServerProperties: TRunpadShellProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TRunpadShell.GetShellState(out pState: RSHELLSTATE): HResult;
begin
  Result := DefaultInterface.GetShellState(pState);
end;

function TRunpadShell.GetShellExecutable(lpszExePath: PChar; cbPathLen: LongWord; 
                                         out lpdwPID: LongWord): HResult;
begin
  Result := DefaultInterface.GetShellExecutable(lpszExePath, cbPathLen, lpdwPID);
end;

function TRunpadShell.TurnShell(bNewState: Integer): HResult;
begin
  Result := DefaultInterface.TurnShell(bNewState);
end;

function TRunpadShell.GetShellMode(out lpdwFlags: LongWord): HResult;
begin
  Result := DefaultInterface.GetShellMode(lpdwFlags);
end;

function TRunpadShell.IsShellOwnedWindow(var hWnd: _RemotableHandle; out lpbOwned: Integer): HResult;
begin
  Result := DefaultInterface.IsShellOwnedWindow(hWnd, lpbOwned);
end;

function TRunpadShell.GetFolderPath(dwFolderType: RSHELLFOLDER; lpszPath: PChar; cbPathLen: LongWord): HResult;
begin
  Result := DefaultInterface.GetFolderPath(dwFolderType, lpszPath, cbPathLen);
end;

function TRunpadShell.GetMachineNumber(out lpdwNum: LongWord): HResult;
begin
  Result := DefaultInterface.GetMachineNumber(lpdwNum);
end;

function TRunpadShell.GetCurrentSheet(lpszName: PChar; cbNameLen: LongWord): HResult;
begin
  Result := DefaultInterface.GetCurrentSheet(lpszName, cbNameLen);
end;

function TRunpadShell.EnableSheets(lpszName: PChar; bEnable: Integer): HResult;
begin
  Result := DefaultInterface.EnableSheets(lpszName, bEnable);
end;

function TRunpadShell.RegisterClient(lpszClientName: PChar; lpszClientPath: PChar; dwFlags: LongWord): HResult;
begin
  Result := DefaultInterface.RegisterClient(lpszClientName, lpszClientPath, dwFlags);
end;

function TRunpadShell.ShowInfoMessage(lpszText: PChar; dwFlags: LongWord): HResult;
begin
  Result := DefaultInterface.ShowInfoMessage(lpszText, dwFlags);
end;

function TRunpadShell.DoSingleAction(dwAction: RSHELLACTION): HResult;
begin
  Result := DefaultInterface.DoSingleAction(dwAction);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TRunpadShellProperties.Create(AServer: TRunpadShell);
begin
  inherited Create;
  FServer := AServer;
end;

function TRunpadShellProperties.GetDefaultInterface: IRunpadShell;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoRunpadShell2.Create: IRunpadShell2;
begin
  Result := CreateComObject(CLASS_RunpadShell2) as IRunpadShell2;
end;

class function CoRunpadShell2.CreateRemote(const MachineName: string): IRunpadShell2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RunpadShell2) as IRunpadShell2;
end;

procedure TRunpadShell2.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D163EEE3-540A-48DA-9009-C194588263B9}';
    IntfIID:   '{548856D7-555A-445B-BDEB-EEE491A14C39}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRunpadShell2.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IRunpadShell2;
  end;
end;

procedure TRunpadShell2.ConnectTo(svrIntf: IRunpadShell2);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRunpadShell2.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRunpadShell2.GetDefaultInterface: IRunpadShell2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TRunpadShell2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TRunpadShell2Properties.Create(Self);
{$ENDIF}
end;

destructor TRunpadShell2.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TRunpadShell2.GetServerProperties: TRunpadShell2Properties;
begin
  Result := FProps;
end;
{$ENDIF}

function TRunpadShell2.GetShellState(out pState: RSHELLSTATE): HResult;
begin
  Result := DefaultInterface.GetShellState(pState);
end;

function TRunpadShell2.GetShellExecutable(lpszExePath: PChar; cbPathLen: LongWord; 
                                          out lpdwPID: LongWord): HResult;
begin
  Result := DefaultInterface.GetShellExecutable(lpszExePath, cbPathLen, lpdwPID);
end;

function TRunpadShell2.TurnShell(bNewState: Integer): HResult;
begin
  Result := DefaultInterface.TurnShell(bNewState);
end;

function TRunpadShell2.GetShellMode(out lpdwFlags: LongWord): HResult;
begin
  Result := DefaultInterface.GetShellMode(lpdwFlags);
end;

function TRunpadShell2.IsShellOwnedWindow(var hWnd: _RemotableHandle; out lpbOwned: Integer): HResult;
begin
  Result := DefaultInterface.IsShellOwnedWindow(hWnd, lpbOwned);
end;

function TRunpadShell2.GetFolderPath(dwFolderType: RSHELLFOLDER; lpszPath: PChar; 
                                     cbPathLen: LongWord): HResult;
begin
  Result := DefaultInterface.GetFolderPath(dwFolderType, lpszPath, cbPathLen);
end;

function TRunpadShell2.GetMachineNumber(out lpdwNum: LongWord): HResult;
begin
  Result := DefaultInterface.GetMachineNumber(lpdwNum);
end;

function TRunpadShell2.GetCurrentSheet(lpszName: PChar; cbNameLen: LongWord): HResult;
begin
  Result := DefaultInterface.GetCurrentSheet(lpszName, cbNameLen);
end;

function TRunpadShell2.EnableSheets(lpszName: PChar; bEnable: Integer): HResult;
begin
  Result := DefaultInterface.EnableSheets(lpszName, bEnable);
end;

function TRunpadShell2.RegisterClient(lpszClientName: PChar; lpszClientPath: PChar; 
                                      dwFlags: LongWord): HResult;
begin
  Result := DefaultInterface.RegisterClient(lpszClientName, lpszClientPath, dwFlags);
end;

function TRunpadShell2.ShowInfoMessage(lpszText: PChar; dwFlags: LongWord): HResult;
begin
  Result := DefaultInterface.ShowInfoMessage(lpszText, dwFlags);
end;

function TRunpadShell2.DoSingleAction(dwAction: RSHELLACTION): HResult;
begin
  Result := DefaultInterface.DoSingleAction(dwAction);
end;

function TRunpadShell2.VipLogin(lpszLogin: PChar; lpszPassword: PChar; bWait: Integer): HResult;
begin
  Result := DefaultInterface.VipLogin(lpszLogin, lpszPassword, bWait);
end;

function TRunpadShell2.VipRegister(lpszLogin: PChar; lpszPassword: PChar; bWait: Integer): HResult;
begin
  Result := DefaultInterface.VipRegister(lpszLogin, lpszPassword, bWait);
end;

function TRunpadShell2.VipLogout(bWait: Integer): HResult;
begin
  Result := DefaultInterface.VipLogout(bWait);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TRunpadShell2Properties.Create(AServer: TRunpadShell2);
begin
  inherited Create;
  FServer := AServer;
end;

function TRunpadShell2Properties.GetDefaultInterface: IRunpadShell2;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TRunpadShell, TRunpadShell2]);
end;

end.
