//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит описание и реализацию класса TClientOptions.
// Класс предоставляет в виде свойств набор опций для настройки работы
// программы GCClient.
//
// Класс реализован по шаблону Singleton.
// Для доступа к свойствам и методам класса используйте вызовы
// TClientOptions.Instance."MethodName" или вспомогательную переменную ClientOptions.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientOptions;
{$IFDEF LINUX}
  {$DEFINE GCCL}
  {$DEFINE GCCLSRV}
{$ENDIF}

interface

uses
  Classes,
  uY2KCommon,
  uClientOptionsConst,
  uTaskKillConst,
  // project units
{$IFDEF GC3SERVER}
  uRegistry,
  uClientOptionsDBStorage;
{$ELSE}
  {$IFDEF LINUX}
    uClientOptionsIniStorage;
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    uClientOptionsRegistryStorage;
  {$ENDIF}
{$ENDIF}

type

  //
  // TClientOptions
  //

  TClientOptions = class(TObject)
  private
    // fields
{$IFDEF GC3SERVER}
    FClientOptionsStorage: TClientOptionsDBStorage;
{$ELSE}
{$IFDEF LINUX}
    FClientOptionsStorage: TClientOptionsIniStorage;
{$ENDIF}
{$IFDEF MSWINDOWS}
    FClientOptionsStorage: TClientOptionsRegistryStorage;
{$ENDIF}
{$ENDIF}
    FbDirty: Boolean;

    FstrCompNumber: String;
    FbBlockKeyboard: Boolean;
    FbBlockMouse: Boolean;
    FbBlockTasks: Boolean;
    FbBlockDisplay: Boolean;
    FbBlockDisplayByStandby: Boolean;
    FbStartBlock: Boolean;
    FnStartBlockSec: Integer;
    FbOfflineBlock: Boolean;
    FstrOfflineBlockType: String;
    FnOfflineBlockTypeImmediatelyMin: Integer;
    FbUnblockPassword: Boolean;
    FstrUnblockPasswordHash: String;
    FbAutoLogoff: Boolean;
    FnAutoLogoffSec: Integer;
    FbAfterStop: Boolean;
    FnAfterStopSec: Integer;
    FstrAfterStopType: String;
    FbSyncTime: Boolean;
    FstrShellMode: String;
    FbUseSounds: Boolean;
    FbUseBaloons: Boolean;
    FbUseTextMessage: Boolean;
    FbUseTextMessageBlinking: Boolean;
    FnUseTextMessageMin: Integer;
    FstrURLCompFree: String;
    FstrURLLogonCompFree: String;
    FstrURLTop: String;
    FstrURLCompFreeAccount: String;
    FstrURLAgreement: String;
    FbAgreement: Boolean;
    FbAllowCardsSupport: Boolean;
    FnLanguage: Integer;
    FlstTarifNames: TStringList;
    FbShowSmallInfo: Boolean;
    FbRunPadHideTabs: Boolean;
    FlstRunPadTabs: TStringList;
    FbRunPadInternetControl: Boolean;
    FstrClientScriptFileName: String;
    FbClientScript: Boolean;
    FbClientScriptHideWindow: Boolean;
    FbRestoreClientInfo: Boolean;
    FlstTaskList: TStringList;
    FTaskKillMode: TTaskKillMode;
    FbAutoInstall: Boolean;
    FbGuestSession: Boolean;
    FbShutdownButton: Boolean;
    FbIsFirstRun: Boolean;
    FstrKDEUser: String;
    FbDebugLog: Boolean;
    FbUseWOL: Boolean;
    FbRunPadShowInfoOnDesktop: Boolean;
    FbRunPadShowInfoOnDesktopText: String;
    FnRunPadMonitorOff: Boolean;
    FnRunPadLockStation: Boolean;

    // private helper methods
    function _GetStringOption(const AstrFolder: String;
        const AstrName: String; const AstrDefaultValue: String): String;
    function _GetIntegerOption(const AstrFolder: String;
        const AstrName: String; const AnDefaultValue: Integer): Integer;
    function _GetBooleanOption(const AstrFolder: String;
        const AstrName: String; const AbDefaultValue: Boolean): Boolean;
    function _GetFloatOption(const AstrFolder: String;
        const AstrName: String; const AfDefaultValue: Double): Double;

  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    class function AccessInstance(
        const ARequest: TSingletonOperation): TClientOptions;

    // properties methods
    procedure SetCompNumber(const AstrCompNumber: String);

    function GetBlockDisplay: Boolean;
    function GetShellMode: TShellMode;
    procedure SetShellMode(const AShellMode: TShellMode);

    function GetAfterStopType(): TAfterStopType;
    procedure SetAfterStopType(const AAfterStopType: TAfterStopType);

    function GetOfflineBlockType(): TOfflineBlockType;
    procedure SetOfflineBlockType(const AOfflineBlockType: TOfflineBlockType);

    procedure SetTarifNames(const AlstTarifNames: TStringList);

    procedure SetURLCompFree(const AstrURLCompFree: String);
    procedure SetURLLogonCompFree(const AstrURLLogonCompFree: String);
    procedure SetURLTop(const AstrURLTop: String);
    procedure SetURLCompFreeAccount(const AstrURLCompFreeAccount: String);
    procedure SetURLAgreement(const AstrURLAgreement: String);

    procedure SetRunPadHideTabs(const AbRunPadHideTabs: Boolean);
    procedure SetRunPadTabs(const AlstRunPadTabs: TStringList);
    procedure SetRunPadInternetControl(const AbRunPadInternetControl: Boolean);
    procedure SetRunPadShowInfoOnDesktop(const AbRunPadShowInfoOnDesktop: Boolean);
    procedure SetRunPadShowInfoOnDesktopText(const AbRunPadShowInfoOnDesktopText: string);

    procedure SetRunPadMonitorOff(const AbRunPadMonitorOff: Boolean);
    procedure SetRunPadLockStation(const AbRunPadLockStation: Boolean);

    procedure SetTaskList(const AlstTaskList: TStringList);
    procedure SetDebugLog(const AValue: Boolean);
  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // class methods
    class function Instance(): TClientOptions;
    class procedure ReleaseInstance();

    // public methods
    procedure Load();
    procedure Save(const AbForced: Boolean = False);
    procedure SetTarifNamesAsText(const AstrTarifNames: String);
    procedure SetRunPadTabsAsText(const AstrRunPadTabs: String);
    procedure SetTaskListAsText(const AstrTaskList: String);
    //ф-ии для сохранения/чтения значений из БД
    procedure SetRunPadHidedTabs(const AstrTarif: String;
        const AlstRunPadHidedTabs: TStringList);
    function GetRunPadHidedTabs(const AstrTarif: String): TStringList;

