unit uKKMTools;

interface

uses
  uKKMPlugin,
  GCSessions;

  procedure KKMPluginStart;
  procedure KKMPluginStop;
  function PrintCheckStart(ASession: TGCSession): Boolean;
  function PrintCheckStop(ASession: TGCSession): Boolean;
  function PrintService(const AnServiceId: Integer;
      const AstrService: String; const AnCount: Integer;
      const AnPrice: Double;
      const AstrComputer: String = '';
      const AstrAccount: String = ''): Boolean;
  function PrintAddTraffic(const ASession: TGCSession;
      const AfPay: Double): Boolean;
  function PrintAddMoney(const ASession: TGCSession;
      const AfPay: Double): Boolean;
  function CashIncome(const AfSum: Currency;
      const AstrInfo: String): Boolean;
  function CashOutcome(const AfSum: Currency;
      const AstrInfo: String): Boolean;

var
  GKKMPlugin: TKKMPlugin;

implementation

uses
  StrUtils,
  SysUtils,
  gccomputers,
  uRegistry,
  Math,
  uRegistryKKM,
  uDebugLog;

procedure KKMPluginStart;
begin
  with GRegistry.Modules.KKM do begin
    if isManager and OnlyForOperator then
      exit;
    if Active and (PluginPath<>'') then begin
      GKKMPlugin := TKKMPlugin.Create(PluginPath, Config);
      GKKMPlugin.Connect;
      if not GKKMPlugin.IsShiftOpened then
        if CustomOperatorName then
          GKKMPlugin.OpenShift(1, OperatorName)
        else
          GKKMPlugin.OpenShift(1, CurOperatorName);
    end;
  end;
end;

procedure KKMPluginStop;
begin
  FreeAndNil(GKKMPlugin);
end;

function PrintCheckStart(ASession: TGCSession): Boolean;
begin
  Result := False;
  if not ASession.PostPay then begin
    case GRegistry.Modules.KKM.CheckMode of
      cmOnlyResultCheck:
        Result := True;
      cmCashInForPrepay:
        Result := GKKMPlugin.CashIn(ASession.CommonPay, '№'
            + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
            + ' Предоплата'
            + ' по тарифу ' + ASession.GetStrTarif );
      cmRefundForChange:
        if ASession.IsGuest then
          Result := GKKMPlugin.StartSale
              and GKKMPlugin.AddItem('№'
              + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
              + ' Оплата по тарифу ' + ASession.GetStrTarif,
              ASession.CommonPay{GetCostTotal}, False, 1,
              ASession.IdTarif, 1, 0, 0, '', 0, 0)
              and GKKMPlugin.EndSale(ptCashe, ASession.CommonPay, 0, 0, 0, 0)
        else
          Result := True;

    end;
  end else
    Result := True;
end;

function PrintCheckStop(ASession: TGCSession): Boolean;
begin
  Result := False;
  with ASession do begin
    if PostPay then
      Result := GKKMPlugin.StartSale
          and GKKMPlugin.AddItem('№'
          + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
          + ' Оплата по тарифу ' + GetStrTarif,
          ASession.GetCostTotal, False, 1, ASession.IdTarif, 1, 0, 0,
          '', 0, 0)
          and GKKMPlugin.EndSale(ptCashe, ASession.ResultCostForKKM, 0, 0, 0, 0)
    else case GRegistry.Modules.KKM.CheckMode of
      cmOnlyResultCheck:
        Result := GKKMPlugin.StartSale
            and GKKMPlugin.AddItem('№'
            + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
            + ' Оплата по тарифу ' + GetStrTarif,
            ASession.ResultCostForKKM, False, 1,
            ASession.IdTarif, 1, 0, 0, '', 0, 0)
            and GKKMPlugin.EndSale(ptCashe, ASession.CommonPay
            + ASession.SeparateTrafficPay, 0, 0, 0, 0);
      cmCashInForPrepay:
        Result := GKKMPlugin.CashOut(ASession.CommonPay
            + ASession.SeparateTrafficPay, '№'
            + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
            + ' Возврат предоплаты'
            + ' по тарифу ' + ASession.GetStrTarif)
            and GKKMPlugin.StartSale
            and GKKMPlugin.AddItem('№'
            + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
            + ' Оплата по тарифу ' + GetStrTarif,
            ASession.ResultCostForKKM, False, 1,
            ASession.IdTarif, 1, 0, 0, '', 0, 0)
            and GKKMPlugin.EndSale(ptCashe, ASession.CommonPay
            + ASession.SeparateTrafficPay, 0, 0, 0, 0);
      cmRefundForChange:
        if ASession.IsGuest
            and ((ASession.CommonPay + ASession.SeparateTrafficPay
            - ASession.ResultCostForKKM) > 0.0001) then
          Result := GKKMPlugin.StartRefund()
              and GKKMPlugin.AddItem('№'
              + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
              + ' Возврат сдачи по тарифу ' + GetStrTarif,
              ASession.CommonPay + ASession.SeparateTrafficPay
              - ASession.ResultCostForKKM, False, 1,
              ASession.IdTarif, 1, 0, 0, '', 0, 0)
              and GKKMPlugin.EndRefund('');
        else
          Result := True;
    end;
  end;
