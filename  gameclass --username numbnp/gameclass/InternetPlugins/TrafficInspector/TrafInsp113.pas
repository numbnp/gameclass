unit TrafInsp113;

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

// PASTLWTR : $Revision:   1.130  $
// File generated on 24.04.2005 22:39:45 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Projects\GC\mod - GCInternetControlComWindows\TI\TRAFINSP.DLL (1)
// LIBID: {3786FCCA-9365-4E47-8AF5-565C5D0A3FBD}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TTrafInspAdmin) : No Server registered for this CoClass
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

interface

uses ActiveX, Classes, Graphics, OleServer, StdVCL, Variants, Windows;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  TrafInspMajorVersion = 1;
  TrafInspMinorVersion = 0;

  LIBID_TrafInsp: TGUID = '{3786FCCA-9365-4E47-8AF5-565C5D0A3FBD}';

  IID_ITrafInspAdmin: TGUID = '{AA0B5820-94A5-43D8-831C-55BEC20F102B}';
  CLASS_TrafInspAdmin: TGUID = '{385D6E60-1ACB-4097-B428-C766661C1E9D}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum APIObjectType
type
  APIObjectType = TOleEnum;
const
  APIObjectTypeCommon = $00000001;
  APIObjectTypeGroup = $00000002;
  APIObjectTypeUser = $00000003;

// Constants for enum APITraffBillType
type
  APITraffBillType = TOleEnum;
const
  APITraffBillTypeIn = $00000000;
  APITraffBillTypeOut = $00000001;
  APITraffBillTypeSumm = $00000002;
  APITraffBillTypeMax = $00000003;

// Constants for enum APICounterType
type
  APICounterType = TOleEnum;
const
  APICounterCont = $00000001;
  APICounterInfo = $00000002;

// Constants for enum UserServiceType
type
  UserServiceType = TOleEnum;
const
  UserServiceTypeIP = $00000001;
  UserServiceTypeProxy = $00000002;
  UserServiceTypeSocksConn = $00000004;
  UserServiceTypeSocksBind = $00000008;
  UserServiceTypeWWWServ = $00000100;

// Constants for enum UserAttrDefs
type
  UserAttrDefs = TOleEnum;
const
  User_DisplayName = $00000000;
  User_Note = $00000001;
  User_IPAddr = $00000002;
  User_IPAddr2 = $00000003;
  User_MAC = $00000004;
  User_LogonName = $00000005;
  User_Password = $00000006;
  User_Group = $00000007;
  User_GroupName = $00000008;
  User_EMail = $00000009;
  User_EMailArr = $0000000A;
  User_Date1 = $0000000B;
  User_Date2 = $0000000C;
  User_AccessTime = $0000000D;
  User_BillDefault = $0000000E;
  User_BillType = $0000000F;
  User_Price = $00000010;
  User_TrafExclude = $00000011;
  User_PriceTime = $00000012;
  User_TimeDaily = $00000013;
  User_ProxyCacheCost = $00000014;
  User_MailCost = $00000015;
  User_Cash0 = $00000016;
  User_Cash = $00000017;
  User_BillMode = $00000018;
  User_BillState = $00000019;
  User_FilterLevel = $0000001A;
  User_FilterCurrLevel = $0000001B;
  User_ServiceMask = $0000001C;
  User_ServiceMaskDef = $0000001D;
  User_BandwidthDef = $0000001E;
  User_InBandwidth = $0000001F;
  User_OutBandwidth = $00000020;
  User_NetStatDef = $00000021;
  User_NetStatInt = $00000022;
  User_NetStatTop = $00000023;
  User_LogState = $00000024;
  User_LogStateInt = $00000025;
  User_LogProxy = $00000026;
  User_StartSession = $00000027;
  User_StartActiveSess = $00000028;
  User_DayWork0 = $00000029;
  User_BillTime = $0000002A;
  User_Blocked = $0000002B;
  User_Active = $0000002C;
  User_BillTraffic = $0000002D;
  User_BillSumma = $0000002E;
  User_BillSummaTime = $0000002F;
  User_BillBall = $00000030;
  User_BlockReason = $00000031;
  User_RxBytes = $00000032;
  User_TxBytes = $00000033;
  User_RxPackets = $00000034;
  User_TxPackets = $00000035;
  User_RxCacheBytes = $00000036;
  User_RxMailBytes = $00000037;
  User_TxMailBytes = $00000038;
  User_MailMessages = $00000039;
  User_RxCurrSpeed = $0000003A;
  User_TxCurrSpeed = $0000003B;
  User_ClientVer = $0000003C;
  User_ClientIP = $0000003D;
  User_CacheMode = $0000003E;
  User_Currency = $0000003F;
  User_RxProxyBytes = $00000040;
  User_Credit = $00000041;
  User_Admin = $00000042;
  User_TxTraffCorr = $00000043;
  User_LastTraffActive = $00000044;
  User_LastLogonTime = $00000045;
  User_LastLogoffTime = $00000046;

// Constants for enum GroupAttrDefs
type
  GroupAttrDefs = TOleEnum;
const
  Group_DisplayName = $00000000;
  Group_Note = $00000001;
  Group_BillDefault = $00000002;
  Group_BillType = $00000003;
  Group_Price = $00000004;
  Group_TrafExclude = $00000005;
  Group_PriceTime = $00000006;
  Group_TimeDaily = $00000007;
  Group_ProxyCacheCost = $00000008;
  Group_MailCost = $00000009;
  Group_Cash0 = $0000000A;
  Group_AccessTime = $0000000B;
  Group_FilterCustom = $0000000C;
  Group_FilterDefBlock = $0000000D;
  Group_FilterUseParent = $0000000E;
  Group_ServiceMask = $0000000F;
  Group_InDefBandwidth = $00000010;
  Group_OutDefBandwidth = $00000011;
  Group_InBandwidth = $00000012;
  Group_OutBandwidth = $00000013;
  Group_Currency = $00000014;
  Group_Credit = $00000015;
  Group_TxTraffCorr = $00000016;

// Constants for enum BillAttrDefs
type
  BillAttrDefs = TOleEnum;
const
  BillCommon_BillType = $00000000;
  BillCommon_Price = $00000001;
  BillCommon_TrafExclude = $00000002;
  BillCommon_PriceTime = $00000003;
  BillCommon_TimeDaily = $00000004;
  BillCommon_ProxyCacheCost = $00000005;
  BillCommon_MailCost = $00000006;
  BillCommon_Cash0 = $00000007;
  BillCommon_AccessTime = $00000008;
  BillCommon_Currency = $00000009;
  BillCommon_Credit = $0000000A;
  BillCommon_TxTraffCorr = $0000000B;
  BillCommon_ViewAllUserSess = $0000000C;

// Constants for enum UserLogAttrDefs
type
  UserLogAttrDefs = TOleEnum;