///    procedure SetDefaultValues();

    // properties
    property Dirty: Boolean
        read FbDirty;
    // номер компьютера
    property CompNumber: String
        read FstrCompNumber write SetCompNumber;
    // блокировать клавиатуру
    property BlockKeyboard: Boolean
        read FbBlockKeyboard write FbBlockKeyboard;
    // блокировать мышь
    property BlockMouse: Boolean
        read FbBlockMouse write FbBlockMouse;
    // снимать задачи при блокировании
    property BlockTasks: Boolean
        read FbBlockTasks write FbBlockTasks;
    // блокировать дисплей
    property BlockDisplay: Boolean
        read GetBlockDisplay write FbBlockDisplay;
    // Выключать монитор в состоянии авторизации при простое
    property BlockDisplayByStandby: Boolean
        read FbBlockDisplayByStandby write FbBlockDisplayByStandby;
   // блокировка сразу после старта компьютера
    property StartBlock: Boolean
        read FbStartBlock write FbStartBlock;
    // кол-во секунд на которое блокирется сразу после старта компьютера
    // (0 - постоянная)
    property StartBlockSec: Integer
        read FnStartBlockSec write FnStartBlockSec;
    // блокировка при обрыве связи
    property OfflineBlock: Boolean
        read FbOfflineBlock write FbOfflineBlock;
    // тип блокировка при обрыве связи
    // (сразу, после окончания сеанса)
    property OfflineBlockType: TOfflineBlockType
        read GetOfflineBlockType write SetOfflineBlockType;
    // (сразу)  = через сколько минут при обрыве связи
    property OfflineBlockTypeImmediatelyMin: Integer
        read FnOfflineBlockTypeImmediatelyMin
        write FnOfflineBlockTypeImmediatelyMin;
    // использовать пароль для разблокировки клиента по CTRL+ALT+U
    property UnblockPassword: Boolean
        read FbUnblockPassword write FbUnblockPassword;
    // строка с хешем пароля для разблокировки клиента по CTRL+ALT+U
    property UnblockPasswordHash: String
        read FstrUnblockPasswordHash write FstrUnblockPasswordHash;
     // блокировка по умолчанию
    property AutoLogoff: Boolean
        read FbAutoLogoff write FbAutoLogoff;
    // кол-во минут, после неактивности которых происходит автоблокирование
    property AutoLogoffSec: Integer
        read FnAutoLogoffSec write FnAutoLogoffSec;
    // действие после окончания сесси (есть/нет)
    property AfterStop: Boolean
        read FbAfterStop write FbAfterStop;
    // кол-во секунд, через которое выполняется
    // действие после окончания сесси
    property AfterStopSec: Integer
        read FnAfterStopSec write FnAfterStopSec;
    // тип действия после окончания сесси
    // (0 - снимать задачи)
    // (1 - Logoff)
    // (2 - Restart)
    // (3 - Shutdown)
    property AfterStopType: TAfterStopType
        read GetAfterStopType write SetAfterStopType;
  // синхронизация времени по серверу
    property SyncTime: Boolean
        read FbSyncTime write FbSyncTime;
    // Шелл-режим
    property ShellMode: TShellMode
        read GetShellMode write SetShellMode;
    // использовать звуки
    property UseSounds: Boolean
        read FbUseSounds write FbUseSounds;
    // использовать Baloons
    property UseBaloons: Boolean
        read FbUseBaloons write FbUseBaloons;
    // использовать текстовое окно
    property UseTextMessage: Boolean
        read FbUseTextMessage write FbUseTextMessage;
    // использовать метод с мерцанием
    property UseTextMessageBlinking: Boolean
        read FbUseTextMessageBlinking write FbUseTextMessageBlinking;
    // кол-во минут до окончания для предупреждения
    property UseTextMessageMin: Integer
        read FnUseTextMessageMin write FnUseTextMessageMin;
    // URL экрана "свободный компьютер"
    property URLCompFree: String
        read FstrURLCompFree write SetURLCompFree;
    // URL экрана "свободный компьютер"
    property URLLogonCompFree: String
        read FstrURLLogonCompFree write SetURLLogonCompFree;
    // URL экрана "свободный компьютер"
    property URLTop: String
        read FstrURLTop write SetURLTop;
    // URL экрана "свободный компьютер"
    property URLLogonHelp: String
        read FstrURLCompFreeAccount write SetURLCompFreeAccount;
    // URL экрана "свободный компьютер"
    property URLAgreement: String
        read FstrURLAgreement write SetURLAgreement;
    // выдавать текст соглашения
    property Agreement: Boolean
        read FbAgreement write FbAgreement;
    // разрешена поддержка клубных карт
    property AllowCardsSupport: Boolean
        read FbAllowCardsSupport write FbAllowCardsSupport;
    // язык интерфейса
    property Language: Integer
        read FnLanguage write FnLanguage;
    // список тарифов для RunPad Shell
    property TarifNames: TStringList
        read FlstTarifNames write SetTarifNames;
    // показывать прозрачное окошко
    property ShowSmallInfo: Boolean
        read FbShowSmallInfo write FbShowSmallInfo;
    // скрывать закладки  RunPad Shell
    property RunPadHideTabs: Boolean
        read FbRunPadHideTabs write SetRunPadHideTabs;
    // список всех закладок RunPad Shell
    property RunPadTabs: TStringList
        read FlstRunPadTabs write SetRunPadTabs;
    // контролировать Internet в  RunPad Shell
    property RunPadInternetControl: Boolean
        read FbRunPadInternetControl write SetRunPadInternetControl;
    // восстанавливать из реестра ClientInfo после перезагрузки
    property RestoreClientInfo: Boolean
        read FbRestoreClientInfo write FbRestoreClientInfo;
    // список задач для taskkill
    property TaskList: TStringList
        read FlstTaskList write SetTaskList;
    property TaskKillMode: TTaskKillMode
        read FTaskKillMode write FTaskKillMode;
    // показывать кнпку "Гость"
    property GuestSession: Boolean
        read FbGuestSession write FbGuestSession;
    property ShutdownButton: Boolean
        read FbShutdownButton write FbShutdownButton;
    // Пытаться автоматически включить оплаченый компьютер
    property UseWOL: Boolean
        read FbUseWOL write FbUseWOL;
    // Выводить текст нарабочем столе RunPad
    property RunPadShowInfoOnDesktop: Boolean
        read FbRunPadShowInfoOnDesktop  write SetRunPadShowInfoOnDesktop;
    // Текст выводимый нарабочем столе RunPad
    property RunPadShowInfoOnDesktopText: String
        read FbRunPadShowInfoOnDesktopText write SetRunPadShowInfoOnDesktopText;

    property RunPadMonitorOff: Boolean
        read FnRunPadMonitorOff  write SetRunPadMonitorOff;
    property RunPadLockStation: Boolean
        read FnRunPadLockStation  write SetRunPadLockStation;



