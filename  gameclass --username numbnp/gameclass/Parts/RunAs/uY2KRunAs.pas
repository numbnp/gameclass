//////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KRunAs;

interface

uses
  // additional units
  JwaWinUser,
  JwaWinBase,
  JwaWinNT,
  JwaWinType,
  JwaUserEnv,
  JwaProfInfo,
  JwaWinError;


function StartInteractiveClientProcess(const AstrUsername: String;
    const AstrDomain: String; AstrPassword: String;
    const AstrCommandLine: String;
    const AbLoadProfile: Boolean = FALSE): Integer; overload;

function StartInteractiveClientProcess(const AhToken: THandle;
    const AstrCommandLine: string;
    const AbLoadProfile: Boolean = FALSE): Integer; overload;


implementation

uses
  SysUtils,
  Dialogs,
  uDebugLog;


const
  DESKTOP_ALL = DESKTOP_READOBJECTS or DESKTOP_CREATEWINDOW or
    DESKTOP_CREATEMENU or DESKTOP_HOOKCONTROL or DESKTOP_JOURNALRECORD or
    DESKTOP_JOURNALPLAYBACK or DESKTOP_ENUMERATE or DESKTOP_WRITEOBJECTS or
    DESKTOP_SWITCHDESKTOP or STANDARD_RIGHTS_REQUIRED;

  WINSTA_ALL = WINSTA_ENUMDESKTOPS or WINSTA_READATTRIBUTES or
    WINSTA_ACCESSCLIPBOARD or WINSTA_CREATEDESKTOP or
    WINSTA_WRITEATTRIBUTES or
    WINSTA_ACCESSGLOBALATOMS or WINSTA_EXITWINDOWS or WINSTA_ENUMERATE or
    WINSTA_READSCREEN or STANDARD_RIGHTS_REQUIRED;

  GENERIC_ACCESS = GENERIC_READ or GENERIC_WRITE or GENERIC_EXECUTE or
    GENERIC_ALL;


function AddAceToWindowStation(const AhWinSta: THandle;
    const ptrSID: PSID): Integer;
var
  ptrACE: PAccessAllowedAce;
  ACLSizeInfo: TACLSizeInformation;
  bDACLExist: LongBool;
  bDACLPresent: LongBool;
//  bSuccess: LongBool;
  dwNewAclSize: DWord;
  dwLength: DWORD;
  dwLengthNeeded: DWord;
  ptrACL: PACL;
  ptrNewACL: PACL;
  ptrSecurityDescriptor: PSecurityDescriptor;
  ptrNewSecurityDescriptor: PSecurityDescriptor;
  ptrTempACE: Pointer;
  SecurityInformation: TSecurityInformation;
  i: Integer;
begin
  Result := -1;
  dwLength := 0;
  ptrSecurityDescriptor := nil;
  ptrNewSecurityDescriptor := nil;
  ptrNewACL := nil;
  ptrACE := nil;
