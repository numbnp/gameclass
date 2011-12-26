unit gcconst;

interface

{$IFDEF MSWINDOWS}
uses Graphics;
{$ENDIF}
{$IFDEF LINUX}
uses QGraphics;
{$ENDIF}

const
  // misc2
  BASE_VERSION = '3.85.2';
  APP_VERSION = '3.85.2.10.4 Free';
  STR_UNREGISTERED_VERSION = 'Unregistered trial version';
  GC_HARDWARE_CONTROL = 'GCHardwareControl';
  GC_PRINTER_CONTROL = 'GCPrinterControl';
  GC_INTERNET_CONTROL = 'GCInternetControl';
 // GC_INTERNET_CONTROL_LINUX ='GCInternetControlLinux';
  GC_INTERNET_CONTROL_COM_LINUX ='GCInternetControlComLinux';

  // Trial Limited
  LIMIT_ACCOUNTS_TRIAL = 30;
  FUCKED_PASS = 'fuckedpass';

  // Interface
  WIDTH_COMPINFO_WINDOW = 200;
  
  // Sockets
  READPORT = 3773;
  SENDPORT = 3774;
  SENDPORT_UNIXSERVER = 3775;
  MAXIMUM_LOST_PINGS = 3;
  GLOBAL_TIMER = 5; // секунды
  MAXIMUM_FAILED_AUTHENTICATIONS = 3;

  // id тарифа REMONT
  ID_TARIF_REMONT = 0;

  // help
  HELP_PREFIX = 'mk:@MSITStore:';
  HELP_FILE_RUS = 'GCServerRus.chm';
  HELP_FILE_ENG = 'GCServerEng.chm';
  HELP_SETTINGS_TARIFS = 'Настройка тарифов';
  HELP_SERVICES = 'Услуги';
  HELP_BEGIN = 'Заглавная страница';
  HELP_BOSSOPTIONS_RIGHTS  = 'Персонал и права на функции';
  HELP_BOSSOPTIONS_OPTIONS  = 'Общие настройки';
  HELP_BOSSOPTIONS_SIDELINE  = 'Услуги';
  HELP_BOSSOPTIONS_USERS  = 'Персонал и права на функции';
  HELP_BOSSOPTIONS_COMPUTERS  = 'Компьютеры';
  HELP_REGISTRATION = 'Регистрация';
  HELP_FAQ_ERR_SQLCONNECT =
      'Часто задаваемые вопросы#Ошибка подключения к SQL-серверу';
  HELP_KILL_TASKS = 'Удаленное завершение процессов';
  HELP_ACCOUNTS = 'Учетные записи';
  HELP_CUSTOM_REPORTS = 'Отчеты';

  // misc
  FORM_MAIN_CAPTION = 'GameClass3 Server';
  LANGUAGE_FILENAME = 'GCServer.lng';
  GUARD_FILENAME = 'GCKern.dll';
  KKM_FOLDER = 'KKM';

  // диалоги с чекбоксом "больше не показывать это сообщение"
  DONTSHOW_MANAGER_FIRST_LOGON = 'dontshowManagerFirstLogon';
  DONTSHOW_MANAGER_EMPTY_PASSWORD = 'dontshowManagerEmptyPassword';
  DONTSHOW_NEW_DISCOUNT_INFO = 'dontshowNewDiscountInfo';
  DONTSHOW_INPUT_IN_TARIFS = 'dontshowInputInTarifs';
  DONTSHOW_SQLCONNECT_ERROR = 'dontshowSqlConnectError';
  DONTSHOW_MDAC_OLD_VERSION = 'dontshowMDACOldVersion';
  DONTSHOW_CLUB_INFO_FILE_ACCESS_ERROR = 'dontshowClubInfoFileAccessError';
  DONTSHOW_RAW_SOCKET_WARNING = 'dontshowRawSocketWarning';

  // типы пересечений
  INTERSECT_NOT = 0;            // нет пересечений
  INTERSECT_ALL = 1;            // интервал перекрыт полностью
  INTERSECT_MIDDLE = 2;         // перекрыта середина интервала
  INTERSECT_LEFT = 3;           // перекрыта левая часть интервала  
  INTERSECT_RIGHT = 4;          // перекрыта правая часть интервала
  INTERSECT_LEFTRIGHT = 5;      // перекрыта левая и правая часть интервала

  // типы условий
  CONDITION_EQUAL = '=';
  CONDITION_EQUALMORE = '>=';

  // DataBase
  DS_COMPUTERS_SELECT = 'ComputersSelect';
  DS_FUNCTIONS_SELECT = 'FunctionsSelect';
  DS_CONTROLCLUB_START = 'UnControlClubStart';
  DS_CONTROLCLUB_TIMER = 'UnControlClubTimer';
  DS_CONTROLCOMP_START = 'UnControlCompStart';
  DS_CONTROLCOMP_TIMER = 'UnControlCompTimer';
  DS_INIT_DATABASE = 'OnInitDatabase';
  DS_GET_LOGONINFO = 'GetLogonInfo';
  DS_SESSION_SAVE = 'SessionsSave';
  DS_SESSIONS_SELECT = 'SessionsSelect';
  DS_SESSIONS_FUTURE_SELECT = 'SessionsFutureSelect';
  DS_SESSIONS_ADD_MONEY = 'SessionsAddMoney';
  DS_SESSIONS_TRAFFIC_PAYMENT = 'SessionsTrafficPayment';
  DS_SESSIONS_UPDATE_PENALTY = 'SessionsUpdatePenalty';
  DS_SESSIONS_UPDATE = 'SessionsUpdate';
  DS_SESSIONS_CHANGE_TARIFF = 'SessionsChangeTariff';
  DS_REGISTRY_SAVE = 'RegistryInsert';
  DS_REGISTRY_LOAD = 'RegistrySelectByKey';
  DS_COMPUTERS_MOVE = 'SessionsMoveComps';
  DS_SESSIONS_STOPIT = 'SessionsStopIt';
  DS_REPORT_CURRENT = 'ReportCurrent';
  DS_REPORT_CURENT_INSERT = 'ReportCurrentInsert';
  DS_PASS_CHANGE = 'secChangePass';
  DS_TARIFS_SELECT = 'TarifsSelect';
  DS_LOGS_INSERT = 'LogsInsert';
  DS_COMPUTERS_ADD = 'ComputersAdd';
  DS_COMPUTERS_DELETE = 'ComputersDelete';
  DS_COMPUTERS_UPDATE = 'ComputersUpdate';
  DS_COMPUTERGROUPS_SELECT = 'ComputerGroupsSelect';
  DS_COMPUTERGROUPS_ADD = 'ComputerGroupsAdd';
  DS_COMPUTERGROUPS_DELETE = 'ComputerGroupsDelete';
  DS_COMPUTERGROUPS_UPDATE = 'ComputerGroupsUpdate';
  DS_TARIFS_MOVEUP = 'TarifsMoveUp';
  DS_TARIFS_ADD = 'TarifsAdd';
  DS_TARIFS_DELETE = 'TarifsDelete';
  DS_TARIFS_UPDATE = 'TarifsUpdate';
  DS_TARIFSVARIANTS_SELECT = 'TarifsVariantsSelect';
  DS_TARIFSVARIANTS_DELETE = 'TarifsVariantsDelete';
  DS_TARIFSVARIANTS_ADD = 'TarifsVariantsAdd';
  DS_TARIFSVARIANTS_UPDATE = 'TarifsVariantsUpdate';
  DS_RIGHTS_SELECT = 'RightsSelect';
  DS_RIGHTS_UPDATE = 'RightsUpdate';
  DS_USERS_SELECT = 'UsersSelect';
  DS_USERS_DELETE = 'UsersDelete';
  DS_USERS_CREATE = 'UsersCreate';
  DS_USERS_CHANGEPASS = 'UsersChangePass';
  DS_GROUPS_SELECT = 'GroupsSelect';
  DS_SESSIONS_READ_UNCONTROLSTATE = 'SessionsReadUncontrolState';
  DS_CLEAR_STATISTICS = 'ClearStatistics';
  DS_SERVICESBASE_SELECT = 'ServicesBaseSelect';
  DS_SERVICESBASE_ADD = 'ServicesBaseAdd';
  DS_SERVICESBASE_DELETE = 'ServicesBaseDelete';
  DS_SERVICESBASE_UPDATE = 'ServicesBaseUpdate';
  DS_SERVICE_TOSELL = 'ServiceToSell';
  DS_HARDWARE_SELECT = 'HardwareSelect';
  DS_HARDWARE_INSERT = 'HardwareInsert';
  DS_JOURNALOP_SELECT = 'JournalOpSelect';
  DS_MAPPINGS_SELECT = 'MappingsSelect';
  DS_MAPPINGS_ADD = 'MappingsAdd';
  DS_MAPPINGS_DELETE = 'MappingsDelete';
  DS_PRINTER_SCAN = 'PrinterScan';
  DS_PRINTERS_SELECT = 'PrintersSelect';
  DS_ACCOUNTS_SELECT = 'AccountsSelect';
  DS_ACCOUNTS_INSERT = 'AccountsInsert';
  DS_ACCOUNTS_DELETE = 'AccountsDelete';
  DS_ACCOUNTS_UPDATECODES = 'AccountsUpdateCodes';
  DS_ACCOUNTS_UNBLOCK = 'AccountsUnblock';
  DS_ACCOUNTS_UPDATE = 'AccountsUpdate';
  DS_DISCOUNTS_SELECT = 'AccountsDiscountSelect';
  DS_DISCOUNTS_INSERT = 'AccountsDiscountInsert';
  DS_DISCOUNTS_DELETE = 'AccountsDiscountDelete';
  DS_DISCOUNTS_UPDATE = 'AccountsDiscountUpdate';
  DS_ACCOUNTS_MONEYPAY = 'AccountsMoneyPay';
  DS_ACCOUNTS_MONEYRETURN = 'AccountsMoneyReturn';
  DS_ACCOUNTS_MONEYHISTORYSELECT = 'AccountsHistorySelect';
  DS_CUSTOMREPORTS_SELECT = 'CustomReportsSelect';
  DS_CUSTOMREPORTS_ADD = 'CustomReportsAdd';
  DS_CUSTOMREPORTS_DELETE = 'CustomReportsDelete';
  DS_CUSTOMREPORTS_UPDATE = 'CustomReportsUpdate';
  DS_CUSTOMREPORTS_IMPORT = 'CustomReportsImport';
  DS_USAGE_DATE_SELECT = 'UsageDateSelect';
  DS_PROCESS_ADD = 'ProcessAdd';