{    // еще не используется
    property AutoInstall: Boolean
        read FbAutoInstall write FbAutoInstall;
 }
    // особые проперти (не записывается на сервере)
    // имя файла скрипта на клиенте
    property ClientScriptFileName: String
      read FstrClientScriptFileName write FstrClientScriptFileName;
    property ClientScript: Boolean
      read FbClientScript write FbClientScript;
    property ClientScriptHideWindow: Boolean
      read FbClientScriptHideWindow write FbClientScriptHideWindow;
    property IsFirstRun: Boolean
      read FbIsFirstRun write FbIsFirstRun;
    property KDEUser: String
      read FstrKDEUser write FstrKDEUser;
    property DebugLog: Boolean
      read FbDebugLog write SetDebugLog;
  end; // TClientOptions


var
  GClientOptions: TClientOptions;


implementation

uses
  // system units
  SysUtils,
  // project units
{$IFDEF GCCL}
  ufrmMain,
  uSafeStorage,
  uClientConst,
  Types,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
//  ActiveX,
//  RS_APILib_TLB,
  uClientInfo,
  uClientInfoConst,
{$ENDIF}
  uDebugLog
{$IFDEF GC3SERVER}
  ,uRegistryScripts
{$ENDIF}
  ;



//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// Exceptions: EAssertionFailed
constructor TClientOptions.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));

end; // TClientOptions.Create


constructor TClientOptions.CreateInstance();
begin
  inherited Create();
  FbDirty := True;

  FlstTarifNames := TStringList.Create;
  FlstRunPadTabs := TStringList.Create;
  FlstTaskList := TStringList.Create;

{$IFDEF GC3SERVER}
  FClientOptionsStorage := TClientOptionsDBStorage.Create(COMPANY_NAME,
      PRODUCT_NAME);
{$ELSE}
{$IFDEF LINUX}
  FClientOptionsStorage := TClientOptionsIniStorage.Create(COMPANY_NAME,
      PRODUCT_NAME);
{$ENDIF}
{$IFDEF MSWINDOWS}
  FClientOptionsStorage := TClientOptionsRegistryStorage.Create(COMPANY_NAME,
      PRODUCT_NAME);
{$ENDIF}
{$ENDIF}

end; // TClientOptions.CreateInstance


destructor TClientOptions.Destroy();
begin
  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  FreeAndNilWithAssert(FClientOptionsStorage);
  FreeAndNilWithAssert(FlstTarifNames);
  FreeAndNilWithAssert(FlstRunPadTabs);
  FreeAndNilWithAssert(FlstTaskList);

  inherited Destroy();

end; // TClientOptions.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// class methods

class function TClientOptions.AccessInstance(
    const ARequest: TSingletonOperation): TClientOptions;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TClientOptions = nil;
begin
  case ARequest of
    SinglOper_Access: begin
      // do nothing
    end;

    SinglOper_Create: begin
      if not Assigned(FInstance) then begin
        FInstance := CreateInstance();
      end;
    end;

    SinglOper_Destroy: begin
      FInstance := nil;
    end;

    else begin
      ASSERT(FALSE,
          Format('Illegal request %d in AccessInstance', [Ord(ARequest)]));
    end;
  end;

  Result := FInstance;

