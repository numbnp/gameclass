unit uIPList;

interface

uses Classes;

type
  TIPInformation = class(TCollectionItem)  //информация об ip-адресе
  private
    FstrIP            : String;   //ip-адрес
    FstrName          : String;   //клиентское имя
    FstrExtraInfo   : String;   //клиентский GUID в TI, INI-строка в UG 2.8
    FstrGroup         : String;   //группа (пока только для TI и UG)
    FstrTarif         : String;   //название тарифа
    FstrServerIP      : String;   //Адрес сервера (нужен для двух и более серверов)
    FbEnabled       : Boolean;  //флаг разрешения к работе
    FnTotalBytesReceived  : Cardinal; //кол-во принятых байт
    FnTotalBytesSent      : Cardinal; //кол-во переданных байт
    FnCurrentBytesReceived  : Cardinal; //кол-во принятых байт
    FnCurrentBytesSent      : Cardinal; //кол-во переданных байт
    FnSpeedLimit    : Cardinal; //скорость в байтах в секунду, 0 - unlimited
    FnTrafficLimit  : Cardinal; //ограничение трафика, 0 - unlimited
  public
    constructor Create(Collection: TCollection); override;

    procedure Enable; //разрешить редирект для ip
    procedure Disable; //запретить редирект для ip
    procedure SetReceived(AnCount: Cardinal); //прибавить вх.трафик
    procedure SetSent(AnCount: Cardinal); //прибавить исх.трафик
    function UnloadReceived: Cardinal; //считать тек. вх.трафик и сбросить его
    function UnloadSent: Cardinal; //считать исх.трафик и сбросить его в ноль

    property IP: String
        read FstrIP write FstrIP;
    property Name: String
        read FstrName write FstrName;
    property ExtraInfo: String
        read FstrExtraInfo write FstrExtraInfo;
    property Group: String
        read FstrGroup write FstrGroup;
    property Tarif: String
        read FstrTarif write FstrTarif;
    property ServerIP: String
        read FstrServerIP write FstrServerIP;
    property Enabled: Boolean
        read FbEnabled write FbEnabled;
    property TotalBytesReceived: Cardinal
        read FnTotalBytesReceived write FnTotalBytesReceived;
    property TotalBytesSent: Cardinal
        read FnTotalBytesSent write FnTotalBytesSent;
    property CurrentBytesReceived: Cardinal
        read FnCurrentBytesReceived write FnCurrentBytesSent;
    property CurrentBytesSent: Cardinal
        read FnCurrentBytesSent write FnCurrentBytesSent;
    property SpeedLimit: Cardinal
        read FnSpeedLimit write FnSpeedLimit;
    property TrafficLimit: Cardinal
        read FnTrafficLimit write FnTrafficLimit;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  TIPInformations = class(TCollection) //класс, список информации об ip-адресах
  public
  //конструктор/деструктор
    constructor Create;
    destructor Destroy; override;
  //интерфейс класса
    //вернуть индекс по адресу
    function Index(const AstrIP: String):integer;
    //добавить новую запись или не добавить если есть
    function Add(const AstrIP: String): TIPInformation;
    function GetItem(const AnIndex: Integer): TIPInformation;
    function GetItemByIP(const AstrIP: String): TIPInformation;
    function GetSerializedList: String;
    procedure SetSerializedList(AstrList: String);

  //пропертя
    property Items[const AnIndex: Integer]: TIPInformation
        read GetItem; default;
    property ItemsByIP[const AstrIP: String]: TIPInformation
        read GetItemByIP;
    property SerializedList: String
        read GetSerializedList write SetSerializedList ;
  end;

implementation
uses
  uY2KString,
  StrUtils;

const
  PARAMETER_DIVIDER_SYMBOL = '|';
  ITEM_DIVIDER_SYMBOL = '&';
///////////////////////////////////////////////////////////////////////////////
//                              TIPInformation
////////////////////////////////////////////////////////////////////////////////
constructor TIPInformation.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FstrIP := '';
  FstrName := '';
  FstrExtraInfo := '';
  FstrGroup := '';
  FstrTarif := '';
  FstrServerIP := '';
  FbEnabled := False;
  FnTotalBytesReceived := 0;
  FnTotalBytesSent := 0;
  FnCurrentBytesReceived := 0;
  FnCurrentBytesSent := 0;
  FnSpeedLimit := 0;
  FnTrafficLimit := 0;
