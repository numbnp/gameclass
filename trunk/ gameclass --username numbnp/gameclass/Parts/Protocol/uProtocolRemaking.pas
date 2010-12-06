unit uProtocolRemaking;

interface
type
  TProtocolRemakingProcedure = procedure (const AnIndex: Integer;
      const AstrString: String) of object;

  procedure ProtocolRemake(const AProcedure: TProtocolRemakingProcedure);

implementation

uses
  uProtocolIndexes,
  uProtocol;

procedure ProtocolRemake(const AProcedure: TProtocolRemakingProcedure);
begin
  AProcedure(IDX_CMD_INFO,STR_CMD_INFO);
  AProcedure(IDX_CMD_INFO_FULL,STR_CMD_INFO_FULL);
  AProcedure(IDX_CMD_BLOCKED,STR_CMD_BLOCKED);
  AProcedure(IDX_CMD_PING,STR_CMD_PING);
  AProcedure(IDX_CMD_KILLTASK,STR_CMD_KILLTASK);
  AProcedure(IDX_CMD_SETTIME,STR_CMD_SETTIME);
  AProcedure(IDX_CMD_RESTART,STR_CMD_RESTART);
  AProcedure(IDX_CMD_SHUTDOWN,STR_CMD_SHUTDOWN);                            
  AProcedure(IDX_CMD_GETHARDWARE,STR_CMD_GETHARDWARE);                            
  AProcedure(IDX_CMD_GETTASKSLIST,STR_CMD_GETTASKSLIST);                            
  AProcedure(IDX_CMD_UNINSTALL,STR_CMD_UNINSTALL);                            
  AProcedure(IDX_CMD_SHELLMODE,STR_CMD_SHELLMODE);                            
  AProcedure(IDX_CMD_CLOSECLIENT,STR_CMD_CLOSECLIENT);                            
  AProcedure(IDX_CMD_GETEXTENDEDINFO,STR_CMD_GETEXTENDEDINFO);                            
  AProcedure(IDX_CMD_SENDMESSAGE,STR_CMD_SENDMESSAGE);                            
  AProcedure(IDX_CMD_AUTH_GOSTATE_0,STR_CMD_AUTH_GOSTATE_0);                            
  AProcedure(IDX_CMD_AUTH_QUERYSTATE_1,STR_CMD_AUTH_QUERYSTATE_1);                            
  AProcedure(IDX_CMD_AUTH_GOSTATE_1,STR_CMD_AUTH_GOSTATE_1);                            
  AProcedure(IDX_CMD_AUTH_QUERYSTATE_2,STR_CMD_AUTH_QUERYSTATE_2);                            
  AProcedure(IDX_CMD_AUTH_FAILEDLOGGING_2,STR_CMD_AUTH_FAILEDLOGGING_2);                            
  AProcedure(IDX_CMD_AUTH_GOSTATE_2,STR_CMD_AUTH_GOSTATE_2);                            
  AProcedure(IDX_CMD_AUTH_QUERYTARIFS_2,STR_CMD_AUTH_QUERYTARIFS_2);                            
  AProcedure(IDX_CMD_AUTH_RETTARIFS_2,STR_CMD_AUTH_RETTARIFS_2);                            
  AProcedure(IDX_CMD_AUTH_QUERYCOSTTIME_2,STR_CMD_AUTH_QUERYCOSTTIME_2);                            
  AProcedure(IDX_CMD_AUTH_RETCOSTTIME_2,STR_CMD_AUTH_RETCOSTTIME_2);                            
  AProcedure(IDX_CMD_AUTH_QUERYSTATE_3,STR_CMD_AUTH_QUERYSTATE_3);                            
  AProcedure(IDX_CMD_AUTH_GOSTATE_3,STR_CMD_AUTH_GOSTATE_3);                            
  AProcedure(IDX_CMD_AUTH_QUERYSTOP_3,STR_CMD_AUTH_QUERYSTOP_3);                            
  AProcedure(IDX_CMD_AUTH_STOPSTATE_3,STR_CMD_AUTH_STOPSTATE_3);                            
  AProcedure(IDX_CMD_AUTH_QUERYLOGOFF,STR_CMD_AUTH_QUERYLOGOFF);                            
  AProcedure(IDX_CMD_AUTH_SENDBALANCEHISTORY,STR_CMD_AUTH_SENDBALANCEHISTORY);                            
  AProcedure(IDX_CMD_AUTH_QUERYCHANGEPASS,STR_CMD_AUTH_QUERYCHANGEPASS);                            
  AProcedure(IDX_CMD_AUTH_PASSCHANGED,STR_CMD_AUTH_PASSCHANGED);                            
  AProcedure(IDX_CMD_SESSIONINFO,STR_CMD_SESSIONINFO);                            
  AProcedure(IDX_CMD_AUTH_ADDTRAFFIC_3,STR_CMD_AUTH_ADDTRAFFIC_3);                            
  AProcedure(IDX_CMD_SETVOLUME,STR_CMD_SETVOLUME);                            
  AProcedure(IDX_CMD_AUTH_QUERYCOSTTRAFFIC_3,STR_CMD_AUTH_QUERYCOSTTRAFFIC_3);                            
  AProcedure(IDX_CMD_AUTH_RETCOSTTRAFFIC_3,STR_CMD_AUTH_RETCOSTTRAFFIC_3);                            
  AProcedure(IDX_CMD_PLAY_SOUND,STR_CMD_PLAY_SOUND);                            
  AProcedure(IDX_CMD_CLIENT_INFO_SET,STR_CMD_CLIENT_INFO_SET);                            
  AProcedure(IDX_CMD_CLIENT_INFO_GET,STR_CMD_CLIENT_INFO_GET);                            
  AProcedure(IDX_CMD_OPTION_SET,STR_CMD_OPTION_SET);                            
  AProcedure(IDX_CMD_OPTION_GET,STR_CMD_OPTION_GET);                            
  AProcedure(IDX_CMD_RET_GETEXTENDEDINFO,STR_CMD_RET_GETEXTENDEDINFO);                            
  AProcedure(IDX_CMD_RET_PINGANSWER,STR_CMD_RET_PINGANSWER);                            
  AProcedure(IDX_CMD_RET_RESTARTING,STR_CMD_RET_RESTARTING);                            
  AProcedure(IDX_CMD_RET_TASKSLIST,STR_CMD_RET_TASKSLIST);                            
  AProcedure(IDX_CMD_RET_GETHARDWARE,STR_CMD_RET_GETHARDWARE);                            
  AProcedure(IDX_CMD_RET_INFO,STR_CMD_RET_INFO);                            
  AProcedure(IDX_CMD_INETBLOCK,STR_CMD_INETBLOCK);                            
  AProcedure(IDX_CMD_INETUNBLOCK,STR_CMD_INETUNBLOCK);                            
  AProcedure(IDX_CMD_INETSETSPEEDFORIP,STR_CMD_INETSETSPEEDFORIP);                            
  AProcedure(IDX_CMD_GETTRAFFICVALUE,STR_CMD_GETTRAFFICVALUE);                            
  AProcedure(IDX_CMD_GETTRAFFICVALUEANSWER,STR_CMD_GETTRAFFICVALUEANSWER);                            
  AProcedure(IDX_CMD_INETSETGROUP, STR_CMD_INETSETGROUP);                            
  AProcedure(IDX_CMD_RET_PROCESSLIST,STR_CMD_RET_PROCESSLIST);
end;

end.