{$WRITEABLECONST OFF}
end; // TClientOptions.AccessInstance


class function TClientOptions.Instance(): TClientOptions;
const
  FInstance: TClientOptions = nil;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TClientOptions.Instance


class procedure TClientOptions.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TClientOptions.ReleaseInstance


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TClientOptions.Load();
begin
  Debug.Trace5('TClientOptions.Load');
try
  FstrCompNumber := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'CompNumber', DEF_COMP_NUMBER);

  FbBlockKeyboard := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'BlockKeyboard', DEF_BLOCK_KEYBOARD);

  FbBlockMouse := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'BlockMouse', DEF_BLOCK_MOUSE);

  FbBlockTasks := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'BlockTasks', DEF_BLOCK_TASKS);

  FbBlockDisplay := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'BlockDisplay', DEF_BLOCK_DISPLAY);

  FbBlockDisplayByStandby := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'BlockDisplayByStandby',
      DEF_BLOCK_DISPLAY_BY_STANDBY);

  FbStartBlock := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'StartBlock', DEF_START_BLOCK);

  FnStartBlockSec := _GetIntegerOption(
      OPTIONS_GENERAL_FOLDER, 'StartBlockSec', DEF_START_BLOCK_SEC);

  FbOfflineBlock := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'OfflineBlock', DEF_OFFLINE_BLOCK);

  FstrOfflineBlockType := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'OfflineBlockType', DEF_OFFLINE_BLOCK_TYPE);

  FnOfflineBlockTypeImmediatelyMin := _GetIntegerOption(
      OPTIONS_GENERAL_FOLDER, 'OfflineBlockTypeImmediatelyMin',
      DEF_OFFLINE_BLOCK_IMMEDIATELY_MIN);

  FbUnblockPassword := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'UnblockPassword', DEF_UNBLOCK_PASSWORD);

  FstrUnblockPasswordHash := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'UnblockPasswordHash', DEF_UNBLOCK_PASSWORD_HASH);

  FbAutoLogoff := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'AutoLogoff', DEF_AUTO_LOGOFF);

  FnAutoLogoffSec := _GetIntegerOption(
      OPTIONS_GENERAL_FOLDER, 'AutoLogoffSec', DEF_AUTO_LOGOFF_SEC);

  FbAfterStop := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'AfterStop', DEF_AFTER_STOP);

  FnAfterStopSec := _GetIntegerOption(
      OPTIONS_GENERAL_FOLDER, 'AfterStopSec', DEF_AFTER_STOP_SEC);

  FstrAfterStopType := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'AfterStopType', DEF_AFTER_STOP_TYPE);

  FbSyncTime := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'SyncTime', DEF_SYNC_TIME);

  FstrShellMode := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'ShellMode', DEF_SHELL_MODE);

  FbUseSounds := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'UseSounds', DEF_USE_SOUNDS);

  FbUseBaloons := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'UseBaloons', DEF_USE_BALOONS);

  FbUseTextMessage := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'UseTextMessage', DEF_USE_TEXT_MESSAGE);

  FbUseTextMessageBlinking := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'UseTextMessageBlinking',
      DEF_USE_TEXT_MESSAGE_BLINKING);

  FnUseTextMessageMin := _GetIntegerOption(
      OPTIONS_GENERAL_FOLDER, 'UseTextMessageMin', DEF_USE_TEXT_MESSAGE_MIN);

  URLCompFree := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'URLCompFree', DEF_URL_COMP_FREE);

  URLLogonCompFree := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'URLLogonCompFree', DEF_URL_LOGON_COMP_FREE);

  URLTop := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'URLTop', DEF_URL_TOP);

  URLLogonHelp := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'URLCompFreeAccount', DEF_URL_ACCOUNT);

  URLAgreement := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'URLAgreement', DEF_URL_AGREEMENT);

  FbAgreement := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'Agreement', DEF_AGREEMENT);

  FbAllowCardsSupport := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'AllowCardsSupport', DEF_ALLOW_CARDS_SUPPORT);

  FnLanguage := _GetIntegerOption(
      OPTIONS_GENERAL_FOLDER, 'Language', DEF_LANGUAGE);
  //Нужно для обработки
  SetTarifNamesAsText(_GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'TarifNames', DEF_TARIFNAMES));

  FbShowSmallInfo :=  _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'ShowSmallInfo', DEF_SHOW_SMALLINFO);

{$IFDEF MSWINDOWS}
  SetRunPadHideTabs(_GetBooleanOption(OPTIONS_GENERAL_FOLDER,
      'RunPadHideTabs', DEF_RUNPADHIDETABS));

  SetRunPadTabsAsText(_GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'RunPadTabs', DEF_RUNPADTABS));

  SetRunPadInternetControl(_GetBooleanOption(OPTIONS_GENERAL_FOLDER,
      'RunPadInternetControl', DEF_RUNPADCONTROLINTERNET));

  FbRunPadShowInfoOnDesktop := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'RunPadShowInfoOnDesktop', DEF_RunPadShowInfoOnDesktop);

  FbRunPadShowInfoOnDesktopText := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'RunPadShowInfoOnDesktopText',
      DEF_RunPadShowInfoOnDesktopText);

