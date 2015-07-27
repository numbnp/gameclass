object srvGCCL: TsrvGCCL
  OldCreateOrder = False
  DisplayName = 'gcclsrv'
  ErrorSeverity = esIgnore
  Interactive = True
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
