unit uRegistryPrinter;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryPrinter = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;

    function LocatePrintedPageCost: Boolean;
    function GetPrintedPageCost: Double;
    procedure SetPrintedPageCost(AValue: Double);
    function LocateActive: Boolean;
    function GetActive: Boolean;
    procedure SetActive(AValue: Boolean);
    function LocateLastProcessedId: Boolean;
    function GetLastProcessedId: Integer;
    procedure SetLastProcessedId(AValue: Integer);
    function LocateUsePMCosts: Boolean;
    function GetUsePMCosts: Boolean;
    procedure SetUsePMCosts(AValue: Boolean);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property Active: Boolean //bActiveGCICProxy
        read GetActive write SetActive;
    property PrintedPageCost: Double
        read GetPrintedPageCost write SetPrintedPageCost;
    property LastProcessedId: Integer
        read GetLastProcessedId write SetLastProcessedId;
    property UsePMCosts: Boolean //bUsePMCostsGCICProxy
        read GetUsePMCosts write SetUsePMCosts;
  end;

implementation

uses
  SysUtils,
  DB,
  uGCDataSet,
  uRegistry,
  gcComputers,
  uRegistration;

{*******************************************************************************
                      class  TRegistryPrinter
*******************************************************************************}
constructor TRegistryPrinter.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryPrinter.Destroy;
begin
  inherited Destroy;
end;

function TRegistryPrinter.LocateActive: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('printers\active', '0');
end;

function TRegistryPrinter.GetActive: Boolean;
begin
  LocateActive;
  Result := Registration.PrinterControl
      and FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryPrinter.SetActive(AValue: Boolean);
begin
  LocateActive;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryPrinter.LocatePrintedPageCost: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('printers\DefaultPrinter', '3');
end;

function TRegistryPrinter.GetPrintedPageCost: Double;
begin
  LocatePrintedPageCost;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryPrinter.SetPrintedPageCost(AValue: Double);
begin
  LocatePrintedPageCost;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryPrinter.LocateLastProcessedId: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('PrinterScanId', '0');
end;

function TRegistryPrinter.GetLastProcessedId: Integer;
begin
  LocateLastProcessedId;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryPrinter.SetLastProcessedId(AValue: Integer);
begin
  LocateLastProcessedId;
  FRegistryRecord.ValueAsInteger := AValue;
end;

function TRegistryPrinter.LocateUsePMCosts: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('printers\UsePMCosts', '0');
end;

function TRegistryPrinter.GetUsePMCosts: Boolean;
begin
  LocateUsePMCosts;
  Result := Registration.PrinterControl
      and FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryPrinter.SetUsePMCosts(AValue: Boolean);
begin
  LocateUsePMCosts;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

end.
