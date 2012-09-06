unit uRegistryOptions;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryOptions = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;

    function LocateAddMoneyMaximum: Boolean;
    function GetAddMoneyMaximum: Double;
    procedure SetAddMoneyMaximum(AValue: Double);
    function LocateAddMoneyMinimum: Boolean;
    function GetAddMoneyMinimum: Double;
    procedure SetAddMoneyMinimum(AValue: Double);
    function LocateStartMoneyMaximum: Boolean;
    function GetStartMoneyMaximum: Double;
    procedure SetStartMoneyMaximum(AValue: Double);
    function LocateStartMoneyMinimum: Boolean;
    function GetStartMoneyMinimum: Double;
    procedure SetStartMoneyMinimum(AValue: Double);
    function LocateClubName: Boolean;
    function GetClubName: String;
    procedure SetClubName(AValue: String);
    function LocateCurrency: Boolean;
    function GetCurrency: String;
    procedure SetCurrency(AValue: String);
    function LocateMaximumTrustPostPay: Boolean;
    function GetMaximumTrustPostPay: Double;
    procedure SetMaximumTrustPostPay(AValue: Double);
    function LocatePostPayMode: Boolean;
    function GetPostPayMode: Boolean;
    procedure SetPostPayMode(AValue: Boolean);
    function LocateOnlyPrePayMode: Boolean;
    function GetOnlyPrePayMode: Boolean;
    procedure SetOnlyPrePayMode(AValue: Boolean);
    function LocateEnableChangeForPackets: Boolean;
    function GetEnableChangeForPackets: Boolean;
    procedure SetEnableChangeForPackets(AValue: Boolean);
    function LocateDisableChange: Boolean;
    function GetDisableChange: Boolean;
    procedure SetDisableChange(AValue: Boolean);
    function LocatePrintedPageCost: Boolean;
    function GetPrintedPageCost: Double;
    procedure SetPrintedPageCost(AValue: Double);
    function LocateUnixServerIP: Boolean;
    function GetUnixServerIP: String;
    procedure SetUnixServerIP(AValue: String);
    function LocateUnixServerQueryTime: Boolean;
    function GetUnixServerQueryTime: Integer;
    procedure SetUnixServerQueryTime(AValue: Integer);
    function LocateMinutsForLongRepair: Boolean;
    function GetMinutsForLongRepair: Integer;
    procedure SetMinutsForLongRepair(AValue: Integer);
    function LocateEnableInternetRemont: Boolean;
    function GetEnableInternetRemont: Boolean;
    procedure SetEnableInternetRemont(AValue: Boolean);
    function LocateReserveDisable: Boolean;
    function GetReserveDisable: Boolean;
    procedure SetReserveDisable(AValue: Boolean);
    function LocateReserveAutoActivate: Boolean;
    function GetReserveAutoActivate: Boolean;
    procedure SetReserveAutoActivate(AValue: Boolean);
    function LocateClientQueryTime: Boolean;
    function GetClientQueryTime: Integer;
    procedure SetClientQueryTime(AValue: Integer);
    function LocateServiceByPrepay: Boolean;
    function GetServiceByPrepay: Boolean;
    procedure SetServiceByPrepay(AValue: Boolean);
    function LocateServiceByPostpay: Boolean;
    function GetServiceByPostpay: Boolean;
    procedure SetServiceByPostpay(AValue: Boolean);
    function LocateServiceNoClose: Boolean;
    function GetServiceNoClose: Boolean;
    procedure SetServiceNoClose(AValue: Boolean);
    function LocateOperatorIP: Boolean;
    function GetOperatorIP: String;
    procedure SetOperatorIP(AValue: String);
    function LocateOperatorPrinterControl: Boolean;
    function GetOperatorPrinterControl: Boolean;
    procedure SetOperatorPrinterControl(AValue: Boolean);
    function LocateOperatorTrafficControl: Boolean;
    function GetOperatorTrafficControl: Boolean;
    procedure SetOperatorTrafficControl(AValue: Boolean);
    function LocateOperatorTrafficInbound: Boolean;
    function GetOperatorTrafficInbound: Cardinal;
    procedure SetOperatorTrafficInbound(AValue: Cardinal);
    function LocateOperatorTrafficOutbound: Boolean;
    function GetOperatorTrafficOutbound: Cardinal;
    procedure SetOperatorTrafficOutbound(AValue: Cardinal);
    function LocateRemovedMoney: Boolean;
    function GetRemovedMoney: Double;
    procedure SetRemovedMoney(AValue: Double);
    function LocateInstallPath: Boolean;
    function GetInstallPath: String;
    procedure SetInstallPath(AValue: String);
    function LocateAutoInstall: Boolean;
    function GetAutoInstall: Boolean;
    procedure SetAutoInstall(AValue: Boolean);
    function LocateEnableChangeForReserveCancel: Boolean;
    function GetEnableChangeForReserveCancel: Boolean;
    procedure SetEnableChangeForReserveCancel(AValue: Boolean);
    function LocateEnableChangeForSeparateTraffic: Boolean;
    function GetEnableChangeForSeparateTraffic: Boolean;
    procedure SetEnableChangeForSeparateTraffic(AValue: Boolean);
    function LocateOperatingTime: Boolean;
    function GetOperatingTime: Boolean;
    procedure SetOperatingTime(AValue: Boolean);
    function LocateOperatingTimeBegin: Boolean;
    function GetOperatingTimeBegin: Double;
    procedure SetOperatingTimeBegin(AValue: Double);
    function LocateOperatingTimeEnd: Boolean;
    function GetOperatingTimeEnd: Double;
    procedure SetOperatingTimeEnd(AValue: Double);
    function LocateDebugLog: Boolean;
    function GetDebugLog: Boolean;
    procedure SetDebugLog(AValue: Boolean);

    //by numb
    function LocateAutoSelectDefaultTarif: Boolean;
    function GetAutoSelectDefaultTarif: Boolean;
    procedure SetAutoSelectDefaultTarif(AValue: Boolean);

    function LocateWriteProcessList: Boolean;
    function GetWriteProcessList: Boolean;
    procedure SetWriteProcessList(AValue: Boolean);

    function LocateWriteUnControlComp: Boolean;
    function GetWriteUnControlComp: Boolean;
    procedure SetWriteUnControlComp(AValue: Boolean);

    function LocateWriteUnControlClub: Boolean;
    function GetWriteUnControlClub: Boolean;
    procedure SetWriteUnControlClub(AValue: Boolean);
    function LocateSendReportAfterClozeChange: Boolean;
    function GetSendReportAfterClozeChange: Boolean;
    procedure SetSendReportAfterClozeChange(AValue: Boolean);

    function LocateMinIntervalBetvenReserved: Boolean;
    function GetMinIntervalBetvenReserved: Integer;
    procedure SetMinIntervalBetvenReserved(AValue: Integer);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property AddMoneyMaximum : Double
        read GetAddMoneyMaximum write SetAddMoneyMaximum;
    property AddMoneyMinimum : Double
        read GetAddMoneyMinimum write SetAddMoneyMinimum;
    property StartMoneyMinimum : Double
        read GetStartMoneyMinimum write SetStartMoneyMinimum;
    property StartMoneyMaximum : Double
        read GetStartMoneyMaximum write SetStartMoneyMaximum;
    property ClubName : String
        read GetClubName write SetClubName;
    property Currency : String
        read GetCurrency write SetCurrency;
    property MaximumTrustPostPay : Double
        read GetMaximumTrustPostPay write SetMaximumTrustPostPay;
    property PostPayMode : Boolean
        read GetPostPayMode write SetPostPayMode;
    property OnlyPrePayMode : Boolean
        read GetOnlyPrePayMode write SetOnlyPrePayMode;
    property EnableChangeForPackets: Boolean
        read GetEnableChangeForPackets write SetEnableChangeForPackets;
    property DisableChange: Boolean
        read GetDisableChange write SetDisableChange;
    property PrintedPageCost : Double
        read GetPrintedPageCost write SetPrintedPageCost;
    property UnixServerIP : String
        read GetUnixServerIP write SetUnixServerIP;
    property UnixServerQueryTime : Integer
        read GetUnixServerQueryTime write SetUnixServerQueryTime;
    property MinutsForLongRepair: Integer // кол-во минут для тарифа "ремонт надолго"
        read GetMinutsForLongRepair write SetMinutsForLongRepair;
    property EnableInternetRemont: Boolean
        read GetEnableInternetRemont write SetEnableInternetRemont;
    property ReserveDisable: Boolean
        read GetReserveDisable write SetReserveDisable;
    property ReserveAutoActivate: Boolean
        read GetReserveAutoActivate write SetReserveAutoActivate;
    property ClientQueryTime : Integer
        read GetClientQueryTime write SetClientQueryTime;
    property ServiceByPrepay: Boolean
        read GetServiceByPrepay write SetServiceByPrepay;
    property ServiceByPostpay: Boolean
        read GetServiceByPostpay write SetServiceByPostpay;
    property ServiceNoClose: Boolean
        read GetServiceNoClose write SetServiceNoClose;
    property OperatorIP : String
        read GetOperatorIP write SetOperatorIP;
    property OperatorPrinterControl: Boolean
        read GetOperatorPrinterControl write SetOperatorPrinterControl;
    property OperatorTrafficControl: Boolean
        read GetOperatorTrafficControl write SetOperatorTrafficControl;
    property OperatorTrafficInbound: Cardinal
        read GetOperatorTrafficInbound write SetOperatorTrafficInbound;
    property OperatorTrafficOutbound: Cardinal
        read GetOperatorTrafficOutbound write SetOperatorTrafficOutbound;
    property RemovedMoney : Double
        read GetRemovedMoney write SetRemovedMoney;
    property InstallPath: String
        read GetInstallPath write SetInstallPath;
    property AutoInstall: Boolean
        read GetAutoInstall write SetAutoInstall;
    property EnableChangeForReserveCancel: Boolean
        read GetEnableChangeForReserveCancel
        write SetEnableChangeForReserveCancel;
    property EnableChangeForSeparateTraffic: Boolean
        read GetEnableChangeForSeparateTraffic
        write SetEnableChangeForSeparateTraffic;
    property OperatingTime : Boolean
        read GetOperatingTime write SetOperatingTime;
    property OperatingTimeBegin : Double
        read GetOperatingTimeBegin write SetOperatingTimeBegin;
    property OperatingTimeEnd : Double
        read GetOperatingTimeEnd write SetOperatingTimeEnd;
    property DebugLog : Boolean
        read GetDebugLog write SetDebugLog;