//  bSuccess := FALSE;
  SecurityInformation := DACL_SECURITY_INFORMATION;

  try
    if not GetUserObjectSecurity(AhWinSta, SecurityInformation,
        ptrSecurityDescriptor, dwLength, dwLengthNeeded) then begin

      if GetLastError() = ERROR_INSUFFICIENT_BUFFER then begin
        ptrSecurityDescriptor := HeapAlloc(
            GetProcessHeap(), HEAP_ZERO_MEMORY, dwLengthNeeded);
        if ptrSecurityDescriptor = nil then begin
          Result := -1;
          Exit;
        end;

        ptrNewSecurityDescriptor := HeapAlloc(
            GetProcessHeap(), HEAP_ZERO_MEMORY, dwLengthNeeded);
        if ptrNewSecurityDescriptor = nil then begin
          Result := -1;
          Exit;
        end;

        dwLength := dwLengthNeeded;

        if not GetUserObjectSecurity(AhWinSta, SecurityInformation,
            ptrSecurityDescriptor, dwLength, dwLengthNeeded) then begin
          Exit;
        end;

      end else begin
        Exit;
      end;

    end;

    if not InitializeSecurityDescriptor(
        ptrNewSecurityDescriptor, SECURITY_DESCRIPTOR_REVISION) then begin
      Exit;
    end;

    if not GetSecurityDescriptorDacl(ptrSecurityDescriptor,
        bDACLPresent, ptrACL, bDACLExist) then begin
      Exit;
    end;

    ZeroMemory(@ACLSizeInfo, SizeOf(ACLSizeInfo));
    ACLSizeInfo.AclBytesInUse := SizeOf(ACL);

    if ptrACL <> nil then begin
      if not GetAclInformation(ptrACL, @ACLSizeInfo,
          SizeOf(ACLSizeInfo), AclSizeInformation) then begin
        Exit;
      end;
    end;

    dwNewAclSize:= aclSizeInfo.AclBytesInUse
        + (2 * SizeOf(ACCESS_ALLOWED_ACE))
        + (2 * GetLengthSid(ptrSID))
        - (2 * SizeOf(DWord));

    ptrNewACL := HeapAlloc(GetProcessHeap, HEAP_ZERO_MEMORY, dwNewAclSize);
    if ptrNewACL = nil then begin
      Result := -1;
      Exit;
    end;

    if not InitializeAcl(ptrNewACL, dwNewACLSize, ACL_REVISION) then begin
      Exit;
    end;

    if bDACLPresent then begin
      if aclSizeInfo.AceCount > 0 then begin
        for i := 0 to aclSizeInfo.AceCount - 1 do begin
          if not GetAce(ptrACL, i, ptrTempACE) then begin
            Exit;
          end;

          if not AddAce(ptrNewACL, ACL_REVISION, MAXDWORD,
              ptrTempACE, PACE_HEADER(ptrTempACE).AceSize) then begin
            Exit;
          end;
        end; // for
      end; // if
    end; // if

    ptrACE := HeapAlloc(GetProcessHeap, HEAP_ZERO_MEMORY,
        SizeOf(ACCESS_ALLOWED_ACE) + GetLengthSid(ptrSID) - SizeOf(DWord));
    if ptrACE = nil then begin
      Result := -1;
      Exit;
    end;

    ptrACE.Header.AceType:= ACCESS_ALLOWED_ACE_TYPE;
    ptrACE.Header.AceFlags:=
        CONTAINER_INHERIT_ACE or INHERIT_ONLY_ACE or OBJECT_INHERIT_ACE;
    ptrACE.Header.AceSize := SizeOf(ACCESS_ALLOWED_ACE)
        + GetLengthSid(ptrSID)
        - SizeOf(DWord);
    ptrACE.Mask:= GENERIC_ACCESS;

    if not CopySid(GetLengthSid(ptrSID), @ptrACE.SidStart, ptrSID) then begin
      Exit;
    end;

    if not AddAce(ptrNewACL, ACL_REVISION,
        MAXDWORD, ptrACE, ptrACE.Header.AceSize) then begin
      Exit;
    end;

    ptrACE.Header.AceFlags:= NO_PROPAGATE_INHERIT_ACE;
    ptrACE.Mask:= WINSTA_ALL;

    if not AddAce(ptrNewACL, ACL_REVISION,
        MAXDWORD, ptrACE, ptrACE.Header.AceSize) then begin
      Exit;
    end;

    if not SetSecurityDescriptorDacl(ptrNewSecurityDescriptor,
        TRUE, ptrNewACL, FALSE) then begin
      Exit;
    end;

    if not SetUserObjectSecurity(AhWinSta,
        SecurityInformation, ptrNewSecurityDescriptor) then begin
      Exit;
    end;

    Result := 0;

  finally
    if ptrACE <> nil then begin
      HeapFree(GetProcessHeap, 0, ptrACE);
    end;

    if ptrNewACL <> nil then begin
      HeapFree(GetProcessHeap, 0, ptrNewACL);
    end;

    if ptrSecurityDescriptor <> nil then begin
      HeapFree(GetProcessHeap, 0, ptrSecurityDescriptor);
    end;

    if ptrNewSecurityDescriptor <> nil then begin
      HeapFree(GetProcessHeap, 0, ptrNewSecurityDescriptor);
    end;

  end; // try

end; // AddAceToWindowStation


function AddAceToDesktop(const AhDesktop: THandle;
    const ptrSID: PSID): Integer;
