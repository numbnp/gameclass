unit uRegistryClientOptions;

interface

uses
  uRegistryRecord,
  uRegistryDataSet;

type

  TRegistryClientOptions = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    function LocateCompNumber: Boolean;
    function GetCompNumber: String;
    procedure SetCompNumber(AValue: String);
    function LocateBlockKeyboard: Boolean;
    function GetBlockKeyboard: Boolean;
    procedure SetBlockKeyboard(AValue: Boolean);
    function LocateBlockMouse: Boolean;
    function GetBlockMouse: Boolean;
    procedure SetBlockMouse(AValue: Boolean);
    function LocateBlockTasks: Boolean;
    function GetBlockTasks: Boolean;
    procedure SetBlockTasks(AValue: Boolean);
    function LocateBlockDisplay: Boolean;
    function GetBlockDisplay: Boolean;
    procedure SetBlockDisplay(AValue: Boolean);
    function LocateStartBlock: Boolean;
    function GetStartBlock: Boolean;
    procedure SetStartBlock(AValue: Boolean);
    function LocateStartBlockSec: Boolean;
    function GetStartBlockSec: Boolean;
    procedure SetStartBlockSec(AValue: Boolean);
    function LocateOfflineBlock: Boolean;
    function GetOfflineBlock: Boolean;
    procedure SetOfflineBlock(AValue: Boolean);
    function LocateOfflineBlockType: Boolean;
    function GetOfflineBlockType: Boolean;
    procedure SetOfflineBlockType(AValue: Boolean);
    function LocateOfflineBlockTypeImmediatelyMin: Boolean;
    function GetOfflineBlockTypeImmediatelyMin: Boolean;
    procedure SetOfflineBlockTypeImmediatelyMin(AValue: Boolean);
    function LocateUnblockPassword: Boolean;
    function GetUnblockPassword: Boolean;
    procedure SetUnblockPassword(AValue: Boolean);
    function LocateUnblockPasswordHash: Boolean;
    function GetUnblockPasswordHash: Boolean;
    procedure SetUnblockPasswordHash(AValue: Boolean);
    function LocateAutoLogoff: Boolean;
    function GetAutoLogoff: Boolean;
    procedure SetAutoLogoff(AValue: Boolean);
    function LocateAutoLogoffSec: Boolean;
    function GetAutoLogoffSec: Boolean;
    procedure SetAutoLogoffSec(AValue: Boolean);
    function LocateAfterStopType: Boolean;
    function GetAfterStopType: Boolean;
    procedure SetAfterStopType(AValue: Boolean);
    function LocateSyncTime: Boolean;
    function GetSyncTime: Boolean;
    procedure SetSyncTime(AValue: Boolean);
    function LocateShellMode: Boolean;
    function GetShellMode: Boolean;
    procedure SetShellMode(AValue: Boolean);
    function LocateUseSounds: Boolean;
    function GetUseSounds: Boolean;
    procedure SetUseSounds(AValue: Boolean);
    function LocateUseBaloons: Boolean;
    function GetUseBaloons: Boolean;
    procedure SetUseBaloons(AValue: Boolean);
    function LocateUseTextMessage: Boolean;
    function GetUseTextMessage: Boolean;
    procedure SetUseTextMessage(AValue: Boolean);
    function LocateUseTextMessageBlinking: Boolean;
    function GetUseTextMessageBlinking: Boolean;
    procedure SetUseTextMessageBlinking(AValue: Boolean);
    function LocateUseTextMessageMin: Boolean;
    function GetUseTextMessageMin: Boolean;
    procedure SetUseTextMessageMin(AValue: Boolean);
    function LocateURLCompFree: Boolean;
    function GetURLCompFree: Boolean;
    procedure SetURLCompFree(AValue: Boolean);
    function LocateURLTop: Boolean;
    function GetURLTop: Boolean;
    procedure SetURLTop(AValue: Boolean);
    function LocateURLAccount: Boolean;
    function GetURLAccount: Boolean;
    procedure SetURLAccount(AValue: Boolean);
    function LocateURLAgreement: Boolean;
    function GetURLAgreement: Boolean;
    procedure SetURLAgreement(AValue: Boolean);
    function LocateAgreement: Boolean;
    function GetAgreement: Boolean;
    procedure SetAgreement(AValue: Boolean);
    function LocateAllowCardsSupport: Boolean;
    function GetAllowCardsSupport: Boolean;
    procedure SetAllowCardsSupport(AValue: Boolean);
    function LocateLanguage: Boolean;
    function GetLanguage: Boolean;
    procedure SetLanguage(AValue: Boolean);
    function LocateTarifNames: Boolean;
    function GetTarifNames: Boolean;
    procedure SetTarifNames(AValue: Boolean);
    function Locate: Boolean;
    function Get: Boolean;
    procedure Set(AValue: Boolean);
    function Locate: Boolean;
    function Get: Boolean;
    procedure Set(AValue: Boolean);
    function Locate: Boolean;
    function Get: Boolean;
    procedure Set(AValue: Boolean);
  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

    // properties
    // номер компьютера
    property CompNumber: String
        read GetCompNumber write SetCompNumber;
    // блокировать клавиатуру
    property BlockKeyboard: Boolean
        read GetBlockKeyboard write SetBlockKeyboard;
    // блокировать мышь
    property BlockMouse: Boolean
        read GetBlockMouse write SetBlockMouse;
    // снимать задачи при блокировании
    property BlockTasks: Boolean
        read GetBlockTasks write SetBlockTasks;
    // блокировать дисплей
    property BlockDisplay: Boolean
        read GetBlockDisplay write SetBlockDisplay;
   // блокировка сразу после старта компьютера
    property StartBlock: Boolean
        read GetStartBlock write SetStartBlock;
    // кол-во секунд на которое блокирется сразу после старта компьютера
    // (0 - постоянная)
    property StartBlockSec: Integer
        read GetStartBlockSec write SetStartBlockSec;
    // блокировка при обрыве связи
    property OfflineBlock: Boolean
        read GetOfflineBlock write SetOfflineBlock;
    // тип блокировка при обрыве связи
    // (сразу, после окончания сеанса)
    property OfflineBlockType: TOfflineBlockType
        read GetOfflineBlockType write SetOfflineBlockType;
    // (сразу)  = через сколько минут при обрыве связи
    property OfflineBlockTypeImmediatelyMin: Integer
        read GetOfflineBlockTypeImmediatelyMin
        write SetOfflineBlockTypeImmediatelyMin;
    // использовать пароль для разблокировки клиента по CTRL+ALT+U
    property UnblockPassword: Boolean
        read GetUnblockPassword write SetUnblockPassword;
    // строка с хешем пароля для разблокировки клиента по CTRL+ALT+U
    property UnblockPasswordHash: String
        read GetUnblockPasswordHash write SetUnblockPasswordHash;
     // блокировка по умолчанию
    property AutoLogoff: Boolean
        read GetAutoLogoff write SetAutoLogoff;
    // кол-во минут, после неактивности которых происходит автоблокирование
    property AutoLogoffSec: Integer
        read GetAutoLogoffSec write SetAutoLogoffSec;
    // действие после окончания сесси (есть/нет)
    property AfterStop: Boolean
        read GetAfterStop write SetAfterStop;
    // кол-во секунд, через которое выполняется
    // действие после окончания сесси
    property AfterStopSec: Integer
        read GetAfterStopSec write SetAfterStopSec;
    // тип действия после окончания сесси
    // (0 - снимать задачи)
    // (1 - Logoff)
    // (2 - Restart)
    // (3 - Shutdown)
    property AfterStopType: TAfterStopType
        read GetAfterStopType write SetAfterStopType;
  // синхронизация времени по серверу
    property SyncTime: Boolean
        read GetSyncTime write SetSyncTime;
    // Шелл-режим
    property ShellMode: TShellMode
        read GetShellMode write SetShellMode;
    // использовать звуки
    property UseSounds: Boolean
        read GetUseSounds write SetUseSounds;
    // использовать Baloons
    property UseBaloons: Boolean
        read GetUseBaloons write SetUseBaloons;
    // использовать текстовое окно
    property UseTextMessage: Boolean
        read GetUseTextMessage write SetUseTextMessage;
    // использовать метод с мерцанием
    property UseTextMessageBlinking: Boolean
        read GetUseTextMessageBlinking write SetUseTextMessageBlinking;
    // кол-во минут до окончания для предупреждения
    property UseTextMessageMin: Integer
        read GetUseTextMessageMin write SetUseTextMessageMin;
    // URL экрана "свободный компьютер"
    property URLCompFree: String
        read GetURLCompFree write SetURLCompFree;
    // URL экрана "свободный компьютер"
    property URLTop: String
        read GetURLTop write SetURLTop;
    // URL экрана "свободный компьютер"
    property URLAccount: String
        read GetURLCompFreeAccount write SetURLCompFreeAccount;
    // URL экрана "свободный компьютер"
    property URLAgreement: String
        read GetURLAgreement write SetURLAgreement;
    // выдавать текст соглашения
    property Agreement: Boolean
        read GetAgreement write SetAgreement;
    // разрешена поддержка клубных карт
    property AllowCardsSupport: Boolean
        read GetAllowCardsSupport write SetAllowCardsSupport;
    // язык интерфейса
    property Language: Integer
        read GetLanguage write SetLanguage;
    // список тарифов для RunPad Shell
    property TarifNames: TStringList
        read GetTarifNames write SetTarifNames;
    // показывать прозрачное окошко
    property ShowSmallInfo: Boolean
        read GetShowSmallInfo write SetShowSmallInfo;
    // список скрытых RunPad Shell
    property RunPadHideTabs: Boolean
        read GetRunPadHideTabs write SetRunPadHideTabs;
    // список всех закладок RunPad Shell
    property RunPadTabs: TStringList
        read GetRunPadTabs write SetRunPadTabs;
    // контролировать Internet в  RunPad Shell
    property RunPadIntenetControl: Boolean
        read GetRunPadIntenetControl write SetRunPadIntenetControl;
  end;