end;

procedure TIPInformation.Enable;
begin
  Enabled := True;
end;

procedure TIPInformation.Disable;
begin
  Enabled := False;
end;

procedure TIPInformation.SetReceived(AnCount: Cardinal);
begin
  if (FnTotalBytesReceived <= AnCount) then begin
    FnCurrentBytesReceived := FnCurrentBytesReceived + AnCount - FnTotalBytesReceived;
    FnTotalBytesReceived := AnCount;
  end
  else begin
    FnCurrentBytesReceived := AnCount;
    FnTotalBytesReceived := AnCount;
  end;
end;

procedure TIPInformation.SetSent(AnCount: Cardinal);
begin
  if (FnTotalBytesSent <= AnCount) then begin//подозреваю что при стопе TI будет сбрасывать счетчик
    FnCurrentBytesSent := FnCurrentBytesSent + AnCount - FnTotalBytesSent;
    FnTotalBytesSent := AnCount;
  end
  else begin
    FnCurrentBytesSent := AnCount;
    FnTotalBytesSent := AnCount;
  end;
end;

function TIPInformation.UnloadReceived: Cardinal;
begin
  Result := FnCurrentBytesReceived;
  FnTotalBytesReceived := 0;
end;

function TIPInformation.UnloadSent: Cardinal;
begin
  Result := FnCurrentBytesSent;
  FnTotalBytesSent := 0;
end;

///////////////////////////////////////////////////////////////////////////////
//                              TIPInformations
////////////////////////////////////////////////////////////////////////////////

constructor TIPInformations.Create;
begin
   inherited Create(TIPInformation);
end;

destructor TIPInformations.Destroy;
begin
   Clear;
   inherited Destroy;
end;

function TIPInformations.Index(const AstrIP: String):integer;
var
   i : Integer;
begin
   Result := -1;
   for i := 0 to Count-1 do
      if Items[i].IP = AstrIP then
         Result := i;
end;

function TIPInformations.Add(const AstrIP: String): TIPInformation;
var
  i : Integer;
  IPInformation : TIPInformation;
begin
  i := Index(AstrIP);
  if i=-1 then begin
    IPInformation := TIPInformation(inherited Add);
    with IPInformation do begin
      IP := AstrIP;
      Name := AstrIP;
    end;
    Result := IPInformation;
  end else
    Result := TIPInformation(inherited Items[i]);
end;

function TIPInformations.GetItem(const AnIndex: Integer): TIPInformation;
begin
  Result := TIPInformation(inherited Items[AnIndex]);
end;

function TIPInformations.GetItemByIP(const AstrIP: String): TIPInformation;
begin
  Result := Add(AstrIP);
end;

function TIPInformations.GetSerializedList: String;
var
  strList: String;
  i: Integer;
begin
  for i:=0 to Count do
    with GetItem(i) do
      strList := strList + IP + PARAMETER_DIVIDER_SYMBOL + Name
         + PARAMETER_DIVIDER_SYMBOL + ExtraInfo + ITEM_DIVIDER_SYMBOL;
  System.Delete(strList, Length(strList)-1, 1);
  Result := strList;
end;

procedure TIPInformations.SetSerializedList(AstrList: String);
var
  str: String;
  i, nCount: Integer;
begin
  Clear;
  nCount := GetParamCountFromString(AstrList, ITEM_DIVIDER_SYMBOL);
  for i := 0 to nCount - 1 do begin
    str := GetParamFromString(AstrList, i, ITEM_DIVIDER_SYMBOL);
    with Add(GetParamFromString(str, 0, PARAMETER_DIVIDER_SYMBOL)) do begin
      Name := GetParamFromString(str, 1, PARAMETER_DIVIDER_SYMBOL);
      ExtraInfo := GetParamFromString(str, 2, PARAMETER_DIVIDER_SYMBOL);
    end;
  end;
end;

end.
