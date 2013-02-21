unit uRegistryCardReader;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type
  TRegistryCardReader = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    FnComputerIndex: Integer;

    function GetEnabled: Boolean;
    procedure SetEnabled(AValue: Boolean);

    function GetComPort: String;
    procedure SetComPort(AValue: String);


  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property Enabled:boolean
      read GetEnabled write SetEnabled;
    property ComPort:string
      read GetComPort write SetComPort;
  end;

implementation

uses
  SysUtils,
  StrUtils,
  DB,
  uGCDataSet;

{*******************************************************************************
                      class  TRegistryCardReader
*******************************************************************************}
constructor TRegistryCardReader.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryCardReader.Destroy;
begin
  inherited Destroy;
end;


function TRegistryCardReader.GetComPort: String;
begin
  Result := FRegistryRecord.GetValueStringEx('CardReader\ComPort','');
end;

function TRegistryCardReader.GetEnabled: Boolean;
begin
  Result := FRegistryRecord.GetValueAsBooleanEx('CardReader\Enabled',False);
end;

procedure TRegistryCardReader.SetComPort(AValue: String);
begin
    FRegistryRecord.SetValueStringEx('CardReader\ComPort',AValue,'');
end;

procedure TRegistryCardReader.SetEnabled(AValue: Boolean);
begin
  FRegistryRecord.SetValueAsBooleanEx('CardReader\Enabled',AValue,False);
end;

end.