implementation

uses
  SysUtils,
  DB, uGCDataSet;

{*******************************************************************************
                      class  TRegistryClientOptions
*******************************************************************************}
constructor TRegistryClientOptions.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryClientOptions.Destroy;
begin
  inherited Destroy;
end;

function TRegistryClientOptions.LocateEnable: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AccountSystem\bEnabled', '0');
end;

function TRegistryClientOptions.GetEnable: Boolean;
begin
  LocateEnable;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClientOptions.SetEnable(AValue: Boolean);
begin
  LocateEnable;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryClientOptions.LocateUseSecurityCodes: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AccountSystem\bUseSecurityCodes',
      '0');
end;

function TRegistryClientOptions.GetUseSecurityCodes: Boolean;
begin
  LocateUseSecurityCodes;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClientOptions.SetUseSecurityCodes(AValue: Boolean);
begin
  LocateUseSecurityCodes;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryClientOptions.LocateBlockIfLogonFailed3Times: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\bBlockIfLogonFailed3times', '1');
end;

function TRegistryClientOptions.GetBlockIfLogonFailed3Times: Boolean;
begin
  LocateBlockIfLogonFailed3Times;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClientOptions.SetBlockIfLogonFailed3Times(AValue: Boolean);
begin
  LocateBlockIfLogonFailed3Times;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryClientOptions.LocateAlwaysAllowAuthentication: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey(
      'AccountSystem\bAlwaysAllowAuthentication', '1');
