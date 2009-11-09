unit uRegistryInfo;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryInfo = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;

    function LocateAppVersion: Boolean;
    function GetAppVersion: String;
    procedure SetAppVersion(AValue: String);
    function LocateUserName: Boolean;
    function GetUserName: String;
    procedure SetUserName(AValue: String);
    function LocateComputersNumber: Boolean;
    function GetComputersNumber: Integer;
    procedure SetComputersNumber(AValue: Integer);
    function LocateHardwareControl: Boolean;
    function GetHardwareControl: Boolean;
    procedure SetHardwareControl(AValue: Boolean);
    function LocatePrinterControl: Boolean;
    function GetPrinterControl: Boolean;
    procedure SetPrinterControl(AValue: Boolean);
    function LocateInternetControl: Boolean;
    function GetInternetControl: Boolean;
    procedure SetInternetControl(AValue: Boolean);
    function LocateInternetControlLinux: Boolean;
    function GetInternetControlLinux: Boolean;
    procedure SetInternetControlLinux(AValue: Boolean);
    function LocateInternetControlComLinux: Boolean;
    function GetInternetControlComLinux: Boolean;
    procedure SetInternetControlComLinux(AValue: Boolean);
    function LocateMainCheckSum: Boolean;
    function GetMainCheckSum: Cardinal;
    procedure SetMainCheckSum(AValue: Cardinal);
    function LocateClientCheckSum: Boolean;
    function GetClientCheckSum: Cardinal;
    procedure SetClientCheckSum(AValue: Cardinal);
    function LocateInstallCheckSum: Boolean;
    function GetInstallCheckSum: Cardinal;
    procedure SetInstallCheckSum(AValue: Cardinal);
    function LocateMainSize: Boolean;
    function GetMainSize: Cardinal;
    procedure SetMainSize(AValue: Cardinal);
    function LocateLastOperatorName: Boolean;
    function GetLastOperatorName: String;
    procedure SetLastOperatorName(AValue: String);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property AppVersion : String
        read GetAppVersion write SetAppVersion;
    property UserName : String
        read GetUserName write SetUserName;
    property ComputersNumber : Integer
        read GetComputersNumber write SetComputersNumber;
    property HardwareControl: Boolean
        read GetHardwareControl write SetHardwareControl;
    property PrinterControl: Boolean
        read GetPrinterControl write SetPrinterControl;
    property InternetControl: Boolean
        read GetInternetControl write SetInternetControl;
    property InternetControlLinux: Boolean
        read GetInternetControlLinux write SetInternetControlLinux;
    property InternetControlComLinux: Boolean
        read GetInternetControlComLinux write SetInternetControlComLinux;
    property MainCheckSum: Cardinal
        read GetMainCheckSum write SetMainCheckSum;
    property ClientCheckSum: Cardinal
        read GetClientCheckSum write SetClientCheckSum;
    property InstallCheckSum: Cardinal
        read GetInstallCheckSum write SetInstallCheckSum;
    property MainSize: Cardinal
        read GetMainSize write SetMainSize;
    property LastOperatorName : String
        read GetLastOperatorName write SetLastOperatorName;

  end;

implementation

uses
  StrUtils,
  SysUtils,
  DB,
  uGCDataSet,
  gcconst,
  gccomputers,
  gcfunctions,
  uRegistration;

{*******************************************************************************
                      class  TRegistryInfo
*******************************************************************************}
constructor TRegistryInfo.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryInfo.Destroy;
begin
  inherited Destroy;
end;

function TRegistryInfo.LocateAppVersion: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AppVersion', APP_VERSION);
end;

function TRegistryInfo.GetAppVersion: String;
begin
  LocateAppVersion;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryInfo.SetAppVersion(AValue: String);
begin
  LocateAppVersion;
  if (FRegistryRecord.Value <> AValue) then
    FRegistryRecord.Value := AValue;
end;

function TRegistryInfo.LocateUserName: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('UserName',
      Registration.UserName);
end;

function TRegistryInfo.GetUserName: String;
begin
  LocateUserName;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryInfo.SetUserName(AValue: String);
begin
  LocateUserName;
  if (FRegistryRecord.Value <> AValue) then
    FRegistryRecord.Value := AValue;
end;

function TRegistryInfo.LocateComputersNumber: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ComputersNumber',
      IntToStr(Registration.CompsRegs));
end;

function TRegistryInfo.GetComputersNumber: Integer;
begin
  LocateComputersNumber;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryInfo.SetComputersNumber(AValue: Integer);
begin
  LocateComputersNumber;
  if (FRegistryRecord.ValueAsInteger <> AValue) then
    FRegistryRecord.ValueAsInteger := AValue;
end;

