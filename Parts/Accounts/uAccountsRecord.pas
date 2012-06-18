unit uAccountsRecord;

interface

uses
  Graphics,
  uAccountsDataSet;

type
  TSecCodes = array [0..19] of String;
  TAccountsRecord = class(TObject)
  private
    FAccountsDataSet: TAccountsDataSet;
    FSecCodes: TSecCodes;
    function GetEnabled: Boolean;
    procedure SetEnabled(AValue: Boolean);
    function GetSecurityBlocked: Boolean;
    procedure SetSecurityBlocked(AValue: Boolean);
    function GetId: Integer;
    function GetName: String;
    procedure SetName(AValue: String);
    function GetPassword: String;
    procedure SetPassword(AValue: String);
    function GetEmail: String;
    procedure SetEmail(AValue: String);
    function GetPhone: String;
    procedure SetPhone(AValue: String);
    function GetAddress: String;
    procedure SetAddress(AValue: String);
    function GetMemo: String;
    procedure SetMemo(AValue: String);
    function GetBalance: Double;
    procedure SetBalance(AValue: Double);
    function GetSummary: Double;
    procedure SetSummary(AValue: Double);
    function GetSecCodesAsString: String;
    procedure SetSecCodesAsString(AValue: String);
    function GetSecCodes: TSecCodes;
    function GetLimitBalance: Double;
    procedure SetLimitBalance(AValue: Double);
    function GetPrivileged: Boolean;
    procedure SetPrivileged(AValue: Boolean);
    function GetPrivilegedDiscount: Integer;
    procedure SetPrivilegedDiscount(AValue: Integer);
    function GetPhoto: TPicture;
    procedure SetPhoto(AValue: TPicture);
    function GetDiscount: Integer;
    function GetPeriodOfValidity: Boolean;
    procedure SetPeriodOfValidity(AValue: Boolean);
    function GetExpirationDate: TDateTime;
    procedure SetExpirationDate(AValue: TDateTime);
    function GetIsTarifsLimit: Boolean;
    procedure SetIsTarifsLimit(Value: Boolean);
    function GetUserLevel: Integer;
    procedure SetUserLevel(Value: Integer);
    function GetForceTariff: Integer;
  public
    constructor Create(AAccountsDataSet: TAccountsDataSet);
//      function GetPhoto:boolean;        // загрузить фоту, если она есть

    procedure GenerateSecCodes;
    procedure MoneyPut(AfMoney: Double);
    procedure MoneyRemove(AfMoney: Double);
    function Opened: Boolean; //баланс больше нуля
    function History: String;


    // Public property
    property Enabled: Boolean                // аккаунт отключен/подключен
        read GetEnabled write SetEnabled;
    property SecurityBlocked: Boolean        // блокировка в случае неверной авторизации N раз
        read GetSecurityBlocked write SetSecurityBlocked;
    property Id: Integer
        read GetId;
    property Name: String
        read GetName write SetName;
    property Password: String
        read GetPassword write SetPassword;
    property Email: String
        read GetEmail write SetEmail;
    property Phone: String
        read GetPhone write SetPhone;
    property Address: String
        read GetAddress write SetAddress;
    property Memo: String
        read GetMemo write SetMemo;
    property Balance: Double                  // состояние баланса
        read GetBalance write SetBalance;
    property Summary: Double                  // накопленная сумма
        read GetSummary write SetSummary;
    property SecCodes: TSecCodes  // таблица доп.кодов авторизации
        read GetSecCodes;
    property SecCodesAsString: String
        read GetSecCodesAsString write SetSecCodesAsString;
    property LimitBalance: Double             // порог отключения (по умолчанию 0)
        read GetLimitBalance write SetLimitBalance;
    property Privileged: Boolean             // привелигированный клиент
        read GetPrivileged write SetPrivileged;
    property PrivilegedDiscount: Integer     // скидка привелигированному клиенту
        read GetPrivilegedDiscount write SetPrivilegedDiscount;
    property Discount: Integer     // результирующая скидка
        read GetDiscount;
    property Photo: TPicture
        read GetPhoto write SetPhoto;
    property PeriodOfValidity: Boolean             // срок действи
        read GetPeriodOfValidity write SetPeriodOfValidity;
    property ExpirationDate: TDateTime
        read GetExpirationDate write SetExpirationDate;
    property IsTarifsLimit: Boolean
        read GetIsTarifsLimit write SetIsTarifsLimit;
    property UserLevel: Integer
        read GetUserLevel write SetUserLevel;
    property ForceTariff: Integer
        read GetForceTariff;
  end;


