unit uParseAndReplase;

interface

//uses SysUtils;

function ParseAndReplase(Str:string):string;

implementation

uses SysUtils,uClientInfo, Math;

function ReplaceWordVariable(Variable:string):string;
var
  Tmp_var:string;
begin
  result := Variable;
  Tmp_var := UpperCase(Variable);
  if Tmp_var = '%NUMB%' then
      result := 'Спасибо что вспомнили про разработчика. numb.'
  else if Tmp_var = '%TIMESTART%' then
      DateTimeToString(result,'hh:mm',(GClientInfo.Start))
  else if Tmp_var = '%TIMESTARTH%' then
      DateTimeToString(result,'hh',(GClientInfo.Start))
  else if Tmp_var = '%TIMESTARTM%' then
      DateTimeToString(result,'mm',(GClientInfo.Start))
  else if Tmp_var = '%TIMESTARTS%' then
      DateTimeToString(result,'ss',(GClientInfo.Start))

  else if Tmp_var = '%TIMESTOP%' then
      DateTimeToString(result,'hh:mm',(GClientInfo.Stop))
  else if Tmp_var = '%TIMESTOPH%' then
      DateTimeToString(result,'hh',(GClientInfo.Stop))
  else if Tmp_var = '%TIMESTOPM%' then
      DateTimeToString(result,'mm',(GClientInfo.Stop))
  else if Tmp_var = '%TIMESTOPS%' then
      DateTimeToString(result,'ss',(GClientInfo.Stop))

  else if Tmp_var = '%TIMENOW%' then
      DateTimeToString(result,'hh:mm',(GClientInfo.NowTime))
  else if Tmp_var = '%TIMENOWH%' then
      DateTimeToString(result,'hh',(GClientInfo.NowTime))
  else if Tmp_var = '%TIMENOWM%' then
      DateTimeToString(result,'mm',(GClientInfo.NowTime))
  else if Tmp_var = '%TIMENOWS%' then
      DateTimeToString(result,'ss',(GClientInfo.NowTime))

  else if Tmp_var = '%TIMELEFT%' then
      DateTimeToString(result,'hh:mm',(GClientInfo.TimeLeft ))
  else if Tmp_var = '%TIMELEFTH%' then
      DateTimeToString(result,'hh',(GClientInfo.TimeLeft))
  else if Tmp_var = '%TIMELEFTM%' then
      DateTimeToString(result,'mm',(GClientInfo.TimeLeft))
  else if Tmp_var = '%TIMELEFTS%' then
      DateTimeToString(result,'ss',(GClientInfo.TimeLeft))

  // блокировка влючена
  else if Tmp_var = '%BLOCKED%' then
      result := IntToStr(IfThen(GClientInfo.Blocked,1,0))
  // имя клиента
  else if Tmp_var = '%LOGIN%' then
      result := GClientInfo.Login
  // состояние баланса
  else if Tmp_var = '%BALANCE%' then
      result := FloatToStr(GClientInfo.Balance)
  // состояние предела баланса
  else if Tmp_var = '%BALANCELIMIT%' then
      result := FloatToStr(GClientInfo.BalanceLimit)
  // оплаченные деньги сессии
  else if Tmp_var = '%SUM%' then
      result := FloatToStr(GClientInfo.Sum)
  // имя тарифа
  else if Tmp_var = '%TARIFNAME%' then
      result := GClientInfo.TarifName
  // отдельная плата за трафик
  else if Tmp_var = '%TRAFFICSEPARATEPAYMENT%' then
      result := IntToStr(IfThen(GClientInfo.TrafficSeparatePayment,1,0))
  // есть ли вообще интернет
  else if Tmp_var = '%INTERNET%' then
      result := IntToStr(IfThen(GClientInfo.Internet,1,0))
  // трафика доступно в КБ
  else if Tmp_var = '%INTERNETAVAILABLEINKB%' then
      result := FloatToStr(GClientInfo.InternetAvailableInKB)
  // трафика доступно в МБ
  else if Tmp_var = '%INTERNETAVAILABLEINMB%' then
      result := FloatToStr(GClientInfo.InternetAvailableInKB/1024)
  // трафика потрачено в КБ
  else if Tmp_var = '%INTERNETUSEDINKB%' then
      result := FloatToStr(GClientInfo.InternetUsedInKB)
  // трафика потрачено в МБ
  else if Tmp_var = '%INTERNETUSEDINMB%' then
      result := FloatToStr(GClientInfo.InternetUsedInKB/1024)
  // IP-адрес клиентской машины
  else if Tmp_var = '%IPADDRESS%' then
      result := GClientInfo.IPAddress;
end;

function ParseAndReplase(Str:string):string;
var
  Tmp_result:string;
  loc_str:string;
  DelimPos:integer;
  Word:String;
begin
  Tmp_result := '';
  loc_str := Str;
  DelimPos:= pos('%',loc_str);
  while DelimPos>0 do
  begin
    Tmp_result := Tmp_result + copy(loc_str,1,DelimPos-1);
    loc_str:= copy(loc_str,DelimPos,Length(loc_str)-DelimPos+1);
    DelimPos:= pos('%',copy(loc_str,2,Length(loc_str)-1))+1;
    Word := copy(loc_str,1,DelimPos);
    Word := ReplaceWordVariable(Word);
    Tmp_result := Tmp_result + Word;
    loc_str:= copy(loc_str,DelimPos+1,Length(loc_str)-DelimPos);
    DelimPos:= pos('%',loc_str);
  end;
  Tmp_result := Tmp_result + loc_str;
  Result := Tmp_result;
end;

end.
