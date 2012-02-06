unit uTariffication;

interface

uses
  gcconst;

type
  // класс цельного интервала тарифа
  TTarifVariants = class
  private
    FnTrafficLimit: Integer; //объем бесплатного трафа
    FfTrafficCost: Double;  //стоимость трафа
    FbTrafficSeparatePayment: Boolean; //отдельная оплата трафа
    FbFreePacket: Boolean; //пакет может начинаться в любое время
  public
    constructor Create;
    // ToDo нужен коммент к функции и посмотреть че она делает и где вызывается
    function IsAvailable(curtime: TDateTime):boolean;
    function TypeIntersect(startR,stopR: TDateTime):integer;
    function GetDaysofweekStop:string;
  public
    id: longword;               // id в базе данных
    idTarif: integer;           // id тарифа, к которому вариант принадлежит
    name: string;               // название варианта
    start: TDateTime;           // начало (учитывается только время суток)
    stop: TDateTime;            // конец (учитывается только время суток)
    cost: double;               // стоимость (за час или за весь интервал)
    ispacket: boolean;          // а это то, от чего зависит за час или интервал стоимость
    daysofweek: string;         // дни недели, вся неделя = "1234567"
    DaysofweekStop: string;     // дни недели, в которых происходит Stop интервала
    bCondition: boolean;        // true, если задано условие
    ConditionType: string;      // тип сравнения в условии (CONDITION_EQUALMORE)
    ConditionValue: integer;    // количество минут в сравнении в условии
    property TrafficLimit: Integer read FnTrafficLimit write FnTrafficLimit;
    property TrafficCost: Double read FfTrafficCost write FfTrafficCost;
    property TrafficSeparatePayment: Boolean
        read FbTrafficSeparatePayment write FbTrafficSeparatePayment;
    property FreePacket: Boolean
        read FbFreePacket write FbFreePacket;

  end;

  // класс тарифа
  TTarif = class
  public
    constructor Create;
    destructor Destroy; override;
    function CalculateTimeLength(start: TDateTime; money: double; vip: Integer; discount:integer):TDateTime;
    function CalculateCost(start,stop: TDateTime;
        vip: Integer; discount:integer; AbClearSeconds: Boolean;
        UseStartMoneyMinimum: Boolean; StartMoneyMinimumBySession: Double):double;
    // переводит секунды во время
    function TimeFromSeconds(seconds: longword): TDateTime;
    function GetWholeStartByIndex(idWhole: longword): TDateTime;
    function GetWholeStopByIndex(idWhole: longword): TDateTime;
    function GetWholeLengthByIndex(idWhole: longword): TDateTime;
    function GetWholeAtMidnightByIndex(idWhole: longword): Boolean;
    function GetWholeCostByIndex(idWhole: longword; idComp: longword): double;
    function GetWholeNameByIndex(idWhole: longword): string;
    function GetWholePrevDay(curtime: TDateTime; idWhole: longword): boolean;
    function GetWholeTrafficLimit(AnWhole: longword; AdtStart: TDateTime;
        AdtStop: TDateTime): Double;
    function GetWholeTrafficCost(AnWhole: longword): Double;
    function GetWholeTrafficSeparatePayment(AnWhole: longword): Boolean;

    // получить эффективный тариф
    function GetInexpensiveTarifVariant(
      const AdtMoment: TDateTime; // момент времени
      const AbCalcByTime: Boolean; // расчет по времени или по деньгам
      const AdtLength: TDateTime; // заказанное время (для условий)
      const AfMoney: Double // оплаченные деньги (для условий)
      ): TTarifVariants;

    // получить эффективный тариф по времени
    function GetInexpensiveTarifVariantByTime(
      const AdtMoment: TDateTime; // момент времени
      const AdtLength: TDateTime // заказанное время (для условий)
      ): TTarifVariants;

    // получить эффективный тариф по деньгам
    function GetInexpensiveTarifVariantByMoney(
      const AdtMoment: TDateTime; // момент времени
      const AfMoney: Double // оплаченные деньги (для условий)
      ): TTarifVariants;


    //возвращает Whole для пакетов, и текущий вариант для непакетов
    function GetTarifVariantByWhole(
      AnWhole: Integer;
      AdtMoment: TDateTime;
      AdtLength: TDateTime
      ): TTarifVariants;


    // функция округления времени вперед или назад с заданным шагом
    function fnRoundTime(length: TDateTime; stepsec: word; direction: integer): TDateTime;
    // функция округляения денег вперед или назад по заданному шагу
    function fnRoundMoney(money: double; stepmoney: double; direction: integer): double;
    // сумма с учетом скидки
    function CorrectedMoney(AfMoney: Double; AnDiscount: Integer): Double;
  private
    // функция подсчета времени исходя из денег
    function MegaFunctionCalcTimeByCost(start: TDateTime; cost: double):TDateTime;
    // функция подсчета денег исходя из времени
    function MegaFunctionCalcCostByTime(start,stop: TDateTime):double;
  private
    rc: integer;    // index of r
    FnBytesInMB: Integer;
    FnSpeedLimitInKB: Integer;
    FstrPluginGroupName: String;
  public
    hourcost: double;
    id: longword;
    name: string;
    internet: integer;
    calctraffic: integer;
    roundtime: integer;
    roundmoney: double;
    variantscount: integer;
    idGroup: Integer;
    userlevel: Integer; // требуемый уровень доступа пользователя
    useseparatesumm: integer; // Использовать отдельную настройку сумм
    startmoneymin: integer;   // минимальная стартовая сумма тарифа
    startmoneymax: integer;   // максимальная стартовая сумма тарифа
    addmoneymin: integer;     // минимальная сумма доплаты тарифа
    addmoneymax: integer;     // максимальная мальная сумма доплаты тарифа
    maximumtrust: integer;    // сумма доверия

    tarifvariants: array[0..(MAX_TARIFS_VARIANTS-1)] of TTarifVariants;
    property BytesInMB: Integer read FnBytesInMB write FnBytesInMB;
    property SpeedLimitInKB: Integer
        read FnSpeedLimitInKB write FnSpeedLimitInKB;
    property PluginGroupName: String
        read FstrPluginGroupName write FstrPluginGroupName;
  end;