end;

function TRegistryClientOptions.GetAlwaysAllowAuthentication: Boolean;
begin
  LocateAlwaysAllowAuthentication;
  Result := FRegistryRecord.ValueAsBoolean;
end;

procedure TRegistryClientOptions.SetAlwaysAllowAuthentication(AValue: Boolean);
begin
  LocateAlwaysAllowAuthentication;
  FRegistryRecord.ValueAsBoolean := AValue;
end;

function TRegistryClientOptions.LocateMinAddedSumma: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AccountSystem\minAddedSumma','10');
end;

function TRegistryClientOptions.GetMinAddedSumma: Double;
begin
  LocateMinAddedSumma;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryClientOptions.SetMinAddedSumma(AValue: Double);
begin
  LocateMinAddedSumma;
  FRegistryRecord.ValueAsDouble := AValue;
end;

function TRegistryClientOptions.LocateWarningAddedSumma: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('AccountSystem\warningAddedSumma',
      '100');
end;

function TRegistryClientOptions.GetWarningAddedSumma: Double;
begin
  LocateWarningAddedSumma;
  Result := FRegistryRecord.ValueAsDouble;
end;

procedure TRegistryClientOptions.SetWarningAddedSumma(AValue: Double);
begin
  LocateWarningAddedSumma;
  FRegistryRecord.ValueAsDouble := AValue;
end;
end.
