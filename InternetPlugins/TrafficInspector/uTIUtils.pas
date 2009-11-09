unit uTIUtils;

interface

uses
  uTICommonInterface,
  uIPInformation;

const
  DEF_GROUP = '{00000000-0000-0000-0000-000000000000}';

  procedure TIGetMissingInfo;
  procedure TICreateMissingUsers;
  procedure TIClearCounters;
  procedure TIStopUsers(const AbStopOnlyGCUsers: Boolean);
  function TIGetGroupInfo(const AstrGroupName: String): String;
  function TIGetTrafficValues(AstrServerIP: String): String;


implementation

uses
  uDebugLog,
  Variants,
  TrafInspTLB,
  uGCTIOptions,
  uGCTICOnst,
  SysUtils,
  StrUtils;

procedure TIGetMissingInfo;
var
  i: integer;
  varUserList, varUserAttr: OleVariant;
  strIP, strGUID: string;
begin
  if TI.Connected then begin
    varUserList := TI.APIGetBillProp(3, '');
    if not VarIsArray(varUserList) then begin
      Debug.Trace5('TI: Cписок клиентов пуст!');
    end else
      for i := VarArrayLowBound(varUserList, 1) to
          VarArrayHighBound(varUserList, 1) do begin
        varUserAttr:= varUserList[i];
        strGUID:= varUserAttr[1];
        strIP:= TI.APIGetAttr(3, strGUID, User_IPAddr);
        // не надо добавлять IP от TI
        if (IPInformations.Index(strIP) <> -1) then
          with IPInformations.GetItemByIP(strIP) do begin
            ExtraInfo := strGUID;
            Name := varUserAttr[0];
          end;
      end;
  end;
end;

procedure TICreateMissingUsers;
var
  i: integer;
  strIP, strGUID: string;
begin
  if TI.Connected then begin
    for i := 0 to IPInformations.Count - 1 do
      if not IPInformations[i].ContainedExtraInfo then begin
        strIP := IPInformations[i].IP;
        strGUID := TI.APIAddUser('', strIP, '');
        IPInformations[i].ExtraInfo := strGUID;
        IPInformations[i].Name := strIP;
        TI.APISetAttr(3,strGUID, User_IPAddr, strIP, False);
        TI.APISetAttr(3,strGUID, User_BillMode, 2, False);
        TI.APISetAttr(3, strGUID, User_ServiceMaskDef, -1, True);
      end;
  end;
end;

procedure TIClearCounters;
begin
  TI.APIResetExpCounter(1,'');
  TI.APIResetExpCounter(2,'');
end;

procedure TIStopUsers(const AbStopOnlyGCUsers: Boolean);
var
  i: integer;
  varUserList, varUserAttr: OleVariant;
begin
  if TI.Connected then begin
    if AbStopOnlyGCUsers then begin
      for i := 0 to IPInformations.Count - 1 do
        if IPInformations[i].ContainedExtraInfo then begin
          try
            TI.APISetUserState(IPInformations[i].ExtraInfo, 0, 0, OPERATOR_NAME,
                'Останов компьтеров из списка GameClass');
          except
            // нет уже такого клиента в TI
            IPInformations[i].ExtraInfo := '';
          end;
        end;
    end else begin
      varUserList := TI.APIGetBillProp(3, '');
      if VarIsArray(varUserList) then begin
        Debug.Trace5('GCTI TIStopUsers VarIsArray ok');
        for i := VarArrayLowBound(varUserList, 1) to
            VarArrayHighBound(varUserList, 1) do begin
          try
            TI.APISetUserState(varUserAttr[i][1], 0, 0, OPERATOR_NAME,
                'Останов всех компьтеров');
          except
            // нет уже такого клиента в TI
            IPInformations[i].ExtraInfo := '';
          end;
        end;
      end;
    end;
  end;
end;

function TIGetGroupInfo(const AstrGroupName: String): String;
var
  i: integer;
  varUserList: OleVariant;
  strGroupName, strGUID: string;
begin
  Result := DEF_GROUP;
  varUserList := TI.APIGetBillProp(2, '');
  if VarIsArray(varUserList) then
    for i:= VarArrayLowBound(varUserList, 1)
        to VarArrayHighBound(varUserList, 1) do begin
      strGUID := varUserList[i][1];
      strGroupName := TI.APIGetAttr(2, strGUID, Group_DisplayName);
      if (strGroupName = AstrGroupName) then
        Result := strGUID;
    end;
end;

function TIGetTrafficValues(AstrServerIP: String): String;
var
   i : Integer;
   nBytesReceived, nBytesSent : Cardinal;
   strValues: String;
begin
  strValues := 'inet_get_traffic_value_answer=';
  if TI.Connected then begin
    for i := 0 to IPInformations.Count - 1 do
      with IPInformations[i] do
        if (ContainedExtraInfo and Enabled
            and (ServerIP = AstrServerIP)) then begin
          nBytesReceived := 0;
          nBytesSent := 0;
          if Options.Genaral.TariffingMode.Value
              = Ord(TariffingModeTraffic) then begin
            //Получить от TrafficInspector'а значения трафика для ip-адреса strAddr
            //здесь значение входящего трафика
            nBytesReceived := TI.APIGetAttr(3, ExtraInfo, User_RxBytes);
            //здесь значение входящего трафика из кеша
            if Options.Genaral.TariffingUseCache.Value then
              nBytesReceived := nBytesReceived + TI.APIGetAttr(3, ExtraInfo,
                  User_RxCacheBytes);
            //здесь значение исходящего трафика
            nBytesSent := TI.APIGetAttr(3, ExtraInfo, User_TxBytes);
          end else if Options.Genaral.TariffingMode.Value
              = Ord(TariffingModeCost) then begin
            //Получить от TrafficInspector'а значения стоимости 1 уе = 1 МБ
            //здесь значение входящего трафика
            nBytesReceived := Trunc(TI.APIGetAttr(3, ExtraInfo, User_BillSumma)
                * 1048576);
            //здесь значение исходящего трафика
          end;
          // добавить полученные значения в список
          SetReceived(nBytesReceived);
          SetSent(nBytesSent);
          // формируем ответ
          strValues := strValues + IP + '/' + IntToStr(UnloadReceived)
              + '/' + IntToStr(UnloadSent) + '/'
        end;
    // стираем последнюю кавычку
    if (RightStr(strValues,1) = '/') then
      SetLength(strValues, Length(strValues)-1);
  end;
  Result := strValues;
end;

end.