var
  Tarifs: array[0..(MAX_TARIFS-1)] of TTarif;
  TarifsCount: integer = 0; // текущее количество тарифов
  GbInexpensiveTarifVariantNotExistsMessageShowed: Boolean;

implementation

uses
  SysUtils,
  DateUtils,
  Math,
  Types,
  uVirtualTime,
  uRegistry,
  gccomputers,
  gclangutils,
  frmGCMessageBox,
  gcfunctions,
  udmActions;


function TTarif.GetWholeStartByIndex(idWhole: longword): TDateTime;
var
  i: integer;
begin
  GetWholeStartByIndex := StrToTime('0:00:00');
  for i:=0 to variantscount-1 do
    if (tarifvariants[i].id = idWhole) then begin
      if tarifvariants[i].FreePacket then
        GetWholeStartByIndex := TimeOf(GetVirtualTime)
      else
        GetWholeStartByIndex := tarifvariants[i].start;
    end;
end;

function TTarif.GetWholeStopByIndex(idWhole: longword): TDateTime;
var
  i: integer;
begin
  GetWholeStopByIndex := StrToTime('0:00:00');
  for i:=0 to variantscount-1 do
    if (tarifvariants[i].id = idWhole) then begin
      if tarifvariants[i].FreePacket then
        GetWholeStopByIndex := TimeOf(TimeOf(GetVirtualTime)
        + tarifvariants[i].start)
      else
        GetWholeStopByIndex := tarifvariants[i].stop;
    end;
end;

function TTarif.GetWholeAtMidnightByIndex(idWhole: longword): Boolean;
var
  i: integer;
  dtStart, dtStop : TDateTime;
  s:String;
begin
  GetWholeAtMidnightByIndex := False;
  for i:=0 to variantscount-1 do
    if (tarifvariants[i].id = idWhole) then begin
      dtStart := tarifvariants[i].start;
      dtStop := tarifvariants[i].stop;
      s:= DateTimeToStr(dtStart) + '  ' + DateTimeToStr(dtStop);
      ReplaceDate(dtStart,StrToDate('01.01.2001'));
      ReplaceDate(dtStop,StrToDate('01.01.2001'));
      s:= DateTimeToStr(dtStart) + '  ' + DateTimeToStr(dtStop);
      if (dtStart < dtStop) then
        GetWholeAtMidnightByIndex := False
      else
        GetWholeAtMidnightByIndex := True;
    end;
end;

function TTarif.GetWholeTrafficLimit(AnWhole: longword; AdtStart: TDateTime;
    AdtStop: TDateTime): Double;