// Computers
  MAX_COMPUTERS = 300; // максимум компьютеров
  MAX_GROUPS  = 50; //макс групп 
  MAX_TARIFS = 50;
  MAX_TARIFS_VARIANTS = 50;
  MAX_DISCOUNTS = 50;

// Functions
  FN_COMP_START = 'fnCompStart';
  FN_COMP_STOP = 'fnCompStop';
  FN_COMP_MOVE = 'fnCompMove';
  FN_COMP_ADD = 'fnCompAdd';
  FN_REMONT_1 = 'fnRemont1';
  FN_REMONT_LONG = 'fnRemontLong';
  FN_PASS_CHANGE = 'fnPassChange';
  FN_CURRENT_REPORT = 'fnCurrentReport';
  FN_LAST_SESSIONS = 'fnLastSessions';
  FN_CLEAR_STATISTICS = 'fnClearStatistics';
  FN_BOSS_OPTIONS = 'fnBossOptions';
  FN_REMOTE_CONTROL = 'fnRemoteControl';
  FN_SIDELINE = 'fnSideline';
  FN_MANUAL_PRINT = 'fnManualPrint';
  FN_SHELLMODE  = 'fnShellMode';
  FN_SENDMESSAGE = 'fnSendMessage';
  FN_REMOTECLIENTS_MANAGE = 'fnRemoteClientsManage';

  FN_REMOVE_FROM_TASKS_TEMPLATE = 'fnRemoveFromTasksTemplate';
  FN_REMOTE_TASKS_KILLING = 'fnRemoteTasksKilling';
  FN_VIEW_FINANCE_ON_SHIFT_REPORT = 'fnViewFinanceOnShiftReport';

  FN_VOLUME = 'fnVolume';
  FN_CLOSE_SHIFT = 'fnCloseShift';
  FN_COLOR = 'fnColor';
  FN_PENALTY = 'fnPenalty';

  FN_ACCOUNTS_CREATE = 'fnAccountsCreate';
  FN_ACCOUNTS_CLEAR_PASSWORD = 'fnAccountsClearPassword';
  FN_ACCOUNTS_CHANGE_MONEY = 'fnAccountsChangeMoney';

  FN_CHANGE_TARIF = 'fnChangeTarif';

  FN_MANUAL_REMOTE_INSTALL = 'fnManualRemoteInstall';

  FN_RESERVE_ACTIVATE = 'fnReserveActivate';
  FN_RESERVE_CANCEL = 'fnReserveCancel';
  FN_SESSION_TRAFFIC_PAYMENT = 'fnSessionTrafficPayment';

  FN_XREPORT = 'fnXReport';
  FN_ZREPORT = 'fnZReport';

  FN_CUSTOMREPORT = 'CustomReports';
  FN_TIMEBONUS = 'TimeBonus';

