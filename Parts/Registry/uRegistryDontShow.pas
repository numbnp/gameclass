unit uRegistryDontShow;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryDontShow = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    function LocateManagerFirstLogon: Boolean;
    function GetManagerFirstLogon: Boolean;
    procedure SetManagerFirstLogon(AValue: Boolean);
    function LocateManagerEmptyPassword: Boolean;
    function GetManagerEmptyPassword: Boolean;
    procedure SetManagerEmptyPassword(AValue: Boolean);
    function LocateNewDiscountInfo: Boolean;
    function GetNewDiscountInfo: Boolean;
    procedure SetNewDiscountInfo(AValue: Boolean);
    function LocateInputInTarifs: Boolean;
    function GetInputInTarifs: Boolean;
    procedure SetInputInTarifs(AValue: Boolean);
    function LocateSqlConnectError: Boolean;
    function GetSqlConnectError: Boolean;
    procedure SetSqlConnectError(AValue: Boolean);
    function LocateMDACOldVersion: Boolean;
    function GetMDACOldVersion: Boolean;
    procedure SetMDACOldVersion(AValue: Boolean);
    function LocateClubInfoFileAccessError: Boolean;
    function GetClubInfoFileAccessError: Boolean;
    procedure SetClubInfoFileAccessError(AValue: Boolean);
    function LocateRawSocketWarning: Boolean;
    function GetRawSocketWarning: Boolean;
    procedure SetRawSocketWarning(AValue: Boolean);
    function LocateFirstOptionsClose: Boolean;
    function GetFirstOptionsClose: Boolean;
    procedure SetFirstOptionsClose(AValue: Boolean);


  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property ManagerFirstLogon: Boolean
        read GetManagerFirstLogon write SetManagerFirstLogon;
    property ManagerEmptyPassword: Boolean
        read GetManagerEmptyPassword write SetManagerEmptyPassword;
    property NewDiscountInfo: Boolean
        read GetNewDiscountInfo write SetNewDiscountInfo;
    property InputInTarifs: Boolean
        read GetInputInTarifs write SetInputInTarifs;
    property SqlConnectError: Boolean
        read GetSqlConnectError write SetSqlConnectError;
    property MDACOldVersion: Boolean
        read GetMDACOldVersion write SetMDACOldVersion;
    property ClubInfoFileAccessError: Boolean
        read GetClubInfoFileAccessError write SetClubInfoFileAccessError;
    property RawSocketWarning: Boolean
        read GetRawSocketWarning write SetRawSocketWarning;
    property FirstOptionsClose: Boolean
        read GetFirstOptionsClose write SetFirstOptionsClose;

  end;

implementation

uses
  SysUtils,
  DB, uGCDataSet;

{*******************************************************************************
                      class  TRegistryDontShow
*******************************************************************************}
constructor TRegistryDontShow.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryDontShow.Destroy;
begin
  inherited Destroy;
end;


function TRegistryDontShow.LocateManagerFirstLogon: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowManagerFirstLogon', '0');
end;

function TRegistryDontShow.GetManagerFirstLogon: Boolean;
begin
  LocateManagerFirstLogon;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetManagerFirstLogon(AValue: Boolean);
begin
  LocateManagerFirstLogon;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryDontShow.LocateManagerEmptyPassword: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowManagerEmptyPassword', '0');
end;

function TRegistryDontShow.GetManagerEmptyPassword: Boolean;
begin
  LocateManagerEmptyPassword;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetManagerEmptyPassword(AValue: Boolean);
begin
  LocateManagerEmptyPassword;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryDontShow.LocateNewDiscountInfo: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowNewDiscountInfo', '0');
end;

function TRegistryDontShow.GetNewDiscountInfo: Boolean;
begin
  LocateNewDiscountInfo;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetNewDiscountInfo(AValue: Boolean);
begin
  LocateNewDiscountInfo;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryDontShow.LocateInputInTarifs: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowInputInTarifs', '0');
end;

function TRegistryDontShow.GetInputInTarifs: Boolean;
begin
  LocateInputInTarifs;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetInputInTarifs(AValue: Boolean);
begin
  LocateInputInTarifs;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryDontShow.LocateSqlConnectError: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowSqlConnectError', '0');
end;

function TRegistryDontShow.GetSqlConnectError: Boolean;
begin
  LocateSqlConnectError;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetSqlConnectError(AValue: Boolean);
begin
  LocateSqlConnectError;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryDontShow.LocateMDACOldVersion: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowMDACOldVersion', '0');
end;

function TRegistryDontShow.GetMDACOldVersion: Boolean;
begin
  LocateMDACOldVersion;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetMDACOldVersion(AValue: Boolean);
begin
  LocateMDACOldVersion;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryDontShow.LocateClubInfoFileAccessError: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowClubInfoFileAccessError', '0');
end;

function TRegistryDontShow.GetClubInfoFileAccessError: Boolean;
begin
  LocateClubInfoFileAccessError;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetClubInfoFileAccessError(AValue: Boolean);
begin
  LocateClubInfoFileAccessError;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryDontShow.LocateRawSocketWarning: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowRawSocketWarning', '0');
end;

function TRegistryDontShow.GetRawSocketWarning: Boolean;
begin
  LocateRawSocketWarning;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetRawSocketWarning(AValue: Boolean);
begin
  LocateRawSocketWarning;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryDontShow.LocateFirstOptionsClose: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('dontshowFirstOptionsClose', '0');
end;

function TRegistryDontShow.GetFirstOptionsClose: Boolean;
begin
  LocateFirstOptionsClose;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryDontShow.SetFirstOptionsClose(AValue: Boolean);
begin
  LocateFirstOptionsClose;
  FRegistryRecord.ValueAsBoolean := AValue;
end;
end.