const
  UserLog_Time = $00000000;
  UserLog_GUID = $00000001;
  UserLog_DisplayName = $00000002;
  UserLog_Active = $00000003;
  UserLog_BillType = $00000004;
  UserLog_BillMode = $00000005;
  UserLog_BillState = $00000006;
  UserLog_Price = $00000007;
  UserLog_PriceTime = $00000008;
  UserLog_TrafExclude = $00000009;
  UserLog_Cash = $0000000A;
  UserLog_StartSession = $0000000B;
  UserLog_BillTime = $0000000C;
  UserLog_BillTraffic = $0000000D;
  UserLog_BillSumma = $0000000E;
  UserLog_BillSummaTime = $0000000F;
  UserLog_BillBall = $00000010;
  UserLog_BlockReason = $00000011;
  UserLog_RxBytes = $00000012;
  UserLog_TxBytes = $00000013;
  UserLog_RxPackets = $00000014;
  UserLog_TxPackets = $00000015;
  UserLog_RxIntBytes = $00000016;
  UserLog_TxIntBytes = $00000017;
  UserLog_RxIntPackets = $00000018;
  UserLog_TxIntPackets = $00000019;
  UserLog_Interval = $0000001A;
  UserLog_RxCache = $0000001B;
  UserLog_RxIntCache = $0000001C;
  UserLog_RxMailBytes = $0000001D;
  UserLog_TxMailBytes = $0000001E;
  UserLog_MailMessages = $0000001F;
  UserLog_RxIntMailBytes = $00000020;
  UserLog_TxIntMailBytes = $00000021;
  UserLog_IntMailMessages = $00000022;
  UserLog_Admin = $00000023;
  UserLog_AdminNote = $00000024;

// Constants for enum ProxyLogAttrDefs
type
  ProxyLogAttrDefs = TOleEnum;
const
  ProxyLog_UserName = $00000000;
  ProxyLog_UserIP = $00000001;
  ProxyLog_UserAgent = $00000002;
  ProxyLog_Date = $00000003;
  ProxyLog_Time = $00000004;
  ProxyLog_Reffered = $00000005;
  ProxyLog_Host = $00000006;
  ProxyLog_HostIP = $00000007;
  ProxyLog_HostPort = $00000008;
  ProxyLog_TimeToken = $00000009;
  ProxyLog_Tx = $0000000A;
  ProxyLog_Rx = $0000000B;
  ProxyLog_Protocol = $0000000C;
  ProxyLog_Method = $0000000D;
  ProxyLog_URI = $0000000E;
  ProxyLog_ContType = $0000000F;
  ProxyLog_RespStatus = $00000010;
  ProxyLog_GUID = $00000011;
  ProxyLog_CacheRead = $00000012;
  ProxyLog_CacheInfo = $00000013;

// Constants for enum NetStatLogAttrDefs
type
  NetStatLogAttrDefs = TOleEnum;
const
  NetStatLog_Time = $00000000;
  NetStatLog_GUID = $00000001;
  NetStatLog_ObjectName = $00000002;
  NetStatLog_Interval = $00000003;
  NetStatLog_LocIP = $00000004;
  NetStatLog_LocPort = $00000005;
  NetStatLog_PeerIP = $00000006;
  NetStatLog_PeerPort = $00000007;
  NetStatLog_Host = $00000008;
  NetStatLog_IPProto = $00000009;
  NetStatLog_AppProto = $0000000A;
  NetStatLog_Rx = $0000000B;
  NetStatLog_Tx = $0000000C;
  NetStatLog_RxPackets = $0000000D;
  NetStatLog_TxPackets = $0000000E;
  NetStatLog_List = $0000000F;
  NetStatLog_LocMAC = $00000010;
  NetStatLog_Cost = $00000011;

// Constants for enum APILogType
type
  APILogType = TOleEnum;
const
  APILogTypeUser = $00000001;
  APILogTypeProxy = $00000002;
  APILogTypeNetStat = $00000003;
  APILogTypeNetStatSort = $00000004;
  APILogTypeBill = $00000005;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ITrafInspAdmin = interface;
  ITrafInspAdminDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  TrafInspAdmin = ITrafInspAdmin;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  TServiceConfig = packed record
    UpTime: TDateTime;
    ServiceVer: WideString;
    OSMajorVer: Integer;
    OSMinorVer: Integer;
    ServerDomain: WideString;
    ServerName: WideString;
    ProductID: WideString;
    LicObject: WideString;
    SwExpired: Integer;
    Started: Integer;
    DriverNotExists: Integer;
    ServerTime: TDateTime;
    HTTPProxyPort: Integer;
    HTTPProxyCacheEnable: Integer;
    BlockHTTPOverNAT: Integer;
    SocksPort: Integer;
    ExtraAuto: Integer;
    AdminSharePass: Integer;
    AdminCount: Integer;
    SMTPServerPort: Integer;
  end;


