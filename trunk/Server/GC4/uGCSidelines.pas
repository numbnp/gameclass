unit uGCSidelines;

interface

uses uGCStrUtils,
      GCConst,
      GCCommon,
      GClangutils,
      StrUtils,
      SysUtils,
      DateUtils,
      gccomputers,
      DB,
      ADODB;

type

 // описание товара
  TGoods = record
    id: integer;
    name: string;
    price: double;
  end;

  TSidelineTypeCost = (
    stcSeparate = 1, //1-отдельная оплата
    stcPrepay = 2,   //2-из предоплаты
    stcPostpay = 3   //3-из постоплаты
  );

  // класс доп.товаров
  TSideline = class
  public
    constructor Create;
    procedure Load;
    procedure Add(newgoods: TGoods);
    procedure Update(oldgoods, newgoods: TGoods);
    function GetPrice(AnServiceId: Integer): Double;
    function GetName(AnServiceId: Integer): String;
    procedure Delete(name: string);
    procedure ToSell(const AnServiceId: Integer; const AnCount: Integer;
      const ATypeCost: TSidelineTypeCost; const AnComputerId: Integer = -1;
      const AnAccountId: Integer = -1;
      const AbUseCustomCost: Boolean = False; const AfCustomCost: Double = 0);
    function GetTypeCostInfo(ATypeCost: TSidelineTypeCost): String;
  public
    // динамический массив товаров
    count: integer;
    goods: array of TGoods;
  end;

var
  Sideline: TSideline;

implementation

uses
  uRegistry,
  GCSessions,
  uVirtualTime,
  uAccountSystem,
  uKKMTools,
  uServerScripting;

constructor TSideline.Create;
begin
  count := 0;
  SetLength(goods,count);
end;


