unit uAccountsDataSet;


interface
uses uGCDataSet, ADODB, gcconst;

type
  TAccountsDataSet = class(TGCDataSet)
  protected
    function DoSelectAll(
        var AdtsResult: TADODataSet): Boolean; override;
    function DoUpdate(const AnId: Integer): Boolean; override;
    function DoDelete (const AnId: Integer): Boolean; override;
    function DoInsert(var AdtsResult: TADODataSet): Boolean; override;
    function DoSelect(const AnId: Integer;
        var AdtsResult: TADODataSet): Boolean; override;
  public
    function LocateByName(const AstrName: String): Boolean;
    function DoUpdateMoneyPut(const AnId: Integer; AfMoney: Double): Boolean;
    function DoUpdateMoneyBonusPut(const AnId: Integer; AfMoney: Double): Boolean;
    function DoUpdateMoneyRemove(const AnId: Integer; AfMoney: Double): Boolean;
    function GetFreeCheckAccountsName: String;
    function GetCheckAccountsPassword: String;
  end;

implementation

uses
  uSQLTools,
  SysUtils,
  DB, Variants,
  uVirtualTime;

function TAccountsDataSet.DoSelectAll(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult, 'exec ' + DS_ACCOUNTS_SELECT);
end;

function TAccountsDataSet.DoSelect(const AnId: Integer;
  var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec ' + DS_ACCOUNTS_SELECT + ' @id=' + IntToStr(AnId));
end;

function TAccountsDataSet.DoUpdate(const AnId: Integer): Boolean;
var
  cmd: TADOCommand;
begin
  Result := False;
  try
    if (Connection <> nil) and Connection.Connected then
    begin
      cmd := TADOCommand.Create(nil);
      cmd.Connection := Connection;
      cmd.CommandType := cmdStoredProc;
      cmd.ParamCheck := false;
      cmd.CommandText := 'AccountsUpdatePhoto';
      cmd.ExecuteOptions := [eoExecuteNoRecords];
      with cmd.Parameters.AddParameter do begin
        DataType := ftInteger;
        Direction := pdInput;
        Value := FieldValues['id'];
      end;
      with cmd.Parameters.AddParameter do begin
        DataType := ftBlob;
        Direction := pdInput;
        if Length(FieldValues['photo']) > 0 then
          Value := FieldValues['photo']
        else
          Value := Null;
      end;
      cmd.execute;
      cmd.Destroy;
      Result := true;
    end;
  except
  end;
  Result := Result and dsDoCommand(Connection,
      'exec ' + DS_ACCOUNTS_UPDATE + ' @id='+ IntToStr(FieldValues['id'])
      + ', @name=N''' + FieldValues['name']
      + ''', @password=N''' + FieldValues['password']
      + ''', @email=N''' + FieldValues['email']
      + ''', @phone = N''' + FieldValues['phone']
      + ''', @isenabled=' + IntToStr(FieldValues['isenabled'])
      + ', @isblocked=' + IntToStr(FieldValues['isblocked'])
      + ', @isprivileged=' + IntToStr(FieldValues['isprivileged'])
      + ', @privilegedDiscount=' + IntToStr(FieldValues['privilegedDiscount'])
      + ', @zeroBalance=' + FloatToStr(FieldValues['zeroBalance'])
      + ', @address=N'''+  FieldValues['address']
      + ''', @memotext=N'''+ FieldValues['memo']
      + ''', @summary=' + FloatToStr(FieldValues['summary'])
      + ', @PeriodOfValidity='+ IntToStr(FieldValues['PeriodOfValidity'])
      + ', @ExpirationDate=N'''+ DateTimeToSQLStr(FieldValues['ExpirationDate'])
      + ''', @assigntarif='+ IntToStr(FieldValues['assigntarif'])
      + ', @userlevel='+ IntToStr(FieldValues['userlevel'])
      + ', @force_tariff='+ IntToStr(FieldValues['force_tariff'])
      + ', @referal='+ IntToStr(FieldValues['referal'])
      + ', @username=N''' + FieldValues['username']
      + ''', @uname=N''' + FieldValues['uname']
      + ''', @uotch=N''' + FieldValues['uotch']
      + ''', @hardcode=N''' + FieldValues['hardcode']
      + ''', @ignorehardcode='+IntToStr(FieldValues['ignorehardcode'])
      );


  Result := Result and dsDoCommand(Connection, 'exec ' + DS_ACCOUNTS_UPDATECODES
      + ' @id=' + IntToStr(FieldValues['id']) + ', @seccodes='''
      + FieldValues['seccodes'] + '''');
end;

function TAccountsDataSet.DoUpdateMoneyPut(const AnId: Integer;
    AfMoney: Double): Boolean;
begin
  Result := dsDoCommand(Connection, 'exec ' + DS_ACCOUNTS_MONEYPAY
      + ' @id=' + IntToStr(FieldValues['id'])
      + ', @summa=' + FloatToSQLStr(AfMoney)
      + ', @moment=''' + DateTimeToSQLStr(GetVirtualTimeReset) + '''');
end;

function TAccountsDataSet.DoUpdateMoneyBonusPut(const AnId: Integer;
    AfMoney: Double): Boolean;
begin
  Result := dsDoCommand(Connection, 'exec ' + DS_ACCOUNTS_MONEYBONUSPAY
      + ' @id=' + IntToStr(FieldValues['id'])
      + ', @summa=' + FloatToSQLStr(AfMoney)
      + ', @moment=''' + DateTimeToSQLStr(GetVirtualTimeReset) + '''');
end;


function TAccountsDataSet.DoUpdateMoneyRemove(const AnId: Integer;
    AfMoney: Double): Boolean;
begin
  Result := dsDoCommand(Connection, 'exec ' + DS_ACCOUNTS_MONEYRETURN
      + ' @id=' + IntToStr(FieldValues['id'])
      + ', @summa=' + FloatToSQLStr(AfMoney)
      + ', @moment=''' + DateTimeToSQLStr(GetVirtualTimeReset) + '''');
end;

function TAccountsDataSet.DoDelete(const AnId: Integer): Boolean;
begin
  Result := dsDoCommand(Connection,
      'exec ' + DS_ACCOUNTS_DELETE + ' @id=' + IntToStr(AnId));
end;

function TAccountsDataSet.DoInsert(var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec ' + DS_ACCOUNTS_INSERT);
end;

function TAccountsDataSet.LocateByName(const AstrName: String): Boolean;
begin
  Result := Locate('name', AstrName, [loCaseInsensitive]);
end;

function TAccountsDataSet.GetFreeCheckAccountsName: String;
var
  dstResult: TADODataSet;
begin
  Result := '';
  dstResult := TADODataSet.Create(Nil);
  if dsDoQuery(Connection, dstResult,
      'select dbo.GetFreeCheckAccountsName() as Name')
      then
    Result := dstResult.FieldValues['Name'];
end;

function TAccountsDataSet.GetCheckAccountsPassword: String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to 10 do
    Result := Result + Char(Integer('0') + Random(10));
end;

end.