// *********************************************************************//
// Interface: ITrafInspAdmin
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AA0B5820-94A5-43D8-831C-55BEC20F102B}
// *********************************************************************//
  ITrafInspAdmin = interface(IDispatch)
    ['{AA0B5820-94A5-43D8-831C-55BEC20F102B}']
    procedure GetServiceConfig(out Info: TServiceConfig); safecall;
    function  GetServiceLog: OleVariant; safecall;
    function  GetIPConfig: WideString; safecall;
    function  Get_ServerConfig(SParam: Integer): OleVariant; safecall;
    procedure Set_ServerConfig(SParam: Integer; Value: OleVariant); safecall;
    procedure SaveServiceConfig; safecall;
    procedure SaveList(List: Integer); safecall;
    function  GetList(List: Integer): OleVariant; safecall;
    procedure SetList(List: Integer; ItemIndex: Integer; ListValue: OleVariant); safecall;
    procedure ListInsert(List: Integer; ItemIndex: Integer; ListValue: OleVariant); safecall;
    procedure ListDelete(List: Integer; ItemIndex: Integer); safecall;
    procedure ListMove(List: Integer; OldIndex: Integer; NewIndex: Integer); safecall;
    function  GetUsersState(Filtered: Integer): OleVariant; safecall;
    procedure SetUserState(const ItemIndex: WideString; NewState: Integer; TrafExcl: OleVariant; 
                           Price: OleVariant; PriceTime: OleVariant; Cash: OleVariant; 
                           const Admin: WideString; const AdminNote: WideString); safecall;
    function  GetSocketsState(Order: Integer; WithLocal: Integer; UseDNS: Integer): OleVariant; safecall;
    function  GetServiceState: OleVariant; safecall;
    function  GetLogFile(LogType: Integer; Date: TDateTime): OleVariant; safecall;
    procedure ResetExtCounter(List: Integer; const Item: WideString); safecall;
    function  GetCaptionList(List: Integer): OleVariant; safecall;
    function  GetProxyStateList(var AllCount: Integer): OleVariant; safecall;
    function  GetNetStat(List: Integer; Obj: OleVariant): OleVariant; safecall;
    function  WhoIs(Query: OleVariant; Param: Integer): OleVariant; safecall;
    procedure ProxyClearCache; safecall;
    procedure ProxyCacheVerification; safecall;
    procedure GetListID(List: Integer; out ListArr: OleVariant; out IDArr: OleVariant; 
                        Param1: OleVariant; Param2: OleVariant); safecall;
    procedure SetListID(List: Integer; const ItemIndex: WideString; Value: OleVariant); safecall;
    procedure ListInsertID(List: Integer; const ItemIndex: WideString; Value: OleVariant); safecall;
    procedure ListDeleteID(List: Integer; const ItemIndex: WideString); safecall;
    function  Get_FilterHostList(const List: WideString): OleVariant; safecall;
    procedure Set_FilterHostList(const List: WideString; Value: OleVariant); safecall;
    procedure FilterRemoveHost(const List: WideString; HostItem: Integer); safecall;
    procedure SetUserFilterMode(const ItemIndex: WideString; FilterMode: Integer); safecall;
    procedure SetUserCacheMode(const ItemIndex: WideString; CacheMode: Integer); safecall;
    procedure SMTPSendNotif(ASubj: OleVariant; ABody: OleVariant); safecall;
    function  GetSMTPServerClientList: OleVariant; safecall;
    function  FindUserByEMail(const EMail: WideString; out Name: WideString; out Group: WideString; 
                              out GroupName: WideString): WideString; safecall;
    function  Get_UserEMailList(const ID: WideString): WideString; safecall;
    procedure Set_UserEMailList(const ID: WideString; const Value: WideString); safecall;
    procedure ClearRBLStat; safecall;
    procedure ProxyKillUser(SessID: Integer); safecall;
    procedure APILogon(Password: OleVariant); safecall;
    function  APIGetBillProp(ObjectType: APIObjectType; ObjectID: OleVariant): OleVariant; safecall;
    function  APISetBillProp(ObjectType: APIObjectType; ObjectID: OleVariant; Price: OleVariant; 
                             TraffExclude: OleVariant; PriceTime: OleVariant; CacheCost: Integer; 
                             MailCost: Integer; Cash: OleVariant; AdminName: OleVariant; 
                             AdminNote: OleVariant): WordBool; safecall;
    function  APIGetUserState(UserID: OleVariant): OleVariant; safecall;
    function  APIBlockReasonAsString(Reason: Integer): OleVariant; safecall;
    function  APISetUserState(UserID: OleVariant; Cash: OleVariant; NewState: Integer; 
                              AdminName: OleVariant; AdminNote: OleVariant): WordBool; safecall;
    procedure APIPushUserLog(UserID: OleVariant; AdminName: OleVariant; AdminNote: OleVariant); safecall;
    function  APIGetFilterProp(FilterID: OleVariant): OleVariant; safecall;
    procedure APISetFilterProp(FilterID: OleVariant; Enabled: WordBool; Cost: Integer; 
                               BillEnabled: WordBool); safecall;
    function  APIReadUserLog(Date1: OleVariant; Date2: OleVariant; UserID: OleVariant): OleVariant; safecall;
    procedure APIResetExpCounter(CounterType: APICounterType; CounterID: OleVariant); safecall;
    function  APIGetAttr(ObjectType: APIObjectType; Obj: OleVariant; Attr: OleVariant): OleVariant; safecall;
    procedure APISetAttr(ObjectType: APIObjectType; Obj: OleVariant; Attr: OleVariant; 
                         Value: OleVariant; DoUpdate: WordBool); safecall;
    procedure APIReadLogXML(LogType: APILogType; Date1: OleVariant; Date2: OleVariant; 
                            Obj: OleVariant; var Data: OleVariant; Param1: OleVariant); safecall;
    function  APISchemaAttr(Schema: Integer; Attr: Integer): OleVariant; safecall;
    function  APISchemaFindAttr(Attr: OleVariant): Integer; safecall;
    function  APIBillTraffTypeAsString(BillType: Integer): OleVariant; safecall;
    function  APIBillModeAsString(BillMode: Integer): OleVariant; safecall;
    function  APISessStateAsString(State: Integer): OleVariant; safecall;
    function  APIServiceAsString(Service: Integer): OleVariant; safecall;
    function  APIServiceSetAsString(ServiceSet: OleVariant): OleVariant; safecall;
    function  APIIPProtoAsString(Proto: Integer): OleVariant; safecall;
    function  APIAppProtoAsString(Proto: Integer): OleVariant; safecall;
    function  APIDNSResolve(Request: OleVariant): OleVariant; safecall;
    function  APIWhoIs(IPAddr: OleVariant; Service: Integer): OleVariant; safecall;
    procedure APIResetUserProxyStat(UserID: OleVariant); safecall;
    procedure UserRestoreTraff(const UserID: WideString; RxBytes: OleVariant; TxBytes: OleVariant; 
                               RxPackets: Integer; TxPackets: Integer; RxProxyBytes: OleVariant; 
                               MailBytes: OleVariant); safecall;
    function  GetUserADEmail(const ItemIndex: WideString): OleVariant; safecall;
    function  Get_NSNetList(List: Integer; const ID: WideString): WideString; safecall;
    procedure Set_NSNetList(List: Integer; const ID: WideString; const Value: WideString); safecall;
    function  AdminLogon(var State: Integer; Token: OleVariant): OleVariant; safecall;
    function  GetMACByIP(const AIP: WideString): WideString; safecall;
    procedure UserClearBlock(const User: WideString); safecall;
    function  APIAddUser(const UserID: WideString; const DisplayName: WideString; 
                         const Group: WideString): WideString; safecall;
    procedure APIDeleteUser(const UserID: WideString); safecall;
    procedure APISaveUserConfig; safecall;
    procedure APIUserLogon(UserID: OleVariant; FromIP: OleVariant; TTL: Integer; Info: OleVariant); safecall;
    procedure APIUserLogoff(UserID: OleVariant; Info: OleVariant; TermSess: Integer); safecall;
    procedure UserLogoff(const User: WideString); safecall;
    property ServerConfig[SParam: Integer]: OleVariant read Get_ServerConfig write Set_ServerConfig;
    property FilterHostList[const List: WideString]: OleVariant read Get_FilterHostList write Set_FilterHostList;
    property UserEMailList[const ID: WideString]: WideString read Get_UserEMailList write Set_UserEMailList;
    property NSNetList[List: Integer; const ID: WideString]: WideString read Get_NSNetList write Set_NSNetList;
  end;

