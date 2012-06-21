unit uRegistryMail;


interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type
  TRegistryMail = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    FnComputerIndex: Integer;
    function LocateSMTPHost: Boolean;
    function GetSMTPHost: String;
    procedure SetSMTPHost(AValue: String);

    function LocateSMTPPort: Boolean;
    function GetSMTPPort: integer;
    procedure SetSMTPPort(AValue: integer);

    function LocateSMTPUseAuth: Boolean;
    function GetSMTPUseAuth: Boolean;
    procedure SetSMTPUseAuth(AValue: Boolean);

    function LocateSMTPUserName: Boolean;
    function GetSMTPUserName: String;
    procedure SetSMTPUserName(AValue: String);

    function LocateSMTPPassword: Boolean;
    function GetSMTPPassword: String;
    procedure SetSMTPPassword(AValue: String);


  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property SMTPHost: String
      read GetSMTPHost write SetSMTPHost;
    property SMTPPort: Integer
      read GetSMTPPort write SetSMTPPort;
    property SMTPUseAuth: Boolean
      read GetSMTPUseAuth write SetSMTPUseAuth;
    property SMTPUserName: String
      read GetSMTPUserName write SetSMTPUserName;
    property SMTPPassword: String
      read GetSMTPPassword write SetSMTPPassword;

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
constructor TRegistryMail.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryMail.Destroy;
begin
  inherited Destroy;
end;


//----------------------------SMTPHost------------------------------
function TRegistryMail.LocateSMTPHost: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SMTP\Host','');
end;

function TRegistryMail.GetSMTPHost: String;
begin
  LocateSMTPHost;
  Result := FRegistryRecord.Value;
end;

procedure TRegistryMail.SetSMTPHost(AValue: String);
begin
  LocateSMTPHost;
  FRegistryRecord.Value:= AValue;
end;

//----------------------------SMTPPort------------------------------
function TRegistryMail.LocateSMTPPort: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SMTP\Port','0');
end;

function TRegistryMail.GetSMTPPort: Integer;
begin
  LocateSMTPPort;
  Result := FRegistryRecord.ValueAsInteger ;
end;

procedure TRegistryMail.SetSMTPPort(AValue: Integer);
begin
  LocateSMTPPort;
  FRegistryRecord.ValueAsInteger:= AValue;
end;

//----------------------------SMTPUseAuth------------------------------
function TRegistryMail.LocateSMTPUseAuth: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SMTP\UseAuth','0');
end;

function TRegistryMail.GetSMTPUseAuth: Boolean;
begin
  LocateSMTPUseAuth;
  Result := FRegistryRecord.ValueAsBoolean ;
end;

procedure TRegistryMail.SetSMTPUseAuth(AValue: Boolean);
begin
  LocateSMTPUseAuth;
  FRegistryRecord.ValueAsBoolean:= AValue;
end;

//----------------------------SMTPUserName------------------------------
function TRegistryMail.LocateSMTPUserName: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SMTP\UserName','');
end;

function TRegistryMail.GetSMTPUserName: String;
begin
  LocateSMTPUserName;
  Result := FRegistryRecord.Value ;
end;

procedure TRegistryMail.SetSMTPUserName(AValue: String);
begin
  LocateSMTPUserName;
  FRegistryRecord.Value:= AValue;
end;

//----------------------------SMTPPassword------------------------------
function TRegistryMail.LocateSMTPPassword: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SMTP\Password','');
end;

function TRegistryMail.GetSMTPPassword: String;
begin
  LocateSMTPPassword;
  Result := FRegistryRecord.Value ;
end;

procedure TRegistryMail.SetSMTPPassword(AValue: String);
begin
  LocateSMTPPassword;
  FRegistryRecord.Value:= AValue;
end;

end.