// By numb
    property AutoSelectDefaultTarif : Boolean
        read GetAutoSelectDefaultTarif write SetAutoSelectDefaultTarif;
    property WriteProcessList : Boolean
        read GetWriteProcessList write SetWriteProcessList;
    property WriteUnControlComp : Boolean
        read GetWriteUnControlComp write SetWriteUnControlComp;
    property WriteUnControlClub : Boolean
        read GetWriteUnControlClub write SetWriteUnControlClub;
    property SendReportAfterClozeChange : Boolean
        read GetSendReportAfterClozeChange write SetSendReportAfterClozeChange;

    property MinIntervalBetvenReserved : integer
        read GetMinIntervalBetvenReserved write SetMinIntervalBetvenReserved;

  end;

implementation

uses
  SysUtils,
  DB, uGCDataSet;

{*******************************************************************************
                      class  TRegistryOptions
*******************************************************************************}
constructor TRegistryOptions.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryOptions.Destroy;
begin
  inherited Destroy;
end;

function TRegistryOptions.LocateAddMoneyMaximum: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AddMoneyMaximum', '100');
end;

function TRegistryOptions.GetAddMoneyMaximum: Double;
begin
  LocateAddMoneyMaximum;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetAddMoneyMaximum(AValue: Double);
begin
  LocateAddMoneyMaximum;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocateAddMoneyMinimum: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AddMoneyMinimum', '1');
