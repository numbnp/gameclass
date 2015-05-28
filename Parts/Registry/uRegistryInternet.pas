unit uRegistryInternet;

interface

uses
  Classes,
  uRegistryRecord,
  uRegistryDataSet;

type

  TInternetTariffingMode = (tmOnlyInbound = 1, tmSummary, tmMaximum);

  TRegistryInternet = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    function GetSummaryControl: Boolean;
    function GetSummaryAccounting: Boolean;
    function LocateInnerProxy: Boolean;
    function GetInnerProxy: Boolean;
    procedure SetInnerProxy(AValue: Boolean);
    function LocateOuterPlugin: Boolean;
    function GetOuterPlugin: Boolean;
    procedure SetOuterPlugin(AValue: Boolean);
    function LocateLinuxPro: Boolean;
    function GetLinuxPro: Boolean;
    procedure SetLinuxPro(AValue: Boolean);
    function LocateLinuxFree: Boolean;
    function GetLinuxFree: Boolean;
    procedure SetLinuxFree(AValue: Boolean);
    function LocateOuterPluginSetLimit: Boolean;
    function GetOuterPluginSetLimit: Boolean;
    procedure SetOuterPluginSetLimit(AValue: Boolean);
    function LocateOuterPluginSetSpeed: Boolean;
    function GetOuterPluginSetSpeed: Boolean;
    procedure SetOuterPluginSetSpeed(AValue: Boolean);
    function LocateOuterPluginSetGroup: Boolean;
    function GetOuterPluginSetGroup: Boolean;
    procedure SetOuterPluginSetGroup(AValue: Boolean);
    function LocateTariffingMode: Boolean;
    function GetTariffingMode: TInternetTariffingMode;
    procedure SetTariffingMode(AValue: TInternetTariffingMode);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    //общаая тру если хоть одно включено
    property SummaryControl: Boolean
        read GetSummaryControl;
    //общаая тру если включен один из модулей учета
    property SummaryAccounting: Boolean
        read GetSummaryAccounting;
    property InnerProxy: Boolean //bActiveGCICProxy
        read GetInnerProxy write SetInnerProxy;
    property OuterPlugin: Boolean //bActiveGCICTI
        read GetOuterPlugin write SetOuterPlugin;
    property LinuxPro: Boolean  //bActiveGCICLPro
        read GetLinuxPro write SetLinuxPro;
    property LinuxFree: Boolean //bActiveGCICLFree
        read GetLinuxFree write SetLinuxFree;
    property OuterPluginSetLimit: Boolean
        read GetOuterPluginSetLimit write SetOuterPluginSetLimit;
    property OuterPluginSetSpeed: Boolean 
        read GetOuterPluginSetSpeed write SetOuterPluginSetSpeed;
    property OuterPluginSetGroup: Boolean
        read GetOuterPluginSetGroup write SetOuterPluginSetGroup;
    property TariffingMode: TInternetTariffingMode
        read GetTariffingMode write SetTariffingMode;
  end;

implementation

uses
  SysUtils,
  DB,
  uGCDataSet,
  gcconst,
  gccomputers;

{*******************************************************************************
                      class  TRegistryInternet
*******************************************************************************}
constructor TRegistryInternet.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryInternet.Destroy;
begin
  inherited Destroy;
end;

function TRegistryInternet.GetSummaryControl: Boolean;
begin
  Result := InnerProxy or OuterPlugin or LinuxFree or LinuxPro;
end;

function TRegistryInternet.GetSummaryAccounting: Boolean;
begin
  Result := InnerProxy or OuterPlugin or LinuxPro;
end;

function TRegistryInternet.LocateInnerProxy: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ActivateTrafficControl', '0');
end;

function TRegistryInternet.GetInnerProxy: Boolean;
begin
  LocateInnerProxy;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInternet.SetInnerProxy(AValue: Boolean);