function TRegistryInfo.LocateHardwareControl: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('HardwareControl',
      IfThen(Registration.HardwareControl, '1', '0'));
end;

function TRegistryInfo.GetHardwareControl: Boolean;
begin
  LocateHardwareControl;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInfo.SetHardwareControl(AValue: Boolean);
begin
  LocateHardwareControl;
  if (FRegistryRecord.ValueAsBoolean <> AValue) then
    FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInfo.LocatePrinterControl: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('PrinterControl',
      IfThen(Registration.PrinterControl, '1', '0'));
end;

function TRegistryInfo.GetPrinterControl: Boolean;
begin
  LocatePrinterControl;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInfo.SetPrinterControl(AValue: Boolean);
begin
  LocatePrinterControl;
  if (FRegistryRecord.ValueAsBoolean <> AValue) then
    FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInfo.LocateInternetControl: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('InternetControl',
      IfThen(Registration.InternetControl, '1', '0'));
end;

function TRegistryInfo.GetInternetControl: Boolean;
begin
  LocateInternetControl;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInfo.SetInternetControl(AValue: Boolean);
begin
  LocateInternetControl;
  if (FRegistryRecord.ValueAsBoolean <> AValue) then
    FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInfo.LocateInternetControlLinux: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('InternetControlLinux',
      IfThen(Registration.InternetControlLinux, '1', '0'));
end;

function TRegistryInfo.GetInternetControlLinux: Boolean;
begin
  LocateInternetControlLinux;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInfo.SetInternetControlLinux(AValue: Boolean);
begin
  LocateInternetControlLinux;
  if (FRegistryRecord.ValueAsBoolean <> AValue) then
    FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInfo.LocateInternetControlComLinux: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('InternetControlComLinux',
      IfThen(Registration.InternetControlComLinux, '1', '0'));
end;

function TRegistryInfo.GetInternetControlComLinux: Boolean;
begin
  LocateInternetControlComLinux;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInfo.SetInternetControlComLinux(AValue: Boolean);
begin
  LocateInternetControlComLinux;
  if (FRegistryRecord.ValueAsBoolean <> AValue) then
    FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInfo.LocateMainCheckSum: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('MainCheckSum',
      IntToStr(GnServerFileCheckSum));
end;

function TRegistryInfo.GetMainCheckSum: Cardinal;
begin
  LocateMainCheckSum;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryInfo.SetMainCheckSum(AValue: Cardinal);
begin
  LocateMainCheckSum;
  if (FRegistryRecord.ValueAsInt64 <> AValue) then
    FRegistryRecord.ValueAsInt64 := AValue;
end;

function TRegistryInfo.LocateClientCheckSum: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ClientCheckSum',
      IntToStr(GnClientScriptFileCheckSum));
end;

function TRegistryInfo.GetClientCheckSum: Cardinal;
begin
  LocateClientCheckSum;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryInfo.SetClientCheckSum(AValue: Cardinal);
begin
  LocateClientCheckSum;
  if (FRegistryRecord.ValueAsInt64 <> AValue) then
    FRegistryRecord.ValueAsInt64 := AValue;
end;

function TRegistryInfo.LocateInstallCheckSum: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('InstallCheckSum',
      IntToStr(GnClientInstallFileCheckSum));
end;

function TRegistryInfo.GetInstallCheckSum: Cardinal;
begin
  LocateInstallCheckSum;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryInfo.SetInstallCheckSum(AValue: Cardinal);
begin
  LocateInstallCheckSum;
  if (FRegistryRecord.ValueAsInt64 <> AValue) then
    FRegistryRecord.ValueAsInt64 := AValue;
end;

function TRegistryInfo.LocateMainSize: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('MainSize',
       IntToStr(GetSize));
end;

function TRegistryInfo.GetMainSize: Cardinal;
begin
  LocateMainSize;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryInfo.SetMainSize(AValue: Cardinal);
begin
  LocateMainSize;
  if (FRegistryRecord.ValueAsInt64 <> AValue) then
    FRegistryRecord.ValueAsInt64 := AValue;
end;

function TRegistryInfo.LocateLastOperatorName: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('LastOperatorName', '');
end;

function TRegistryInfo.GetLastOperatorName: String;
begin
  LocateLastOperatorName;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryInfo.SetLastOperatorName(AValue: String);
begin
  LocateLastOperatorName;
  if (FRegistryRecord.Value <> AValue) then
    FRegistryRecord.Value := AValue;
end;


{function TRegistryInfo.Locate: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('', '0');
end;

function TRegistryInfo.Get: Boolean;
begin
  Locate;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInfo.Set(AValue: Boolean);
begin
  Locate;
  FRegistryRecord.ValueAsBoolean := AValue;
end;
}
end.
