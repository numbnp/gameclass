//////////////////////////////////////////////////////////////////////////////
//
// Описание протокола
//
//////////////////////////////////////////////////////////////////////////////

unit uProtocolIndexes;

interface

const
  // команды от сервера
  IDX_CMD_INFO                    = 7;
  IDX_CMD_INFO_FULL               = 34;
  IDX_CMD_BLOCKED                 = 47;
  IDX_CMD_PING                    = 33;
  IDX_CMD_KILLTASK                = 38;
  IDX_CMD_SETTIME                 = 3;
  IDX_CMD_RESTART                 = 30;
  IDX_CMD_SHUTDOWN                = 48;
  IDX_CMD_GETHARDWARE             = 55;
  IDX_CMD_GETTASKSLIST            = 35;
  IDX_CMD_UNINSTALL               = 52;
  IDX_CMD_SHELLMODE               = 5;
  IDX_CMD_CLOSECLIENT             = 32;
  IDX_CMD_GETEXTENDEDINFO         = 41;
  IDX_CMD_SENDMESSAGE             = 0;
  IDX_CMD_AUTH_GOSTATE_0          = 53;
  IDX_CMD_AUTH_QUERYSTATE_1       = 54;
  IDX_CMD_AUTH_GOSTATE_1          = 50;
  IDX_CMD_AUTH_QUERYSTATE_2       = 19;
  IDX_CMD_AUTH_FAILEDLOGGING_2    = 28;
  IDX_CMD_AUTH_GOSTATE_2          = 27;
  IDX_CMD_AUTH_QUERYTARIFS_2      = 51;
  IDX_CMD_AUTH_RETTARIFS_2        = 9;
  IDX_CMD_AUTH_QUERYCOSTTIME_2    = 36;
  IDX_CMD_AUTH_RETCOSTTIME_2      = 11;
  IDX_CMD_AUTH_QUERYSTATE_3       = 17;
  IDX_CMD_AUTH_GOSTATE_3          = 2;
  IDX_CMD_AUTH_QUERYSTOP_3        = 13;
  IDX_CMD_AUTH_STOPSTATE_3        = 8;
  IDX_CMD_AUTH_QUERYLOGOFF        = 4;
  IDX_CMD_AUTH_SENDBALANCEHISTORY = 21;
  IDX_CMD_AUTH_QUERYCHANGEPASS    = 18;
  IDX_CMD_AUTH_PASSCHANGED        = 24;
  IDX_CMD_SESSIONINFO             = 22; //команда не используется
  IDX_CMD_AUTH_ADDTRAFFIC_3       = 12;

  IDX_CMD_SETVOLUME               = 15;
  IDX_CMD_AUTH_QUERYCOSTTRAFFIC_3 = 29;
  IDX_CMD_AUTH_RETCOSTTRAFFIC_3   = 43;
  IDX_CMD_PLAY_SOUND              = 37;
  IDX_CMD_CLIENT_INFO_SET         = 45;
  IDX_CMD_CLIENT_INFO_GET         = 42;
  IDX_CMD_OPTION_SET              = 10;
  IDX_CMD_OPTION_GET              = 49;
  IDX_CMD_RET_GETEXTENDEDINFO     = 46;
  IDX_CMD_RET_PINGANSWER          = 16;
  IDX_CMD_RET_RESTARTING          = 23;
  IDX_CMD_RET_TASKSLIST           = 44;
  IDX_CMD_RET_GETHARDWARE         = 20;
  IDX_CMD_RET_INFO                = 26;
  IDX_CMD_INETBLOCK               = 6;
  IDX_CMD_INETUNBLOCK             = 1;
  IDX_CMD_INETSETSPEEDFORIP       = 40;
  IDX_CMD_GETTRAFFICVALUE         = 14;
  IDX_CMD_GETTRAFFICVALUEANSWER   = 39;
  IDX_CMD_INETSETGROUP            = 31;
  IDX_CMD_RET_PROCESSLIST         = 25;




implementation

end.