begin
  LocateInnerProxy;
  FRegistryRecord.ValueAsBoolean := AValue;
  if AValue then begin
    LocateOuterPlugin;
    FRegistryRecord.ValueAsBoolean := False;
    LocateLinuxPro;
    FRegistryRecord.ValueAsBoolean := False;
    LocateLinuxFree;
    FRegistryRecord.ValueAsBoolean := False;
  end;
end;

function TRegistryInternet.LocateOuterPlugin: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ActivateTrafficControlTI', '0');
end;

function TRegistryInternet.GetOuterPlugin: Boolean;
begin
  LocateOuterPlugin;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInternet.SetOuterPlugin(AValue: Boolean);
begin
  LocateOuterPlugin;
  FRegistryRecord.ValueAsBoolean := AValue;
  if AValue then begin
    LocateInnerProxy;
    FRegistryRecord.ValueAsBoolean := False;
    LocateLinuxPro;
    FRegistryRecord.ValueAsBoolean := False;
    LocateLinuxFree;
    FRegistryRecord.ValueAsBoolean := False;
  end;
end;

function TRegistryInternet.LocateLinuxPro: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ActivateTrafficControlComLinux', '0');
end;

function TRegistryInternet.GetLinuxPro: Boolean;
begin
  LocateLinuxPro;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInternet.SetLinuxPro(AValue: Boolean);
begin
  LocateLinuxPro;
  FRegistryRecord.ValueAsBoolean := AValue;
  if AValue then begin
    LocateInnerProxy;
    FRegistryRecord.ValueAsBoolean := False;
    LocateOuterPlugin;
    FRegistryRecord.ValueAsBoolean := False;
    LocateLinuxFree;
    FRegistryRecord.ValueAsBoolean := False;
  end;
end;

function TRegistryInternet.LocateLinuxFree: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ActivateTrafficControlLinuxFree',
      '0');
end;

function TRegistryInternet.GetLinuxFree: Boolean;
begin
  LocateLinuxFree;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInternet.SetLinuxFree(AValue: Boolean);
begin
  LocateLinuxFree;
  FRegistryRecord.ValueAsBoolean := AValue;
  if AValue then begin
    LocateInnerProxy;
    FRegistryRecord.ValueAsBoolean := False;
    LocateOuterPlugin;
    FRegistryRecord.ValueAsBoolean := False;
    LocateLinuxPro;
    FRegistryRecord.ValueAsBoolean := False;
  end;
end;

function TRegistryInternet.LocateOuterPluginSetLimit: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OuterProxy\SetLimit', '1');
end;

function TRegistryInternet.GetOuterPluginSetLimit: Boolean;
begin
  Result := LocateOuterPluginSetLimit;
  Result := Result and FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInternet.SetOuterPluginSetLimit(AValue: Boolean);
begin
  LocateOuterPluginSetLimit;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInternet.LocateOuterPluginSetSpeed: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OuterProxy\SetSpeed', '1');
end;

function TRegistryInternet.GetOuterPluginSetSpeed: Boolean;
begin
  Result := LocateOuterPluginSetSpeed;
  Result := Result and FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInternet.SetOuterPluginSetSpeed(AValue: Boolean);
begin
  LocateOuterPluginSetSpeed;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInternet.LocateOuterPluginSetGroup: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OuterProxy\SetGroup', '1');
end;

function TRegistryInternet.GetOuterPluginSetGroup: Boolean;
begin
  Result := LocateOuterPluginSetGroup;
  Result := Result and FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInternet.SetOuterPluginSetGroup(AValue: Boolean);
begin
  LocateOuterPluginSetGroup;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInternet.LocateTariffingMode: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('Internet\TariffingMode', '1');
end;

function TRegistryInternet.GetTariffingMode: TInternetTariffingMode;
begin
  LocateTariffingMode;
  Result := TInternetTariffingMode(FRegistryRecord.ValueAsInteger);
end;

procedure TRegistryInternet.SetTariffingMode(AValue: TInternetTariffingMode);
begin
  LocateTariffingMode;
  FRegistryRecord.ValueAsInteger := Integer(AValue);
end;

end.