// *********************************************************************//
// DispIntf:  ITrafInspAdminDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AA0B5820-94A5-43D8-831C-55BEC20F102B}
// *********************************************************************//
  ITrafInspAdminDisp = dispinterface
    ['{AA0B5820-94A5-43D8-831C-55BEC20F102B}']
    procedure GetServiceConfig(out Info: {??TServiceConfig}OleVariant); dispid 201;
    function  GetServiceLog: OleVariant; dispid 202;
    function  GetIPConfig: WideString; dispid 203;
    property ServerConfig[SParam: Integer]: OleVariant dispid 204;
    procedure SaveServiceConfig; dispid 206;
    procedure SaveList(List: Integer); dispid 207;
    function  GetList(List: Integer): OleVariant; dispid 208;
    procedure SetList(List: Integer; ItemIndex: Integer; ListValue: OleVariant); dispid 209;
    procedure ListInsert(List: Integer; ItemIndex: Integer; ListValue: OleVariant); dispid 210;
    procedure ListDelete(List: Integer; ItemIndex: Integer); dispid 211;
    procedure ListMove(List: Integer; OldIndex: Integer; NewIndex: Integer); dispid 212;
    function  GetUsersState(Filtered: Integer): OleVariant; dispid 213;
    procedure SetUserState(const ItemIndex: WideString; NewState: Integer; TrafExcl: OleVariant; 
                           Price: OleVariant; PriceTime: OleVariant; Cash: OleVariant; 
                           const Admin: WideString; const AdminNote: WideString); dispid 214;
    function  GetSocketsState(Order: Integer; WithLocal: Integer; UseDNS: Integer): OleVariant; dispid 215;
    function  GetServiceState: OleVariant; dispid 216;
    function  GetLogFile(LogType: Integer; Date: TDateTime): OleVariant; dispid 217;
    procedure ResetExtCounter(List: Integer; const Item: WideString); dispid 219;
    function  GetCaptionList(List: Integer): OleVariant; dispid 220;
    function  GetProxyStateList(var AllCount: Integer): OleVariant; dispid 221;
    function  GetNetStat(List: Integer; Obj: OleVariant): OleVariant; dispid 222;
    function  WhoIs(Query: OleVariant; Param: Integer): OleVariant; dispid 223;
    procedure ProxyClearCache; dispid 224;
    procedure ProxyCacheVerification; dispid 225;
    procedure GetListID(List: Integer; out ListArr: OleVariant; out IDArr: OleVariant; 
                        Param1: OleVariant; Param2: OleVariant); dispid 205;
    procedure SetListID(List: Integer; const ItemIndex: WideString; Value: OleVariant); dispid 226;
    procedure ListInsertID(List: Integer; const ItemIndex: WideString; Value: OleVariant); dispid 227;
    procedure ListDeleteID(List: Integer; const ItemIndex: WideString); dispid 228;
    property FilterHostList[const List: WideString]: OleVariant dispid 229;
    procedure FilterRemoveHost(const List: WideString; HostItem: Integer); dispid 230;
    procedure SetUserFilterMode(const ItemIndex: WideString; FilterMode: Integer); dispid 231;
    procedure SetUserCacheMode(const ItemIndex: WideString; CacheMode: Integer); dispid 232;
    procedure SMTPSendNotif(ASubj: OleVariant; ABody: OleVariant); dispid 300;
    function  GetSMTPServerClientList: OleVariant; dispid 218;
    function  FindUserByEMail(const EMail: WideString; out Name: WideString; out Group: WideString; 
                              out GroupName: WideString): WideString; dispid 233;
    property UserEMailList[const ID: WideString]: WideString dispid 234;
    procedure ClearRBLStat; dispid 235;
    procedure ProxyKillUser(SessID: Integer); dispid 236;
    procedure APILogon(Password: OleVariant); dispid 237;
    function  APIGetBillProp(ObjectType: APIObjectType; ObjectID: OleVariant): OleVariant; dispid 238;
    function  APISetBillProp(ObjectType: APIObjectType; ObjectID: OleVariant; Price: OleVariant; 
                             TraffExclude: OleVariant; PriceTime: OleVariant; CacheCost: Integer; 
                             MailCost: Integer; Cash: OleVariant; AdminName: OleVariant; 
                             AdminNote: OleVariant): WordBool; dispid 239;
    function  APIGetUserState(UserID: OleVariant): OleVariant; dispid 240;
    function  APIBlockReasonAsString(Reason: Integer): OleVariant; dispid 241;
    function  APISetUserState(UserID: OleVariant; Cash: OleVariant; NewState: Integer; 
                              AdminName: OleVariant; AdminNote: OleVariant): WordBool; dispid 242;
    procedure APIPushUserLog(UserID: OleVariant; AdminName: OleVariant; AdminNote: OleVariant); dispid 243;
    function  APIGetFilterProp(FilterID: OleVariant): OleVariant; dispid 244;
    procedure APISetFilterProp(FilterID: OleVariant; Enabled: WordBool; Cost: Integer; 
                               BillEnabled: WordBool); dispid 245;
    function  APIReadUserLog(Date1: OleVariant; Date2: OleVariant; UserID: OleVariant): OleVariant; dispid 246;
    procedure APIResetExpCounter(CounterType: APICounterType; CounterID: OleVariant); dispid 247;
    function  APIGetAttr(ObjectType: APIObjectType; Obj: OleVariant; Attr: OleVariant): OleVariant; dispid 248;
    procedure APISetAttr(ObjectType: APIObjectType; Obj: OleVariant; Attr: OleVariant; 
                         Value: OleVariant; DoUpdate: WordBool); dispid 249;
    procedure APIReadLogXML(LogType: APILogType; Date1: OleVariant; Date2: OleVariant; 
                            Obj: OleVariant; var Data: OleVariant; Param1: OleVariant); dispid 250;
    function  APISchemaAttr(Schema: Integer; Attr: Integer): OleVariant; dispid 251;
    function  APISchemaFindAttr(Attr: OleVariant): Integer; dispid 252;
    function  APIBillTraffTypeAsString(BillType: Integer): OleVariant; dispid 253;
    function  APIBillModeAsString(BillMode: Integer): OleVariant; dispid 254;
    function  APISessStateAsString(State: Integer): OleVariant; dispid 255;
    function  APIServiceAsString(Service: Integer): OleVariant; dispid 256;
    function  APIServiceSetAsString(ServiceSet: OleVariant): OleVariant; dispid 257;
    function  APIIPProtoAsString(Proto: Integer): OleVariant; dispid 258;
    function  APIAppProtoAsString(Proto: Integer): OleVariant; dispid 259;
    function  APIDNSResolve(Request: OleVariant): OleVariant; dispid 260;
    function  APIWhoIs(IPAddr: OleVariant; Service: Integer): OleVariant; dispid 261;
    procedure APIResetUserProxyStat(UserID: OleVariant); dispid 262;
    procedure UserRestoreTraff(const UserID: WideString; RxBytes: OleVariant; TxBytes: OleVariant; 
                               RxPackets: Integer; TxPackets: Integer; RxProxyBytes: OleVariant; 
                               MailBytes: OleVariant); dispid 263;
    function  GetUserADEmail(const ItemIndex: WideString): OleVariant; dispid 264;
    property NSNetList[List: Integer; const ID: WideString]: WideString dispid 265;
    function  AdminLogon(var State: Integer; Token: OleVariant): OleVariant; dispid 266;
    function  GetMACByIP(const AIP: WideString): WideString; dispid 267;
    procedure UserClearBlock(const User: WideString); dispid 268;
    function  APIAddUser(const UserID: WideString; const DisplayName: WideString; 
                         const Group: WideString): WideString; dispid 269;
    procedure APIDeleteUser(const UserID: WideString); dispid 270;
    procedure APISaveUserConfig; dispid 271;
    procedure APIUserLogon(UserID: OleVariant; FromIP: OleVariant; TTL: Integer; Info: OleVariant); dispid 272;
    procedure APIUserLogoff(UserID: OleVariant; Info: OleVariant; TermSess: Integer); dispid 273;
    procedure UserLogoff(const User: WideString); dispid 274;
  end;

// *********************************************************************//
// The Class CoTrafInspAdmin provides a Create and CreateRemote method to          
// create instances of the default interface ITrafInspAdmin exposed by              
// the CoClass TrafInspAdmin. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTrafInspAdmin = class
    class function Create: ITrafInspAdmin;
    class function CreateRemote(const MachineName: string): ITrafInspAdmin;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTrafInspAdmin
