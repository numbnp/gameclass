unit uRegistryInterface;

interface

uses
  Graphics,
  uRegistryRecord,
  uRegistryDataSet,
  uRegistryDontShow;

type

  TRegistryInterface = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    FRegistryDontShow: TRegistryDontShow;
    function LocateSoundNegativeBalance: Boolean;
    function GetSoundNegativeBalance: Boolean;
    procedure SetSoundNegativeBalance(AValue: Boolean);
    function LocateSoundLostLink: Boolean;
    function GetSoundLostLink: Boolean;
    procedure SetSoundLostLink(AValue: Boolean);
    function LocateSwitchToGC3Win: Boolean;
    function GetSwitchToGC3Win: Boolean;
    procedure SetSwitchToGC3Win(AValue: Boolean);
    function LocateDontHideIntoSysTray: Boolean;
    function GetDontHideIntoSysTray: Boolean;
    procedure SetDontHideIntoSysTray(AValue: Boolean);
    function LocateActivateMessageTab: Boolean;
    function GetActivateMessageTab: Boolean;
    procedure SetActivateMessageTab(AValue: Boolean);
    function LocateBackColor: Boolean;
    function GetBackColor: Integer;
    procedure SetBackColor(AValue: Integer);
    function LocateShowCopmTechInfo: Boolean;
    function GetShowCopmTechInfo: Boolean;
    procedure SetShowCopmTechInfo(AValue: Boolean);
    function LocateColumnWidth(AnColumnNumber: Integer): Boolean;
    function GetColumnWidth(AnColumnNumber: Integer): Integer;
    procedure SetColumnWidth(AnColumnNumber: Integer; AValue: Integer);
    function LocateTableFont: Boolean;
    function GetTableFont: TFont;
    procedure SetTableFont(AValue: TFont);
    function LocateMultiActionsFullControl: Boolean;
    function GetMultiActionsFullControl: Boolean;
    procedure SetMultiActionsFullControl(AValue: Boolean);
    function LocateHideSessionChartWithoutReserve: Boolean;
    function GetHideSessionChartWithoutReserve: Boolean;
    procedure SetHideSessionChartWithoutReserve(AValue: Boolean);
    function LocateSoundGuestSession: Boolean;
    function GetSoundGuestSession: Boolean;
    procedure SetSoundGuestSession(AValue: Boolean);
  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    property SoundNegativeBalance: Boolean
        read GetSoundNegativeBalance write SetSoundNegativeBalance;
    property SoundLostLink: Boolean
        read GetSoundLostLink write SetSoundLostLink;
    property SwitchToGC3Win: Boolean
        read GetSwitchToGC3Win write SetSwitchToGC3Win;
    property DontHideIntoSysTray: Boolean
        read GetDontHideIntoSysTray write SetDontHideIntoSysTray;
    property ActivateMessageTab: Boolean
        read GetActivateMessageTab write SetActivateMessageTab;
    property DontShow: TRegistryDontShow
        read FRegistryDontShow;
    property BackColor: Integer
        read GetBackColor write SetBackColor;
    property ShowCopmTechInfo: Boolean
        read GetShowCopmTechInfo write SetShowCopmTechInfo;
    property ColumnWidth[AnColumnNumber: Integer]: Integer
        read GetColumnWidth write SetColumnWidth;
    property TableFont: TFont
        read GetTableFont write SetTableFont;
    property MultiActionsFullControl: Boolean
        read GetMultiActionsFullControl write SetMultiActionsFullControl;
    property HideSessionChartWithoutReserve: Boolean
        read GetHideSessionChartWithoutReserve
        write SetHideSessionChartWithoutReserve;
    property SoundGuestSession: Boolean
        read GetSoundGuestSession write SetSoundGuestSession;

  end;

implementation

uses
  SysUtils,
  DB,
  uGCDataSet,
  frmMain,
  uY2KCommon,
  uY2KString;

{*******************************************************************************
                      class  TRegistryInterface
*******************************************************************************}
constructor TRegistryInterface.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
  FRegistryDontShow := TRegistryDontShow.Create(ARegistryDataSet,
      ARegistryRecord);
end;

destructor TRegistryInterface.Destroy;
begin
  inherited Destroy;
end;


function TRegistryInterface.LocateSoundNegativeBalance: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('bSoundNegativeBalance', '0');
end;