var
  dtMoment: TDateTime;
  fTrafficLimit: Double; //дабл чтобы не терять объемы при округлении на минутах
  tv : TTarifVariants;
begin
  GetWholeTrafficLimit := 0;
//  tv := GetTarifVariantByWhole(AnWhole,GetVirtualTime); Не понял почему  GetVirtualTime
  tv := GetTarifVariantByWhole(AnWhole,AdtStart,AdtStop-AdtStart);
  if (tv = Nil) or not GetWholeTrafficSeparatePayment(AnWhole) then
    exit;
  dtMoment := AdtStart;
  fTrafficLimit := 0;
  while (dtMoment < AdtStop) do begin
    fTrafficLimit := fTrafficLimit +
      GetTarifVariantByWhole(AnWhole,dtMoment,AdtStop-AdtStart).TrafficLimit*1024/60; //Килобайты ж
    dtMoment := dtMoment + EncodeTime(0,1,0,0); // прибавляем по 1 минуте
  end;
  GetWholeTrafficLimit := Round(fTrafficLimit);
end;

function TTarif.GetWholeTrafficCost(AnWhole: longword): Double;
var
  tv : TTarifVariants;
begin
  GetWholeTrafficCost := 0;
  tv := GetTarifVariantByWhole(AnWhole,GetVirtualTime,0);
  if (tv <> Nil) then
    GetWholeTrafficCost := tv.TrafficCost;
end;

function TTarif.GetWholeTrafficSeparatePayment(AnWhole: longword): Boolean;
var
  tv : TTarifVariants;
begin
  GetWholeTrafficSeparatePayment := False;
  tv := GetTarifVariantByWhole(AnWhole,GetVirtualTime,0);
  if (tv <> Nil) then
    GetWholeTrafficSeparatePayment := tv.TrafficSeparatePayment
        and (internet = 1);
end;

function TTarif.GetWholePrevDay(curtime: TDateTime; idWhole: longword): boolean;
var
  i,j: integer;
  fuckit: boolean;
  curday, prevday: integer;
  lefttime, righttime: TDateTime;
begin
  GetWholePrevDay := false;
  for i:=0 to variantscount-1 do
    if (tarifvariants[i].id = idWhole) then
    begin
      if tarifvariants[i].FreePacket then
        exit;
      // вычисляем текущий день недели
      curday := DayOfWeek(curtime);
      curday := curday - 1;
      if (curday = 0) then curday := 7;
      prevday := curday - 1;
      if prevday=0 then prevday := 7;
      fuckit := false;
      for j:=1 to StrLen(PChar(tarifvariants[i].daysofweek)) do
      begin
        if (StrToInt(tarifvariants[i].daysofweek[j]) = curday) then
        begin
          lefttime := StrToDate(DateToStr(curtime));
          lefttime := IncHour(lefttime,HourOf(tarifvariants[i].start));
          lefttime := IncMinute(lefttime,MinuteOf(tarifvariants[i].start));
          righttime := lefttime;
          righttime := IncHour(righttime, HourOf(tarifvariants[i].stop));
          righttime := IncMinute(righttime, MinuteOf(tarifvariants[i].stop));
          if ((lefttime<=curtime) and (curtime<righttime)) then  fuckit := true;
        end;
        if (StrToInt(tarifvariants[i].daysofweek[j]) = prevday) then
          GetWholePrevDay := true;
      end;
      if (fuckit = true) then GetWholePrevDay := false;
    end;
end;


function TTarif.GetWholeNameByIndex(idWhole: longword): string;
var
  i: integer;
begin
  GetWholeNameByIndex := '';
  for i:=0 to variantscount-1 do
    if (tarifvariants[i].id = idWhole) then GetWholeNameByIndex := tarifvariants[i].name;
end;


function TTarif.GetWholeLengthByIndex(idWhole: longword): TDateTime;
var
  i: integer;
begin
  GetWholeLengthByIndex := StrToTime('0:00:00');
  for i:=0 to variantscount-1 do
    if (tarifvariants[i].id = idWhole) then begin
      if tarifvariants[i].FreePacket then
        GetWholeLengthByIndex := TimeOf(tarifvariants[i].Start)
      else begin
        if (tarifvariants[i].stop > tarifvariants[i].start) then
          GetWholeLengthByIndex := TimeOf(tarifvariants[i].stop
              - tarifvariants[i].start)
        else
          GetWholeLengthByIndex := 1.0 - TimeOf(tarifvariants[i].start
              - tarifvariants[i].stop);
      end;
    end;