end;

function TRegistryOptions.GetAddMoneyMinimum: Double;
begin
  LocateAddMoneyMinimum;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetAddMoneyMinimum(AValue: Double);
begin
  LocateAddMoneyMinimum;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocateStartMoneyMaximum: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('StartMoneyMaximum', '200');
end;

function TRegistryOptions.GetStartMoneyMaximum: Double;
begin
  LocateStartMoneyMaximum;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetStartMoneyMaximum(AValue: Double);
begin
  LocateStartMoneyMaximum;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocateStartMoneyMinimum: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('StartMoneyMinimum', '5');
end;

function TRegistryOptions.GetStartMoneyMinimum: Double;
begin
  LocateStartMoneyMinimum;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetStartMoneyMinimum(AValue: Double);
begin
  LocateStartMoneyMinimum;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocateClubName: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ClubName', 'Your Computers Club');
end;

function TRegistryOptions.GetClubName: String;
begin
  LocateClubName;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryOptions.SetClubName(AValue: String);
begin
  LocateClubName;
  FRegistryRecord.Value := AValue;
end;

function TRegistryOptions.LocateCurrency: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('Currency', '$');
end;

function TRegistryOptions.GetCurrency: String;
begin
  LocateCurrency;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryOptions.SetCurrency(AValue: String);
