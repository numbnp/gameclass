//////////////////////////////////////////////////////////////////////////////
//
// Описание протокола
//
//////////////////////////////////////////////////////////////////////////////

unit uProtocolIndexes;

interface

const
  // команды от сервера
  IDX_CMD_INFO                    = 0000;
  IDX_CMD_INFO_FULL               = 0000;
  IDX_CMD_BLOCKED                 = 0000;
  IDX_CMD_PING                    = 0000;
  IDX_CMD_KILLTASK                = 0000;
  IDX_CMD_SETTIME                 = 0000;
  IDX_CMD_RESTART                 = 0000;
  IDX_CMD_SHUTDOWN                = 0000;
  IDX_CMD_GETHARDWARE             = 0000;
  IDX_CMD_GETTASKSLIST            = 0000;
  IDX_CMD_UNINSTALL               = 0000;
  IDX_CMD_SHELLMODE               = 0000;
  IDX_CMD_CLOSECLIENT             = 0000;
  IDX_CMD_GETEXTENDEDINFO         = 0000;
  IDX_CMD_SENDMESSAGE             = 0000;
  IDX_CMD_AUTH_GOSTATE_0          = 0000;
  IDX_CMD_AUTH_QUERYSTATE_1       = 0000;
  IDX_CMD_AUTH_GOSTATE_1          = 0000;
  IDX_CMD_AUTH_QUERYSTATE_2       = 0000;
  IDX_CMD_AUTH_FAILEDLOGGING_2    = 0000;
  IDX_CMD_AUTH_GOSTATE_2          = 0000;
  IDX_CMD_AUTH_QUERYTARIFS_2      = 0000;
  IDX_CMD_AUTH_RETTARIFS_2        = 0000;
  IDX_CMD_AUTH_QUERYCOSTTIME_2    = 0000;
  IDX_CMD_AUTH_RETCOSTTIME_2      = 0000;
  IDX_CMD_AUTH_QUERYSTATE_3       = 0000;
  IDX_CMD_AUTH_GOSTATE_3          = 0000;
  IDX_CMD_AUTH_QUERYSTOP_3        = 0000;
  IDX_CMD_AUTH_STOPSTATE_3        = 0000;
  IDX_CMD_AUTH_QUERYLOGOFF        = 0000;
  IDX_CMD_AUTH_SENDBALANCEHISTORY = 0000;
  IDX_CMD_AUTH_QUERYCHANGEPASS    = 0000;
  IDX_CMD_AUTH_PASSCHANGED        = 0000;
  IDX_CMD_SESSIONINFO             = 0000; //команда не используется
  IDX_CMD_AUTH_ADDTRAFFIC_3       = 0000;

  IDX_CMD_SETVOLUME               = 0000;
  IDX_CMD_AUTH_QUERYCOSTTRAFFIC_3 = 0000;
  IDX_CMD_AUTH_RETCOSTTRAFFIC_3   = 0000;
  IDX_CMD_PLAY_SOUND              = 0000;
  IDX_CMD_CLIENT_INFO_SET         = 0000;
  IDX_CMD_CLIENT_INFO_GET         = 0000;
  IDX_CMD_OPTION_SET              = 0000;
  IDX_CMD_OPTION_GET              = 0000;
  IDX_CMD_RET_GETEXTENDEDINFO     = 0000;
  IDX_CMD_RET_PINGANSWER          = 0000;
  IDX_CMD_RET_RESTARTING          = 0000;
  IDX_CMD_RET_TASKSLIST           = 0000;
  IDX_CMD_RET_GETHARDWARE         = 0000;
  IDX_CMD_RET_INFO                = 0000;
  IDX_CMD_INETBLOCK               = 0000;
  IDX_CMD_INETUNBLOCK             = 0000;
  IDX_CMD_INETSETSPEEDFORIP       = 0000;
  IDX_CMD_GETTRAFFICVALUE         = 0000;
  IDX_CMD_GETTRAFFICVALUEANSWER   = 0000;
  IDX_CMD_INETSETGROUP            = 0000;
  IDX_CMD_RET_PROCESSLIST         = 0000;




implementation

end.
