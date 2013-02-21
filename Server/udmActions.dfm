object dmActions: TdmActions
  OldCreateOrder = False
  Left = 670
  Top = 587
  Height = 109
  Width = 147
  object ActionManager: TActionManager
    Left = 40
    Top = 16
    StyleName = 'XP Style'
    object actExit: TAction
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actExitExecute
    end
    object actConnect: TAction
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
      OnExecute = actConnectExecute
    end
    object actDisconnect: TAction
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
      OnExecute = actDisconnectExecute
    end
    object actAbout: TAction
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnExecute = actAboutExecute
    end
    object actHelp: TAction
      Caption = #1055#1086#1084#1086#1097#1100
      OnExecute = actHelpExecute
    end
    object actLangRussian: TAction
      Caption = #1056#1091#1089#1089#1082#1080#1081
      OnExecute = actLangRussianExecute
    end
    object actLangEnglish: TAction
      Caption = 'English'
      OnExecute = actLangEnglishExecute
    end
    object actRedrawComps: TAction
      Caption = 'RedrawComps'
      OnExecute = actRedrawCompsExecute
    end
    object actPreLogon: TAction
      Caption = 'PreLogon'
      OnExecute = actPreLogonExecute
    end
    object actLoadSessions: TAction
      Caption = 'LoadSessions'
      OnExecute = actLoadSessionsExecute
    end
    object actAddCheckAccount: TAction
      Caption = #1054#1087#1083#1072#1090#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1091#1095#1077#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
      OnExecute = actAddCheckAccountExecute
    end
    object actTimeBonus: TAction
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1073#1077#1089#1087#1083#1072#1090#1085#1086#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
      OnExecute = actTimeBonusExecute
    end
  end
end