// Help String      : Traffic inspector remote control
// Default Interface: ITrafInspAdmin
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTrafInspAdminProperties= class;
{$ENDIF}
  TTrafInspAdmin = class(TOleServer)
  private
    FIntf:        ITrafInspAdmin;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTrafInspAdminProperties;
    function      GetServerProperties: TTrafInspAdminProperties;
{$ENDIF}
    function      GetDefaultInterface: ITrafInspAdmin;
  protected
    procedure InitServerData; override;
    function  Get_ServerConfig(SParam: Integer): OleVariant;
    procedure Set_ServerConfig(SParam: Integer; Value: OleVariant);
    function  Get_FilterHostList(const List: WideString): OleVariant;
    procedure Set_FilterHostList(const List: WideString; Value: OleVariant);
    function  Get_UserEMailList(const ID: WideString): WideString;
    procedure Set_UserEMailList(const ID: WideString; const Value: WideString);
    function  Get_NSNetList(List: Integer; const ID: WideString): WideString;
    procedure Set_NSNetList(List: Integer; const ID: WideString; const Value: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ITrafInspAdmin);
    procedure Disconnect; override;
    procedure GetServiceConfig(out Info: TServiceConfig);
    function  GetServiceLog: OleVariant;
    function  GetIPConfig: WideString;
    procedure SaveServiceConfig;
    procedure SaveList(List: Integer);
    function  GetList(List: Integer): OleVariant;
    procedure SetList(List: Integer; ItemIndex: Integer; ListValue: OleVariant);
    procedure ListInsert(List: Integer; ItemIndex: Integer; ListValue: OleVariant);
    procedure ListDelete(List: Integer; ItemIndex: Integer);
    procedure ListMove(List: Integer; OldIndex: Integer; NewIndex: Integer);
    function  GetUsersState(Filtered: Integer): OleVariant;
    procedure SetUserState(const ItemIndex: WideString; NewState: Integer; TrafExcl: OleVariant; 
                           Price: OleVariant; PriceTime: OleVariant; Cash: OleVariant; 
                           const Admin: WideString; const AdminNote: WideString);
    function  GetSocketsState(Order: Integer; WithLocal: Integer; UseDNS: Integer): OleVariant;
    function  GetServiceState: OleVariant;
    function  GetLogFile(LogType: Integer; Date: TDateTime): OleVariant;
    procedure ResetExtCounter(List: Integer; const Item: WideString);
    function  GetCaptionList(List: Integer): OleVariant;
    function  GetProxyStateList(var AllCount: Integer): OleVariant;
    function  GetNetStat(List: Integer; Obj: OleVariant): OleVariant;
    function  WhoIs(Query: OleVariant; Param: Integer): OleVariant;
    procedure ProxyClearCache;
    procedure ProxyCacheVerification;
    procedure GetListID(List: Integer; out ListArr: OleVariant; out IDArr: OleVariant); overload;
    procedure GetListID(List: Integer; out ListArr: OleVariant; out IDArr: OleVariant; 
                        Param1: OleVariant); overload;
    procedure GetListID(List: Integer; out ListArr: OleVariant; out IDArr: OleVariant; 
                        Param1: OleVariant; Param2: OleVariant); overload;
    procedure SetListID(List: Integer; const ItemIndex: WideString; Value: OleVariant);
    procedure ListInsertID(List: Integer; const ItemIndex: WideString; Value: OleVariant);
    procedure ListDeleteID(List: Integer; const ItemIndex: WideString);
    procedure FilterRemoveHost(const List: WideString; HostItem: Integer);
    procedure SetUserFilterMode(const ItemIndex: WideString; FilterMode: Integer);
    procedure SetUserCacheMode(const ItemIndex: WideString; CacheMode: Integer);
    procedure SMTPSendNotif(ASubj: OleVariant; ABody: OleVariant);
    function  GetSMTPServerClientList: OleVariant;
    function  FindUserByEMail(const EMail: WideString; out Name: WideString; out Group: WideString; 
                              out GroupName: WideString): WideString;
    procedure ClearRBLStat;
    procedure ProxyKillUser(SessID: Integer);
    procedure APILogon(Password: OleVariant);
    function  APIGetBillProp(ObjectType: APIObjectType; ObjectID: OleVariant): OleVariant;
    function  APISetBillProp(ObjectType: APIObjectType; ObjectID: OleVariant; Price: OleVariant; 
                             TraffExclude: OleVariant; PriceTime: OleVariant; CacheCost: Integer; 
                             MailCost: Integer; Cash: OleVariant; AdminName: OleVariant; 
                             AdminNote: OleVariant): WordBool;
    function  APIGetUserState(UserID: OleVariant): OleVariant;
    function  APIBlockReasonAsString(Reason: Integer): OleVariant;
    function  APISetUserState(UserID: OleVariant; Cash: OleVariant; NewState: Integer; 
                              AdminName: OleVariant; AdminNote: OleVariant): WordBool;
    procedure APIPushUserLog(UserID: OleVariant; AdminName: OleVariant; AdminNote: OleVariant);
    function  APIGetFilterProp(FilterID: OleVariant): OleVariant;
    procedure APISetFilterProp(FilterID: OleVariant; Enabled: WordBool; Cost: Integer; 
                               BillEnabled: WordBool);
    function  APIReadUserLog(Date1: OleVariant; Date2: OleVariant; UserID: OleVariant): OleVariant;
    procedure APIResetExpCounter(CounterType: APICounterType; CounterID: OleVariant);
    function  APIGetAttr(ObjectType: APIObjectType; Obj: OleVariant; Attr: OleVariant): OleVariant;
    procedure APISetAttr(ObjectType: APIObjectType; Obj: OleVariant; Attr: OleVariant; 
                         Value: OleVariant; DoUpdate: WordBool);
    procedure APIReadLogXML(LogType: APILogType; Date1: OleVariant; Date2: OleVariant; 
                            Obj: OleVariant; var Data: OleVariant); overload;
    procedure APIReadLogXML(LogType: APILogType; Date1: OleVariant; Date2: OleVariant; 
                            Obj: OleVariant; var Data: OleVariant; Param1: OleVariant); overload;
    function  APISchemaAttr(Schema: Integer; Attr: Integer): OleVariant;
    function  APISchemaFindAttr(Attr: OleVariant): Integer;
    function  APIBillTraffTypeAsString(BillType: Integer): OleVariant;
    function  APIBillModeAsString(BillMode: Integer): OleVariant;
    function  APISessStateAsString(State: Integer): OleVariant;
    function  APIServiceAsString(Service: Integer): OleVariant;
    function  APIServiceSetAsString(ServiceSet: OleVariant): OleVariant;
    function  APIIPProtoAsString(Proto: Integer): OleVariant;
    function  APIAppProtoAsString(Proto: Integer): OleVariant;
    function  APIDNSResolve(Request: OleVariant): OleVariant;
    function  APIWhoIs(IPAddr: OleVariant; Service: Integer): OleVariant;
    procedure APIResetUserProxyStat(UserID: OleVariant);
    procedure UserRestoreTraff(const UserID: WideString; RxBytes: OleVariant; TxBytes: OleVariant; 
                               RxPackets: Integer; TxPackets: Integer; RxProxyBytes: OleVariant; 
                               MailBytes: OleVariant);
    function  GetUserADEmail(const ItemIndex: WideString): OleVariant;
    function  AdminLogon(var State: Integer; Token: OleVariant): OleVariant;
    function  GetMACByIP(const AIP: WideString): WideString;
    procedure UserClearBlock(const User: WideString);
    function  APIAddUser(const UserID: WideString; const DisplayName: WideString; 
                         const Group: WideString): WideString;
    procedure APIDeleteUser(const UserID: WideString);
    procedure APISaveUserConfig;
    procedure APIUserLogon(UserID: OleVariant; FromIP: OleVariant; TTL: Integer; Info: OleVariant);
    procedure APIUserLogoff(UserID: OleVariant; Info: OleVariant; TermSess: Integer);
    procedure UserLogoff(const User: WideString);
    property  DefaultInterface: ITrafInspAdmin read GetDefaultInterface;
    property ServerConfig[SParam: Integer]: OleVariant read Get_ServerConfig write Set_ServerConfig;
    property FilterHostList[const List: WideString]: OleVariant read Get_FilterHostList write Set_FilterHostList;
    property UserEMailList[const ID: WideString]: WideString read Get_UserEMailList write Set_UserEMailList;
    property NSNetList[List: Integer; const ID: WideString]: WideString read Get_NSNetList write Set_NSNetList;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTrafInspAdminProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTrafInspAdmin
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTrafInspAdminProperties = class(TPersistent)
  private
    FServer:    TTrafInspAdmin;
    function    GetDefaultInterface: ITrafInspAdmin;
    constructor Create(AServer: TTrafInspAdmin);
  protected
    function  Get_ServerConfig(SParam: Integer): OleVariant;
    procedure Set_ServerConfig(SParam: Integer; Value: OleVariant);
    function  Get_FilterHostList(const List: WideString): OleVariant;
    procedure Set_FilterHostList(const List: WideString; Value: OleVariant);
    function  Get_UserEMailList(const ID: WideString): WideString;
    procedure Set_UserEMailList(const ID: WideString; const Value: WideString);
    function  Get_NSNetList(List: Integer; const ID: WideString): WideString;
    procedure Set_NSNetList(List: Integer; const ID: WideString; const Value: WideString);
  public
    property DefaultInterface: ITrafInspAdmin read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoTrafInspAdmin.Create: ITrafInspAdmin;
