unit uIPInfo;

interface

uses SysUtils, Classes;

type

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
   BooleanPtr = ^Boolean;

   TIPInfo = record   //запись, информация об ip-адресе
      Addr     : String;   //ip-адрес
      Name     : String;   //клиентское имя в TI
      GUID     : String;   //клиентский GUID в TI
      Enabled  : Boolean;  //флаг разрешения к редиректу
      TotalBytesReceived  : Cardinal; //кол-во принятых байт
      TotalBytesSent      : Cardinal; //кол-во переданных байт
      CurrentBytesReceived  : Cardinal; //кол-во принятых байт
      CurrentBytesSent      : Cardinal; //кол-во переданных байт
      TrafficSpeed   : Cardinal; //скорость в байтах в секунду, 0 - unlimited
      TarifName  : String; //название тарифа
      IPServer   : String; //Адрес сервера (нужен для двух и более серверов)
      GroupName  : String; //имя группы

   end;
   TIPInfoPtr = ^TIPInfo;//тип указателя на информацию об ip-адресе

   TGUIDString = array [1..40] of Char;
   TGUIDStringPtr = ^TGUIDString;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
   TIPInfoList = class  //класс, список информации об ip-адресах
   public
   //паблик вэриэйблс
      FList : array of TIPInfo; //массив записей TIPInfo
   //конструктор/деструктор
      constructor Create;
      destructor Destroy; override;
  //интерфейс класса
      function Index(Addr:string):integer; //вернуть индекс по адресу
      procedure Clear;  //стереть все нахрен
      function Add(Addr:string; AstrIPServer: String):TIPInfoPtr;  //добавить новую запись
                                             //и вернуть на нее ptr
      function Get(Addr:string):TIPInfoPtr; //вернуть ptr записи по адресу
      function Enabled(Addr:string):Boolean; //разрешен редирект ?
      procedure Enable(Addr:string); //разрешить редирект для ip
      procedure Disable(Addr:string); //запретить редирект для ip
      procedure SetReceived(Addr:string;Count:Cardinal); //прибавить вх.трафик
      procedure SetSent(Addr:string;Count:Cardinal); //прибавить исх.трафик
      procedure Reset(Addr:string); //сбросить трафик в 0
      procedure SetTrafficSpeed(Addr:string; Speed:Cardinal); //Установить скорость
      procedure SetTarifName(Addr:string;TarifName:string); //установить название тарифа
      procedure SetGroupName(const AstrAddress: String;
          AstrGroupName: String); //Установить имя группы
   end;
   TIPInfoListPtr = ^TIPInfoList;//тип указателя на список ip-адресов


////////////////////////////////////////////////////////////////////////////////
//                              implementation
////////////////////////////////////////////////////////////////////////////////
implementation

////////////////////////////////////////////////////////////////////////////////
//                              TIPInfoList
////////////////////////////////////////////////////////////////////////////////

constructor TIPInfoList.Create;
begin
   inherited Create;
   SetLength(FList,0);
end;

destructor TIPInfoList.Destroy;
begin
   Clear;
   inherited Destroy;
end;

function TIPInfoList.Index(Addr:string):integer;
var
   i : Integer;
begin
   Result := -1;
   for i := Low(FList) to High(FList) do
      if Flist[i].Addr = Addr then
         Result := i;
   if Result=-1 then begin
      i := High(FList)+1;
      SetLength(FList,i-Low(FList)+1);
      FList[i].Addr := Addr;
      FList[i].Name := '';
      FList[i].GUID := '';
      FList[i].Enabled := false;
      FList[i].TotalBytesReceived := 0;
      FList[i].TotalBytesSent := 0;
      FList[i].CurrentBytesReceived := 0;
      FList[i].CurrentBytesSent := 0;
      FList[i].TrafficSpeed := 0;
      FList[i].TarifName := '';
      FList[i].GroupName := '';
      Result := i;
   end;
end;

procedure TIPInfoList.Clear;
begin
   SetLength(FList,0);
end;

function TIPInfoList.Add(Addr:string; AstrIPServer: String):TIPInfoPtr;
var
   i : Integer;
begin
   i := Index(Addr);
   FList[i].IPServer := AstrIPServer;
   Result:=@FList[i];
end;

function TIPInfoList.Get(Addr:string):TIPInfoPtr;
var
   n:integer;
begin
   n:=Index(Addr);
   if n =-1 then
      Result := Nil
   else
      Result:=@FList[n];
end;

function TIPInfoList.Enabled(Addr:string):Boolean;
var
   n:integer;
begin
   Result := False;
   n:=Index(Addr);
   if n <> -1 then
      if FList[n].Enabled then
         Result := True;
end;

procedure TIPInfoList.Enable(Addr:string);
var
   n:integer;
begin
   n:=Index(Addr);
   if n <> -1 then
      FList[n].Enabled := True;
end;

procedure TIPInfoList.Disable(Addr:string);
var
   n:integer;
begin
   n:=Index(Addr);
   if n <> -1 then
      FList[n].Enabled := False;
end;

procedure TIPInfoList.SetReceived(Addr:string;Count:Cardinal);
var
   n:integer;
begin
   n:=Index(Addr);
   if n <> -1 then begin
      if (FList[n].TotalBytesReceived <= Count) then begin//подозреваю что при стопе TI будет сбрасывать счетчик
        FList[n].CurrentBytesReceived := FList[n].CurrentBytesReceived + Count - FList[n].TotalBytesReceived;
        FList[n].TotalBytesReceived := Count;
      end
      else begin
        FList[n].CurrentBytesReceived := Count;
        FList[n].TotalBytesReceived := Count;
      end;
   end;
end;

procedure TIPInfoList.SetSent(Addr:string;Count:Cardinal);
var
   n:integer;
begin
   n:=Index(Addr);
   if n <> -1 then begin
      if (FList[n].TotalBytesSent <= Count) then begin//подозреваю что при стопе TI будет сбрасывать счетчик
        FList[n].CurrentBytesSent := FList[n].CurrentBytesSent + Count - FList[n].TotalBytesSent;
        FList[n].TotalBytesSent := Count;
      end
      else begin
        FList[n].CurrentBytesSent := Count;
        FList[n].TotalBytesSent := Count;
      end;
   end;
end;

procedure TIPInfoList.Reset(Addr:string);
var
   n:integer;
begin
   n:=Index(Addr);
   if n <> -1 then begin
      FList[n].TotalBytesSent := 0;
      FList[n].TotalBytesReceived := 0;
      FList[n].CurrentBytesSent := 0;
      FList[n].CurrentBytesReceived := 0;
   end;
end;

procedure TIPInfoList.SetTrafficSpeed(Addr:string;Speed:Cardinal);
var
   n:integer;
begin
   n:=Index(Addr);
   if n <> -1 then
      FList[n].TrafficSpeed := Speed;
end;

procedure TIPInfoList.SetTarifName(Addr:string;TarifName:string); //установить название тарифа
var
   n:integer;
begin
   n:=Index(Addr);
   if n <> -1 then
      FList[n].TarifName := TarifName;
end;

procedure TIPInfoList.SetGroupName(const AstrAddress: String;
    AstrGroupName: String); //Установить имя группы
var
   n:integer;
begin
   n := Index(AstrAddress);
   if n <> -1 then
      FList[n].GroupName  := AstrGroupName;
end;

end.