implementation

uses
  SysUtils,
  Classes,
  ExtCtrls,
  gcfunctions,
  gcconst,
  uAccountSystem,
  ADODB,
  uSQLTools,
  gclangutils,
  gccomputers,
  uRegistry;

constructor TAccountsRecord.Create(AAccountsDataSet: TAccountsDataSet);
begin
  FAccountsDataSet := AAccountsDataSet;
end;

function TAccountsRecord.GetEnabled: Boolean;
begin
  Result := FAccountsDataSet.FieldValues['isenabled'];
end;

procedure TAccountsRecord.SetEnabled(AValue: Boolean);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['isenabled'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetSecurityBlocked: Boolean;
begin
  Result := False;
  try
    Result := FAccountsDataSet.FieldValues['isblocked'];
  except
  end;
end;

procedure TAccountsRecord.SetSecurityBlocked(AValue: Boolean);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['isblocked'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetId: Integer;
begin
  Result := FAccountsDataSet.FieldValues['id'];
end;

function TAccountsRecord.GetName: String;
begin
  Result := translate('Guest');
  try
    Result := FAccountsDataSet.FieldValues['name'];
  except
  end;
end;

procedure TAccountsRecord.SetName(AValue: String);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['name'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetPassword: String;
begin
  Result := FAccountsDataSet.FieldValues['password'];
end;

procedure TAccountsRecord.SetPassword(AValue: String);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['password'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetEmail: String;
begin
  Result := FAccountsDataSet.FieldValues['email'];
end;

procedure TAccountsRecord.SetEmail(AValue: String);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['email'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetPhone: String;
begin
  Result := FAccountsDataSet.FieldValues['phone'];
end;

procedure TAccountsRecord.SetPhone(AValue: String);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['phone'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetAddress: String;
begin
  Result := FAccountsDataSet.FieldValues['address'];
end;

procedure TAccountsRecord.SetAddress(AValue: String);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['address'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetMemo: String;
begin
  Result := FAccountsDataSet.FieldValues['memo'];
end;

procedure TAccountsRecord.SetMemo(AValue: String);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['memo'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetBalance: Double;
begin
  Result := FAccountsDataSet.FieldValues['balance'];
end;

procedure TAccountsRecord.SetBalance(AValue: Double);
begin
  If not FunctionAmIRight(FN_ACCOUNTS_CHANGE_MONEY) then exit;
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['balance'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetSummary: Double;
begin
  try
    Result := FAccountsDataSet.FieldValues['summary'];
  except
    Result := 0;
  end;
end;

procedure TAccountsRecord.SetSummary(AValue: Double);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['summary'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetSecCodesAsString: String;
begin
  Result := FAccountsDataSet.FieldValues['seccodes'];
end;

procedure TAccountsRecord.SetSecCodesAsString(AValue: String);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['seccodes'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetSecCodes: TSecCodes;
var
  str: String;
  i: Integer;
begin
  str := GetSecCodesAsString;
  for i := 0 to 19 do begin
    if (strlen(PChar(str))>=4) then begin
      FSecCodes[i] := Copy(str,1,4);
      str := Copy(str,5,10000);
    end else
      FSecCodes[i] := '';
  end;
  Result := FSecCodes;
end;

procedure TAccountsRecord.GenerateSecCodes;
var
  str: String;
  i: Integer;
begin
  str := '';
  Randomize;
  for i:=1 to 80 do
    str := str + IntToStr(random(10));
  SecCodesAsString := str;
end;

procedure TAccountsRecord.MoneyPut(AfMoney: Double);
begin
  FAccountsDataSet.DoUpdateMoneyPut(Id, AfMoney);
end;

procedure TAccountsRecord.MoneyRemove(AfMoney: Double);
begin
  FAccountsDataSet.DoUpdateMoneyRemove(Id, AfMoney);
end;

function TAccountsRecord.GetLimitBalance: Double;
begin
  Result := FAccountsDataSet.FieldValues['zeroBalance'];
end;

procedure TAccountsRecord.SetLimitBalance(AValue: Double);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['zeroBalance'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetPrivileged: Boolean;
begin
  Result := FAccountsDataSet.FieldValues['isprivileged'];
end;

procedure TAccountsRecord.SetPrivileged(AValue: Boolean);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['isprivileged'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetPrivilegedDiscount: Integer;
begin
  Result := FAccountsDataSet.FieldValues['privilegedDiscount'];
end;

procedure TAccountsRecord.SetPrivilegedDiscount(AValue: Integer);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['privilegedDiscount'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetPhoto: TPicture;
var
  picture: TPicture;
  stream : TStringStream;
  imgAccountPhoto: TImage;
begin
//  stream := TStringStream.Create(FdsMain.FieldValues['photo']);
//  imgAccountPhoto.Picture.Graphic.LoadFromStream(stream);

  imgAccountPhoto := TImage.Create(Nil);
//  picture := TPicture.Create;
  stream := TStringStream.Create(FAccountsDataSet.FieldValues['photo']);
  imgAccountPhoto.Picture.Graphic.LoadFromStream(stream);
//  imgAccountPhoto.Picture.Graphic.LoadFromStream(stream);
//  picture.Graphic.LoadFromStream(stream);
  stream.Free;
end;

procedure TAccountsRecord.SetPhoto(AValue: TPicture);
var
  stream : TStringStream;
begin
  stream := TStringStream.Create('');
  AValue.Graphic.SaveToStream(stream);
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['photo'] := stream.DataString;
  FAccountsDataSet.Post;
  stream.Free;
end;

function TAccountsRecord.GetDiscount: Integer;
begin
  Result := 0;
  if (Self = Nil) then exit;
  try
    if (Balance < 0) and GAccountSystem.DiscountAfterLimitDisabled then
      Result := 0
    else begin
      Result := GAccountSystem.AccountsDiscounts.Discount(Summary);
      if Privileged and (PrivilegedDiscount > Result) then
        Result := PrivilegedDiscount;
    end;
  except
  end;
end;

function TAccountsRecord.Opened: Boolean; //баланс больше нуля
begin
  Result := (Balance > LimitBalance);
end;

function TAccountsRecord.History: String;
var
  dts: TADODataSet;
  query: string;
begin
  Result := '';
    query := 'exec ' + DS_ACCOUNTS_MONEYHISTORYSELECT + ' @idAccount=' + IntToStr(Id);
    dts := TADODataSet.Create(nil);
    dsDoQuery(FAccountsDataSet.Connection, dts, query);
    query := '';
    while (not dts.Recordset.EOF) do begin
//      query := query + DateTimeToStr(dts.Recordset.Fields.Item['moment'].Value);
//        query := query + FormatDateTime('dd mmm yyyy hh:nn > ',dts.Recordset.Fields.Item['moment'].Value);
        query := query + DateTimeToSQLStr(dts.Recordset.Fields.Item['moment'].Value)+' > ';
      if(dts.Recordset.Fields.Item['what'].Value = 0) then
         query := query + translate('AccountsHistoryAdd');
      if(dts.Recordset.Fields.Item['what'].Value = 1) then
         query := query + translate('AccountsHistoryRemove');
      if(dts.Recordset.Fields.Item['what'].Value = 2) then
         query := query + translate('AccountsHistoryPayment');
      query := query + ' ' + FormatFloat('0.00',dts.Recordset.Fields.Item['summa'].Value) ;
      query := query + ' ' + GRegistry.Options.Currency;
      query := query + #$D#$A;
      dts.Recordset.MoveNext;
    end;
    Result := query;

    dts.Close;
    dts.Destroy;
end;

function TAccountsRecord.GetPeriodOfValidity: Boolean;
begin
  Result := FAccountsDataSet.FieldValues['PeriodOfValidity'];
end;

procedure TAccountsRecord.SetPeriodOfValidity(AValue: Boolean);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['PeriodOfValidity'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetExpirationDate: TDateTime;
begin
  Result := FAccountsDataSet.FieldValues['ExpirationDate'];
end;

procedure TAccountsRecord.SetExpirationDate(AValue: TDateTime);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['ExpirationDate'] := AValue;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetIsTarifsLimit: Boolean;
begin
  Result := (FAccountsDataSet.FieldValues['assigntarif'] = 1);
end;

procedure TAccountsRecord.SetIsTarifsLimit(Value: Boolean);
begin
  FAccountsDataSet.Edit;
  if Value then
    FAccountsDataSet.FieldValues['assigntarif'] := 1
  else
    FAccountsDataSet.FieldValues['assigntarif'] := 0;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetUserLevel: Integer;
begin
  Result := FAccountsDataSet.FieldValues['userlevel'];
end;

procedure TAccountsRecord.SetUserLevel(Value: Integer);
begin
  FAccountsDataSet.Edit;
  FAccountsDataSet.FieldValues['userlevel'] := Value;
  FAccountsDataSet.Post;
end;

function TAccountsRecord.GetForceTariff: Integer;
begin
  Result := FAccountsDataSet.FieldValues['force_tariff'];
end;

end.
