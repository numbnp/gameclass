object srvGCTI: TsrvGCTI
  OldCreateOrder = False
  Dependencies = <
    item
      Name = 'TrafInspSrv'
      IsGroup = False
    end>
  DisplayName = 'gctisrv'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Left = 434
  Top = 567
  Height = 150
  Width = 215
end