begin
  LocateCurrency;
  FRegistryRecord.Value := AValue;
end;

function TRegistryOptions.LocateMaximumTrustPostPay: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('MaximumTrustPostPay', '200');
end;

function TRegistryOptions.GetMaximumTrustPostPay: Double;
begin
  LocateMaximumTrustPostPay;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetMaximumTrustPostPay(AValue: Double);
begin
  LocateMaximumTrustPostPay;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocatePostPayMode: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('PostPayMode', '0');
end;

function TRegistryOptions.GetPostPayMode: Boolean;
var
  bOnlyPrePayMode: Boolean;
begin
  bOnlyPrePayMode := GetOnlyPrePayMode;
  LocatePostPayMode;
  Result := FRegistryRecord.ValueAsBoolean and not bOnlyPrePayMode;
end;

procedure TRegistryOptions.SetPostPayMode(AValue: Boolean);
begin
  LocatePostPayMode;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateOnlyPrePayMode: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OnlyPrePayMode', '0');
end;

function TRegistryOptions.GetOnlyPrePayMode: Boolean;
begin
  LocateOnlyPrePayMode;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetOnlyPrePayMode(AValue: Boolean);
begin
  LocateOnlyPrePayMode;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateEnableChangeForPackets: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('EnableChangeForPackets', '0');
end;

function TRegistryOptions.GetEnableChangeForPackets: Boolean;
begin
  LocateEnableChangeForPackets;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetEnableChangeForPackets(AValue: Boolean);
begin
  LocateEnableChangeForPackets;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateDisableChange: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('DisableChange', '0');
end;

function TRegistryOptions.GetDisableChange: Boolean;
begin
  LocateDisableChange;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetDisableChange(AValue: Boolean);
begin
  LocateDisableChange;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocatePrintedPageCost: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('printers\DefaultPrinter', '3');
end;

function TRegistryOptions.GetPrintedPageCost: Double;
begin
  LocatePrintedPageCost;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetPrintedPageCost(AValue: Double);
begin
  LocatePrintedPageCost;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocateUnixServerIP: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('UnixServerIP', '127.0.0.1');
end;

function TRegistryOptions.GetUnixServerIP: String;
begin
  LocateUnixServerIP;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryOptions.SetUnixServerIP(AValue: String);
begin
  LocateUnixServerIP;
  FRegistryRecord.Value := AValue;
end;

function TRegistryOptions.LocateUnixServerQueryTime: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('UnixServerQueryTime', '5');
end;

function TRegistryOptions.GetUnixServerQueryTime: Integer;
begin
  LocateUnixServerQueryTime;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryOptions.SetUnixServerQueryTime(AValue: Integer);
begin
  LocateUnixServerQueryTime;
  FRegistryRecord.ValueAsInteger := AValue;
end;

function TRegistryOptions.LocateMinutsForLongRepair: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('MinutsForLongRepair', '360');
end;

function TRegistryOptions.GetMinutsForLongRepair: Integer;
begin
  LocateMinutsForLongRepair;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryOptions.SetMinutsForLongRepair(AValue: Integer);
begin
  LocateMinutsForLongRepair;
  FRegistryRecord.ValueAsInteger := AValue;
end;


function TRegistryOptions.LocateEnableInternetRemont: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('EnableInternetRemont', '0');
end;

function TRegistryOptions.GetEnableInternetRemont: Boolean;
begin
  LocateEnableInternetRemont;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetEnableInternetRemont(AValue: Boolean);
begin
  LocateEnableInternetRemont;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateReserveDisable: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ReserveDisable', '0');
end;

function TRegistryOptions.GetReserveDisable: Boolean;
begin
  LocateReserveDisable;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetReserveDisable(AValue: Boolean);
begin
  LocateReserveDisable;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateReserveAutoActivate: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ReserveAutoActivate', '0');
end;

function TRegistryOptions.GetReserveAutoActivate: Boolean;
begin
  LocateReserveAutoActivate;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetReserveAutoActivate(AValue: Boolean);