begin
  Result := CreateComObject(CLASS_TrafInspAdmin) as ITrafInspAdmin;
end;

class function CoTrafInspAdmin.CreateRemote(const MachineName: string): ITrafInspAdmin;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TrafInspAdmin) as ITrafInspAdmin;
end;

procedure TTrafInspAdmin.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{385D6E60-1ACB-4097-B428-C766661C1E9D}';
    IntfIID:   '{AA0B5820-94A5-43D8-831C-55BEC20F102B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTrafInspAdmin.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ITrafInspAdmin;
  end;
end;

procedure TTrafInspAdmin.ConnectTo(svrIntf: ITrafInspAdmin);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTrafInspAdmin.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTrafInspAdmin.GetDefaultInterface: ITrafInspAdmin;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTrafInspAdmin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTrafInspAdminProperties.Create(Self);
{$ENDIF}
end;

destructor TTrafInspAdmin.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTrafInspAdmin.GetServerProperties: TTrafInspAdminProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function  TTrafInspAdmin.Get_ServerConfig(SParam: Integer): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ServerConfig[SParam];
end;

procedure TTrafInspAdmin.Set_ServerConfig(SParam: Integer; Value: OleVariant);
begin
  DefaultInterface.ServerConfig[SParam] := Value;
end;

function  TTrafInspAdmin.Get_FilterHostList(const List: WideString): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.FilterHostList[List];
end;

procedure TTrafInspAdmin.Set_FilterHostList(const List: WideString; Value: OleVariant);
begin
  DefaultInterface.FilterHostList[List] := Value;
end;

function  TTrafInspAdmin.Get_UserEMailList(const ID: WideString): WideString;
begin
  Result := DefaultInterface.UserEMailList[ID];
end;