end;

function TTarif.GetWholeCostByIndex(idWhole: longword; idComp: longword): double;
var
  i: integer;
begin
  GetWholeCostByIndex := 0;
  for i:=0 to variantscount-1 do
    if (tarifvariants[i].id = idWhole) then
    begin
//TODOVIP      if (Comps[ComputersGetIndex(idComp)].vip) then
//        GetWholeCostByIndex := fnRoundMoney(tarifvariants[i].cost*(1+Options.VIPk/100),roundmoney,1)
//      else
        GetWholeCostByIndex := tarifvariants[i].cost;
      break;
    end;
end;

constructor TTarifVariants.Create;
begin
  DaysofweekStop := '';
end;

// возвращает список дней окончания интервала
function TTarifVariants.GetDaysofweekStop:string;
var
  i: integer;
  NextDay: string;
begin
  if (DaysofweekStop<>'') then begin
    GetDaysofweekStop := DaysofweekStop;
    exit;
  end;

  for i:=1 to StrLen(PChar(daysofweek)) do begin
    NextDay := daysofweek[i];
    if ((TimeOf(start)>TimeOf(stop)) or ((TimeOf(start)=EncodeTime(0,0,0,0)) and (TimeOf(stop)=EncodeTime(0,0,0,0)))) then begin
      NextDay := IntToStr(StrToInt(NextDay)+1);
      if (NextDay = '8') then NextDay := '1';
    end;
    DaysofweekStop := DaysofweekStop + NextDay;
  end;

  GetDaysofweekStop := DaysofweekStop;
end;

function TTarifVariants.IsAvailable(curtime: TDateTime):boolean;
var
  bFreePacketAvailable: Boolean;
  nTodayDayOfWeek, nTomorrowDayOfWeek: Integer;
begin
  IsAvailable := false;
  // эта функция возвращает true только для пакетных вариантов тарифов
  if (ispacket = false) then exit;
  if FreePacket then begin
    //тариф доступен если в днях недели есть сегодня и завтра
    //или только сегодня и до конца суток хватает времени
    nTodayDayOfWeek := DayOfTheWeek(curtime);
    nTomorrowDayOfWeek := nTodayDayOfWeek + 1;
    if (nTomorrowDayOfWeek > 7) then
      nTomorrowDayOfWeek := 1;
    bFreePacketAvailable := False;
    if (Pos(IntToStr(nTodayDayOfWeek), daysofweek)<>0)
        and (Pos(IntToStr(nTomorrowDayOfWeek), daysofweek)<>0) then
      bFreePacketAvailable := True;
    if (Pos(IntToStr(nTodayDayOfWeek), daysofweek)<>0)
        and (EncodeTime(23, 59, 59, 99) - TimeOf(Start) > TimeOf(curtime)) then
      bFreePacketAvailable := True;
    Result := bFreePacketAvailable;
    exit;
  end;
  IsAvailable := (TypeIntersect(curtime, curtime) <> INTERSECT_NOT);
end;

constructor TTarif.Create;
begin
  variantscount := 0;
  GbInexpensiveTarifVariantNotExistsMessageShowed := False;
end;

destructor TTarif.Destroy;
var
  i: integer;
begin
  if (variantscount>0) then
    for i:=0 to (variantscount-1) do
      tarifvariants[i].Destroy;
end;

// функция подсчета времени исходя из денег
function TTarif.CalculateTimeLength(start: TDateTime; money: double; vip: Integer; discount:integer):TDateTime;
var
  new_stop, new_length: TDateTime;
  n : Integer;
begin
  //Для ремонта нельзя рассчитатьт время
  if (id = ID_TARIF_REMONT) then exit;
  //для пакетов
//  start := RecodeSecond(RecodeMilliSecond(start, 0),0);
  if (discount = 100) then begin
    CalculateTimeLength := EncodeTime(12,0,0,0);//IncHour(start,12);
    exit;
  end;
 // применить минимальную оплату
 if useseparatesumm > 0 then
   begin
     if (money < startmoneymin) then
       begin
       CalculateTimeLength := 0;
       exit;
     end;
   end
 else
   begin
     if (money < GRegistry.Options.StartMoneyMinimum) then
       begin
         CalculateTimeLength := 0;
         exit;
       end;
   end;

 // vip в обратную сторону, типа VIP - плати больше :)