var
  ACLSizeInfo: ACL_SIZE_INFORMATION;
  bDACLExist: LongBool;
  bDACLPresent: LongBool;
  dwNewAclSize: DWord;
  dwLength: DWord;
  dwLengthNeeded: DWord;
  ptrACL: PACL;
  ptrNewACL: PACL;
  ptrSecurityDescriptor: PSecurityDescriptor;
  ptrNewSecurityDescriptor: PSecurityDescriptor;
  ptrTempACE: Pointer;
  SecurityInformation: TSecurityInformation;
  i: Integer;
begin
  Result := -1;
  dwLength := 0;
  ptrACL := nil;
  ptrNewACL := nil;
  ptrSecurityDescriptor := nil;
  ptrNewSecurityDescriptor := nil;
  SecurityInformation := DACL_SECURITY_INFORMATION;

  try
    if not GetUserObjectSecurity(AhDesktop, SecurityInformation,
        ptrSecurityDescriptor, dwLength, dwLengthNeeded) then begin

      Result := GetLastError();
      if Result = ERROR_INSUFFICIENT_BUFFER then begin
        ptrSecurityDescriptor := HeapAlloc(
            GetProcessHeap, HEAP_ZERO_MEMORY, dwLengthNeeded);
        if ptrSecurityDescriptor = nil then begin
          Result := -1;
          Exit;
        end;

        ptrNewSecurityDescriptor:= HeapAlloc(
            GetProcessHeap, HEAP_ZERO_MEMORY, dwLengthNeeded);
        if ptrNewSecurityDescriptor = nil then begin
          Result := -1;
          Exit;
        end;

        dwLength := dwLengthNeeded;

        if not GetUserObjectSecurity(AhDesktop, SecurityInformation,
            ptrSecurityDescriptor, dwLength, dwLengthNeeded) then begin
          Result := GetLastError();
          Exit;
        end;

      end else begin
        Exit;
      end;
    end;

    if not InitializeSecurityDescriptor(ptrNewSecurityDescriptor,
                SECURITY_DESCRIPTOR_REVISION) then begin
       Result := GetLastError();
       Exit;
    end;

    if not GetSecurityDescriptorDacl(ptrSecurityDescriptor,
        bDACLPresent, ptrACL, bDACLExist) then begin
      Result := GetLastError();
      Exit;
    end;

    ZeroMemory(@ACLSizeInfo, SizeOf(ACL_SIZE_INFORMATION));
    ACLSizeInfo.AclBytesInUse:= SizeOf(ACL);

    if ptrACL <> nil then begin
      if not GetAclInformation(ptrACL, @ACLSizeInfo,
          SizeOf(ACL_SIZE_INFORMATION), AclSizeInformation) then begin
        Result := GetLastError();
        Exit;
      end;
    end;

    dwNewAclSize := ACLSizeInfo.AclBytesInUse
        + SizeOf(ACCESS_ALLOWED_ACE)
        + GetLengthSid(ptrSID)
        - SizeOf(DWORD);

    ptrNewACL := HeapAlloc(
        GetProcessHeap(), HEAP_ZERO_MEMORY, dwNewAclSize);
    if ptrNewACL = nil then begin
      Result := -1;
      Exit;
    end;

    if not InitializeAcl(ptrNewACL, dwNewAclSize, ACL_REVISION) then begin
      Result := GetLastError();
      Exit;
    end;

    if bDACLPresent then begin
      if ACLSizeInfo.AceCount > 0 then begin
        for i := 0 to ACLSizeInfo.AceCount - 1 do begin
          if not GetAce(ptrACL, i, ptrTempACE) then begin
            Result := GetLastError();
            Exit;
          end;

          if not AddAce(ptrNewACL, ACL_REVISION, MAXDWORD,
              ptrTempACE, PACE_HEADER(ptrTempACE).AceSize) then begin
            Result := GetLastError();
            Exit;
          end;

        end; // for
      end; // if
    end; // if

    if not AddAccessAllowedAce(
        ptrNewACL, ACL_REVISION, DESKTOP_ALL, ptrSID) then begin
      Result := GetLastError();
      Exit;
    end;

    if not SetSecurityDescriptorDacl(
        ptrNewSecurityDescriptor, TRUE, ptrNewACL, FALSE) then begin
      Result := GetLastError();
      Exit;
    end;

    if not SetUserObjectSecurity(AhDesktop, SecurityInformation,
        ptrNewSecurityDescriptor) then begin
      Result := GetLastError();
      Exit;
    end;

    Result := 0;

  finally
    if ptrNewACL <> nil then begin
      HeapFree(GetProcessHeap, 0, ptrNewACL);
    end;

    if ptrSecurityDescriptor <> nil then begin
      HeapFree(GetProcessHeap, 0, ptrSecurityDescriptor);
    end;

    if ptrNewSecurityDescriptor <> nil then begin
      HeapFree(GetProcessHeap, 0, ptrNewSecurityDescriptor);
    end;

  end;

