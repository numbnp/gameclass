unit uRegistryModules;

interface

uses
  Classes,
  uRegistryRecord,
  uRegistryDataSet,
  uRegistryPrinter,
  uRegistryInternet,
  uRegistryHardware,
  uRegistryKKM;

type

  TRegistryModules = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    FRegistryPrinter: TRegistryPrinter;
    FRegistryInternet: TRegistryInternet;
    FRegistryHardware: TRegistryHardware;
    FRegistryKKM: TRegistryKKM;

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property Printer: TRegistryPrinter
      read FRegistryPrinter;
    property Internet: TRegistryInternet
      read FRegistryInternet;
    property Hardware: TRegistryHardware
      read FRegistryHardware;
    property KKM: TRegistryKKM
       read FRegistryKKM;

  end;

implementation

uses
  SysUtils,
  DB,
  uGCDataSet,
  gcconst;

{*******************************************************************************
                      class  TRegistryModules
*******************************************************************************}
constructor TRegistryModules.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
  FRegistryPrinter := TRegistryPrinter.Create(FRegistryDataSet,
      FRegistryRecord);
  FRegistryInternet := TRegistryInternet.Create(FRegistryDataSet,
      FRegistryRecord);
  FRegistryHardware := TRegistryHardware.Create(FRegistryDataSet,
      FRegistryRecord);
  FRegistryKKM := TRegistryKKM.Create(FRegistryDataSet, FRegistryRecord);
end;

destructor TRegistryModules.Destroy;
begin
  FreeAndNil(FRegistryPrinter);
  FreeAndNil(FRegistryInternet);
  FreeAndNil(FRegistryHardware);
  FreeAndNil(FRegistryKKM);
  inherited Destroy;
end;

end.