begin
  LocateReserveAutoActivate;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateClientQueryTime: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ClientQueryTime', '5');
end;

function TRegistryOptions.GetClientQueryTime: Integer;
begin
  LocateClientQueryTime;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryOptions.SetClientQueryTime(AValue: Integer);
begin
  LocateClientQueryTime;
  FRegistryRecord.ValueAsInteger := AValue;
end;

function TRegistryOptions.LocateServiceByPrepay: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ServiceByPrepay', '0');
end;

function TRegistryOptions.GetServiceByPrepay: Boolean;
begin
  LocateServiceByPrepay;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetServiceByPrepay(AValue: Boolean);
begin
  LocateServiceByPrepay;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateServiceByPostpay: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ServiceByPostpay', '0');
end;

function TRegistryOptions.GetServiceByPostpay: Boolean;
begin
  LocateServiceByPostpay;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetServiceByPostpay(AValue: Boolean);
begin
  LocateServiceByPostpay;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateServiceNoClose: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ServiceNoClose', '0');
end;

function TRegistryOptions.GetServiceNoClose: Boolean;
begin
  LocateServiceNoClose;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetServiceNoClose(AValue: Boolean);
begin
  LocateServiceNoClose;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateOperatorIP: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OperatorIP', '192.168.0.254');
end;

function TRegistryOptions.GetOperatorIP: String;
begin
  LocateOperatorIP;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryOptions.SetOperatorIP(AValue: String);
begin
  LocateOperatorIP;
  FRegistryRecord.Value := AValue;
end;

function TRegistryOptions.LocateOperatorPrinterControl: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OperatorPrinterControl', '0');
end;

function TRegistryOptions.GetOperatorPrinterControl: Boolean;
begin
  LocateOperatorPrinterControl;
  Result := FRegistryRecord.ValueAsBoolean;
    //and GRegistry.Modules.Printer.Active;
end;

procedure TRegistryOptions.SetOperatorPrinterControl(AValue: Boolean);
begin
  LocateOperatorPrinterControl;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateOperatorTrafficControl: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OperatorTrafficControl', '0');
end;

function TRegistryOptions.GetOperatorTrafficControl: Boolean;
begin
  LocateOperatorTrafficControl;
  Result := FRegistryRecord.ValueAsBoolean;
//      and GRegistry.Modules.Internet.SummaryAccounting;
end;

procedure TRegistryOptions.SetOperatorTrafficControl(AValue: Boolean);
begin
  LocateOperatorTrafficControl;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateOperatorTrafficInbound: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OperatorTrafficInbound', '0');
end;

function TRegistryOptions.GetOperatorTrafficInbound: Cardinal;
begin
  LocateOperatorTrafficInbound;
  Result := FRegistryRecord.ValueAsInt64;
end;

procedure TRegistryOptions.SetOperatorTrafficInbound(AValue: Cardinal);
begin
  LocateOperatorTrafficInbound;
  FRegistryRecord.ValueAsInt64 := AValue;
end;

function TRegistryOptions.LocateOperatorTrafficOutbound: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OperatorTrafficOutbound', '0');
end;

function TRegistryOptions.GetOperatorTrafficOutbound: Cardinal;
begin
  LocateOperatorTrafficOutbound;
  Result := FRegistryRecord.ValueAsInt64;
end;

procedure TRegistryOptions.SetOperatorTrafficOutbound(AValue: Cardinal);
begin
  LocateOperatorTrafficOutbound;
  FRegistryRecord.ValueAsInt64 := AValue;
end;

function TRegistryOptions.LocateRemovedMoney: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('RemovedMoney', '0');
end;

function TRegistryOptions.GetRemovedMoney: Double;
begin
  LocateRemovedMoney;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetRemovedMoney(AValue: Double);
begin
  LocateRemovedMoney;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocateInstallPath: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('InstallPath', '');
end;

function TRegistryOptions.GetInstallPath: String;
begin
  LocateInstallPath;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryOptions.SetInstallPath(AValue: String);
begin
  LocateInstallPath;
  FRegistryRecord.Value := AValue;
end;

function TRegistryOptions.LocateAutoInstall: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AutoInstall', '0');
end;

function TRegistryOptions.GetAutoInstall: Boolean;
begin
  LocateAutoInstall;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetAutoInstall(AValue: Boolean);