{$ENDIF}

  FbRestoreClientInfo := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'RestoreClientInfo',
      DEF_RESTORE_CLIENT_INFO);

  FbAutoInstall := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'AutoInstall',
      DEF_AUTO_INSTALL);
  {$IFDEF GC3SERVER}
  FstrClientScriptFileName := ExtractFileName(GRegistry.Scripts.OnClientPath);
  FbClientScript := GRegistry.Scripts.OnClient;
  FbClientScriptHideWindow := GRegistry.Scripts.OnClientHideWindow;
  SetTaskList(GRegistry.TaskKill.Template);
  FTaskKillMode := GRegistry.TaskKill.Mode;
  FbGuestSession := GRegistry.Client.GuestSession;

  FbShutdownButton := GRegistry.Client.ShutdownButton;

  FbUseWOL := GRegistry.Client.UseWOL;



  SetDebugLog(GRegistry.Options.DebugLog);
  {$ELSE}
  FstrClientScriptFileName := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'ClientScriptFileName',
      DEF_CLIENT_SCRIPT_FILE_NAME);
  FbClientScript := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'ClientScript',
      DEF_CLIENT_SCRIPT);
  FbClientScriptHideWindow := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'ClientScriptHideWindow',
      DEF_CLIENT_SCRIPT_HIDE_WINDOW);
  SetTaskListAsText(_GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'TaskList', DEF_TASKLIST));
  FTaskKillMode := TTaskKillMode(_GetIntegerOption(
      OPTIONS_GENERAL_FOLDER, 'TaskKillMode', DEF_TASKKILLMODE));
  FbGuestSession := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'GuestSession',
      DEF_GUEST_SESSION);
  FbShutdownButton := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'ShutdownButton',
      DEF_SHUTDOWN_BUTTON);
  FbUseWOL := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'UseWOL',
      DEF_USE_WOL);

  SetDebugLog(_GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'DebugLog',
      DEF_DEBUG));
  {$ENDIF}
  FbIsFirstRun := _GetBooleanOption(
      OPTIONS_GENERAL_FOLDER, 'IsFirstRun', DEF_IS_FIRST_RUN);
  FstrKDEUser := _GetStringOption(
      OPTIONS_GENERAL_FOLDER, 'KDEUser', DEF_KDE_USER);

  FbDirty := False;
except
  on e: Exception do begin
    Debug.Trace0('TclientOptions load Error! ' + e.Message);
  end;
end;

  Debug.Trace5('TClientOptions.Loaded');
end; // TClientOptions.Load


procedure TClientOptions.Save(const AbForced: Boolean = False);
begin
  if FbDirty or AbForced then begin
    Debug.Trace5('TClientOptions.Save');
try
    with FClientOptionsStorage do begin
      SaveOption(OPTIONS_GENERAL_FOLDER, 'CompNumber', FstrCompNumber);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'BlockKeyboard', FbBlockKeyboard);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'BlockMouse', FbBlockMouse);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'BlockTasks', FbBlockTasks);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'BlockDisplay', FbBlockDisplay);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'BlockDisplayByStandby',
          FbBlockDisplayByStandby);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'StartBlock', FbStartBlock);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'StartBlockSec', FnStartBlockSec);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'OfflineBlock', FbOfflineBlock);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'OfflineBlockType', FstrOfflineBlockType);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'OfflineBlockTypeImmediatelyMin',
          FnOfflineBlockTypeImmediatelyMin);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'UnblockPassword', FbUnblockPassword);
      SaveOption(OPTIONS_GENERAL_FOLDER,
        'UnblockPasswordHash', FstrUnblockPasswordHash);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'AutoLogoff', FbAutoLogoff);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'AutoLogoffSec', FnAutoLogoffSec);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'AfterStop', FbAfterStop);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'AfterStopSec', FnAfterStopSec);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'AfterStopType', FstrAfterStopType);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'SyncTime', FbSyncTime);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'ShellMode', FstrShellMode);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'UseSounds', FbUseSounds);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'UseBaloons', FbUseBaloons);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'UseTextMessage', FbUseTextMessage);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'UseTextMessageBlinking',
          FbUseTextMessageBlinking);
      SaveOption(OPTIONS_GENERAL_FOLDER,
        'UseTextMessageMin', FnUseTextMessageMin);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'URLCompFree', FstrURLCompFree);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'URLTop', FstrURLTop);
      SaveOption(OPTIONS_GENERAL_FOLDER,
        'URLCompFreeAccount', FstrURLCompFreeAccount);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'URLAgreement', FstrURLAgreement);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'Agreement', FbAgreement);
      SaveOption(OPTIONS_GENERAL_FOLDER,
        'AllowCardsSupport', FbAllowCardsSupport);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'Language', FnLanguage);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'TarifNames', FlstTarifNames.Text);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'ShowSmallInfo', FbShowSmallInfo);

{$IFDEF MSWINDOWS}
      SaveOption(OPTIONS_GENERAL_FOLDER, 'RunPadHideTabs',
          FbRunPadHideTabs);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'RunPadTabs', FlstRunPadTabs.Text);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'RunPadInternetControl',
          FbRunPadInternetControl);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'RunPadShowInfoOnDesktop', FbRunPadShowInfoOnDesktop);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'RunPadShowInfoOnDesktopText', FbRunPadShowInfoOnDesktopText );
{$ENDIF}
      SaveOption(OPTIONS_GENERAL_FOLDER, 'RestoreClientInfo',
          FbRestoreClientInfo);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'AutoInstall',
          FbAutoInstall);
{$IFDEF GC3SERVER}
      GRegistry.Client.ShutdownButton := FbShutdownButton;
{$ELSE}
      SaveOption(OPTIONS_GENERAL_FOLDER, 'ClientScriptFileName',
          FstrClientScriptFileName);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'ClientScript',
          FbClientScript);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'ClientScriptHideWindow',
          FbClientScriptHideWindow);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'TaskList', FlstTaskList.Text);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'GuestSession', FbGuestSession);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'ShutdownButton', FbShutdownButton);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'UseWOL', FbUseWOL);
      SaveOption(OPTIONS_GENERAL_FOLDER, 'TaskKillMode',
          Integer(FTaskKillMode));
      SaveOption(OPTIONS_GENERAL_FOLDER, 'DebugLog',
          FbDebugLog);
{$ENDIF}
      //Сохраняем False чтобы при следующем запуске было False
      SaveOption(OPTIONS_GENERAL_FOLDER, 'IsFirstRun', False);
      //KDEUser не сохраняем вообще, т.к. он записывается инсталлятором
    end; // with
    FbDirty := False;
