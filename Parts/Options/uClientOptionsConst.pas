//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит константы ClientOptions.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientOptionsConst;

interface

const
  // значения по умолчанию для опций
  DEF_COMP_NUMBER = '0';
  DEF_BLOCK_KEYBOARD = TRUE;
  DEF_BLOCK_MOUSE = TRUE;
  DEF_BLOCK_TASKS = FALSE;
  DEF_BLOCK_DISPLAY = FALSE;
  DEF_BLOCK_DISPLAY_BY_STANDBY = FALSE;
  DEF_START_BLOCK = TRUE;
  DEF_START_BLOCK_SEC = 0;
  DEF_OFFLINE_BLOCK = TRUE;
  DEF_OFFLINE_BLOCK_TYPE = 'AfterSessionStop';
  DEF_OFFLINE_BLOCK_IMMEDIATELY_MIN = 0;
  DEF_UNBLOCK_PASSWORD = FALSE;
  DEF_UNBLOCK_PASSWORD_HASH = '';
  DEF_AUTO_LOGOFF = TRUE;
  DEF_AUTO_LOGOFF_SEC = 60;
  DEF_AFTER_STOP  = FALSE;
  DEF_AFTER_STOP_SEC = 30;
  DEF_AFTER_STOP_TYPE = 'KillTask';
  DEF_SYNC_TIME = TRUE;
  DEF_SHELL_MODE = 'Unknown';
  DEF_USE_SOUNDS = TRUE;
  DEF_USE_BALOONS = TRUE;
  DEF_USE_TEXT_MESSAGE = TRUE;
  DEF_USE_TEXT_MESSAGE_BLINKING = FALSE;
  DEF_USE_TEXT_MESSAGE_MIN = 5;
  DEF_URL_COMP_FREE = 'comp_free.html';
  DEF_URL_LOGON_COMP_FREE = 'logon_comp_free.html';
  DEF_URL_TOP = 'top.html';
  DEF_URL_ACCOUNT = 'account.html';
  DEF_URL_AGREEMENT = 'agreement.html';
  DEF_AGREEMENT = FALSE;
  DEF_ALLOW_CARDS_SUPPORT = TRUE;
  DEF_LANGUAGE = 2;
  DEF_TARIFNAMES = '';
  DEF_SHOW_SMALLINFO = TRUE;
  DEF_RUNPADCONTROLINTERNET = True;
  DEF_RUNPADHIDETABS = False;
  DEF_RUNPADTABS = 'ACTION' + Chr(13) + Chr(10)
      + 'ADMIN' + Chr(13) + Chr(10)
      + 'INTERNET' + Chr(13) + Chr(10)
      + 'RPG' + Chr(13) + Chr(10)
      + 'ДЛЯ ВЗРОСЛЫХ' + Chr(13) + Chr(10)
      + 'МУЗЫКА' + Chr(13) + Chr(10)
      + 'ПРОГРАММЫ' + Chr(13) + Chr(10)
      + 'СИМУЛЯТОРЫ' + Chr(13) + Chr(10)
      + 'СТРАТЕГИИ' + Chr(13) + Chr(10)
      + 'ФИЛЬМЫ';
  DEF_RESTORE_CLIENT_INFO = False;
  DEF_CLIENT_SCRIPT_FILE_NAME = 'client.bat';
  DEF_CLIENT_SCRIPT = False;
  DEF_CLIENT_SCRIPT_HIDE_WINDOW = False;
  DEF_TASKLIST = 'hl.exe';
  DEF_TASKKILLMODE = 0;
  DEF_AUTO_INSTALL = False;
  DEF_GUEST_SESSION = False;
  DEF_USE_WOL = True;
  DEF_RunPadShowInfoOnDesktop = False;
  DEF_RunPadShowInfoOnDesktopText = '№ %MACHINE% Время %TIME% %MODE%';
  DEF_IS_FIRST_RUN = True;
  DEF_KDE_USER = '';
  DEF_DEBUG = False;
  // строковые идентификаторы, доступных для совместного
  // использования c GameClass, оболочек
  RUNPAD_SHELL = 'Runpad';
  UNKNOWN_SHELL = 'Unknown';
  // константы для инициализации хранилища настроек
  COMPANY_NAME = 'Nodasoft';
  PRODUCT_NAME = 'GameClass';

  // папки для логического деления опций
  OPTIONS_GENERAL_FOLDER = 'Client';

type

  // перечисление поддерживаемых программ-оболочек
  TShellMode = (
      ShellMode_Unknown,
      ShellMode_Runpad
  );

  // перечисление поддерживаемых действий после окончания сесси
  TAfterStopType = (
      AfterStopType_KillTask,
      AfterStopType_Logoff,
      AfterStopType_Restart,
      AfterStopType_Shutdown
  );

  // перечисление птипов блокировки при обрыве связи
  TOfflineBlockType = (
      OfflineBlockType_Immediately,
      OfflineBlockType_AfterSessionStop
  );

  //
  // TClientOptions
  //


implementation


end.