function TRegistryInterface.GetSoundNegativeBalance: Boolean;
begin
  LocateSoundNegativeBalance;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetSoundNegativeBalance(AValue: Boolean);
begin
  LocateSoundNegativeBalance;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInterface.LocateSoundLostLink: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('bSoundLostLink', '0');
end;

function TRegistryInterface.GetSoundLostLink: Boolean;
begin
  LocateSoundLostLink;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetSoundLostLink(AValue: Boolean);
begin
  LocateSoundLostLink;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInterface.LocateSwitchToGC3Win: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('bSwitchToGC3Win', '1');
end;

function TRegistryInterface.GetSwitchToGC3Win: Boolean;
begin
  Result := False;
  try
    LocateSwitchToGC3Win;
    Result := FRegistryRecord.ValueAsBoolean;
  except
  end;
end;

procedure TRegistryInterface.SetSwitchToGC3Win(AValue: Boolean);
begin
  LocateSwitchToGC3Win;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInterface.LocateDontHideIntoSysTray: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('DontHideIntoSysTray', '0');
end;

function TRegistryInterface.GetDontHideIntoSysTray: Boolean;
begin
  LocateDontHideIntoSysTray;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetDontHideIntoSysTray(AValue: Boolean);
begin
  LocateDontHideIntoSysTray;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInterface.LocateActivateMessageTab: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ActivateMessageTab', '0');
end;

function TRegistryInterface.GetActivateMessageTab: Boolean;
begin
  LocateActivateMessageTab;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetActivateMessageTab(AValue: Boolean);
begin
  LocateActivateMessageTab;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInterface.LocateBackColor: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('nBackColor',
      IntToStr(clWindow));
end;

function TRegistryInterface.GetBackColor: Integer;
begin
  LocateBackColor;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryInterface.SetBackColor(AValue: Integer);
begin
  LocateBackColor;
  FRegistryRecord.ValueAsInteger := AValue;
end;

function TRegistryInterface.LocateShowCopmTechInfo: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('bShowTechCompsInfo', '0');
end;

function TRegistryInterface.GetShowCopmTechInfo: Boolean;
begin
  LocateShowCopmTechInfo;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetShowCopmTechInfo(AValue: Boolean);
begin
  LocateShowCopmTechInfo;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInterface.LocateColumnWidth(AnColumnNumber: Integer): Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('column'
      + IntToStr(AnColumnNumber),
      IntToStr(formMain.gridComps.Columns.Items[AnColumnNumber].Width));
end;

function TRegistryInterface.GetColumnWidth(AnColumnNumber: Integer): Integer;
begin
  LocateColumnWidth(AnColumnNumber);
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryInterface.SetColumnWidth(AnColumnNumber: Integer;
    AValue: Integer);
begin
  LocateColumnWidth(AnColumnNumber);
  FRegistryRecord.ValueAsInteger := AValue;
end;


function TRegistryInterface.LocateTableFont: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('TableFont',
      FontToStr(formMain.Font));
end;

function TRegistryInterface.GetTableFont: TFont;
begin
  LocateTableFont;
  Result := StrToFont(FRegistryRecord.Value);
end;

procedure TRegistryInterface.SetTableFont(AValue: TFont);
begin
  LocateTableFont;
  FRegistryRecord.Value := FontToStr(AValue);
end;


function TRegistryInterface.LocateMultiActionsFullControl: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('MultiActionsFullControl', '-1');
end;

function TRegistryInterface.GetMultiActionsFullControl: Boolean;
begin
  LocateMultiActionsFullControl;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetMultiActionsFullControl(AValue: Boolean);
begin
  LocateMultiActionsFullControl;
  FRegistryRecord.ValueAsBoolean := AValue;
end;
//
function TRegistryInterface.LocateHideSessionChartWithoutReserve: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('HideSessionChartWithoutReserve', '0');
end;

function TRegistryInterface.GetHideSessionChartWithoutReserve: Boolean;
begin
  LocateHideSessionChartWithoutReserve;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetHideSessionChartWithoutReserve(AValue: Boolean);
begin
  LocateHideSessionChartWithoutReserve;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInterface.LocateSoundGuestSession: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('GuestSession', '1');
end;

function TRegistryInterface.GetSoundGuestSession: Boolean;
begin
  LocateSoundGuestSession;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetSoundGuestSession(AValue: Boolean);
begin
  LocateSoundGuestSession;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

end.