except
  on e: Exception do begin
    Debug.Trace0('TclientOptions save Error! ' + e.Message);
  end;
end;
    Debug.Trace5('TClientOptions.Saved');
  end;
end; // TClientOptions.Save

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods
procedure TClientOptions.SetTarifNamesAsText(const AstrTarifNames: String);
var
   lstTarifNames: TStringList;
begin
  lstTarifNames := TStringList.Create;
  lstTarifNames.Text := AstrTarifNames;
  SetTarifNames(lstTarifNames);
  lstTarifNames.Free;
end; // TClientOptions.SetTarifNamesAsText

procedure TClientOptions.SetRunPadTabsAsText(const AstrRunPadTabs: String);
var
   lstRunPadTabs: TStringList;
begin
  lstRunPadTabs := TStringList.Create;
  lstRunPadTabs.Text := AstrRunPadTabs;
  SetRunPadTabs(lstRunPadTabs);
  lstRunPadTabs.Free;
end; // TClientOptions.SetRunPadTabsAsText

procedure TClientOptions.SetRunPadHidedTabs(const AstrTarif: String;
    const AlstRunPadHidedTabs: TStringList);
var
  lstRunPadHidedTabs: TStringList;
begin
  lstRunPadHidedTabs := GetRunPadHidedTabs(AstrTarif);
  if lstRunPadHidedTabs.Text <> AlstRunPadHidedTabs.Text then begin
    FbDirty := True;
    FClientOptionsStorage.SaveOption(OPTIONS_GENERAL_FOLDER, 'RunPadHidedTabs\'
        + AstrTarif, AlstRunPadHidedTabs.Text);
  end;
  lstRunPadHidedTabs.Free;
end;

function TClientOptions.GetRunPadHidedTabs(const AstrTarif: String): TStringList;
var
   lstRunPadHidedTabs: TStringList;
   strRunPadHidedTabs: String;
begin
  lstRunPadHidedTabs := TStringList.Create;
  strRunPadHidedTabs := _GetStringOption(
    OPTIONS_GENERAL_FOLDER, 'RunPadHidedTabs\'+AstrTarif, '');
  lstRunPadHidedTabs.Text := strRunPadHidedTabs;
  Result := lstRunPadHidedTabs;
end;

procedure TClientOptions.SetTarifNames(const AlstTarifNames: TStringList);
begin
  if FlstTarifNames.Text <> AlstTarifNames.Text then begin
    FbDirty := True;
    FlstTarifNames.Text := AlstTarifNames.Text;
{$IFDEF GCCL}
//  SendMessage(frmMain.Handle,WM_USER_THREADSAFE_UPDATE,
//      lParam(ThreadSafeOperation_RunPad),0);
{$ENDIF}
  end;
end; // TClientOptions.SetTarifNames

procedure TClientOptions.SetRunPadHideTabs(
    const AbRunPadHideTabs: Boolean);
begin
  if FbRunPadHideTabs <> AbRunPadHideTabs then begin
    FbDirty := True;
    FbRunPadHideTabs := AbRunPadHideTabs;
{$IFDEF GCCL}
   //скрываем закладки в рападе
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
        Integer(RunPadAction_HideTabs));
{$ENDIF}
  end;
end; // TClientOptions.SetRunPadInternetControl

procedure TClientOptions.SetRunPadTabs(const AlstRunPadTabs: TStringList);
begin
  if FlstRunPadTabs.Text <> AlstRunPadTabs.Text then begin
    FbDirty := True;
    FlstRunPadTabs.Text := AlstRunPadTabs.Text;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
        Integer(RunPadAction_HideTabs));
{$ENDIF}
  end;
end; // TClientOptions.SetTarifNames

procedure TClientOptions.SetRunPadInternetControl(
    const AbRunPadInternetControl: Boolean);
begin
  if FbRunPadInternetControl <> AbRunPadInternetControl then begin
    FbDirty := True;
    FbRunPadInternetControl := AbRunPadInternetControl;
{$IFDEF GCCL}
   //скрываем закладки в рападе
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction,
        Integer(RunPadAction_HideTabs));
{$ENDIF}
  end;
end; // TClientOptions.SetRunPadInternetControl

procedure TClientOptions.SetRunPadShowInfoOnDesktop(
    const AbRunPadShowInfoOnDesktop: Boolean);
begin
  if FbRunPadShowInfoOnDesktop <> AbRunPadShowInfoOnDesktop then begin
    FbDirty := True;
    FbRunPadShowInfoOnDesktop := AbRunPadShowInfoOnDesktop;
{$IFDEF GCCL}
{$ENDIF}
  end;
end; // TClientOptions.SetRunPadShowInfoOnDesktop

procedure TClientOptions.SetRunPadShowInfoOnDesktopText(
    const AbRunPadShowInfoOnDesktopText: string);
