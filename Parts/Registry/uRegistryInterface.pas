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

    function LocateColumnFieldName(AnColumnNumber: Integer): Boolean;
    function GetColumnFieldName(AnColumnNumber: Integer): String;
    procedure SetColumnFieldName(AnColumnNumber: Integer; AValue: String);

    function LocateMultiActionsFullControl: Boolean;
    function GetMultiActionsFullControl: Boolean;
    procedure SetMultiActionsFullControl(AValue: Boolean);
    function LocateHideSessionChartWithoutReserve: Boolean;
    function GetHideSessionChartWithoutReserve: Boolean;
    procedure SetHideSessionChartWithoutReserve(AValue: Boolean);
    function LocateSoundGuestSession: Boolean;
    function GetSoundGuestSession: Boolean;
    procedure SetSoundGuestSession(AValue: Boolean);
    function LocateSoundEndSession: Boolean;
    function GetSoundEndSession: Boolean;
    procedure SetSoundEndSession(AValue: Boolean);
    function LocateTableFont: Boolean;
    function GetTableFont: TFont;
    procedure SetTableFont(AValue: TFont);
    function LocateBlockedFont: Boolean;
    function GetBlockedFont: TFont;
    procedure SetBlockedFont(AValue: TFont);
    function LocateNotBusyFont: Boolean;
    function GetNotBusyFont: TFont;
    procedure SetNotBusyFont(AValue: TFont);
    function LocateAuthenticatedFont: Boolean;
    function GetAuthenticatedFont: TFont;
    procedure SetAuthenticatedFont(AValue: TFont);
    function LocateReserveFont: Boolean;
    function GetReserveFont: TFont;
    procedure SetReserveFont(AValue: TFont);
    function LocateAccupiedFont: Boolean;
    function GetAccupiedFont: TFont;
    procedure SetAccupiedFont(AValue: TFont);
    function LocatePreventedFont: Boolean;
    function GetPreventedFont: TFont;
    procedure SetPreventedFont(AValue: TFont);
    function LocateShowRunPadPanel: Boolean;
    function GetShowRunPadPanel: Boolean;
    procedure SetShowRunPadPanel(AValue: Boolean);

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

    property ColumnFieldName[AnColumnNumber: Integer]: String
        read GetColumnFieldName write SetColumnFieldName;

    property MultiActionsFullControl: Boolean
        read GetMultiActionsFullControl write SetMultiActionsFullControl;
    property HideSessionChartWithoutReserve: Boolean
        read GetHideSessionChartWithoutReserve
        write SetHideSessionChartWithoutReserve;
    property SoundGuestSession: Boolean
        read GetSoundGuestSession write SetSoundGuestSession;
    property SoundEndSession: Boolean
        read GetSoundEndSession write SetSoundEndSession;
    property TableFont: TFont
        read GetTableFont write SetTableFont;
    property BlockedFont: TFont
        read GetBlockedFont write SetBlockedFont;
    property NotBusyFont: TFont
        read GetNotBusyFont write SetNotBusyFont;
    property AuthenticatedFont: TFont
        read GetAuthenticatedFont write SetAuthenticatedFont;
    property ReserveFont: TFont
        read GetReserveFont write SetReserveFont;
    property AccupiedFont: TFont
        read GetAccupiedFont write SetAccupiedFont;
    property PreventedFont: TFont
        read GetPreventedFont write SetPreventedFont;
    property ShowRunPadPanel: Boolean
        read GetShowRunPadPanel write SetShowRunPadPanel;

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

function TRegistryInterface.LocateColumnFieldName(AnColumnNumber: Integer): Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('columnfieldname'
      + IntToStr(AnColumnNumber) , '' );
end;

function TRegistryInterface.GetColumnFieldName(AnColumnNumber: Integer): String;
begin
  LocateColumnFieldName(AnColumnNumber);
  Result := FRegistryRecord.Value;
end;

procedure TRegistryInterface.SetColumnFieldName(AnColumnNumber: Integer;
    AValue: String);
begin
  LocateColumnFieldName(AnColumnNumber);
  FRegistryRecord.Value := AValue;
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

function TRegistryInterface.LocateBlockedFont: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('BlockedFont',
      FontToStr(formMain.Font));
end;

function TRegistryInterface.GetBlockedFont: TFont;
begin
  LocateBlockedFont;
  Result := StrToFont(FRegistryRecord.Value);
end;

procedure TRegistryInterface.SetBlockedFont(AValue: TFont);
begin
  LocateBlockedFont;
  FRegistryRecord.Value := FontToStr(AValue);
end;

function TRegistryInterface.LocateNotBusyFont: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('notBusyFont',
      FontToStr(formMain.Font));
end;

function TRegistryInterface.GetNotBusyFont: TFont;
begin
  LocateNotBusyFont;
  Result := StrToFont(FRegistryRecord.Value);
end;

procedure TRegistryInterface.SetNotBusyFont(AValue: TFont);
begin
  LocateNotBusyFont;
  FRegistryRecord.Value := FontToStr(AValue);
end;

function TRegistryInterface.LocateAuthenticatedFont: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('AuthenticatedFont',
      FontToStr(formMain.Font));
end;

function TRegistryInterface.GetAuthenticatedFont: TFont;
begin
  LocateAuthenticatedFont;
  Result := StrToFont(FRegistryRecord.Value);
end;

procedure TRegistryInterface.SetAuthenticatedFont(AValue: TFont);
begin
  LocateAuthenticatedFont;
  FRegistryRecord.Value := FontToStr(AValue);
end;

function TRegistryInterface.LocateReserveFont: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('ReserveFont',
      FontToStr(formMain.Font));
end;

function TRegistryInterface.GetReserveFont: TFont;
begin
  LocateReserveFont;
  Result := StrToFont(FRegistryRecord.Value);
end;

procedure TRegistryInterface.SetReserveFont(AValue: TFont);
begin
  LocateReserveFont;
  FRegistryRecord.Value := FontToStr(AValue);
end;

function TRegistryInterface.LocateAccupiedFont: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('AccupiedFont',
      FontToStr(formMain.Font));
end;

function TRegistryInterface.GetAccupiedFont: TFont;
begin
  LocateAccupiedFont;
  Result := StrToFont(FRegistryRecord.Value);
end;

procedure TRegistryInterface.SetAccupiedFont(AValue: TFont);
begin
  LocateAccupiedFont;
  FRegistryRecord.Value := FontToStr(AValue);
end;

function TRegistryInterface.LocatePreventedFont: Boolean;
begin
  Result := FRegistryDataSet.LocateByKeyWithUserName('PreventedFont',
      FontToStr(formMain.Font));
end;

function TRegistryInterface.GetPreventedFont: TFont;
begin
  LocatePreventedFont;
  Result := StrToFont(FRegistryRecord.Value);
end;

procedure TRegistryInterface.SetPreventedFont(AValue: TFont);
begin
  LocatePreventedFont;
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

function TRegistryInterface.LocateSoundEndSession: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('SoundEndSession', '0');
end;

function TRegistryInterface.GetSoundEndSession: Boolean;
begin
  LocateSoundEndSession;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetSoundEndSession(AValue: Boolean);
begin
  LocateSoundEndSession;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryInterface.LocateShowRunPadPanel: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('ShowRunPadPanel', '1');
end;

function TRegistryInterface.GetShowRunPadPanel: Boolean;
begin
  LocateShowRunPadPanel;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryInterface.SetShowRunPadPanel(AValue: Boolean);
begin
  LocateShowRunPadPanel;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

end.