begin
  LocateAutoInstall;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateEnableChangeForReserveCancel: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('EnableChangeForReserveCancel', '-1');
end;

function TRegistryOptions.GetEnableChangeForReserveCancel: Boolean;
begin
  LocateEnableChangeForReserveCancel;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetEnableChangeForReserveCancel(AValue: Boolean);
begin
  LocateEnableChangeForReserveCancel;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateEnableChangeForSeparateTraffic: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('EnableChangeForSeparateTraffic', '0');
end;

function TRegistryOptions.GetEnableChangeForSeparateTraffic: Boolean;
begin
  LocateEnableChangeForSeparateTraffic;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetEnableChangeForSeparateTraffic(AValue: Boolean);
begin
  LocateEnableChangeForSeparateTraffic;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateOperatingTimeBegin: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OperatingTimeBegin', '0');
end;

function TRegistryOptions.GetOperatingTimeBegin: Double;
begin
  LocateOperatingTimeBegin;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetOperatingTimeBegin(AValue: Double);
begin
  LocateOperatingTimeBegin;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocateOperatingTimeEnd: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OperatingTimeEnd', '0');
end;

function TRegistryOptions.GetOperatingTimeEnd: Double;
begin
  LocateOperatingTimeEnd;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryOptions.SetOperatingTimeEnd(AValue: Double);
begin
  LocateOperatingTimeEnd;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryOptions.LocateOperatingTime: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OperatingTime', '0');
end;

function TRegistryOptions.GetOperatingTime: Boolean;
begin
  LocateOperatingTime;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetOperatingTime(AValue: Boolean);
begin
  LocateOperatingTime;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateDebugLog: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('DebugLog', '0');
end;

function TRegistryOptions.GetDebugLog: Boolean;
begin
  LocateDebugLog;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetDebugLog(AValue: Boolean);
begin
  LocateDebugLog;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateAutoSelectDefaultTarif: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AutoSelectDefaultTarif', '0');
end;

function TRegistryOptions.GetAutoSelectDefaultTarif: Boolean;
begin
  LocateAutoSelectDefaultTarif;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetAutoSelectDefaultTarif(AValue: Boolean);
begin
  LocateAutoSelectDefaultTarif;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateWriteProcessList: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('WriteProcessList', '1');
end;

function TRegistryOptions.GetWriteProcessList: Boolean;
begin
  LocateWriteProcessList;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetWriteProcessList(AValue: Boolean);
begin
  LocateWriteProcessList;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateWriteUnControlComp: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('WriteUnControlComp', '1');
end;

function TRegistryOptions.GetWriteUnControlComp: Boolean;
begin
  LocateWriteUnControlComp;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetWriteUnControlComp(AValue: Boolean);
begin
  LocateWriteUnControlComp;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryOptions.LocateWriteUnControlClub: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('WriteUnControlClub', '1');
end;

function TRegistryOptions.GetWriteUnControlClub: Boolean;
begin
  LocateWriteUnControlClub;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.SetWriteUnControlClub(AValue: Boolean);
begin
  LocateWriteUnControlClub;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

{function TRegistryOptions.Locate: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('', '0');
end;

function TRegistryOptions.Get: Boolean;
begin
  Locate;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryOptions.Set(AValue: Boolean);
begin
  Locate;
  FRegistryRecord.ValueAsBoolean := AValue;
end;
}
function TRegistryOptions.GetSendReportAfterClozeChange: Boolean;
begin
  LocateSendReportAfterClozeChange;
  Result := FRegistryRecord.ValueAsBoolean;
end;

function TRegistryOptions.LocateSendReportAfterClozeChange: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SendReportAfterClozeChange', '0');
end;

procedure TRegistryOptions.SetSendReportAfterClozeChange(AValue: Boolean);
begin
  LocateSendReportAfterClozeChange;
  FRegistryRecord.ValueAsBoolean := AValue;
end;


function TRegistryOptions.LocateMinIntervalBetvenReserved: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('MinIntervalBetvenReserved', '60');
end;

function TRegistryOptions.GetMinIntervalBetvenReserved: Integer;
begin
  LocateMinIntervalBetvenReserved;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryOptions.SetMinIntervalBetvenReserved(AValue: Integer);
begin
  LocateMinIntervalBetvenReserved;
  FRegistryRecord.ValueAsInteger := AValue;
end;




end.
