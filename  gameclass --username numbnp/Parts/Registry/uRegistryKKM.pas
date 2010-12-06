unit uRegistryKKM;

interface

uses
  Classes,
  uRegistryRecord,
  uRegistryDataSet;

type

  TCheckMode = (
      cmOnlyResultCheck = 1,
      cmCashInForPrepay = 2,
      cmRefundForChange = 3);

  TRegistryKKM = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    function LocateActive: Boolean;
    function GetActive: Boolean;
    procedure SetActive(AValue: Boolean);
    function LocatePluginPath: Boolean;
    function GetPluginPath: String;
    procedure SetPluginPath(AValue: String);
    function LocateDisconnectBlock: Boolean;
    function GetDisconnectBlock: Boolean;
    procedure SetDisconnectBlock(AValue: Boolean);
    function LocateZOrderByCloseShift: Boolean;
    function GetZOrderByCloseShift: Boolean;
    procedure SetZOrderByCloseShift(AValue: Boolean);
    function LocatePrintNonFiscal: Boolean;
    function GetPrintNonFiscal: Boolean;
    procedure SetPrintNonFiscal(AValue: Boolean);
    function LocateCustomOperatorName: Boolean;
    function GetCustomOperatorName: Boolean;
    procedure SetCustomOperatorName(AValue: Boolean);
    function LocateOperatorName: Boolean;
    function GetOperatorName: String;
    procedure SetOperatorName(AValue: String);
    function LocateConfig: Boolean;
    function GetConfig: String;
    procedure SetConfig(AValue: String);
    function LocateCheckMode: Boolean;
    function GetCheckMode: TCheckMode;
    procedure SetCheckMode(AValue: TCheckMode);
    function LocateOnlyForOperator: Boolean;
    function GetOnlyForOperator: Boolean;
    procedure SetOnlyForOperator(AValue: Boolean);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property Active: Boolean
        read GetActive write SetActive;
    property PluginPath: String
        read GetPluginPath write SetPluginPath;
    property DisconnectBlock: Boolean
        read GetDisconnectBlock write SetDisconnectBlock;
    property ZOrderByCloseShift: Boolean
        read GetZOrderByCloseShift write SetZOrderByCloseShift;
    property PrintNonFiscal: Boolean
        read GetPrintNonFiscal write SetPrintNonFiscal;
    property CustomOperatorName: Boolean
        read GetCustomOperatorName write SetCustomOperatorName;
    property OperatorName: String
        read GetOperatorName write SetOperatorName;
    property Config: String
        read GetConfig write SetConfig;
    property OnlyForOperator: Boolean
        read GetOnlyForOperator write SetOnlyForOperator;
    property CheckMode: TCheckMode
        read GetCheckMode write SetCheckMode;
  end;

implementation

uses
  uRegistration,
  SysUtils,
  DB,
  uGCDataSet,
  gcconst,
  gccomputers;

{*******************************************************************************
                      class  TRegistryKKM
*******************************************************************************}
constructor TRegistryKKM.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryKKM.Destroy;
begin
  inherited Destroy;
end;

function TRegistryKKM.LocateActive: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\Active', '0');
end;

function TRegistryKKM.GetActive: Boolean;
begin
  LocateActive;
  Result := Registration.KKMControl
      and FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryKKM.SetActive(AValue: Boolean);
begin
  LocateActive;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryKKM.LocatePluginPath: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\FileName', '');
end;

function TRegistryKKM.GetPluginPath: String;
begin
  LocatePluginPath;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryKKM.SetPluginPath(AValue: String);
begin
  LocatePluginPath;
  FRegistryRecord.Value := AValue;
end;

function TRegistryKKM.LocateDisconnectBlock: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\DisconnectBlock', '0');
end;

function TRegistryKKM.GetDisconnectBlock: Boolean;
begin
  LocateDisconnectBlock;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryKKM.SetDisconnectBlock(AValue: Boolean);
begin
  LocateDisconnectBlock;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryKKM.LocateZOrderByCloseShift: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\ZOrderByCloseShift', '0');
end;

function TRegistryKKM.GetZOrderByCloseShift: Boolean;
begin
  LocateZOrderByCloseShift;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryKKM.SetZOrderByCloseShift(AValue: Boolean);
begin
  LocateZOrderByCloseShift;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryKKM.LocatePrintNonFiscal: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\PrintNonFiscal', '0');
end;

function TRegistryKKM.GetPrintNonFiscal: Boolean;
begin
  LocatePrintNonFiscal;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryKKM.SetPrintNonFiscal(AValue: Boolean);
begin
  LocatePrintNonFiscal;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryKKM.LocateCustomOperatorName: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\CustomOperatorName', '0');
end;

function TRegistryKKM.GetCustomOperatorName: Boolean;
begin
  LocateCustomOperatorName;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryKKM.SetCustomOperatorName(AValue: Boolean);
begin
  LocateCustomOperatorName;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryKKM.LocateOperatorName: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\OperatorName', '');
end;

function TRegistryKKM.GetOperatorName: String;
begin
  LocateOperatorName;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryKKM.SetOperatorName(AValue: String);
begin
  LocateOperatorName;
  FRegistryRecord.Value := AValue;
end;

function TRegistryKKM.LocateConfig: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\Config', '');
end;

function TRegistryKKM.GetConfig: String;
begin
  LocateConfig;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryKKM.SetConfig(AValue: String);
begin
  LocateConfig;
  FRegistryRecord.Value := AValue;
end;

function TRegistryKKM.LocateCheckMode: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\CheckMode', '3');
end;

function TRegistryKKM.GetCheckMode: TCheckMode;
begin
  LocateCheckMode;
  Result := TCheckMode(FRegistryRecord.ValueAsInteger);
end;

procedure TRegistryKKM.SetCheckMode(AValue: TCheckMode);
begin
  LocateCheckMode;
  FRegistryRecord.ValueAsInteger := Integer(AValue);
end;


function TRegistryKKM.LocateOnlyForOperator: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('KKM\OnlyForOperator', '0');
end;

function TRegistryKKM.GetOnlyForOperator: Boolean;
begin
  LocateOnlyForOperator;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryKKM.SetOnlyForOperator(AValue: Boolean);
begin
  LocateOnlyForOperator;
  FRegistryRecord.ValueAsBoolean := AValue;
end;



end.