begin
  if FbRunPadShowInfoOnDesktopText <> AbRunPadShowInfoOnDesktopText then begin
    FbDirty := True;
    FbRunPadShowInfoOnDesktopText := AbRunPadShowInfoOnDesktopText;
{$IFDEF GCCL}
{$ENDIF}
  end;
end; // TClientOptions.SetRunPadShowInfoOnDesktopText

procedure TClientOptions.SetRunPadMonitorOff(
    const AbRunPadMonitorOff: Boolean);
begin
  if FnRunPadMonitorOff <> AbRunPadMonitorOff then begin
//    FbDirty := True;
    FnRunPadMonitorOff := AbRunPadMonitorOff;
{$IFDEF GCCL}
  if AbRunPadMonitorOff then
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction, Integer(RunPadAction_MonitorOff ),'')
  else
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction, Integer(RunPadAction_MonitorOn ),'')
{$ENDIF}
  end;
end; // TClientOptions.SetRunPadMonitorOff

procedure TClientOptions.SetRunPadLockStation(
    const AbRunPadLockStation: Boolean);
begin
  if FnRunPadLockStation <> AbRunPadLockStation then begin
//    FbDirty := True;
    FnRunPadLockStation := AbRunPadLockStation;
{$IFDEF GCCL}
  if AbRunPadLockStation then
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction, Integer(RunPadAction_LockStation ),'')
  else
    TSafeStorage.Instance().Push(ThreadSafeOperation_RunPadAction, Integer(RunPadAction_UnlockStation ),'')
{$ENDIF}
  end;
end; // TClientOptions.SetRunPadMonitorOff

procedure TClientOptions.SetCompNumber(
    const AstrCompNumber: String);
begin
  if FstrCompNumber <> AstrCompNumber then begin
    FbDirty := True;
    FstrCompNumber := AstrCompNumber;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateCompNumber, 0);
{$ENDIF}
  end;
end; // TClientOptions.SetCompNumber

function TClientOptions.GetBlockDisplay: Boolean;
begin
  Result := FbBlockDisplay
{$IFDEF GCCL}
      and ((GClientInfo.ClientState = ClientState_Blocked)
      or ((GClientInfo.ClientState = ClientState_Authentication)
      and FbBlockDisplayByStandby
      and GClientInfo.IsStandby));
{$ENDIF}
  ;
end; // TClientOptions.GetBlockDisplay

function TClientOptions.GetShellMode: TShellMode;
begin
  if CompareText(FstrShellMode, RUNPAD_SHELL) = 0 then begin
    Result := ShellMode_Runpad;
  end else begin
    Result := ShellMode_Unknown;
  end;
end; // TClientOptions.GetShellMode


// Exceptions: EAssertionFailed
procedure TClientOptions.SetShellMode(const AShellMode: TShellMode);
var
  strShellMode: String;
begin
  case AShellMode of
    ShellMode_Runpad:
      strShellMode := RUNPAD_SHELL;
    ShellMode_Unknown:
      strShellMode := UNKNOWN_SHELL;
    else begin
      strShellMode := UNKNOWN_SHELL;
      ASSERT(FALSE, 'SetShellMode error! Unknown shell type.');
    end;
  end;
  if FstrShellMode <> strShellMode then begin
    FbDirty := True;
    FstrShellMode := strShellMode;
  end;
end; // TClientOptions.SetShellMode

function TClientOptions.GetAfterStopType(): TAfterStopType;
begin
  if CompareText(FstrAfterStopType,'KillTask') = 0  then
    Result := AfterStopType_KillTask
  else if CompareText(FstrAfterStopType,'Logoff') = 0  then
    Result := AfterStopType_Logoff
  else if CompareText(FstrAfterStopType,'Restart') = 0  then
    Result := AfterStopType_Restart
  else if CompareText(FstrAfterStopType,'Shutdown') = 0  then
    Result := AfterStopType_Shutdown
  else begin
    Result := AfterStopType_KillTask;
    ASSERT(FALSE, 'GetAfterStopType error! Unknown AfterStop type.');
  end;

end; // TClientOptions.GetAfterStopType


// Exceptions: EAssertionFailed
procedure TClientOptions.SetAfterStopType(const AAfterStopType: TAfterStopType);
var
  strAfterStopType: String;
begin
  case AAfterStopType of
    AfterStopType_KillTask: strAfterStopType := 'KillTask';
    AfterStopType_Logoff: strAfterStopType := 'Logoff';
    AfterStopType_Restart: strAfterStopType := 'Restart';
    AfterStopType_Shutdown: strAfterStopType := 'Shutdown';
    else begin
      strAfterStopType := 'KillTask';
      ASSERT(FALSE, 'SetAfterStopType error! Unknown AfterStop type.');
    end;
  end;
  if FstrAfterStopType <> strAfterStopType then begin
    FbDirty := True;
    FstrAfterStopType := strAfterStopType;
  end;
end; // TClientOptions.SetAfterStopType

function TClientOptions.GetOfflineBlockType(): TOfflineBlockType;
begin
   if CompareText(FstrOfflineBlockType,'Immediately') = 0  then
    Result := OfflineBlockType_Immediately
  else if CompareText(FstrOfflineBlockType,'AfterSessionStop') = 0  then
    Result := OfflineBlockType_AfterSessionStop
  else begin
    Result := OfflineBlockType_AfterSessionStop;
    ASSERT(FALSE, 'GetOfflineBlockType error! Unknown OfflineBlock type.');
  end;
end; // TClientOptions.GetOfflineBlockType


// Exceptions: EAssertionFailed
procedure TClientOptions.SetOfflineBlockType(
  const AOfflineBlockType: TOfflineBlockType);
var
  strOfflineBlockType: String;