procedure TTrafInspAdmin.Set_UserEMailList(const ID: WideString; const Value: WideString);
  { Warning: The property UserEMailList has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.UserEMailList := Value;
end;

function  TTrafInspAdmin.Get_NSNetList(List: Integer; const ID: WideString): WideString;
begin
  Result := DefaultInterface.NSNetList[List, ID];
end;

procedure TTrafInspAdmin.Set_NSNetList(List: Integer; const ID: WideString; const Value: WideString);
  { Warning: The property NSNetList has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.NSNetList := Value;
end;

procedure TTrafInspAdmin.GetServiceConfig(out Info: TServiceConfig);
begin
  DefaultInterface.GetServiceConfig(Info);
end;

function  TTrafInspAdmin.GetServiceLog: OleVariant;
begin
  Result := DefaultInterface.GetServiceLog;
end;

function  TTrafInspAdmin.GetIPConfig: WideString;
begin
  Result := DefaultInterface.GetIPConfig;
end;

procedure TTrafInspAdmin.SaveServiceConfig;
begin
  DefaultInterface.SaveServiceConfig;
end;

procedure TTrafInspAdmin.SaveList(List: Integer);
begin
  DefaultInterface.SaveList(List);
end;

function  TTrafInspAdmin.GetList(List: Integer): OleVariant;
begin
  Result := DefaultInterface.GetList(List);
end;

procedure TTrafInspAdmin.SetList(List: Integer; ItemIndex: Integer; ListValue: OleVariant);
begin
  DefaultInterface.SetList(List, ItemIndex, ListValue);
end;

procedure TTrafInspAdmin.ListInsert(List: Integer; ItemIndex: Integer; ListValue: OleVariant);
begin
  DefaultInterface.ListInsert(List, ItemIndex, ListValue);
end;

procedure TTrafInspAdmin.ListDelete(List: Integer; ItemIndex: Integer);
begin
  DefaultInterface.ListDelete(List, ItemIndex);
end;

procedure TTrafInspAdmin.ListMove(List: Integer; OldIndex: Integer; NewIndex: Integer);
begin
  DefaultInterface.ListMove(List, OldIndex, NewIndex);
end;

function  TTrafInspAdmin.GetUsersState(Filtered: Integer): OleVariant;
begin
  Result := DefaultInterface.GetUsersState(Filtered);
end;

procedure TTrafInspAdmin.SetUserState(const ItemIndex: WideString; NewState: Integer; 
                                      TrafExcl: OleVariant; Price: OleVariant; 
                                      PriceTime: OleVariant; Cash: OleVariant; 
                                      const Admin: WideString; const AdminNote: WideString);
begin
  DefaultInterface.SetUserState(ItemIndex, NewState, TrafExcl, Price, PriceTime, Cash, Admin, 
                                AdminNote);
end;

function  TTrafInspAdmin.GetSocketsState(Order: Integer; WithLocal: Integer; UseDNS: Integer): OleVariant;
begin
  Result := DefaultInterface.GetSocketsState(Order, WithLocal, UseDNS);
end;

function  TTrafInspAdmin.GetServiceState: OleVariant;
begin
  Result := DefaultInterface.GetServiceState;
end;

function  TTrafInspAdmin.GetLogFile(LogType: Integer; Date: TDateTime): OleVariant;
begin
  Result := DefaultInterface.GetLogFile(LogType, Date);
end;

procedure TTrafInspAdmin.ResetExtCounter(List: Integer; const Item: WideString);
begin
  DefaultInterface.ResetExtCounter(List, Item);
end;

function  TTrafInspAdmin.GetCaptionList(List: Integer): OleVariant;
begin
  Result := DefaultInterface.GetCaptionList(List);
end;

function  TTrafInspAdmin.GetProxyStateList(var AllCount: Integer): OleVariant;
begin
  Result := DefaultInterface.GetProxyStateList(AllCount);
end;

function  TTrafInspAdmin.GetNetStat(List: Integer; Obj: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNetStat(List, Obj);
end;

function  TTrafInspAdmin.WhoIs(Query: OleVariant; Param: Integer): OleVariant;
begin
  Result := DefaultInterface.WhoIs(Query, Param);
end;

procedure TTrafInspAdmin.ProxyClearCache;
begin
  DefaultInterface.ProxyClearCache;
end;

procedure TTrafInspAdmin.ProxyCacheVerification;
begin
  DefaultInterface.ProxyCacheVerification;
end;

procedure TTrafInspAdmin.GetListID(List: Integer; out ListArr: OleVariant; out IDArr: OleVariant);
begin
  DefaultInterface.GetListID(List, ListArr, IDArr, EmptyParam, EmptyParam);
end;

procedure TTrafInspAdmin.GetListID(List: Integer; out ListArr: OleVariant; out IDArr: OleVariant; 
                                   Param1: OleVariant);
begin
  DefaultInterface.GetListID(List, ListArr, IDArr, Param1, EmptyParam);
end;

procedure TTrafInspAdmin.GetListID(List: Integer; out ListArr: OleVariant; out IDArr: OleVariant; 
                                   Param1: OleVariant; Param2: OleVariant);
begin
  DefaultInterface.GetListID(List, ListArr, IDArr, Param1, Param2);
end;

procedure TTrafInspAdmin.SetListID(List: Integer; const ItemIndex: WideString; Value: OleVariant);
begin
  DefaultInterface.SetListID(List, ItemIndex, Value);
end;

procedure TTrafInspAdmin.ListInsertID(List: Integer; const ItemIndex: WideString; Value: OleVariant);
begin
  DefaultInterface.ListInsertID(List, ItemIndex, Value);
end;

procedure TTrafInspAdmin.ListDeleteID(List: Integer; const ItemIndex: WideString);
begin
  DefaultInterface.ListDeleteID(List, ItemIndex);
end;

procedure TTrafInspAdmin.FilterRemoveHost(const List: WideString; HostItem: Integer);
begin
  DefaultInterface.FilterRemoveHost(List, HostItem);
end;

procedure TTrafInspAdmin.SetUserFilterMode(const ItemIndex: WideString; FilterMode: Integer);
begin
  DefaultInterface.SetUserFilterMode(ItemIndex, FilterMode);
end;

procedure TTrafInspAdmin.SetUserCacheMode(const ItemIndex: WideString; CacheMode: Integer);
begin
  DefaultInterface.SetUserCacheMode(ItemIndex, CacheMode);
end;

procedure TTrafInspAdmin.SMTPSendNotif(ASubj: OleVariant; ABody: OleVariant);
begin
  DefaultInterface.SMTPSendNotif(ASubj, ABody);
end;

function  TTrafInspAdmin.GetSMTPServerClientList: OleVariant;
begin
  Result := DefaultInterface.GetSMTPServerClientList;
end;

function  TTrafInspAdmin.FindUserByEMail(const EMail: WideString; out Name: WideString; 
                                         out Group: WideString; out GroupName: WideString): WideString;
begin
  Result := DefaultInterface.FindUserByEMail(EMail, Name, Group, GroupName);
end;

procedure TTrafInspAdmin.ClearRBLStat;
begin
  DefaultInterface.ClearRBLStat;
end;

procedure TTrafInspAdmin.ProxyKillUser(SessID: Integer);
begin
  DefaultInterface.ProxyKillUser(SessID);
end;

procedure TTrafInspAdmin.APILogon(Password: OleVariant);
begin
  DefaultInterface.APILogon(Password);
end;

function  TTrafInspAdmin.APIGetBillProp(ObjectType: APIObjectType; ObjectID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.APIGetBillProp(ObjectType, ObjectID);
end;

function  TTrafInspAdmin.APISetBillProp(ObjectType: APIObjectType; ObjectID: OleVariant; 
                                        Price: OleVariant; TraffExclude: OleVariant; 
                                        PriceTime: OleVariant; CacheCost: Integer; 
                                        MailCost: Integer; Cash: OleVariant; AdminName: OleVariant; 
                                        AdminNote: OleVariant): WordBool;
begin
  Result := DefaultInterface.APISetBillProp(ObjectType, ObjectID, Price, TraffExclude, PriceTime, 
                                            CacheCost, MailCost, Cash, AdminName, AdminNote);
end;

function  TTrafInspAdmin.APIGetUserState(UserID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.APIGetUserState(UserID);
end;

function  TTrafInspAdmin.APIBlockReasonAsString(Reason: Integer): OleVariant;
begin
  Result := DefaultInterface.APIBlockReasonAsString(Reason);
end;

function  TTrafInspAdmin.APISetUserState(UserID: OleVariant; Cash: OleVariant; NewState: Integer; 
                                         AdminName: OleVariant; AdminNote: OleVariant): WordBool;
begin
  Result := DefaultInterface.APISetUserState(UserID, Cash, NewState, AdminName, AdminNote);
end;

procedure TTrafInspAdmin.APIPushUserLog(UserID: OleVariant; AdminName: OleVariant; 
                                        AdminNote: OleVariant);
begin
  DefaultInterface.APIPushUserLog(UserID, AdminName, AdminNote);
end;

function  TTrafInspAdmin.APIGetFilterProp(FilterID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.APIGetFilterProp(FilterID);
end;

procedure TTrafInspAdmin.APISetFilterProp(FilterID: OleVariant; Enabled: WordBool; Cost: Integer; 
                                          BillEnabled: WordBool);
begin
  DefaultInterface.APISetFilterProp(FilterID, Enabled, Cost, BillEnabled);
end;

function  TTrafInspAdmin.APIReadUserLog(Date1: OleVariant; Date2: OleVariant; UserID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.APIReadUserLog(Date1, Date2, UserID);
end;

procedure TTrafInspAdmin.APIResetExpCounter(CounterType: APICounterType; CounterID: OleVariant);
begin
  DefaultInterface.APIResetExpCounter(CounterType, CounterID);
end;

function  TTrafInspAdmin.APIGetAttr(ObjectType: APIObjectType; Obj: OleVariant; Attr: OleVariant): OleVariant;
begin
  Result := DefaultInterface.APIGetAttr(ObjectType, Obj, Attr);
end;

procedure TTrafInspAdmin.APISetAttr(ObjectType: APIObjectType; Obj: OleVariant; Attr: OleVariant; 
                                    Value: OleVariant; DoUpdate: WordBool);
begin
  DefaultInterface.APISetAttr(ObjectType, Obj, Attr, Value, DoUpdate);
end;

procedure TTrafInspAdmin.APIReadLogXML(LogType: APILogType; Date1: OleVariant; Date2: OleVariant; 
                                       Obj: OleVariant; var Data: OleVariant);
begin
  DefaultInterface.APIReadLogXML(LogType, Date1, Date2, Obj, Data, EmptyParam);
end;

procedure TTrafInspAdmin.APIReadLogXML(LogType: APILogType; Date1: OleVariant; Date2: OleVariant; 
                                       Obj: OleVariant; var Data: OleVariant; Param1: OleVariant);
begin
  DefaultInterface.APIReadLogXML(LogType, Date1, Date2, Obj, Data, Param1);
end;

function  TTrafInspAdmin.APISchemaAttr(Schema: Integer; Attr: Integer): OleVariant;
begin
  Result := DefaultInterface.APISchemaAttr(Schema, Attr);
end;

function  TTrafInspAdmin.APISchemaFindAttr(Attr: OleVariant): Integer;
begin
  Result := DefaultInterface.APISchemaFindAttr(Attr);
end;

function  TTrafInspAdmin.APIBillTraffTypeAsString(BillType: Integer): OleVariant;
begin
  Result := DefaultInterface.APIBillTraffTypeAsString(BillType);
end;

function  TTrafInspAdmin.APIBillModeAsString(BillMode: Integer): OleVariant;
begin
  Result := DefaultInterface.APIBillModeAsString(BillMode);
end;

function  TTrafInspAdmin.APISessStateAsString(State: Integer): OleVariant;
begin
  Result := DefaultInterface.APISessStateAsString(State);
end;

function  TTrafInspAdmin.APIServiceAsString(Service: Integer): OleVariant;
begin
  Result := DefaultInterface.APIServiceAsString(Service);
end;

function  TTrafInspAdmin.APIServiceSetAsString(ServiceSet: OleVariant): OleVariant;
begin
  Result := DefaultInterface.APIServiceSetAsString(ServiceSet);
end;

function  TTrafInspAdmin.APIIPProtoAsString(Proto: Integer): OleVariant;
begin
  Result := DefaultInterface.APIIPProtoAsString(Proto);
end;

function  TTrafInspAdmin.APIAppProtoAsString(Proto: Integer): OleVariant;
begin
  Result := DefaultInterface.APIAppProtoAsString(Proto);
end;

function  TTrafInspAdmin.APIDNSResolve(Request: OleVariant): OleVariant;
begin
  Result := DefaultInterface.APIDNSResolve(Request);
end;

function  TTrafInspAdmin.APIWhoIs(IPAddr: OleVariant; Service: Integer): OleVariant;
begin
  Result := DefaultInterface.APIWhoIs(IPAddr, Service);
end;

procedure TTrafInspAdmin.APIResetUserProxyStat(UserID: OleVariant);
begin
  DefaultInterface.APIResetUserProxyStat(UserID);
end;

procedure TTrafInspAdmin.UserRestoreTraff(const UserID: WideString; RxBytes: OleVariant; 
                                          TxBytes: OleVariant; RxPackets: Integer; 
                                          TxPackets: Integer; RxProxyBytes: OleVariant; 
                                          MailBytes: OleVariant);
begin
  DefaultInterface.UserRestoreTraff(UserID, RxBytes, TxBytes, RxPackets, TxPackets, RxProxyBytes, 
                                    MailBytes);
end;

function  TTrafInspAdmin.GetUserADEmail(const ItemIndex: WideString): OleVariant;
begin
  Result := DefaultInterface.GetUserADEmail(ItemIndex);
end;

function  TTrafInspAdmin.AdminLogon(var State: Integer; Token: OleVariant): OleVariant;
begin
  Result := DefaultInterface.AdminLogon(State, Token);
end;

function  TTrafInspAdmin.GetMACByIP(const AIP: WideString): WideString;
begin
  Result := DefaultInterface.GetMACByIP(AIP);
end;

procedure TTrafInspAdmin.UserClearBlock(const User: WideString);
begin
  DefaultInterface.UserClearBlock(User);
end;

function  TTrafInspAdmin.APIAddUser(const UserID: WideString; const DisplayName: WideString; 
                                    const Group: WideString): WideString;
begin
  Result := DefaultInterface.APIAddUser(UserID, DisplayName, Group);
end;

procedure TTrafInspAdmin.APIDeleteUser(const UserID: WideString);
begin
  DefaultInterface.APIDeleteUser(UserID);
end;

procedure TTrafInspAdmin.APISaveUserConfig;
begin
  DefaultInterface.APISaveUserConfig;
end;

procedure TTrafInspAdmin.APIUserLogon(UserID: OleVariant; FromIP: OleVariant; TTL: Integer; 
                                      Info: OleVariant);
begin
  DefaultInterface.APIUserLogon(UserID, FromIP, TTL, Info);
end;

procedure TTrafInspAdmin.APIUserLogoff(UserID: OleVariant; Info: OleVariant; TermSess: Integer);
begin
  DefaultInterface.APIUserLogoff(UserID, Info, TermSess);
end;

procedure TTrafInspAdmin.UserLogoff(const User: WideString);
begin
  DefaultInterface.UserLogoff(User);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTrafInspAdminProperties.Create(AServer: TTrafInspAdmin);
begin
  inherited Create;
  FServer := AServer;
end;

function TTrafInspAdminProperties.GetDefaultInterface: ITrafInspAdmin;
begin
  Result := FServer.DefaultInterface;
end;

function  TTrafInspAdminProperties.Get_ServerConfig(SParam: Integer): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ServerConfig[SParam];
end;

procedure TTrafInspAdminProperties.Set_ServerConfig(SParam: Integer; Value: OleVariant);
begin
  DefaultInterface.ServerConfig[SParam] := Value;
end;

function  TTrafInspAdminProperties.Get_FilterHostList(const List: WideString): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.FilterHostList[List];
end;

procedure TTrafInspAdminProperties.Set_FilterHostList(const List: WideString; Value: OleVariant);
begin
  DefaultInterface.FilterHostList[List] := Value;
end;

function  TTrafInspAdminProperties.Get_UserEMailList(const ID: WideString): WideString;
begin
  Result := DefaultInterface.UserEMailList[ID];
end;

procedure TTrafInspAdminProperties.Set_UserEMailList(const ID: WideString; const Value: WideString);
  { Warning: The property UserEMailList has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.UserEMailList := Value;
end;

function  TTrafInspAdminProperties.Get_NSNetList(List: Integer; const ID: WideString): WideString;
begin
  Result := DefaultInterface.NSNetList[List, ID];
end;

procedure TTrafInspAdminProperties.Set_NSNetList(List: Integer; const ID: WideString; 
                                                 const Value: WideString);
  { Warning: The property NSNetList has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.NSNetList := Value;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TTrafInspAdmin]);
end;

end.