end;

function PrintService(const AnServiceId: Integer;
    const AstrService: String; const AnCount: Integer;
    const AnPrice: Double;
    const AstrComputer: String = '';
    const AstrAccount: String = ''): Boolean;
begin
  Result := False;
  try
    Result := GKKMPlugin.StartSale
        and GKKMPlugin.AddItem(
        IfThen(Length(AstrComputer) > 0, '№' + AstrComputer + ' ')
        + 'Услуга: ' + AstrService,
        AnPrice * AnCount, False, 1, 20 + AnServiceId, 1, 0, 0,
        '', 0, 0)
        and GKKMPlugin.EndSale(ptCashe, AnPrice * AnCount, 0, 0, 0, 0)
  except
    on e: Exception do begin
      Debug.Trace0('PrintService error! ' + e.Message);
    end;
  end;
end;

function PrintAddTraffic(const ASession: TGCSession;
    const AfPay: Double): Boolean;
begin
//  Result := False;
  Result := GKKMPlugin.StartSale
      and GKKMPlugin.AddItem('№'
      + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
      + ' Доплата за трафик по тарифу' + ASession.GetStrTarif,
      AfPay, False, 1, ASession.IdTarif, 1, 0, 0,
      '', 0, 0)
      and GKKMPlugin.EndSale(ptCashe, AfPay, 0, 0, 0, 0)
end;

function PrintAddMoney(const ASession: TGCSession;
    const AfPay: Double): Boolean;
begin
  Result := False;
  if not ASession.PostPay then begin
    case GRegistry.Modules.KKM.CheckMode of
      cmOnlyResultCheck:
        Result := True;
      cmCashInForPrepay:
        Result := GKKMPlugin.CashIn(AfPay, '№'
            + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
            + ' Добавление предоплаты'
            + ' по тарифу ' + ASession.GetStrTarif );
      cmRefundForChange:
        Result := GKKMPlugin.StartSale
            and GKKMPlugin.AddItem('№'
            + Comps[ComputersGetIndex(ASession.IdComp)].GetStrNumber
            + ' Доплата по тарифу ' + ASession.GetStrTarif,
            AfPay, False, 1,
            ASession.IdTarif, 1, 0, 0, '', 0, 0)
            and GKKMPlugin.EndSale(ptCashe, AfPay, 0, 0, 0, 0);
    end;
  end else
    Result := True;
end;

function CashIncome(const AfSum: Currency;
        const AstrInfo: String): Boolean;
begin
  Result := False;
  case GRegistry.Modules.KKM.CheckMode of
    cmOnlyResultCheck:
      Result := True;
    cmCashInForPrepay:
      Result := GKKMPlugin.CashIn(AfSum, AstrInfo);
    cmRefundForChange:
      Result := GKKMPlugin.StartSale
          and GKKMPlugin.AddItem(AstrInfo,
          AfSum, False, 1,
          1, 1, 0, 0, '', 0, 0)
          and GKKMPlugin.EndSale(ptCashe, AfSum, 0, 0, 0, 0);
  end;
end;

function CashOutcome(const AfSum: Currency;
        const AstrInfo: String): Boolean;
begin
  Result := False;
  case GRegistry.Modules.KKM.CheckMode of
    cmOnlyResultCheck:
      Result := True;
    cmCashInForPrepay:
      Result := GKKMPlugin.CashOut(AfSum, AstrInfo);
    cmRefundForChange:
      Result := GKKMPlugin.StartRefund
          and GKKMPlugin.AddItem(AstrInfo,
          AfSum, False, 1,
          1, 1, 0, 0, '', 0, 0)
          and GKKMPlugin.EndRefund('');
  end;
end;

initialization
  GKKMPlugin := Nil;

end.
