unit MMDevApi_tlb;
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants, MMSystem;

const
  // TypeLibrary Major and minor versions
  MMDeviceAPILibMajorVersion = 1;
  MMDeviceAPILibMinorVersion = 0;

  LIBID_MMDeviceAPILib: TGUID = '{2FDAAFA3-7523-4F66-9957-9D5E7FE698F6}';

  IID_IMMDeviceEnumerator: TGUID = '{A95664D2-9614-4F35-A746-DE8DB63617E6}';
  CLASS_MMDeviceEnumerator: TGUID = '{BCDE0395-E52F-467C-8E3D-C4579291692E}';
  IID_IMMDeviceCollection: TGUID = '{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}';
  IID_IMMDevice: TGUID = '{D666063F-1587-4E43-81F1-B948E807363F}';
  IID_ISequentialStream: TGUID = '{0C733A30-2A1C-11CE-ADE5-00AA0044773D}';
  IID_IStream: TGUID = '{0000000C-0000-0000-C000-000000000046}';
  IID_IStorage: TGUID = '{0000000B-0000-0000-C000-000000000046}';
  IID_IEnumSTATSTG: TGUID = '{0000000D-0000-0000-C000-000000000046}';
  IID_IRecordInfo: TGUID = '{0000002F-0000-0000-C000-000000000046}';
  IID_ITypeInfo: TGUID = '{00020401-0000-0000-C000-000000000046}';
  IID_ITypeComp: TGUID = '{00020403-0000-0000-C000-000000000046}';
  IID_ITypeLib: TGUID = '{00020402-0000-0000-C000-000000000046}';
  IID_IPropertyStore: TGUID = '{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}';
  IID_IMMNotificationClient: TGUID = '{7991EEC9-7E89-4D85-8390-6C703CEC60C0}';

  IID_IAudioEndpointVolume: TGUID = '{5CDF2C82-841E-4546-9722-0CF74078229A}';
  IID_IAudioMeterInformation : TGUID = '{C02216F6-8C67-4B5B-9D00-D008E73E0064}';
  IID_IAudioEndpointVolumeCallback: TGUID = '{657804FA-D6AD-4496-8A60-352752AF4F89}';

  IID_IAudioClient: TGUID = '{1CB9AD4C-DBFA-4c32-B178-C2F568A703B2}';
  IID_IAudioCaptureClient: TGUID = '{C8ADBD64-E71E-48a0-A4DE-185C395CD317}';

type
  __MIDL___MIDL_itf_mmdeviceapi_0000_0000_0001 = TOleEnum;

const
  eRender = $00000000;
  eCapture = $00000001;
  eAll = $00000002;
  EDataFlow_enum_count = $00000003;

type
  tagTYPEKIND = TOleEnum;

const
  TKIND_ENUM = $00000000;
  TKIND_RECORD = $00000001;
  TKIND_MODULE = $00000002;
  TKIND_INTERFACE = $00000003;
  TKIND_DISPATCH = $00000004;
  TKIND_COCLASS = $00000005;
  TKIND_ALIAS = $00000006;
  TKIND_UNION = $00000007;
  TKIND_MAX = $00000008;

type
  tagDESCKIND = TOleEnum;

const
  DESCKIND_NONE = $00000000;
  DESCKIND_FUNCDESC = $00000001;
  DESCKIND_VARDESC = $00000002;
  DESCKIND_TYPECOMP = $00000003;
  DESCKIND_IMPLICITAPPOBJ = $00000004;
  DESCKIND_MAX = $00000005;

type
  tagFUNCKIND = TOleEnum;

const
  FUNC_VIRTUAL = $00000000;
  FUNC_PUREVIRTUAL = $00000001;
  FUNC_NONVIRTUAL = $00000002;
  FUNC_STATIC = $00000003;
  FUNC_DISPATCH = $00000004;

type
  tagINVOKEKIND = TOleEnum;

const
  INVOKE_FUNC = $00000001;
  INVOKE_PROPERTYGET = $00000002;
  INVOKE_PROPERTYPUT = $00000004;
  INVOKE_PROPERTYPUTREF = $00000008;

type
  tagCALLCONV = TOleEnum;

const
  CC_FASTCALL = $00000000;
  CC_CDECL = $00000001;
  CC_MSCPASCAL = $00000002;
  CC_PASCAL = $00000002;
  CC_MACPASCAL = $00000003;
  CC_STDCALL = $00000004;
  CC_FPFASTCALL = $00000005;
  CC_SYSCALL = $00000006;
  CC_MPWCDECL = $00000007;
  CC_MPWPASCAL = $00000008;
  CC_MAX = $00000009;

type
  tagVARKIND = TOleEnum;

const
  VAR_PERINSTANCE = $00000000;
  VAR_STATIC = $00000001;
  VAR_CONST = $00000002;
  VAR_DISPATCH = $00000003;

type
  tagSYSKIND = TOleEnum;

const
  SYS_WIN16 = $00000000;
  SYS_WIN32 = $00000001;
  SYS_MAC = $00000002;
  SYS_WIN64 = $00000003;

type
  __MIDL___MIDL_itf_mmdeviceapi_0000_0000_0002 = TOleEnum;

const
  eConsole = $00000000;
  eMultimedia = $00000001;
  eCommunications = $00000002;
  ERole_enum_count = $00000003;