//TODOVIP if (vip) then money := money / (1 + Options.VIPk/100);
 //скидки : увеличиваем бабосы на процент скидки
 //!!Формулы разные потому, что скидка не м.б. >100%, а наценка может!
 if (discount > 0) and (discount < 100) then
   money := money /(1 - discount/100);

 // округляем бабло в меньшую сторону ToDo!Временно не округляем
  money := fnRoundMoney(money, roundmoney, -1);
 // вычисляем время конца, исходя из посекундной оплаты и из оплаченных денег

 new_stop := MegaFunctionCalcTimeByCost(start,money);
{  n := MinutesBetween(start,new_stop);
// new_stop := RecodeSecond(RecodeMilliSecond(new_stop, 0),0);
  n := MinutesBetween(start,new_stop);
 }
 // теперь можем применить округление по времени в меньшую сторону
 //if ( not ((HourOf(new_stop) = 23) and (MinuteOf(new_stop)=59)) ) then
 new_length := fnRoundTime(new_stop-start, roundtime, -1);
 n := MinutesBetween(start,start+new_length);
 CalculateTimeLength := new_length;
end;

// функция подсчета денег исходя из времени
{ TODO : Реализовать функцию взымания минимальной суммы только при окончании сесии }
function TTarif.CalculateCost(start,stop: TDateTime; vip: Integer;
    discount:integer; AbClearSeconds: Boolean; UseStartMoneyMinimum: Boolean; StartMoneyMinimumBySession: Double):double;
var
  new_stop: TDateTime;
  summa: double;
  n: Integer;
begin
  Result := 0;
  //Для ремонта стоимость 0
  if (id = ID_TARIF_REMONT) then exit;

 // округлим время конца вперед!
// new_stop := start + fnRoundTime(stop-start, roundtime, 1);
  if AbClearSeconds then begin
    start := RecodeSecond(RecodeMilliSecond(start, 0),0);
    stop := RecodeSecond(RecodeMilliSecond(stop, 0),0);
  end;
  new_stop := stop;
  n := MinutesBetween(start,new_stop);
 //вычислили оплату (посекундно, поминутно ... в зависимости от параметра)
 summa := MegaFunctionCalcCostByTime(start,new_stop);

 // cost1 := (TotalSeconds(new_length)/3600)*price;
//TODOVIP if (vip) then summa := summa *(1 + Options.VIPk/100);
 //скидки : уменьшаем стоимость на процент скидки
 if (discount > 0) and (discount < 100) then
   summa := summa *(1 - discount/100);
// summa := fnRoundMoney(summa, roundmoney, 1);
 summa := fnRoundMoney(summa, roundmoney, 1);
 // а теперь применить минимальную оплату
{  if (summa < GRegistry.Options.StartMoneyMinimum) then
    summa := GRegistry.Options.StartMoneyMinimum;
}
  if useseparatesumm > 0 then
    begin
      if (summa < startmoneymin) then
      summa := startmoneymin;
    end
  else
    begin
      if (summa < GRegistry.Options.StartMoneyMinimum) then
        summa := GRegistry.Options.StartMoneyMinimum;
    end;

 if (discount = 100) then
  summa := 0;
 CalculateCost := summa;
end;

function TTarif.TimeFromSeconds(seconds: longword): TDateTime;
var
  hour_, min_, sec_: word;
begin
  hour_ := trunc(seconds/3600);
  min_ := trunc((seconds - hour_*3600)/60);
  sec_ := seconds - hour_*3600 - min_*60;
  if (hour_>23) then begin
    hour_ := 23;
    min_ := 59;
    sec_ := 0;
  end;
  TimeFromSeconds := EncodeTime(hour_,min_,sec_,0);
end;

// функция округления времени вперед или назад с заданным шагом
function TTarif.fnRoundTime(length: TDateTime; stepsec: word; direction: integer): TDateTime;
var
  diffsec,old_diffsec: longword;
  i1: longword;
begin
  // всего секунд
  diffsec := TotalSeconds(length);
  if (diffsec < 2) then diffsec := diffsec + GLOBAL_TIMER;
  
  if direction > 0 then diffsec := diffsec - 1;
  old_diffsec := diffsec; 
  i1 := Round(diffsec / stepsec);
  if ((i1 * stepsec) <= diffsec) then
    diffsec := (i1 + 1) * stepsec
  else
    diffsec := i1 * stepsec;

  //если направление округления меньше нуля, то округляем в меньшую сторону
  if (direction < 0) then
    if diffsec > old_diffsec then diffsec := diffsec - stepsec;

  fnRoundTime := TimeFromSeconds(diffsec);