begin
  case AOfflineBlockType of
    OfflineBlockType_Immediately: strOfflineBlockType := 'Immediately';
    OfflineBlockType_AfterSessionStop: strOfflineBlockType := 'AfterSessionStop';
    else begin
      strOfflineBlockType := 'AfterSessionStop';
      ASSERT(FALSE, 'SetOfflineBlockType error! Unknown OfflineBlock type.');
    end;
  end;
  if FstrOfflineBlockType <> strOfflineBlockType then begin
    FbDirty := True;
    FstrOfflineBlockType := strOfflineBlockType;
  end;
end; // TClientOptions.SetOfflineBlockType

procedure TClientOptions.SetURLCompFree(const AstrURLCompFree: String);
begin
  if FstrURLCompFree <> AstrURLCompFree then begin
    FbDirty := True;
    FstrURLCompFree := AstrURLCompFree;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_NavigateWebBrousers, 0);
{$ENDIF}
  end;
end; // TClientOptions.SetURLCompFree

procedure TClientOptions.SetURLLogonCompFree(const AstrURLLogonCompFree: String);
begin
  if FstrURLLogonCompFree <> AstrURLLogonCompFree then begin
    FbDirty := True;
    FstrURLLogonCompFree := AstrURLLogonCompFree;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_NavigateWebBrousers, 0);
{$ENDIF}
  end;
end; // TClientOptions.SetURLCompFree

procedure TClientOptions.SetURLTop(const AstrURLTop: String);
begin
  if FstrURLTop <> AstrURLTop then begin
    FbDirty := True;
    FstrURLTop := AstrURLTop;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_NavigateWebBrousers, 0);
{$ENDIF}
  end;
end; // TClientOptions.SetURLCompFree

procedure TClientOptions.SetURLCompFreeAccount(const AstrURLCompFreeAccount:
  String);
begin
  if FstrURLCompFreeAccount <> AstrURLCompFreeAccount then begin
    FbDirty := True;
    FstrURLCompFreeAccount := AstrURLCompFreeAccount;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_NavigateWebBrousers, 0);
{$ENDIF}
  end;
end; // TClientOptions.SetURLCompFree

procedure TClientOptions.SetURLAgreement(const AstrURLAgreement: String);
begin
  if FstrURLAgreement <> AstrURLAgreement then begin
    FbDirty := True;
    FstrURLAgreement := AstrURLAgreement;
{$IFDEF GCCL}
    TSafeStorage.Instance().Push(ThreadSafeOperation_NavigateWebBrousers, 0);
{$ENDIF}
  end;
end; // TClientOptions.SetURLCompFree

procedure TClientOptions.SetTaskList(const AlstTaskList: TStringList);
begin
  if FlstTaskList.Text <> AlstTaskList.Text then begin
    FbDirty := True;
    FlstTaskList.Text := AlstTaskList.Text;
  end;
end; // TClientOptions.SetTarifNames

procedure TClientOptions.SetTaskListAsText(const AstrTaskList: String);
var
   lstTaskList: TStringList;
begin
  lstTaskList := TStringList.Create;
  lstTaskList.Text := AstrTaskList;
  SetTaskList(lstTaskList);
  lstTaskList.Free;
end; // TClientOptions.SetRunPadTabsAsText

procedure TClientOptions.SetDebugLog(const AValue: Boolean);
begin
  if FbDebugLog <> AValue then begin
    FbDirty := True;
    FbDebugLog := AValue;
  end;
  if AValue then begin
    Debug.Level := 9;
  end;
end; // TClientOptions.SetTarifNames

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TClientOptions._GetStringOption(const AstrFolder: String;
    const AstrName: String; const AstrDefaultValue: String): String;
var
  strValue: String;
  FuncRes: TFunctionResult;
begin
  FuncRes := FClientOptionsStorage.GetOption(AstrFolder, AstrName, strValue);
  if FuncRes = RES_SUCCESS then begin
    Result := strValue;
  end else begin
    Result := AstrDefaultValue;
  end;
end; // TClientOptions._GetStringOption


function TClientOptions._GetIntegerOption(const AstrFolder: String;
    const AstrName: String; const AnDefaultValue: Integer): Integer;
var
  nValue: Integer;
  FuncRes: TFunctionResult;
begin
  FuncRes := FClientOptionsStorage.GetOption(AstrFolder, AstrName, nValue);
  if FuncRes = RES_SUCCESS then begin
    Result := nValue;
  end else begin
    Result := AnDefaultValue;
  end;
end; // TClientOptions._GetIntegerOption


function TClientOptions._GetBooleanOption(const AstrFolder: String;
    const AstrName: String; const AbDefaultValue: Boolean): Boolean;
var
  bValue: Boolean;
  FuncRes: TFunctionResult;
begin
  FuncRes := FClientOptionsStorage.GetOption(AstrFolder, AstrName, bValue);
  if FuncRes = RES_SUCCESS then begin
    Result := bValue;
  end else begin
    Result := AbDefaultValue;
  end;
end; // TClientOptions._GetBooleanOption


function TClientOptions._GetFloatOption(const AstrFolder: String;
    const AstrName: String; const AfDefaultValue: Double): Double;
var
  fValue: Double;
  FuncRes: TFunctionResult;
begin
  FuncRes := FClientOptionsStorage.GetOption(AstrFolder, AstrName, fValue);
  if FuncRes = RES_SUCCESS then begin
    Result := fValue;
  end else begin
    Result := AfDefaultValue;
  end;
end; // TClientOptions._GetFloatOption


initialization

  GClientOptions := TClientOptions.Instance();

finalization

  TClientOptions.ReleaseInstance();

end.