// колонки в списке
  COL_COMPUTER = 0;
  COL_STATE = 1;
  COL_TARIF = 2;
  COL_BALANCE = 3;
  COL_START = 4;
  COL_STOP = 5;
  COL_TIME = 6;
  COL_TIMELEFT = 7;
  COL_PRINTED = 8;
  COL_TRAFFIC = 9;
  COL_CLIENT = 10;
  COL_DESCRIPTION = 11;

  // иконки в EVENTS LIST'e
  EVENT_ICON_EMPTY = 0;
  EVENT_ICON_INFORMATION = 1;
  EVENT_ICON_WARNING = 2;
  EVENT_ICON_ERROR = 3;
  EVENT_ICON_MAIL = 4;
  EVENT_ICON_COMPUTER = 5;
  EVENT_ICON_PRINTER = 6;
  // уровни логов
  LEVEL_0 = 0;  // инфа по безопасности !!! для записи !!!
  LEVEL_1 = 1;  // информация для записи
  LEVEL_2 = 2;  // информация не для записи
  LEVEL_ERROR = 127; // ошибки в проге

  // фреймы для окна настроек
  FRAME_COMPUTERS = 0;
  FRAME_USERS = 1;
  FRAME_CLIENTS = 4;
  FRAME_TARIFS = 2;
  FRAME_SIDELINE = 10; // дополнительные товары
  FRAME_RIGHTS = 3;
  FRAME_OPTIONS = 5;
  FRAME_SOUNDS = 6;
  FRAME_PRINTER = 7;
  FRAME_TRAFFIC = 8;
  FRAME_HARDWARE = 9;
  FRAME_GC3CLIENT = 11;
  FRAME_RUNPAD = 12;
  FRAME_SCRIPTS = 13;
  FRAME_KKM = 14;
  FRAME_INTERFACE = 15;
  FRAME_CLIENT_INTERFACE = 16;
  FRAME_TASKKILL = 17;
  FRAME_DISCOUNTS = 18;

  //всякая муть
  READ_UNCONTROLSTATE_TIMEOUT = GLOBAL_TIMER + 1; //задержка в сек. для того чтобы процедура у менеджера
                                   //успевала читать данные записанные оператором
  DS_SELECTION_UNSELECTED = 0;
  DS_SELECTION_SELECTED = 1;
  DS_SELECTION_CURSOR = 2;
  DS_SELECTION_CLICK = 3;

  CLUB_INFO_DIRECTORY = 'ClubInfo';
  CLUB_INFO_NAME_FILENAME = 'club.htm';
  CLUB_INFO_STATE_FILENAME = 'curstate.htm';
  CLUB_INFO_NAME_HTML_BEGIN = '<html><head><title>gameclass</title><meta http-equiv="Content-Type" content="text/html; charset=windows-1251"></head><body><h3>';
  CLUB_INFO_NAME_HTML_END = '</h3></body></html>';
  CLUB_INFO_STATE_HTML_BEGIN = '<html><head><title>GameClass CurrentState</title><meta http-equiv="Content-Type" content="text/html; charset=windows-1251"></head>';
  CLUB_INFO_STATE_HTML_BEGIN2 = '<body><table width="100%" border="1" cellspacing="0" cellpadding="0"><tr><td>Вкл/Выкл</td><td>Компьютер</td><td>Конец сеанса</td><td>Осталось</td></tr>';
  CLUB_INFO_STATE_HTML_END = '</table></body></html>';

  DEF_SCRIPTS_DIRECTORY = 'Scripts';
  DEF_CLIENT_SCRIPT_FILENAME = 'Clinet.vbs';
  DEF_SESSION_SCRIPT_FILENAME = 'Sessions.bat';
  DEF_SERVER_SCRIPT_FILENAME = 'Server.bat';

  SESSIONS_CHART_COLOR_RESERVE = clBlue;
  SESSIONS_CHART_COLOR_ACTIVE = clLime;//RGB(0,255,0);//clGreen;
  SESSIONS_CHART_COLOR_REMONT = clPurple;
  SESSIONS_CHART_COLOR_DESIGNED = clYellow;
  SESSIONS_CHART_COLOR_DESIGNED_BAD = clRed;
  SESSIONS_CHART_COLOR_FINISHED = clGray;
  SESSIONS_CHART_COLOR_BAD = clRed;
//  SESSIONS_CHART_COLOR_ = cl;

  // для функции GetParamFromString;
  PARAM_NOT_EXISTS = 'ParamNotExists$gdsfgdg4g65';

  // Для DTPicker дата отcчета дней но не 0.0
  FIRST_DATE = 36526.0;// 01.01.2000                  
  LAST_DATE = 401769.0;// 01.01.3000                  

implementation

end.