end;

// функция округляения денег вперед или назад по заданному шагу
function TTarif.fnRoundMoney(money: double; stepmoney: double; direction: integer): double;
var
  oldmoney, roundmoney, newmoney: double;
  i1: longword;
  range:integer;
  nPartCount: Integer;
  fRoundedMoney: Double;
begin
//а вот следующая строчка считает неверно
//nPartCount := Trunc(money/stepmoney);
  fRoundedMoney := money/stepmoney;
  nPartCount := Trunc(fRoundedMoney);
  fRoundedMoney := stepmoney * nPartCount;
  if (direction > 0) and (abs(money-fRoundedMoney) > 0.00001) then
    fRoundedMoney := fRoundedMoney + stepmoney;
  Result := fRoundedMoney;
{  oldmoney := money;
  i1 := Round(money / stepmoney);
  roundmoney := stepmoney * i1;
  range := Round(log10(stepmoney));
  roundmoney := RoundTo(roundmoney,range-1);
  newmoney := RoundTo(money,range-1);
  if ( roundmoney < newmoney) then
    newmoney := (i1 + 1) * stepmoney
  else
    newmoney := i1 * stepmoney;

  // если направление округления меньше нуля, то округляем в меньшую сторону
  if (direction < 0) then
    if newmoney > oldmoney then newmoney := newmoney - stepmoney;

  fnRoundMoney := newmoney;
}

end;

function TTarif.CorrectedMoney(AfMoney: Double; AnDiscount: Integer): Double;
begin
  Result := AfMoney;
  //скидки : уменьшаем стоимость на процент скидки
  if (AnDiscount > 0) and (AnDiscount < 100) then
    Result := AfMoney *(1 - AnDiscount/100);
  Result := fnRoundMoney(Result, roundmoney, 1);
  // а теперь применить минимальную оплату
  if (Result < GRegistry.Options.StartMoneyMinimum) then
    Result := GRegistry.Options.StartMoneyMinimum;
  if (AnDiscount = 100) then
    Result := 0;
end;

function TTarif.MegaFunctionCalcTimeByCost(start: TDateTime;
    cost: double):TDateTime;
var
  moment: TDateTime;
  summa: double;
  bExit: Boolean;
  nMin: Integer; //количество минут
  nSec: Integer; //количество секунд
  fConst: Double;
begin
  summa := cost;
  moment := start;
  nMin := 0;
  //Если округление меньше минуты, считаем по минутам,
  // иначе по времени округления
  // Последний отрезок (размер округления),
  // выравненный до минут считаем по округлению секунд
  //если больше суток то нафик
  if (roundtime < 60) then begin
    while (roundto(summa,-3) >= 0) and (nMin <= 1441) do begin
      summa := summa - GetInexpensiveTarifVariantByMoney(moment,cost).cost/60;
      moment := IncMinute(moment,1);
      Inc(nMin);
    end;
    //Сумма получилась отрицательная откатываемся на шаг назад
    moment := IncMinute(moment, -1);
    summa := summa + GetInexpensiveTarifVariantByMoney(moment,cost).cost/60;
  end;
  //Теперь у нас либо 0, либо >0
  fConst := roundtime / 60 / 60;
  while (roundto(summa,-3) >= 0) and ((moment-start) < 1.0) do begin
    summa := summa - GetInexpensiveTarifVariantByMoney(moment,cost).cost
        * fConst;
    moment := IncSecond(moment,roundtime);
  end;
  //Сумма получилась отрицательная откатываемся на шаг назад
  moment := IncSecond(moment, -roundtime);
  summa := summa + GetInexpensiveTarifVariantByMoney(moment,cost).cost
        * fConst;
  // какая-то лишняя секунда
  if (summa < 0) then
      moment := IncSecond(moment, -roundtime);
  MegaFunctionCalcTimeByCost := moment;
end;

function TTarif.MegaFunctionCalcCostByTime(start,stop: TDateTime):double;
var
  moment: TDateTime;
  summa: double;
  dtStopWithoutLastMinutes: TDateTime;
  nLastMinutes: Integer;
  fConst: Double;
