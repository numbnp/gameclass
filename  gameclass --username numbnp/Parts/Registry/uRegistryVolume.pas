unit uRegistryVolume;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type
  TRegistryVolumeItem = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    FnComputerIndex: Integer;
    function LocateCustom: Boolean;
    function GetCustom: Boolean;
    procedure SetCustom(AValue: Boolean);
    function LocateMain: Boolean;
    function GetMain: Integer;
    procedure SetMain(AValue: Integer);
    function LocateWave: Boolean;
    function GetWave: Integer;
    procedure SetWave(AValue: Integer);
    function LocateMute: Boolean;
    function GetMute: Boolean;
    procedure SetMute(AValue: Boolean);
  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);

    property ComputerIndex: Integer
      read FnComputerIndex write FnComputerIndex;
    property Custom: Boolean
      read GetCustom write SetCustom;
    property Main: Integer
      read GetMain write SetMain;
    property Wave: Integer
      read GetWave write SetWave;
    property Mute: Boolean
      read GetMute write SetMute;
  end;

  TRegistryVolume = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    FRegistryVolumeItem: TRegistryVolumeItem;
    function LocateOnlyLimit: Boolean;
    function GetOnlyLimit: Boolean;
    procedure SetOnlyLimit(AValue: Boolean);
    function GetItem(Index: Integer): TRegistryVolumeItem ;
  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property OnlyLimit: Boolean
      read GetOnlyLimit write SetOnlyLimit;
    property Items[Index: Integer]:TRegistryVolumeItem
        read GetItem; default;
  end;

implementation

uses
  SysUtils,
  StrUtils,
  DB,
  uGCDataSet;

{*******************************************************************************
                      class  TRegistryVolumeItem
*******************************************************************************}
constructor TRegistryVolumeItem.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

function TRegistryVolumeItem.LocateCustom: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('VolumeCustom'
      + IntToStr(FnComputerIndex),
      IfThen((FnComputerIndex = 0),'-1','0'));
end;

function TRegistryVolumeItem.GetCustom: Boolean;
begin
  LocateCustom;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryVolumeItem.SetCustom(AValue: Boolean);
begin
  LocateCustom;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryVolumeItem.LocateMain: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('VolumeMain'
      + IntToStr(FnComputerIndex),'65535');
end;

function TRegistryVolumeItem.GetMain: Integer;
begin
  LocateMain;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryVolumeItem.SetMain(AValue: Integer);
begin
  LocateMain;
  FRegistryRecord.ValueAsInteger := AValue;
end;

function TRegistryVolumeItem.LocateWave: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('VolumeWave'
      + IntToStr(FnComputerIndex),'65535');
end;

function TRegistryVolumeItem.GetWave: Integer;
begin
  LocateWave;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryVolumeItem.SetWave(AValue: Integer);
begin
  LocateWave;
  FRegistryRecord.ValueAsInteger := AValue;
end;

function TRegistryVolumeItem.LocateMute: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('VolumeMute'
      + IntToStr(FnComputerIndex),'0');
end;

function TRegistryVolumeItem.GetMute: Boolean;
begin
  LocateMute;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryVolumeItem.SetMute(AValue: Boolean);
begin
  LocateMute;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

{*******************************************************************************
                      class  TRegistryVolume
*******************************************************************************}
constructor TRegistryVolume.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
  FRegistryVolumeItem := TRegistryVolumeItem.Create(
      ARegistryDataSet, ARegistryRecord);
end;

destructor TRegistryVolume.Destroy;
begin
  FreeAndNil(FRegistryVolumeItem);
  inherited Destroy;
end;

function TRegistryVolume.LocateOnlyLimit: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('OnlyLimit','1');
end;

function TRegistryVolume.GetOnlyLimit: Boolean;
begin
  LocateOnlyLimit;
  //инверсия т.к. это было SetVolume
  Result := not FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryVolume.SetOnlyLimit(AValue: Boolean);
begin
  LocateOnlyLimit;
  //инверсия т.к. это было SetVolume
  FRegistryRecord.ValueAsBoolean := not AValue;
end;

function TRegistryVolume.GetItem(Index: Integer): TRegistryVolumeItem ;
begin
  FRegistryVolumeItem.ComputerIndex := Index;
  Result := FRegistryVolumeItem;
end;

end.