end; // AddAceToDesktop


function GetLogonSID(const AhToken: THandle; var ptrSid: PSID): Integer;
var
  dwIndex: DWord;
  dwLength: DWord;
  ptrTokenGroup: PTokenGroups;
begin
  Result := -1;
  dwLength := 0;
  ptrTokenGroup := nil;

  try
    if not GetTokenInformation(
        AhToken, TokenGroups, ptrTokenGroup, 0, dwLength) then begin

      Result := GetLastError();
      if Result <> ERROR_INSUFFICIENT_BUFFER then begin
        Exit;
      end;

      ptrTokenGroup := HeapAlloc(GetProcessHeap, HEAP_ZERO_MEMORY, dwLength);
      if ptrTokenGroup = nil then begin
        Result := -1;
        Exit;
      end;

    end;

    if not GetTokenInformation(
        AhToken, TokenGroups, ptrTokenGroup, dwLength, dwLength) then begin
      Result := GetLastError();
      Exit;
    end;

    for dwIndex := 0 to ptrTokenGroup.GroupCount - 1 do begin
      if (ptrTokenGroup.Groups[dwIndex].Attributes and SE_GROUP_LOGON_ID) =
          SE_GROUP_LOGON_ID then begin

        dwLength := GetLengthSid(ptrTokenGroup.Groups[dwIndex].Sid);
        ptrSid := HeapAlloc(GetProcessHeap, HEAP_ZERO_MEMORY, dwLength);
        if ptrSid = nil then begin
          Result := -1;
          Exit;
        end;

        if not CopySid(
            dwLength, ptrSid, ptrTokenGroup.Groups[dwIndex].Sid) then begin
          HeapFree(GetProcessHeap(), 0, ptrSid);
          Result := GetLastError();
          Exit;
        end;
        Break;
      end;
    end;

    Result := 0;

  finally
    if ptrTokenGroup <> nil then begin
      HeapFree(GetProcessHeap(), 0, ptrTokenGroup);
    end;
  end;

end; // GetLogonSID


function StartInteractiveClientProcess(const AhToken: THandle;
    const AstrCommandLine: string;
    const AbLoadProfile: Boolean = FALSE): Integer;
const
  DESKTOP_DESIRED_ACCESS = READ_CONTROL
      or WRITE_DAC
      or DESKTOP_WRITEOBJECTS
      or DESKTOP_READOBJECTS;
var
  hDesktop: THandle;
  hWinSta: THandle;
  hWinStaSave: THandle;
  ProcessInformation: TProcessInformation;
  ptrSid: PSID;
  StartupInfo: TStartupInfo;
  ProfileInfo: TProfileInfo;
  pcUserName: PChar;
  nSize: Cardinal;
