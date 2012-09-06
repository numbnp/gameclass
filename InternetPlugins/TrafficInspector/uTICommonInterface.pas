//////////////////////////////////////////////////////////////////////////////
//
// TTICommonInterface - общий интиерфейс для старого и нового COM-интерфейса TI.
//
//////////////////////////////////////////////////////////////////////////////
unit uTICommonInterface;

interface

uses
  // project units
  uY2KCommon,
  OleServer,
  ActiveX,
  TrafInsp2TLB;
//  TrafInsp115;


type

  //
  // TTICommonInterface
  //
//type
  APIObjectType = TOleEnum;
  APICounterType = TOleEnum;

  TTICommonInterface = class(TObject)
  private
    // fields
    FTrafInspAdmin: Variant;
    FPerm: Variant;
    FbCreated: Boolean;
    FbConnected: Boolean;
  protected
    //helper methods
    function _CreateTIInterface: Boolean;
    function _GetActive: Boolean;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrUserName: String; const AstrPassword: String); overload;
    destructor Destroy(); override;

    function Logon(const AstrUserName: String; const AstrPassword: String;
        var AstrErrorMessage: String): Boolean;

    function  APIGetBillProp(ObjectType: APIObjectType;
        ObjectID: OleVariant): OleVariant;
    function  APIGetAttr(ObjectType: APIObjectType; Obj: OleVariant;
        Attr: OleVariant): OleVariant;
    procedure APISetAttr(ObjectType: APIObjectType; Obj: OleVariant;
        Attr: OleVariant; Value: OleVariant; DoUpdate: WordBool);
    function  APISetBillProp(ObjectType: APIObjectType;
        ObjectID: OleVariant; Price: OleVariant; TraffExclude: OleVariant;
        PriceTime: OleVariant; CacheCost: Integer; MailCost: Integer;
        Cash: OleVariant; AdminName: OleVariant;
        AdminNote: OleVariant): WordBool;
    function  APISetUserState(UserID: OleVariant; Cash: OleVariant;
        NewState: Integer; AdminName: OleVariant;
        AdminNote: OleVariant): WordBool; 
    procedure APIResetExpCounter(CounterType: APICounterType;
        CounterID: OleVariant);
    function  APIAddUser(const UserID: WideString;
        const DisplayName: WideString; const Group: WideString): WideString;

    procedure InsertList(List: APIListType; Index: OleVariant; xml: OleVariant);
    function GetList(List: APIListType; Param1: OleVariant; Param2: OleVariant; AttrLevel: ConfigAttrLevelType)): OleVariant;

    // properties
    property Active: Boolean
      read _GetActive;
    property Connected: Boolean
      read FbConnected;
  end; // TTICommonInterface


var
  TI: TTICommonInterface;


implementation
uses
  // system units
  Graphics,
  SysUtils,
  Windows,
  Forms,
  uGCTIConst,
  uDebugLog,
  Variants,
  ComObj, StrUtils;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TTICommonInterface

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TTICommonInterface.Create();
begin
  inherited Create();
  CoInitialize(Nil);
  FbCreated := False;
  FbConnected := False;
  FbCreated := _CreateTIInterface;
end; // TTICommonInterface.Create

constructor TTICommonInterface.Create(const AstrUserName: String; const AstrPassword: String);
var
  strMessage: String;
begin
  Create();
  if not Logon(AstrUserName, AstrPassword, strMessage) then
    Debug.Trace5('TI: '+ strMessage);
end;

destructor TTICommonInterface.Destroy();
begin
  FPerm := null;
  FTrafInspAdmin := null;
  CoUninitialize;
  inherited Destroy();
end; // TTICommonInterface.Destroy


/////////////////////////////////////////////////////////////////////
function TTICommonInterface._CreateTIInterface: Boolean;
begin
  Result := True;
  try
    FTrafInspAdmin := CreateOleObject('TrafInsp.TrafInspAdmin');
    FPerm := FTrafInspAdmin.QueryPermissions;
  except
    Result := False;
    FTrafInspAdmin := null;
  end;