begin
  summa := 0;
  //Если Время больше суток, то это оч.долго считать, поэтому ограничиваем
  if (stop-start)>1.0 {сутки} then
    stop := start + 1.0;
  moment := start;
  //Если округление меньше минуты, считаем по минутам,
  // иначе по времени округления
  // Последний отрезок (размер округления),
  // выравненный до минут считаем по округлению секунд
  if (roundtime < 60) then begin
    nLastMinutes := (roundtime + 59) div 60;
    dtStopWithoutLastMinutes := IncMinute(stop, -nLastMinutes);
    while (CompareDateTime(moment, dtStopWithoutLastMinutes)
        = LessThanValue) do begin
      summa := summa
          + GetInexpensiveTarifVariantByTime(moment,stop-start).cost/60;
      moment := IncMinute(moment,1);
    end;
  end;
  fConst := roundtime / 60 / 60;
  while (CompareDateTime(moment, stop) = LessThanValue) do begin
    summa := summa
        + GetInexpensiveTarifVariantByTime(moment,stop-start).cost
        * fConst;
    moment := IncSecond(moment,roundtime);
  end;
  MegaFunctionCalcCostByTime := summa;
end;

function TTarif.GetInexpensiveTarifVariant(
      const AdtMoment: TDateTime; // момент времени
      const AbCalcByTime: Boolean; // расчет по времени или по деньгам
      const AdtLength: TDateTime; // заказанное время (для условий)
      const AfMoney: Double // оплаченные деньги (для условий)
      ): TTarifVariants;

var
  i, min_index: integer;
  minimum : double;
begin
  Result := Nil;
  if (id = ID_TARIF_REMONT) then exit;
  // пусть первый элемент - пока что минимальный
  min_index := -1;
  minimum := MAX_DOUBLE; //думаю такого минимума не будет :)

  for i:=0 to variantscount-1 do
    if (not TarifVariants[i].ispacket) and
      (TarifVariants[i].cost < minimum)
        and IsBetween(TimeOf(AdtMoment),
        TimeOf(TarifVariants[i].start),TimeOf(TarifVariants[i].stop))
        and (Pos(IntToStr(DayOfTheWeek(AdtMoment)),
        TarifVariants[i].daysofweek)<>0)
        then begin
      if (TarifVariants[i].bCondition
          and (TarifVariants[i].ConditionType = CONDITION_EQUALMORE)
          and ((((MinutesBetween(0,AdtLength) >= TarifVariants[i].ConditionValue)
          or (AfMoney/TarifVariants[i].cost*60 >= TarifVariants[i].ConditionValue))
          and AbCalcByTime)
          or (((AfMoney/TarifVariants[i].cost*60 >= TarifVariants[i].ConditionValue)
          and not AbCalcByTime))))
          or not TarifVariants[i].bCondition then begin
        min_index := MinutesBetween(0,AdtLength);
        min_index := i;
        minimum := TarifVariants[i].cost;
      end;
    end;
  if (min_index = -1) then begin
    if not GbInexpensiveTarifVariantNotExistsMessageShowed then begin
      GbInexpensiveTarifVariantNotExistsMessageShowed := True;
    Console.AddEvent(EVENT_ICON_ERROR, LEVEL_ERROR, translate('InexpensiveTarifVariantNotExists'));
    formGCMessageBox.memoInfo.Text := translate('InexpensiveTarifVariantNotExists') + translate('HighCryticalError');
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
    dmActions.actExit.Execute;
   end;
    Result := TTarifVariants.Create;
  end else
    Result := TarifVariants[min_index];
end;

// получить эффективный тариф по времени
function TTarif.GetInexpensiveTarifVariantByTime(const AdtMoment: TDateTime;
    const AdtLength: TDateTime): TTarifVariants;
var
  fMoney: Double;
  tv: TTarifVariants;
begin
  Result := Nil;
  //изврат изза сдвигов с условиями, т.к. 50р=1ч 135р=3ч, а 2ч59м != 149р = 134р
  tv := GetInexpensiveTarifVariant(AdtMoment, True, AdtLength, 0);
  if (tv <> Nil) then begin
    fMoney := tv.cost * MinutesBetween(0,AdtLength) / 60;
    Result := GetInexpensiveTarifVariant(AdtMoment, True, AdtLength, fMoney);
  end;
end;

// получить эффективный тариф по деньгам
function TTarif.GetInexpensiveTarifVariantByMoney(const AdtMoment: TDateTime;
    const AfMoney: Double): TTarifVariants;