begin
  hDesktop := 0;
  hWinSta := 0;
  hWinStaSave := 0;
  ptrSid := nil;
  Result := -1;

  try
    // Сохраняем текущую window station.
    hWinStaSave:= GetProcessWindowStation();
    if hWinStaSave = 0 then begin
      Result := GetLastError();
      Exit;
    end;

    // Получаем интерактивную window station (константа winsta0).
    hWinSta := OpenWindowStation('winsta0', FALSE,
        READ_CONTROL or WRITE_DAC);
    if hWinSta = 0 then begin
      Result := GetLastError();
      Exit;
    end;

    // Устанавливаем интерактивную window station как текущую.
    if not SetProcessWindowStation(hwinsta) then begin
      Result := GetLastError();
      Exit;
    end;

    // Получаем интерактивный десктоп.
    hDesktop := OpenDesktop('default', 0, FALSE, DESKTOP_DESIRED_ACCESS);

    // Восстанавливаем сохраненную ранее window station.
    if not SetProcessWindowStation(hWinStaSave) then begin
      Result := GetLastError();
      Exit;
    end;

    if hDesktop = 0 then begin
      Result := GetLastError();
      Exit;
    end;

    Result := GetLogonSID(AhToken, ptrSid);
    if Result <> 0 then begin
      Exit;
    end;

    // Обеспечиваем SID полный доступ к интерактивной window station.
    Result := AddACEToWindowStation(hWinSta, ptrSid);
    if Result <> 0 then begin
      Exit;
    end;

    // Обеспечиваем SID полный доступ к интерактивному десктопу.
    Result := AddACEToDesktop(hDesktop, ptrSid);
    if Result <> 0 then begin
      Exit;
    end;

    if not ImpersonateLoggedOnUser(AhToken) then begin
      Result := GetLastError();
      Exit;
    end;

    if AbLoadProfile then begin
      nSize := 0;
      pcUserName := nil;
      if not GetUserName(nil, nSize) then begin

        Result := GetLastError();
        if Result = ERROR_INSUFFICIENT_BUFFER then begin

          GetMem(pcUserName, nSize);
          ZeroMemory(pcUserName, nSize);

          if not GetUserName(pcUserName, nSize) then begin
            FreeMem(pcUserName);
            pcUserName := nil;
          end;
        end;
      end;
    end;

    RevertToSelf();
    
    if AbLoadProfile then begin
      if pcUserName <> nil then begin
        ZeroMemory(@ProfileInfo, SizeOf(ProfileInfo));
        ProfileInfo.dwSize := SizeOf(ProfileInfo);
        ProfileInfo.lpUserName := pcUserName;
        if not LoadUserProfile(AhToken, {in, out}ProfileInfo) then begin
          Result := GetLastError();
          MessageDlg('LoadUserProfile error! ' + IntToStr(Result), mtError, [mbOK], 0);
        end;
      end;
    end;

    ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
    StartupInfo.cb := SizeOf(StartupInfo);
    StartupInfo.lpDesktop := 'winsta0\default';

    Debug.Trace0('CreateProcessAsUser:'+AstrCommandLine);
    if CreateProcessAsUser(AhToken, nil, PAnsiChar(AstrCommandLine),
        nil, nil, FALSE, NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo,
        {out}ProcessInformation) then begin

      Result := 0;
      if (ProcessInformation.hThread <> INVALID_HANDLE_VALUE) then begin
        CloseHandle(ProcessInformation.hThread);
      end;

    end else begin
      Result := GetLastError();
    end;

  finally

    if pcUserName <> nil then begin
      FreeMem(pcUserName);
    end;

    if hWinStaSave <> 0 then begin
      SetProcessWindowStation(hWinStaSave);
    end;

    if ptrSid <> nil then begin
      HeapFree(GetProcessHeap(), 0, ptrSid);
    end;

    if hDesktop <> 0 then begin
      CloseDesktop(hDesktop);
    end;

    if hWinSta <> 0 then begin
      CloseWindowStation(hWinSta);
    end;

  end; // try

end; // StartInteractiveClientProcess


function StartInteractiveClientProcess(const AstrUsername: String;
    const AstrDomain: String; AstrPassword: String;
    const AstrCommandLine: String;
    const AbLoadProfile: Boolean = FALSE): Integer; overload;
var
  hToken: THandle;
begin
  Result := -1;
  hToken := 0;

  try
    if not LogonUser(PChar(AstrUsername), PChar(AstrDomain),
        PChar(AstrPassword), LOGON32_LOGON_INTERACTIVE,
        LOGON32_PROVIDER_DEFAULT, hToken) then begin
      Result := GetLastError();
      Exit;
    end;

    Result := StartInteractiveClientProcess(
        hToken, AstrCommandLine, AbLoadProfile);

  finally
    if (hToken <> INVALID_HANDLE_VALUE) or (hToken <> 0) then begin
      CloseHandle(hToken);
    end;
  end;

end; // StartInteractiveClientProcess


end.