end;

function TTICommonInterface._GetActive: Boolean;
begin
  Result := FbCreated;
end;

/////////////////////////////////////////////////////////////////////
function TTICommonInterface.Logon(const AstrUserName: String; const AstrPassword: String;
    var AstrErrorMessage: String): Boolean;
var
  varPassword: OleVariant;
  varUserName: OleVariant;
begin
  Result := False;
  AstrErrorMessage := 'API: Интерфейс недоступен!';
  if not Active then
    exit;
  AstrErrorMessage := 'API: Неправильный пароль';
  try
    varPassword := AstrPassword;
    varUserName := AstrUserName;
    //FTrafInspAdmin.APILogon(varPassword);
    if FPerm.DoSharedLogon(varUserName,varPassword,'GameClass') = 0 then
      Result := True;
  except
    on E: Exception do begin
      if Pos(E.Message, 'API') <> 0 then
        AstrErrorMessage := E.Message;
    end;
  end;
  AstrErrorMessage :=
      AnsiReplaceStr(AstrErrorMessage, 'API интерфейс:', 'API:');
  FbConnected := Result;
  if Result then
    AstrErrorMessage := 'API: Подключение выполнено';
end;

function TTICommonInterface.APIGetBillProp(ObjectType: APIObjectType;
    ObjectID: OleVariant): OleVariant;
begin
  if not Active then
    exit;
  Result := FTrafInspAdmin.APIGetBillProp(ObjectType, ObjectID);
end;

function TTICommonInterface.APIGetAttr(ObjectType: APIObjectType;
    Obj: OleVariant; Attr: OleVariant): OleVariant;
begin
  if not Active then
    exit;
  Result := FTrafInspAdmin.APIGetAttr(ObjectType, Obj, Attr);
end;

procedure TTICommonInterface.APISetAttr(ObjectType: APIObjectType;
    Obj: OleVariant; Attr: OleVariant; Value: OleVariant; DoUpdate: WordBool);
begin
  if not Active then
    exit;
  FTrafInspAdmin.APISetAttr(ObjectType, Obj, Attr, Value, DoUpdate);
end;

function  TTICommonInterface.APISetBillProp(ObjectType: APIObjectType;
    ObjectID: OleVariant; Price: OleVariant; TraffExclude: OleVariant;
    PriceTime: OleVariant; CacheCost: Integer; MailCost: Integer;
    Cash: OleVariant; AdminName: OleVariant; AdminNote: OleVariant): WordBool;
begin
  Result := False;
  if not Active then
    exit;
  Result := FTrafInspAdmin.APISetBillProp(ObjectType, ObjectID, Price,
      TraffExclude, PriceTime, CacheCost, MailCost, Cash, AdminName, AdminNote);
end;


function TTICommonInterface.APISetUserState(UserID: OleVariant;
    Cash: OleVariant; NewState: Integer; AdminName: OleVariant;
    AdminNote: OleVariant): WordBool;
begin
  Result := False;
  if not Active then
    exit;
  Result := FTrafInspAdmin.APISetUserState(UserID, Cash, NewState,
        AdminName, AdminNote);
end;


procedure TTICommonInterface.APIResetExpCounter(CounterType: APICounterType;
    CounterID: OleVariant);
begin
  if not Active then
    exit;
  FTrafInspAdmin.APIResetExpCounter(CounterType, CounterID);
end;

function TTICommonInterface.APIAddUser(const UserID: WideString;
    const DisplayName: WideString; const Group: WideString): WideString;
begin
end;

procedure TTICommonInterface.InsertList(List: APIListType; Index: OleVariant; xml: OleVariant);
begin
  FTrafInspAdmin.InsertList(List,Index,xml);
end;


function TTICommonInterface.GetList(List: APIListType; Param1: OleVariant; Param2: OleVariant; AttrLevel: ConfigAttrLevelType)): OleVariant;
begin
  result := FTrafInspAdmin.GetList(List,Param1,Param2,AttrLevel);
end;

end.