begin
  Result := GetInexpensiveTarifVariant(AdtMoment, False, 0, AfMoney);
end;

 //возвращает Whole для пакетов, и текущий вариант для непакетов
function TTarif.GetTarifVariantByWhole(AnWhole: Integer; AdtMoment: TDateTime;
    AdtLength: TDateTime): TTarifVariants;
var
  i: Integer;
begin
  Result := Nil;
  if (id = ID_TARIF_REMONT) then exit;
  if (AnWhole = 0) then
    Result := GetInexpensiveTarifVariantByTime(AdtMoment, AdtLength)
  else
    for i:=0 to variantscount-1 do
      if TarifVariants[i].id = AnWhole then
        Result := TarifVariants[i];
end;

// функция выдает тип пересечения с интервалом (startR)-(stopR)
function TTarifVariants.TypeIntersect(startR,stopR: TDateTime):integer;
var
  dayR: string;         // день интервала R (R - наш произвольный интервал длиной до 24 часов)
  timeStartR: TDateTime;// время старта R
  timeStopR: TDateTime; // время стопа R
  timeStartV: TDateTime;// время старта V (V - наш вариант-интервал длиной до 24 часов)
  timeStopV: TDateTime; // время стопа V
  bStartDayV: boolean;  // если есть такой день старта у V как R
  bStopDayV: boolean;   // если есть такой день стопа у V как R
begin
  TypeIntersect := INTERSECT_NOT;

  // получим день интервала R
  dayR := IntToStr(DayOfWeek(startR)-1);
  if (dayR='0') then dayR := '7';

  bStartDayV := (StrScan(PChar(daysofweek),dayR[1])<>nil);
  bStopDayV := (StrScan(PChar(GetDaysofweekStop),dayR[1])<>nil);

  timeStartR := TimeOf(startR);
  timeStopR := TimeOf(stopR);
  timeStartV := TimeOf(start);
  timeStopV := TimeOf(stop);
  if (timeStopV = 0) then timeStopV := 0.999999999;

  // случай INTERSECT_NOT
  if (not (bStartDayV or bStopDayV)) then begin
    TypeIntersect := INTERSECT_NOT;
    exit;
  end;

  // если начинается в другой день, то подправляем время старта
  if ((not bStartDayV) and bStopDayV) then timeStartV := EncodeTime(0,0,0,0);
  // если кончается в другой день, то подправляем время стопа
  if (bStartDayV and (not bStopDayV)) then timeStopV := EncodeTime(0,0,0,0);

  // первый случай (типа нормальный)
  if (timeStopV>timeStartV) then
  begin
    // INTERSECT_ALL
    if ((timeStartR>=timeStartV) and (timeStopR<=timeStopV)) then begin
      TypeIntersect := INTERSECT_ALL;
      exit;
    end;
    // INTERSECT_MIDDLE
    if ((timeStartR<timeStartV) and (timeStopR>timeStopV)) then begin
      TypeIntersect := INTERSECT_MIDDLE;
      exit;
    end;
    // INTERSECT_LEFT
    if ((timeStopR>timeStopV) and (timeStartR<timeStopV))then begin
      TypeIntersect := INTERSECT_LEFT;
      exit;
    end;
    // INTERSECT_RIGHT
    if ((timeStartR<timeStartV) and (timeStopR>timeStartV)) then begin
      TypeIntersect := INTERSECT_RIGHT;
      exit;
    end;
  end;

  // второй случай (типа ненормальный)
  if (timeStopV<timeStartV) then
  begin
    // INTERSECT_ALL
    if(
          ((timeStartR<timeStopV) and (timeStopR<=timeStopV)) or
          ((timeStartR>=timeStartV) and (timeStopR>timeStartV)) or
          ((timeStartR>=timeStopV) and (timeStopR<=timeStopV))
     ) then begin
      TypeIntersect := INTERSECT_ALL;
      exit;
    end;
    // INTERSECT_LEFTRIGHT
    if ((timeStopR>timeStartV) and (timeStartR<timeStopV)) then begin
      TypeIntersect := INTERSECT_LEFTRIGHT;
      exit;
    end;
    // INTERSECT_LEFT
    if (timeStartR<timeStopV)then begin
      TypeIntersect := INTERSECT_LEFT;
      exit;
    end;
    // INTERSECT_RIGHT
    if (timeStopR>timeStartV) then begin
      TypeIntersect := INTERSECT_RIGHT;
      exit;
    end;
  end;
end;

end.