type
  IMMDeviceEnumerator = interface;
  IMMDeviceCollection = interface;
  IMMDevice = interface;
  ISequentialStream = interface;
  IStream = interface;
  IStorage = interface;
  IEnumSTATSTG = interface;
  IRecordInfo = interface;
  ITypeInfo = interface;
  ITypeComp = interface;
  ITypeLib = interface;
  IPropertyStore = interface;
  IMMNotificationClient = interface;

  MMDeviceEnumerator = IMMDeviceEnumerator;

  wirePSAFEARRAY = ^PUserType4;
  wireSNB = ^tagRemSNB; 
  PUserType5 = ^_FLAGGED_WORD_BLOB; {*}
  PUserType6 = ^_wireVARIANT; {*}
  PUserType13 = ^_wireBRECORD; {*}
  PUserType4 = ^_wireSAFEARRAY; {*}
  PPUserType1 = ^PUserType4; {*}
  PUserType10 = ^tagTYPEDESC; {*}
  PUserType11 = ^tagARRAYDESC; {*}
  PUserType2 = ^tag_inner_PROPVARIANT; {*}
  PUserType1 = ^TGUID; {*}
  PByte1 = ^Byte; {*}
  PUserType3 = ^_FILETIME; {*}
  POleVariant1 = ^OleVariant; {*}
  PUserType7 = ^tagTYPEATTR; {*}
  PUserType8 = ^tagFUNCDESC; {*}
  PUserType9 = ^tagVARDESC; {*}
  PUserType12 = ^tagTLIBATTR; {*}
  PUserType14 = ^_tagpropertykey; {*}

  EDataFlow = __MIDL___MIDL_itf_mmdeviceapi_0000_0000_0001; 

  _LARGE_INTEGER = packed record
    QuadPart: Int64;
  end;

  _ULARGE_INTEGER = packed record
    QuadPart: Largeuint;
  end;

  _FILETIME = packed record
    dwLowDateTime: LongWord;
    dwHighDateTime: LongWord;
  end;

  tagCLIPDATA = packed record
    cbSize: LongWord;
    ulClipFmt: Integer;
    pClipData: ^Byte;
  end;

  tagBSTRBLOB = packed record
    cbSize: LongWord;
    pData: ^Byte;
  end;

  tagBLOB = packed record
    cbSize: LongWord;
    pBlobData: ^Byte;
  end;

  tagVersionedStream = packed record
    guidVersion: TGUID;
    pStream: IStream;
  end;

  tagSTATSTG = packed record
    pwcsName: PWideChar;
    type_: LongWord;
    cbSize: _ULARGE_INTEGER;
    mtime: _FILETIME;
    ctime: _FILETIME;
    atime: _FILETIME;
    grfMode: LongWord;
    grfLocksSupported: LongWord;
    clsid: TGUID;
    grfStateBits: LongWord;
    reserved: LongWord;
  end;

  tagRemSNB = packed record
    ulCntStr: LongWord;
    ulCntChar: LongWord;
    rgString: ^Word;
  end;

  tagCAC = packed record
    cElems: LongWord;
    pElems: ^Shortint;
  end;

  tagCAUB = packed record
    cElems: LongWord;
    pElems: ^Byte;
  end;

  _wireSAFEARR_BSTR = packed record
    Size: LongWord;
    aBstr: ^PUserType5;
  end;

  _wireSAFEARR_UNKNOWN = packed record
    Size: LongWord;
    apUnknown: ^IUnknown;
  end;

  _wireSAFEARR_DISPATCH = packed record
    Size: LongWord;
    apDispatch: ^IDispatch;
  end;

  _FLAGGED_WORD_BLOB = packed record
    fFlags: LongWord;
    clSize: LongWord;
    asData: ^Word;
  end;

  _wireSAFEARR_VARIANT = packed record
    Size: LongWord;
    aVariant: ^PUserType6;
  end;

  _wireBRECORD = packed record
    fFlags: LongWord;
    clSize: LongWord;
    pRecInfo: IRecordInfo;
    pRecord: ^Byte;
  end;

  __MIDL_IOleAutomationTypes_0005 = record
    case Integer of
      0: (lptdesc: PUserType10);
      1: (lpadesc: PUserType11);
      2: (hreftype: LongWord);
  end;

  tagTYPEDESC = packed record
    __MIDL__IOleAutomationTypes0004: __MIDL_IOleAutomationTypes_0005;
    vt: Word;
  end;

  tagSAFEARRAYBOUND = packed record
    cElements: LongWord;
    lLbound: Integer;
  end;

  ULONG_PTR = LongWord; 

  tagIDLDESC = packed record
    dwReserved: ULONG_PTR;
    wIDLFlags: Word;
  end;

  DWORD = LongWord; 

  tagPARAMDESCEX = packed record
    cBytes: LongWord;
    varDefaultValue: OleVariant;
  end;

  tagPARAMDESC = packed record
    pparamdescex: ^tagPARAMDESCEX;
    wParamFlags: Word;
  end;

  tagELEMDESC = packed record
    tdesc: tagTYPEDESC;
    paramdesc: tagPARAMDESC;
  end;

  tagFUNCDESC = packed record
    memid: Integer;
    lprgscode: ^SCODE;
    lprgelemdescParam: ^tagELEMDESC;
    funckind: tagFUNCKIND;
    invkind: tagINVOKEKIND;
    callconv: tagCALLCONV;
    cParams: Smallint;
    cParamsOpt: Smallint;
    oVft: Smallint;
    cScodes: Smallint;
    elemdescFunc: tagELEMDESC;
    wFuncFlags: Word;
  end;

  __MIDL_IOleAutomationTypes_0006 = record
    case Integer of
      0: (oInst: LongWord);
      1: (lpvarValue: ^OleVariant);
  end;

  tagVARDESC = packed record
    memid: Integer;
    lpstrSchema: PWideChar;
    __MIDL__IOleAutomationTypes0005: __MIDL_IOleAutomationTypes_0006;
    elemdescVar: tagELEMDESC;
    wVarFlags: Word;
    varkind: tagVARKIND;
  end;

  tagTLIBATTR = packed record
    guid: TGUID;
    lcid: LongWord;
    syskind: tagSYSKIND;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    wLibFlags: Word;
  end;

  _wireSAFEARR_BRECORD = packed record
    Size: LongWord;
    aRecord: ^PUserType13;
  end;

  _wireSAFEARR_HAVEIID = packed record
    Size: LongWord;
    apUnknown: ^IUnknown;
    iid: TGUID;
  end;

  _BYTE_SIZEDARR = packed record
    clSize: LongWord;
    pData: ^Byte;
  end;

  _SHORT_SIZEDARR = packed record
    clSize: LongWord;
    pData: ^Word;
  end;

  _LONG_SIZEDARR = packed record
    clSize: LongWord;
    pData: ^LongWord;
  end;

  _HYPER_SIZEDARR = packed record
    clSize: LongWord;
    pData: ^Int64;
  end;

  tagCAI = packed record
    cElems: LongWord;
    pElems: ^Smallint;
  end;

  tagCAUI = packed record
    cElems: LongWord;
    pElems: ^Word;
  end;

  tagCAL = packed record
    cElems: LongWord;
    pElems: ^Integer;
  end;

  tagCAUL = packed record
    cElems: LongWord;
    pElems: ^LongWord;
  end;

  tagCAH = packed record
    cElems: LongWord;
    pElems: ^_LARGE_INTEGER;
  end;

  tagCAUH = packed record
    cElems: LongWord;
    pElems: ^_ULARGE_INTEGER;
  end;

  tagCAFLT = packed record
    cElems: LongWord;
    pElems: ^Single;
  end;

  tagCADBL = packed record
    cElems: LongWord;
    pElems: ^Double;
  end;

  tagCABOOL = packed record
    cElems: LongWord;
    pElems: ^WordBool;
  end;

  tagCASCODE = packed record
    cElems: LongWord;
    pElems: ^SCODE;
  end;

  tagCACY = packed record
    cElems: LongWord;
    pElems: ^Currency;
  end;

  tagCADATE = packed record
    cElems: LongWord;
    pElems: ^TDateTime;
  end;

  tagCAFILETIME = packed record
    cElems: LongWord;
    pElems: ^_FILETIME;
  end;

  tagCACLSID = packed record
    cElems: LongWord;
    pElems: ^TGUID;
  end;

  tagCACLIPDATA = packed record
    cElems: LongWord;
    pElems: ^tagCLIPDATA;
  end;

  tagCABSTR = packed record
    cElems: LongWord;
    pElems: ^WideString;
  end;

  tagCABSTRBLOB = packed record
    cElems: LongWord;
    pElems: ^tagBSTRBLOB;
  end;

  tagCALPSTR = packed record
    cElems: LongWord;
    pElems: ^PChar;
  end;

  tagCALPWSTR = packed record
    cElems: LongWord;
    pElems: ^PWideChar;
  end;

  tagCAPROPVARIANT = packed record
    cElems: LongWord;
    pElems: PUserType2;
  end;

  __MIDL___MIDL_itf_mmdeviceapi_0003_0081_0001 = record
    case Integer of
      0: (cVal: Shortint);
      1: (bVal: Byte);
      2: (iVal: Smallint);
      3: (uiVal: Word);
      4: (lVal: Integer);
      5: (ulVal: LongWord);
      6: (intVal: SYSINT);
      7: (uintVal: SYSUINT);
      8: (hVal: _LARGE_INTEGER);
      9: (uhVal: _ULARGE_INTEGER);
      10: (fltVal: Single);
      11: (dblVal: Double);
      12: (boolVal: WordBool);
      13: (bool: WordBool);
      14: (scode: SCODE);
      15: (cyVal: Currency);
      16: (date: TDateTime);
      17: (filetime: _FILETIME);
      18: (puuid: ^TGUID);
      19: (pClipData: ^tagCLIPDATA);
      20: (bstrVal: {!!WideString}Pointer);
      21: (bstrblobVal: tagBSTRBLOB);
      22: (blob: tagBLOB);
      23: (pszVal: PChar);
      24: (pwszVal: PWideChar);
      25: (punkVal: {!!IUnknown}Pointer);
      26: (pdispVal: {!!IDispatch}Pointer);
      27: (pStream: {!!IStream}Pointer);
      28: (pStorage: {!!IStorage}Pointer);
      29: (pVersionedStream: ^tagVersionedStream);
      30: (parray: wirePSAFEARRAY);
      31: (cac: tagCAC);
      32: (caub: tagCAUB);
      33: (cai: tagCAI);
      34: (caui: tagCAUI);
      35: (cal: tagCAL);
      36: (caul: tagCAUL);
      37: (cah: tagCAH);
      38: (cauh: tagCAUH);
      39: (caflt: tagCAFLT);
      40: (cadbl: tagCADBL);
      41: (cabool: tagCABOOL);
      42: (cascode: tagCASCODE);
      43: (cacy: tagCACY);
      44: (cadate: tagCADATE);
      45: (cafiletime: tagCAFILETIME);
      46: (cauuid: tagCACLSID);
      47: (caclipdata: tagCACLIPDATA);
      48: (cabstr: tagCABSTR);
      49: (cabstrblob: tagCABSTRBLOB);
      50: (calpstr: tagCALPSTR);
      51: (calpwstr: tagCALPWSTR);
      52: (capropvar: tagCAPROPVARIANT);
      53: (pcVal: ^Shortint);
      54: (pbVal: ^Byte);
      55: (piVal: ^Smallint);
      56: (puiVal: ^Word);
      57: (plVal: ^Integer);
      58: (pulVal: ^LongWord);
      59: (pintVal: ^SYSINT);
      60: (puintVal: ^SYSUINT);
      61: (pfltVal: ^Single);
      62: (pdblVal: ^Double);
      63: (pboolVal: ^WordBool);
      64: (pdecVal: ^TDecimal);
      65: (pscode: ^SCODE);
      66: (pcyVal: ^Currency);
      67: (pdate: ^TDateTime);
      68: (pbstrVal: ^WideString);
      69: (ppunkVal: {!!^IUnknown}Pointer);
      70: (ppdispVal: {!!^IDispatch}Pointer);
      71: (pparray: ^wirePSAFEARRAY);
      72: (pvarVal: PUserType2);
  end;

  _tagpropertykey = packed record
    fmtid: TGUID;
    pid: LongWord;
  end;

  ERole = __MIDL___MIDL_itf_mmdeviceapi_0000_0000_0002; 

  tag_inner_PROPVARIANT = packed record
    vt: Word;
    wReserved1: Byte;
    wReserved2: Byte;
    wReserved3: LongWord;
    __MIDL____MIDL_itf_mmdeviceapi_0003_00810001: __MIDL___MIDL_itf_mmdeviceapi_0003_0081_0001;
  end;

  __MIDL_IOleAutomationTypes_0004 = record
    case Integer of
      0: (llVal: Int64);
      1: (lVal: Integer);
      2: (bVal: Byte);
      3: (iVal: Smallint);
      4: (fltVal: Single);
      5: (dblVal: Double);
      6: (boolVal: WordBool);
      7: (scode: SCODE);
      8: (cyVal: Currency);
      9: (date: TDateTime);
      10: (bstrVal: ^_FLAGGED_WORD_BLOB);
      11: (punkVal: {!!IUnknown}Pointer);
      12: (pdispVal: {!!IDispatch}Pointer);
      13: (parray: ^PUserType4);
      14: (brecVal: ^_wireBRECORD);
      15: (pbVal: ^Byte);
      16: (piVal: ^Smallint);
      17: (plVal: ^Integer);
      18: (pllVal: ^Int64);
      19: (pfltVal: ^Single);
      20: (pdblVal: ^Double);
      21: (pboolVal: ^WordBool);
      22: (pscode: ^SCODE);
      23: (pcyVal: ^Currency);
      24: (pdate: ^TDateTime);
      25: (pbstrVal: ^PUserType5);
      26: (ppunkVal: {!!^IUnknown}Pointer);
      27: (ppdispVal: {!!^IDispatch}Pointer);
      28: (pparray: ^PPUserType1);
      29: (pvarVal: ^PUserType6);
      30: (cVal: Shortint);
      31: (uiVal: Word);
      32: (ulVal: LongWord);
      33: (ullVal: Largeuint);
      34: (intVal: SYSINT);
      35: (uintVal: SYSUINT);
      36: (decVal: TDecimal);
      37: (pdecVal: ^TDecimal);
      38: (pcVal: ^Shortint);
      39: (puiVal: ^Word);
      40: (pulVal: ^LongWord);
      41: (pullVal: ^Largeuint);
      42: (pintVal: ^SYSINT);
      43: (puintVal: ^SYSUINT);
  end;

  __MIDL_IOleAutomationTypes_0001 = record
    case Integer of
      0: (BstrStr: _wireSAFEARR_BSTR);
      1: (UnknownStr: _wireSAFEARR_UNKNOWN);
      2: (DispatchStr: _wireSAFEARR_DISPATCH);
      3: (VariantStr: _wireSAFEARR_VARIANT);
      4: (RecordStr: _wireSAFEARR_BRECORD);
      5: (HaveIidStr: _wireSAFEARR_HAVEIID);
      6: (ByteStr: _BYTE_SIZEDARR);
      7: (WordStr: _SHORT_SIZEDARR);
      8: (LongStr: _LONG_SIZEDARR);
      9: (HyperStr: _HYPER_SIZEDARR);
  end;

  _wireSAFEARRAY_UNION = packed record
    sfType: LongWord;
    u: __MIDL_IOleAutomationTypes_0001;
  end;

  _wireVARIANT = packed record
    clSize: LongWord;
    rpcReserved: LongWord;
    vt: Word;
    wReserved1: Word;
    wReserved2: Word;
    wReserved3: Word;
    __MIDL__IOleAutomationTypes0002: __MIDL_IOleAutomationTypes_0004;
  end;

  tagTYPEATTR = packed record
    guid: TGUID;
    lcid: LongWord;
    dwReserved: LongWord;
    memidConstructor: Integer;
    memidDestructor: Integer;
    lpstrSchema: PWideChar;
    cbSizeInstance: LongWord;
    typekind: tagTYPEKIND;
    cFuncs: Word;
    cVars: Word;
    cImplTypes: Word;
    cbSizeVft: Word;
    cbAlignment: Word;
    wTypeFlags: Word;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    tdescAlias: tagTYPEDESC;
    idldescType: tagIDLDESC;
  end;

  tagARRAYDESC = packed record
    tdescElem: tagTYPEDESC;
    cDims: Word;
    rgbounds: ^tagSAFEARRAYBOUND;
  end;

  _wireSAFEARRAY = packed record
    cDims: Word;
    fFeatures: Word;
    cbElements: LongWord;
    cLocks: LongWord;
    uArrayStructs: _wireSAFEARRAY_UNION;
    rgsabound: ^tagSAFEARRAYBOUND;
  end;

  IMMDeviceEnumerator = interface(IUnknown)
    ['{A95664D2-9614-4F35-A746-DE8DB63617E6}']
    function EnumAudioEndpoints(dataFlow: EDataFlow; dwStateMask: LongWord; 
                                out ppDevices: IMMDeviceCollection): HResult; stdcall;
    function GetDefaultAudioEndpoint(dataFlow: EDataFlow; role: ERole; out ppEndpoint: IMMDevice): HResult; stdcall;
    function GetDevice(pwstrId: PWideChar; out ppDevice: IMMDevice): HResult; stdcall;
    function RegisterEndpointNotificationCallback(const pClient: IMMNotificationClient): HResult; stdcall;
    function UnregisterEndpointNotificationCallback(const pClient: IMMNotificationClient): HResult; stdcall;
  end;

  IMMDeviceCollection = interface(IUnknown)
    ['{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}']
    function GetCount(out pcDevices: SYSUINT): HResult; stdcall;
    function Item(nDevice: SYSUINT; out ppDevice: IMMDevice): HResult; stdcall;
  end;

  IMMDevice = interface(IUnknown)
    ['{D666063F-1587-4E43-81F1-B948E807363F}']
    function Activate(var iid: TGUID; dwClsCtx: LongWord;
                      var pActivationParams: tag_inner_PROPVARIANT; out ppInterface: Pointer): HResult; stdcall;
    function OpenPropertyStore(stgmAccess: LongWord; out ppProperties: IPropertyStore): HResult; stdcall;
    function GetId(out ppstrId: PWideChar): HResult; stdcall;
    function GetState(out pdwState: LongWord): HResult; stdcall;
  end;

  ISequentialStream = interface(IUnknown)
    ['{0C733A30-2A1C-11CE-ADE5-00AA0044773D}']
    function RemoteRead(out pv: Byte; cb: LongWord; out pcbRead: LongWord): HResult; stdcall;
    function RemoteWrite(var pv: Byte; cb: LongWord; out pcbWritten: LongWord): HResult; stdcall;
  end;

  IStream = interface(ISequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function RemoteSeek(dlibMove: _LARGE_INTEGER; dwOrigin: LongWord; 
                        out plibNewPosition: _ULARGE_INTEGER): HResult; stdcall;
    function SetSize(libNewSize: _ULARGE_INTEGER): HResult; stdcall;
    function RemoteCopyTo(const pstm: IStream; cb: _ULARGE_INTEGER; out pcbRead: _ULARGE_INTEGER; 
                          out pcbWritten: _ULARGE_INTEGER): HResult; stdcall;
    function Commit(grfCommitFlags: LongWord): HResult; stdcall;
    function Revert: HResult; stdcall;
    function LockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function UnlockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function Stat(out pstatstg: tagSTATSTG; grfStatFlag: LongWord): HResult; stdcall;
    function Clone(out ppstm: IStream): HResult; stdcall;
  end;

  IStorage = interface(IUnknown)
    ['{0000000B-0000-0000-C000-000000000046}']
    function CreateStream(pwcsName: PWideChar; grfMode: LongWord; reserved1: LongWord; 
                          reserved2: LongWord; out ppstm: IStream): HResult; stdcall;
    function RemoteOpenStream(pwcsName: PWideChar; cbReserved1: LongWord; var reserved1: Byte; 
                              grfMode: LongWord; reserved2: LongWord; out ppstm: IStream): HResult; stdcall;
    function CreateStorage(pwcsName: PWideChar; grfMode: LongWord; reserved1: LongWord; 
                           reserved2: LongWord; out ppstg: IStorage): HResult; stdcall;
    function OpenStorage(pwcsName: PWideChar; const pstgPriority: IStorage; grfMode: LongWord; 
                         var snbExclude: tagRemSNB; reserved: LongWord; out ppstg: IStorage): HResult; stdcall;
    function RemoteCopyTo(ciidExclude: LongWord; var rgiidExclude: TGUID; 
                          var snbExclude: tagRemSNB; const pstgDest: IStorage): HResult; stdcall;
    function MoveElementTo(pwcsName: PWideChar; const pstgDest: IStorage; pwcsNewName: PWideChar; 
                           grfFlags: LongWord): HResult; stdcall;
    function Commit(grfCommitFlags: LongWord): HResult; stdcall;
    function Revert: HResult; stdcall;
    function RemoteEnumElements(reserved1: LongWord; cbReserved2: LongWord; var reserved2: Byte; 
                                reserved3: LongWord; out ppenum: IEnumSTATSTG): HResult; stdcall;
    function DestroyElement(pwcsName: PWideChar): HResult; stdcall;
    function RenameElement(pwcsOldName: PWideChar; pwcsNewName: PWideChar): HResult; stdcall;
    function SetElementTimes(pwcsName: PWideChar; var pctime: _FILETIME; var patime: _FILETIME; 
                             var pmtime: _FILETIME): HResult; stdcall;
    function SetClass(var clsid: TGUID): HResult; stdcall;
    function SetStateBits(grfStateBits: LongWord; grfMask: LongWord): HResult; stdcall;
    function Stat(out pstatstg: tagSTATSTG; grfStatFlag: LongWord): HResult; stdcall;
  end;

  IEnumSTATSTG = interface(IUnknown)
    ['{0000000D-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: tagSTATSTG; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumSTATSTG): HResult; stdcall;
  end;

  IRecordInfo = interface(IUnknown)
    ['{0000002F-0000-0000-C000-000000000046}']
    function RecordInit(out pvNew: Pointer): HResult; stdcall;
    function RecordClear(var pvExisting: Pointer): HResult; stdcall;
    function RecordCopy(var pvExisting: Pointer; out pvNew: Pointer): HResult; stdcall;
    function GetGuid(out pguid: TGUID): HResult; stdcall;
    function GetName(out pbstrName: WideString): HResult; stdcall;
    function GetSize(out pcbSize: LongWord): HResult; stdcall;
    function GetTypeInfo(out ppTypeInfo: ITypeInfo): HResult; stdcall;
    function GetField(var pvData: Pointer; szFieldName: PWideChar; out pvarField: OleVariant): HResult; stdcall;
    function GetFieldNoCopy(var pvData: Pointer; szFieldName: PWideChar; out pvarField: OleVariant;
                            out ppvDataCArray: Pointer): HResult; stdcall;
    function PutField(wFlags: LongWord; var pvData: Pointer; szFieldName: PWideChar;
                      var pvarField: OleVariant): HResult; stdcall;
    function PutFieldNoCopy(wFlags: LongWord; var pvData: Pointer; szFieldName: PWideChar;
                            var pvarField: OleVariant): HResult; stdcall;
    function GetFieldNames(var pcNames: LongWord; out rgBstrNames: WideString): HResult; stdcall;
    function IsMatchingType(const pRecordInfo: IRecordInfo): Integer; stdcall;
    function RecordCreate: Pointer; stdcall;
    function RecordCreateCopy(var pvSource: Pointer; out ppvDest: Pointer): HResult; stdcall;
    function RecordDestroy(var pvRecord: Pointer): HResult; stdcall;
  end;

  ITypeInfo = interface(IUnknown)
    ['{00020401-0000-0000-C000-000000000046}']
    function RemoteGetTypeAttr(out ppTypeAttr: PUserType7; out pDummy: DWORD): HResult; stdcall;
    function GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
    function RemoteGetFuncDesc(index: SYSUINT; out ppFuncDesc: PUserType8; out pDummy: DWORD): HResult; stdcall;
    function RemoteGetVarDesc(index: SYSUINT; out ppVarDesc: PUserType9; out pDummy: DWORD): HResult; stdcall;
    function RemoteGetNames(memid: Integer; out rgBstrNames: WideString; cMaxNames: SYSUINT;
                            out pcNames: SYSUINT): HResult; stdcall;
    function GetRefTypeOfImplType(index: SYSUINT; out pRefType: LongWord): HResult; stdcall;
    function GetImplTypeFlags(index: SYSUINT; out pImplTypeFlags: SYSINT): HResult; stdcall;
    function LocalGetIDsOfNames: HResult; stdcall;
    function LocalInvoke: HResult; stdcall;
    function RemoteGetDocumentation(memid: Integer; refPtrFlags: LongWord;
                                    out pbstrName: WideString; out pBstrDocString: WideString;
                                    out pdwHelpContext: LongWord; out pBstrHelpFile: WideString): HResult; stdcall;
    function RemoteGetDllEntry(memid: Integer; invkind: tagINVOKEKIND; refPtrFlags: LongWord;
                               out pBstrDllName: WideString; out pbstrName: WideString;
                               out pwOrdinal: Word): HResult; stdcall;
    function GetRefTypeInfo(hreftype: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
    function LocalAddressOfMember: HResult; stdcall;
    function RemoteCreateInstance(var riid: TGUID; out ppvObj: IUnknown): HResult; stdcall;
    function GetMops(memid: Integer; out pBstrMops: WideString): HResult; stdcall;
    function RemoteGetContainingTypeLib(out ppTLib: ITypeLib; out pIndex: SYSUINT): HResult; stdcall;
    function LocalReleaseTypeAttr: HResult; stdcall;
    function LocalReleaseFuncDesc: HResult; stdcall;
    function LocalReleaseVarDesc: HResult; stdcall;
  end;

  ITypeComp = interface(IUnknown)
    ['{00020403-0000-0000-C000-000000000046}']
    function RemoteBind(szName: PWideChar; lHashVal: LongWord; wFlags: Word;
                        out ppTInfo: ITypeInfo; out pDescKind: tagDESCKIND;
                        out ppFuncDesc: PUserType8; out ppVarDesc: PUserType9;
                        out ppTypeComp: ITypeComp; out pDummy: DWORD): HResult; stdcall;
    function RemoteBindType(szName: PWideChar; lHashVal: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
  end;

  ITypeLib = interface(IUnknown)
    ['{00020402-0000-0000-C000-000000000046}']
    function RemoteGetTypeInfoCount(out pcTInfo: SYSUINT): HResult; stdcall;
    function GetTypeInfo(index: SYSUINT; out ppTInfo: ITypeInfo): HResult; stdcall;
    function GetTypeInfoType(index: SYSUINT; out pTKind: tagTYPEKIND): HResult; stdcall;
    function GetTypeInfoOfGuid(var guid: TGUID; out ppTInfo: ITypeInfo): HResult; stdcall;
    function RemoteGetLibAttr(out ppTLibAttr: PUserType12; out pDummy: DWORD): HResult; stdcall;
    function GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
    function RemoteGetDocumentation(index: SYSINT; refPtrFlags: LongWord;
                                    out pbstrName: WideString; out pBstrDocString: WideString;
                                    out pdwHelpContext: LongWord; out pBstrHelpFile: WideString): HResult; stdcall;
    function RemoteIsName(szNameBuf: PWideChar; lHashVal: LongWord; out pfName: Integer;
                          out pBstrLibName: WideString): HResult; stdcall;
    function RemoteFindName(szNameBuf: PWideChar; lHashVal: LongWord; out ppTInfo: ITypeInfo;
                            out rgMemId: Integer; var pcFound: Word; out pBstrLibName: WideString): HResult; stdcall;
    function LocalReleaseTLibAttr: HResult; stdcall;
  end;

  IPropertyStore = interface(IUnknown)
    ['{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}']
    function GetCount(out cProps: LongWord): HResult; stdcall;
    function GetAt(iProp: LongWord; out pkey: _tagpropertykey): HResult; stdcall;
    function GetValue(var key: _tagpropertykey; out pv: tag_inner_PROPVARIANT): HResult; stdcall;
    function SetValue(var key: _tagpropertykey; var propvar: tag_inner_PROPVARIANT): HResult; stdcall;
    function Commit: HResult; stdcall;
  end;

  IMMNotificationClient = interface(IUnknown)
    ['{7991EEC9-7E89-4D85-8390-6C703CEC60C0}']
    function OnDeviceStateChanged(pwstrDeviceId: PWideChar; dwNewState: LongWord): HResult; stdcall;
    function OnDeviceAdded(pwstrDeviceId: PWideChar): HResult; stdcall;
    function OnDeviceRemoved(pwstrDeviceId: PWideChar): HResult; stdcall;
    function OnDefaultDeviceChanged(flow: EDataFlow; role: ERole; pwstrDefaultDeviceId: PWideChar): HResult; stdcall;
    function OnPropertyValueChanged(pwstrDeviceId: PWideChar; key: _tagpropertykey): HResult; stdcall;
  end;

  CoMMDeviceEnumerator = class
    class function Create: IMMDeviceEnumerator;
    class function CreateRemote(const MachineName: string): IMMDeviceEnumerator;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMMDeviceEnumeratorProperties= class;
{$ENDIF}
  TMMDeviceEnumerator = class(TOleServer)
  private
    FIntf: IMMDeviceEnumerator;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMMDeviceEnumeratorProperties;
    function GetServerProperties: TMMDeviceEnumeratorProperties;
{$ENDIF}
    function GetDefaultInterface: IMMDeviceEnumerator;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMMDeviceEnumerator);
    procedure Disconnect; override;
    function EnumAudioEndpoints(dataFlow: EDataFlow; dwStateMask: LongWord;
                                out ppDevices: IMMDeviceCollection): HResult;
    function GetDefaultAudioEndpoint(dataFlow: EDataFlow; role: ERole; out ppEndpoint: IMMDevice): HResult;
    function GetDevice(pwstrId: PWideChar; out ppDevice: IMMDevice): HResult;
    function RegisterEndpointNotificationCallback(const pClient: IMMNotificationClient): HResult;
    function UnregisterEndpointNotificationCallback(const pClient: IMMNotificationClient): HResult;
    property DefaultInterface: IMMDeviceEnumerator read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMMDeviceEnumeratorProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
 TMMDeviceEnumeratorProperties = class(TPersistent)
  private
    FServer:    TMMDeviceEnumerator;
    function    GetDefaultInterface: IMMDeviceEnumerator;
    constructor Create(AServer: TMMDeviceEnumerator);
  protected
  public
    property DefaultInterface: IMMDeviceEnumerator read GetDefaultInterface;
  published
  end;
{$ENDIF}

const
  AUDCLNT_STREAMFLAGS_CROSSPROCESS  = $00010000;
  AUDCLNT_STREAMFLAGS_LOOPBACK      = $00020000;
  AUDCLNT_STREAMFLAGS_EVENTCALLBACK = $00040000;
  AUDCLNT_STREAMFLAGS_NOPERSIST     = $00080000;

type
  AUDIO_VOLUME_NOTIFICATION_DATA = packed record
    guidEventContext: TGUID;
    bMuted: BOOL;
    fMasterVolume: Single;
    nChannels: UINT;
    afChannelVolumes: array[0..1] of Single;
  end;

  PAUDIO_VOLUME_NOTIFICATION_DATA = ^AUDIO_VOLUME_NOTIFICATION_DATA;

  _AUDCLNT_SHAREMODE = (
    AUDCLNT_SHAREMODE_SHARED,
    AUDCLNT_SHAREMODE_EXCLUSIVE
    );

  _AUDCLNT_BUFFERFLAGS = (
    AUDCLNT_BUFFERFLAGS_DATA_DISCONTINUITY = $1,
    AUDCLNT_BUFFERFLAGS_SILENT = $2,
    AUDCLNT_BUFFERFLAGS_TIMESTAMP_ERROR = $4
    );

type
  IAudioEndpointVolumeCallback = interface(IUnknown)
    ['{657804FA-D6AD-4496-8A60-352752AF4F89}']
    function OnNotify(pNotify: PAUDIO_VOLUME_NOTIFICATION_DATA): HRESULT; stdcall;
  end;

  IAudioEndpointVolume = interface(IUnknown)
    ['{5CDF2C82-841E-4546-9722-0CF74078229A}']
    function RegisterControlChangeNotify(AudioEndPtVol: IAudioEndpointVolumeCallback): Integer; stdcall;
    function UnregisterControlChangeNotify(AudioEndPtVol: IAudioEndpointVolumeCallback): Integer; stdcall;
    function GetChannelCount(out PInteger): Integer; stdcall;
    function SetMasterVolumeLevel(fLevelDB: single; pguidEventContext: PGUID):Integer; stdcall;
    function SetMasterVolumeLevelScalar(fLevelDB: single; pguidEventContext: PGUID):Integer; stdcall;
    function GetMasterVolumeLevel(out fLevelDB: single):Integer; stdcall;
    function GetMasterVolumeLevelScalar(out fLevel: single):Integer; stdcall;
    function SetChannelVolumeLevel(nChannel: Integer; fLevelDB: double; pguidEventContext: TGUID):Integer; stdcall;
    function SetChannelVolumeLevelScalar(nChannel: Integer; fLevelDB: single; pguidEventContext: TGUID):Integer; stdcall;
    function GetChannelVolumeLevel(nChannel: Integer; out fLevelDB: double) : Integer; stdcall;
    function GetChannelVolumeLevelScalar(nChannel: Integer; out fLevel: double) : Integer; stdcall;
    function SetMute(bMute: Boolean ; pguidEventContext: PGUID) :Integer; stdcall;
    function GetMute(out bMute: Boolean) :Integer; stdcall;
    function GetVolumeStepInfo(pnStep: Integer; out pnStepCount: Integer):Integer; stdcall;
    function VolumeStepUp(pguidEventContext: TGUID) :Integer; stdcall;
    function VolumeStepDown(pguidEventContext: TGUID) :Integer; stdcall;
    function QueryHardwareSupport(out pdwHardwareSupportMask): Integer; stdcall;
    function GetVolumeRange(out pflVolumeMindB: Double; out pflVolumeMaxdB: Double; out pflVolumeIncrementdB: Double): Integer; stdcall;
  end;

  IAudioClient = interface(IUnknown)
    ['{1CB9AD4C-DBFA-4c32-B178-C2F568A703B2}']
    function Initialize(ShareMode: _AUDCLNT_SHAREMODE; StreamFlags: Cardinal;
      hnsBufferDuration, hnsPeriodicity: Int64; pFormat: PWaveFormatEx;
      AudioSessionGuid: PGUID): HRESULT; stdcall;
    function GetBufferSize(var NumBufferFrames: Cardinal): HRESULT; stdcall;
    function GetStreamLatency(var hnsLatency: Int64): HRESULT; stdcall;
    function GetCurrentPadding(var NumPaddingFrames: Cardinal): HRESULT; stdcall;
    function IsFormatSupported(ShareMode: _AUDCLNT_SHAREMODE; pFormat: PWaveFormatEx;
      var pClosestMatch: PWaveFormatEx): HRESULT; stdcall;
    function GetMixFormat(var pDeviceFormat: PWaveFormatEx): HRESULT; stdcall;
    function GetDevicePeriod(var hnsDefaultDevicePeriod, hnsMinimumDevicePeriod: Int64): HRESULT; stdcall;
    function Start(): HRESULT; stdcall;
    function Stop(): HRESULT; stdcall;
    function Reset(): HRESULT; stdcall;
    function SetEventHandle(eventHandle: THandle): HRESULT; stdcall;
    function GetService(var riid: TGUID; var pv: Pointer): HRESULT; stdcall;
  end;

  IAudioCaptureClient = interface(IUnknown)
    ['{C8ADBD64-E71E-48a0-A4DE-185C395CD317}']
    function GetBuffer(var pData: PByte; var NumFramesToRead: Cardinal;
      var dwFlags: Cardinal; var u64DevicePosition, u64QPCPosition: UInt64): HRESULT; stdcall;
    function ReleaseBuffer(NumFramesRead: Cardinal): HRESULT; stdcall;
    function GetNextPacketSize(var NumFramesInNextPacket: Cardinal): HRESULT; stdcall;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'MMDevice';

  dtlOcxPage = 'MMDevice';

implementation

uses ComObj;

class function CoMMDeviceEnumerator.Create: IMMDeviceEnumerator;
begin
  Result := CreateComObject(CLASS_MMDeviceEnumerator) as IMMDeviceEnumerator;
end;

class function CoMMDeviceEnumerator.CreateRemote(const MachineName: string): IMMDeviceEnumerator;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MMDeviceEnumerator) as IMMDeviceEnumerator;
end;

procedure TMMDeviceEnumerator.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{BCDE0395-E52F-467C-8E3D-C4579291692E}';
    IntfIID:   '{A95664D2-9614-4F35-A746-DE8DB63617E6}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMMDeviceEnumerator.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then begin
    punk := GetServer;
    Fintf:= punk as IMMDeviceEnumerator;
  end;
end;

procedure TMMDeviceEnumerator.ConnectTo(svrIntf: IMMDeviceEnumerator);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMMDeviceEnumerator.DisConnect;
begin
  if Fintf <> nil then FIntf := nil;
end;

function TMMDeviceEnumerator.GetDefaultInterface: IMMDeviceEnumerator;
begin
  if FIntf = nil then Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMMDeviceEnumerator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMMDeviceEnumeratorProperties.Create(Self);
{$ENDIF}
end;

destructor TMMDeviceEnumerator.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMMDeviceEnumerator.GetServerProperties: TMMDeviceEnumeratorProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TMMDeviceEnumerator.EnumAudioEndpoints(dataFlow: EDataFlow; dwStateMask: LongWord; 
                                                out ppDevices: IMMDeviceCollection): HResult;
begin
  Result := DefaultInterface.EnumAudioEndpoints(dataFlow, dwStateMask, ppDevices);
end;

function TMMDeviceEnumerator.GetDefaultAudioEndpoint(dataFlow: EDataFlow; role: ERole; 
                                                     out ppEndpoint: IMMDevice): HResult;
begin
  Result := DefaultInterface.GetDefaultAudioEndpoint(dataFlow, role, ppEndpoint);
end;

function TMMDeviceEnumerator.GetDevice(pwstrId: PWideChar; out ppDevice: IMMDevice): HResult;
begin
  Result := DefaultInterface.GetDevice(pwstrId, ppDevice);
end;

function TMMDeviceEnumerator.RegisterEndpointNotificationCallback(const pClient: IMMNotificationClient): HResult;
begin
  Result := DefaultInterface.RegisterEndpointNotificationCallback(pClient);
end;

function TMMDeviceEnumerator.UnregisterEndpointNotificationCallback(const pClient: IMMNotificationClient): HResult;
begin
  Result := DefaultInterface.UnregisterEndpointNotificationCallback(pClient);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMMDeviceEnumeratorProperties.Create(AServer: TMMDeviceEnumerator);
begin
  inherited Create;
  FServer := AServer;
end;

function TMMDeviceEnumeratorProperties.GetDefaultInterface: IMMDeviceEnumerator;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TMMDeviceEnumerator]);
end;

end.

