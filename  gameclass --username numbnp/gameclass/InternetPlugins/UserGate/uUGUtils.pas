unit uUGUtils;

interface

uses
  uUGConfig;

{
var
  UG: TUGConfig;
begin
  UG := TUGConfig.Create();
  FreeAndNil(UG);

}
const
  DEF_GROUP = 'default';

  procedure UGGetMissingInfo(const AUGConfig: TUGConfig);
  procedure UGCreateMissingUsers(const AUGConfig: TUGConfig);
  procedure UGClearCounters(const AUGConfig: TUGConfig);
  procedure UGStopUsers(const AUGConfig: TUGConfig;
      const AbStopOnlyGCUsers: Boolean);
  procedure UGSetGroup(const AUGConfig: TUGConfig;
      const AstrIP: String; const AstrGroupName: String);
  function UGGetTrafficValues(const AUGConfig: TUGConfig;
      AstrServerIP: String): String;
  procedure UGEnableUser(const AUGConfig: TUGConfig;
      const AstrIP: String; const AbEnable: Boolean);
  function UGReverseIPAddr(var AstrConfig:String): Boolean;
  function UGCorrectEditUser(const AUGConfig: TUGConfig;
      const AstrConfig: String): Boolean;


implementation

uses
  Windows,
  uIPInformation,
  uDebugLog,
  Variants,
  uGCUGOptions,
  uGCUGCOnst,
  SysUtils,
  StrUtils,
  uY2KString, Classes;

const
  BUF_SIZE = 4096;
  UG_SEPARATOR = '&';
  UG_KEY_SEPARATOR = '=';
  DEF_USER_CONFIG = 'UserName=Новый пользователь&ID=0&Group=default&Rate=default'
      + '&UserDisabled=0&GroupDisabled=0&Login=&Password='
      + '&Domain=&IPAddr=192.168.1.1&IPRange=255.255.255.255';

function UGGetValueFromConfig(const AstrConfig:String;
    const AstrKey: String): String;
var
  strKey, strValue: String;
  i, nCount, nPos: Integer;
begin
  Result := '';
  nCount := GetParamCountFromString(AstrConfig, UG_SEPARATOR);
  for i := 0 to nCount - 1 do begin
    strKey := GetParamFromString(AstrConfig, i ,UG_SEPARATOR);
    strValue := GetParamFromString(strKey, 1, UG_KEY_SEPARATOR);
    strKey := GetParamFromString(strKey, 0, UG_KEY_SEPARATOR);
    if (strKey = AstrKey) then begin
      Result := strValue;
      break;
    end;
  end;
end;

function UGReplaceValueInConfig(var AstrConfig:String;
    const AstrKey: String; const AstrNewValue: String): Boolean;
var
  strKeyAndValue, strKey, strValue: String;
  i, nCount, nPos: Integer;
begin
  Result := False;
  nCount := GetParamCountFromString(AstrConfig, UG_SEPARATOR);
  for i := 0 to nCount - 1 do begin
    strKeyAndValue := GetParamFromString(AstrConfig, i ,UG_SEPARATOR);
    strKey := GetParamFromString(strKeyAndValue, 0, UG_KEY_SEPARATOR);
    strValue := GetParamFromString(strKeyAndValue, 1, UG_KEY_SEPARATOR);
    if (strKey = AstrKey) then begin
      ReplaceParamInString(strKeyAndValue, AstrNewValue, 1, UG_KEY_SEPARATOR);
      ReplaceParamInString(AstrConfig, strKeyAndValue, i, UG_SEPARATOR);
      Result := True;
      break;
    end;
  end;
end;

function UGReverseIPAddr(var AstrConfig:String): Boolean;
var
  strKeyAndValue, strKey, strValue, strNewValue: String;
  i, nCount, nPos: Integer;
