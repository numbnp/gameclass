unit uRegistryHardware;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryHardware = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;

    function LocateActive: Boolean;
    function GetActive: Boolean;
    procedure SetActive(AValue: Boolean);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property Active: Boolean
        read GetActive write SetActive;
  end;

implementation

uses
  SysUtils,
  DB,
  uGCDataSet,
  uRegistry,
  gcComputers;

{*******************************************************************************
                      class  TRegistryHardware
*******************************************************************************}
constructor TRegistryHardware.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryHardware.Destroy;
begin
  inherited Destroy;
end;

function TRegistryHardware.LocateActive: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ActivateHardwareControl', '0');
end;

function TRegistryHardware.GetActive: Boolean;
begin
  LocateActive;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryHardware.SetActive(AValue: Boolean);
begin
  LocateActive;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

end.