procedure TSideline.Add(newgoods: TGoods);
begin
  count := count + 1;
  SetLength(goods,count);
  newgoods.name := FilterString(newgoods.name);
  goods[count-1] := newgoods;
  dsDoCommand(DS_SERVICESBASE_ADD + ' @goods=N''' + newgoods.name
      + ''', @price='
      + AnsiReplaceStr(FormatFloat('0.00',newgoods.price),',','.'));
end;

procedure TSideline.Update(oldgoods, newgoods: TGoods);
begin
  newgoods.name := FilterString(newgoods.name);
  dsDoCommand(DS_SERVICESBASE_UPDATE + ' @oldgoods=N'''
      + oldgoods.name + ''', @newgoods=N''' + newgoods.name
      + ''', @newprice='
      + AnsiReplaceStr(FormatFloat('0.00',newgoods.price),',','.'));
end;

procedure TSideline.Delete(name: string);
begin
  dsDoCommand(DS_SERVICESBASE_DELETE + ' @goods=N''' + name + '''');
end;

function TSideline.GetPrice(AnServiceId: Integer): Double;
var
  i: integer;
begin
  GetPrice := 0;
  if (AnServiceId = 0) then begin
    GetPrice := GRegistry.Options.PrintedPageCost;
    exit;
  end;
  for i:=0 to (count-1) do
    if (goods[i].id = AnServiceId) then begin
      GetPrice := goods[i].price;
      break;
    end;
end;

function TSideline.GetName(AnServiceId: Integer): String;
var
  i: integer;
begin
  GetName := '';
  for i:=0 to (count-1) do
    if (goods[i].id = AnServiceId) then begin
      GetName := goods[i].name;
      break;
    end;
end;

procedure TSideline.ToSell(const AnServiceId: Integer; const AnCount: Integer;
      const ATypeCost: TSidelineTypeCost; const AnComputerId: Integer = -1;
      const AnAccountId: Integer = -1;
      const AbUseCustomCost: Boolean = False; const AfCustomCost: Double = 0);
var
  strInfo: String;
  strConsole: String;
  session: TGCSession;
  strCompNumber: String;
  fCost: Double;
begin
  dsDoCommand(DS_SERVICE_TOSELL
      + ' @idService = ' + IntToStr(AnServiceId)
      + ', @count = '+ IntToStr(AnCount)
      + ', @now='''+DateTimeToSql(GetVirtualTime)
      + ''', @idComputer = ' + IntToStr(AnComputerId)
      + ', @idAccount = ' + IntToStr(AnAccountId)
      + ', @TypeCost = ' + IntToStr(Integer(ATypeCost))
      + ', @UseCustomCost = ' + BoolToStr(AbUseCustomCost)
      + ', @CustomCost = ' + FloatToStr(AfCustomCost));
  if AbUseCustomCost then
    fCost := AfCustomCost * AnCount
  else
    fCost := Sideline.GetPrice(AnServiceId) * AnCount;
  if (ATypeCost <> stcSeparate) then begin
    session := Comps[ComputersGetIndex(AnComputerId)].session;
    session.UpdateOnDB(0, 0, 0, 0, 0, fCost, 0, 0);
  end;
  strInfo := CurOperatorName + ' ' + IntToStr(AnServiceId) + ' '
      + ' '+ IntToStr(AnCount)
      + ' ';
  strConsole := translate('ServiceReady')
    + ' ' + Sideline.GetName(AnServiceId) + ', ' + translate('lblQuantity')
    + '=' + IntToStr(AnCount) + ', ' + translate('lblSumma')
    + ' = '
    + FormatFloat('0.00', fCost)
    + ' ' + GRegistry.Options.Currency + ' '
    + Sideline.GetTypeCostInfo(ATypeCost);
  if (AnComputerId <> -1) then begin
    strInfo := strInfo + Comps[ComputersGetIndex(AnComputerId)].ipaddr;
    strConsole := strConsole + ' ' + translate('Computer') + ': '
        + Comps[ComputersGetIndex(AnComputerId)].GetStrNumber;
  end else
    strInfo := strInfo + 'none';
  strInfo := strInfo + ' ';
  if (AnAccountId <> -1) then begin
    strInfo := strInfo + GAccountSystem.Accounts.Items[AnAccountId].Name;
    strConsole := strConsole + ' ' + translate('Client') + ': '
        + GAccountSystem.Accounts.Items[AnAccountId].Name;
  end else
    strInfo := strInfo + 'none';
  case ATypeCost of
    stcSeparate: strInfo := strInfo + ' Separate';
    stcPrepay: strInfo := strInfo + ' Prepay';
    stcPostpay: strInfo := strInfo + ' Postpay';
  end;
  strCompNumber := '';
  if (AnComputerId <> -1) then
    strCompNumber := Comps[ComputersGetIndex(AnComputerId)].GetStrNumber;
  if (ATypeCost = stcSeparate) and GRegistry.Modules.KKM.Active then
    PrintService(AnServiceId, Sideline.GetName(AnServiceId),
        AnCount, Sideline.GetPrice(AnServiceId), strCompNumber);
  Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, strConsole);
  RunServerScript(aService, strInfo);
end;

function TSideline.GetTypeCostInfo(ATypeCost: TSidelineTypeCost): String;
begin
  Result := '';
  case ATypeCost of
    stcSeparate: Result := 'отдельная оплата';
    stcPrepay: Result := 'вычесть из предоплаты за сеанс';
    stcPostpay: Result := 'включить в постопалату за сеанс';
  end;
end;

procedure TSideline.Load;
var
  dts: TADODataSet;
  g: TGoods;
begin
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_SERVICESBASE_SELECT, @dts);

    count := 0;
    while (not dts.Recordset.EOF) do
    begin
      count := count + 1;
      SetLength(goods,count);
      g.name := dts.Recordset.Fields.Item['name'].Value;
      g.price := dts.Recordset.Fields.Item['price'].Value;
      g.id := dts.Recordset.Fields.Item['id'].Value;
      goods[count-1] := g;
      dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;
  end;
end;


end.