begin
  Result := False;
  nCount := GetParamCountFromString(AstrConfig, UG_SEPARATOR);
  for i := 0 to nCount - 1 do begin
    strKeyAndValue := GetParamFromString(AstrConfig, i ,UG_SEPARATOR);
    strKey := GetParamFromString(strKeyAndValue, 0, UG_KEY_SEPARATOR);
    strValue := GetParamFromString(strKeyAndValue, 1, UG_KEY_SEPARATOR);
    if (strKey = 'IPAddr') then begin
      strNewValue := strValue;
      if (GetParamCountFromString(strValue, '.') = 4) then begin
        strNewValue := GetParamFromString(strValue, 3, '.') + '.'
            + GetParamFromString(strValue, 2, '.') + '.'
            + GetParamFromString(strValue, 1, '.') + '.'
            + GetParamFromString(strValue, 0, '.');
      end;
      ReplaceParamInString(strKeyAndValue, strNewValue, 1, UG_KEY_SEPARATOR);
      ReplaceParamInString(AstrConfig, strKeyAndValue, i, UG_SEPARATOR);
      Result := True;
      break;
    end;
  end;
end;

function UGGetFreeID(const AUGConfig: TUGConfig): Integer;
var
  i: integer;
  strError, strIP, strUserInfo: string;
  hRes: HRESULT;
  nSize: Integer;
  buf: array [0 .. BUF_SIZE] of Char;
  nPos: DWORD;
begin
  Result := -1;
  if AUGConfig.LoadUserInfo(strError) then begin
    nPos := 0;
		repeat
   		nSize := sizeof(buf);
      hRes := AUGConfig.EnumUsers(nPos, buf, nSize);
  		if (hRes = S_OK) then begin
        strUserInfo := buf;
        Debug.Trace5('UGGetFreeID Enum: ' + strUserInfo);
        strIP := UGGetValueFromConfig(strUserInfo, 'IPAddr');
        Debug.Trace5('UGGetFreeID Enum: ' + strUserInfo
            + '  IP=<' + strIP + '>');
        if (IPInformations.Index(strIP) = -1) then begin
          strError := UGGetValueFromConfig(strUserInfo, 'ID');
          TryStrToInt(strError, Result);
        end;
      end else
        Debug.Trace0('UGGetFreeID EnumUsers: ' + strError);
    until (hRes <> S_OK) or (nPos = 0);
  end else
    Debug.Trace0('UGGetFreeID: ' + strError);
end;

procedure UGGetMissingInfo(const AUGConfig: TUGConfig);
var
  i: integer;
  strErr, strIP, strUserInfo: string;
  hRes: HRESULT;
  nSize: Integer;
  buf: array [0 .. BUF_SIZE] of Char;
  nPos: DWORD;
begin
  if AUGConfig.Connected then begin
    if AUGConfig.LoadUserInfo(strErr) then begin
      nPos := 0;
  		repeat
    		nSize := sizeof(buf);
        hRes := AUGConfig.EnumUsers(nPos, buf, nSize);
    		if (hRes = S_OK) then begin
          strUserInfo := buf;
          strIP := UGGetValueFromConfig(strUserInfo, 'IPAddr');
          Debug.Trace5('UGGetMissingInfo: ' + strIP + ' ' + strUserInfo);
          if (IPInformations.Index(strIP) <> -1) then
            with IPInformations.GetItemByIP(strIP) do begin
              ExtraInfo := strUserInfo;
              Name := UGGetValueFromConfig(strUserInfo, 'UserName');
            end;
        end;
      until (hRes <> S_OK) or (nPos = 0);
    end else
      Debug.Trace0('UGGetMissingInfo :' + strErr);
  end;
end;


// В UG пока что невозможно добавить юзера
// Редактируем первого Новый
procedure UGCreateMissingUsers(const AUGConfig: TUGConfig);
var
  nFreeID, i: integer;
  strErr, strIP, strUserInfo: string;
begin
  Debug.Trace5('UGCreateMissingUsers');
  if AUGConfig.Connected then begin
    Debug.Trace5('Connected');
    for i := 0 to IPInformations.Count - 1 do
      if not IPInformations[i].ContainedExtraInfo then begin
        Debug.Trace5('User no ContainedExtraInfo:' + IPInformations[i].Name);
        nFreeID := UGGetFreeID(AUGConfig);
        Debug.Trace5('UGGetFreeID:' + IntToStr(nFreeID));
        if (nFreeID <> -1) then begin
          strUserInfo := DEF_USER_CONFIG;
          strIP := IPInformations[i].IP;
          UGReplaceValueInConfig(strUserInfo, 'UserName', strIP);
          UGReplaceValueInConfig(strUserInfo, 'IPAddr', strIP);
          UGReplaceValueInConfig(strUserInfo, 'ID', IntToStr(nFreeID));
          IPInformations[i].Name := strIP;
          Debug.Trace5('NewUserInfo:' + strUserInfo);
          if UGCorrectEditUser(AUGConfig, strUserInfo) then
            IPInformations[i].ExtraInfo := strUserInfo;
{          //Сохраняем два раза т.к. UG переворачивает IP-адрес
          with AUGConfig do begin
          if EditUser(strUserInfo, strErr) then begin
            Debug.Trace5('UGCreateMissingUsers[' + strIP + '] Edit1:'
                + strUserInfo);
            if ReloadUserInfo(strErr) then
              if GetUserInfoByName(strIP, strUserInfo, strErr) then
                if EditUser(strUserInfo, strErr) then begin
                Debug.Trace5('UGCreateMissingUsers[' + strIP + '] Edit2:'
                    + strUserInfo);
                  if ReloadUserInfo(strErr) then
                    if GetUserInfoByName(strIP, strUserInfo, strErr) then begin
                      IPInformations[i].ExtraInfo := strUserInfo;
                      Debug.Trace5('UGCreateMissingUsers[' + strIP + '] OK! :' + strUserInfo);
                    end;
                end;
            end;
          end;
}
        end;
      end;
  end;
end;

procedure UGStopUsers(const AUGConfig: TUGConfig;
    const AbStopOnlyGCUsers: Boolean);
var
  nIndex: Integer;
  strErr, strIP, strUserInfo: string;
  hRes: HRESULT;
  nSize: Integer;
  buf: array [0 .. BUF_SIZE] of Char;
  nPos: DWORD;
begin
  if AUGConfig.Connected then begin
    if AUGConfig.LoadUserInfo(strErr) then begin
      nPos := 0;
  		repeat
    		nSize := sizeof(buf);
        hRes := AUGConfig.EnumUsers(nPos, buf, nSize);
    		if (hRes = S_OK) then begin
          strUserInfo := buf;
          strIP := UGGetValueFromConfig(strUserInfo, 'IPAddr');
          nIndex := IPInformations.Index(strIP);
          if not AbStopOnlyGCUsers
              or (nIndex <> -1) then begin
            UGReplaceValueInConfig(strUserInfo, 'UserDisabled', '1');
            if not UGCorrectEditUser(AUGConfig, strUserInfo) then
              // нет уже такого клиента в UG
              IPInformations[nIndex].ExtraInfo := '';
          end;
        end;
      until (hRes <> S_OK) or (nPos = 0);
    end else
      Debug.Trace0('UGStopUsers: ' + strErr);
  end;
end;

procedure UGSetGroup(const AUGConfig: TUGConfig;
    const AstrIP: String; const AstrGroupName: String);
var
  nIndex: Integer;
  strErr, strIP, strUserInfo: string;
begin
  if AUGConfig.Connected then begin
    if AUGConfig.LoadUserInfo(strErr)
        and AUGConfig.GetUserInfoByName(AstrIP, strUserInfo, strErr) then begin
      UGReplaceValueInConfig(strUserInfo, 'Group', AstrGroupName);
      UGCorrectEditUser(AUGConfig, strUserInfo);
    end else
      Debug.Trace0('UGSetGroup: ' + strErr);
  end;
end;

procedure UGEnableUser(const AUGConfig: TUGConfig;
    const AstrIP: String; const AbEnable: Boolean);
var
  nIndex: Integer;
  strErr, strIP, strUserInfo: string;
begin
  if AUGConfig.Connected then begin
    if AUGConfig.LoadUserInfo(strErr)
        and AUGConfig.GetUserInfoByName(AstrIP, strUserInfo, strErr) then begin
      if AbEnable then
        UGReplaceValueInConfig(strUserInfo, 'UserDisabled', '0')
      else begin
        UGReplaceValueInConfig(strUserInfo, 'UserDisabled', '1');
      end;
      UGCorrectEditUser(AUGConfig, strUserInfo);
    end else
      Debug.Trace0('UGEnableUser: ' + strErr);
  end;
end;


function UGGetTrafficValues(const AUGConfig: TUGConfig;
    AstrServerIP: String): String;
var
  i : Integer;
  nBytesReceived, nBytesSent : Cardinal;
  strValues, strErr: String;
  fCost, fBalance: Double;
begin
  strValues := 'inet_get_traffic_value_answer=';
  if AUGConfig.Connected then begin
    for i := 0 to IPInformations.Count - 1 do
      with IPInformations[i] do
        if (ContainedExtraInfo and Enabled
            and (ServerIP = AstrServerIP)) then begin
          if AUGConfig.GetUserStat(IP, nBytesReceived, nBytesSent, fCost,
              fBalance, strErr) then begin
            if Options.Genaral.TariffingMode.Value
                = Ord(TariffingModeCost) then begin
              //Получить от TrafficInspector'а значения стоимости 1 уе = 1 МБ
              //здесь значение входящего трафика
              nBytesReceived := Trunc(fCost * 1048576);
              //здесь значение исходящего трафика
              nBytesSent := 0;
            end;
            Debug.Trace5('UGGetTrafficValues [' + IP + ']='
                + IntToStr(nBytesReceived) + '/'
                + IntToStr(CurrentBytesReceived) + '/'
                + IntToStr(TotalBytesReceived));
            // добавить полученные значения в список
            SetReceived(nBytesReceived);
            SetSent(nBytesSent);
            // формируем ответ
            strValues := strValues + IP + '/' + IntToStr(UnloadReceived)
                + '/' + IntToStr(UnloadSent) + '/'
          end else
            Debug.Trace0(strErr);
        end;
      // стираем последнюю кавычку
    if (RightStr(strValues,1) = '/') then
      SetLength(strValues, Length(strValues)-1);
  end;
  Result := strValues;
end;

procedure UGClearCounters(const AUGConfig: TUGConfig);
var
  i : Integer;
  nBytesReceived, nBytesSent : Cardinal;
  fCost, fBalance: Double;
  strErr: String;
begin
  if AUGConfig.Connected then begin
    for i := 0 to IPInformations.Count - 1 do
      with IPInformations[i] do
        if ContainedExtraInfo then begin
          if AUGConfig.GetUserStat(IP, nBytesReceived, nBytesSent, fCost,
              fBalance, strErr) then begin
            if Options.Genaral.TariffingMode.Value
                = Ord(TariffingModeCost) then begin
              //Получить от TrafficInspector'а значения стоимости 1 уе = 1 МБ
              //здесь значение входящего трафика
              nBytesReceived := Trunc(fCost * 1048576);
              //здесь значение исходящего трафика
              nBytesSent := 0;
            end;
            // добавить полученные значения в список
            SetReceived(nBytesReceived);
            SetSent(nBytesSent);
            // Обнуляем значения
            UnloadReceived;
            UnloadSent;
          end else
            Debug.Trace0(strErr);
        end;
  end;
end;

function UGCorrectEditUser(const AUGConfig: TUGConfig;
    const AstrConfig: String): Boolean;
var
  strCorrectConfig, strError: String;
  bRes: Boolean;
begin
  bRes := True;
  strCorrectConfig := AstrConfig;
  strError := 'ExtInfo не содержит IPAddr';
  bRes := UGReverseIPAddr(strCorrectConfig);
  Debug.Trace5('UGCorrectEditUser CorrectConfig: ' + strCorrectConfig);
  bRes := bRes and AUGConfig.Connected;
  bRes := bRes and AUGConfig.EditUser(strCorrectConfig, strError);
  bRes := bRes and AUGConfig.ReloadUserInfo(strError);
  if not bRes then
    Debug.Trace0('UGCorrectEditUser(' + AstrConfig + '): ' + strError)
  else
    Debug.Trace5('UGCorrectEditUser OK' + strCorrectConfig);
  Result := bRes;
end;

end.
















