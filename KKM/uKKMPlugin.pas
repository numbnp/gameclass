//////////////////////////////////////////////////////////////////////////////
//
// TKKMPlugin - класс - оболочка над функциями DLL,
// реализующими интеграцию GC с ККМ.
// Функции находятся в отдельной DLL.
//
//////////////////////////////////////////////////////////////////////////////

unit uKKMPlugin;

interface

uses
  Types;


type

  // типы для экспортируемых из DLL функций
  TIsKKMPluginProc = function: Boolean; stdcall;
  TGetNameProc = function: PChar; stdcall;
  TGetVersionProc = function: PChar; stdcall;
  TGetNotesProc = function : PChar; stdcall;
  TGetConfigTypesProc = function : PChar; stdcall;
  TGetConfigProc = function : PChar; stdcall;
  TSetConfigProc = procedure (const AstrConfig: PChar); stdcall;
  TInternalConfigProc = procedure (const AnApplicationHandle: Integer;
      const AstrExt: PChar); stdcall;
  TConnectProc = function: Boolean; stdcall;
  TDisconnectProc = function: Boolean; stdcall;
  TIsConnectedProc = function: Boolean; stdcall;
  TOpenShiftProc = function (const AnOperatorNum: Integer;
      const AstrOperatorName: PChar;
      const AstrExt: PChar): Boolean; stdcall;
  TIsShiftOpenedProc = function (const AstrExt: PChar): Boolean; stdcall;
  TXReportProc = function (const AstrExt: PChar): Boolean; stdcall;
  TZReportProc = function (const AstrExt: PChar): Boolean; stdcall;
  TCashInProc = function (const AfSum: Currency;
      const AstrAccount: PChar;
      const AstrExt: PChar): Boolean; stdcall;
  TCashOutProc = function (const AfSum: Currency;
      const AstrAccount: PChar;
      const AstrExt: PChar): Boolean; stdcall;
  TStartSaleProc = function (const AstrExt: PChar): Boolean; stdcall;
  TStartRefundProc = function (const AstrExt: PChar): Boolean; stdcall;
  TAddItemProc = function (
      const AstrName: PChar;
      const AfPrice: Currency;
      const AbIsTare: Boolean;
      const AnDepartment: Integer;
      const AnCode: Integer;
      const AnQuantity: Integer;
      const AnQuantityPerc: Integer;
      const AnTaxIndex: Integer;
      const AstrUnitName: PChar;
      const AfPercent: Double;
      const AfAmount: Currency;
      const AstrExt: PChar): Boolean; stdcall;
  TEndSaleProc = function (
      const AnType: Integer;
      // 0 -
      const AfCash: Currency;
      const AfCashless: Currency;
      const AnTaxIndex: Integer;
      const AfPercent: Double;
      const AfAmount: Currency;
      const AstrExt: PChar): Boolean; stdcall;
  TEndRefundProc = function (const AstrExt: PChar): Boolean; stdcall;
  TPrintNonFiscalProc = function (const AstrText: PChar;
    const AstrExt: PChar): Boolean; stdcall;
  TGetLastErrorProc = function: PChar; stdcall;
  TGetErrorCountProc = function: Integer; stdcall;

  TPayType = (ptCashe = 0, ptCredit = 1, ptCard = 2, ptCashCredit = 3,
      ptCashCard = 4);



  //
  // TKKMPlugin
  //

  TKKMPlugin = class(TObject)
  protected
    // fields
    FhLibrary:              THandle;
    FIsKKMPluginProc:       TIsKKMPluginProc;
    FGetNameProc:           TGetNameProc;
    FGetVersionProc:        TGetVersionProc;
    FGetNotesProc:          TGetNotesProc;
    FGetConfigTypesProc:    TGetConfigTypesProc;
    FGetConfigProc:         TGetConfigProc;
    FSetConfigProc:         TSetConfigProc;
    FInternalConfigProc:        TInternalConfigProc;
    FConnectProc:           TConnectProc;
    FDisconnectProc:        TDisconnectProc;
    FIsConnectedProc:       TIsConnectedProc;
    FOpenShiftProc:         TOpenShiftProc;
    FIsShiftOpenedProc:     TIsShiftOpenedProc;
    FXReportProc:           TXReportProc;
    FZReportProc:           TZReportProc;
    FCashInProc:            TCashInProc;
    FCashOutProc:           TCashOutProc;
    FStartSaleProc:         TStartSaleProc;
    FStartRefundProc:       TStartRefundProc;
    FAddItemProc:           TAddItemProc;
    FEndSaleProc:           TEndSaleProc;
    FEndRefundProc:         TEndRefundProc;
    FPrintNonFiscalProc:    TPrintNonFiscalProc;
    FGetLastErrorProc:      TGetLastErrorProc;
    FGetErrorCountProc:     TGetErrorCountProc;

    FstrDLLFileName:        String;
    FbConnected:            Boolean;

    // private helper methods
    function _GetProcAddress(const AstrProcName: string;
        var AptrProc: pointer): boolean;
    function _GetProcAddresses(): boolean;
    function _GetLoaded: Boolean;
    function _CheckConnect: Boolean;

    // second level initialization / finalization
    function LoadDll(): Boolean; overload;

  public
    // constructor / destructor
    constructor Create; overload;
    constructor Create(const AstrDLLFileName: string); overload;
    constructor Create(const AstrDLLFileName: String;
        const AstrConfig: String); overload;
    destructor Destroy(); override;

    // public methods
    function LoadDll(const AstrDLLFileName: String): Boolean; overload;
    function IsKKMPlugin: Boolean;
    function GetName: String;
    function GetVersion: String;
    function GetNotes: String;
    function GetConfigTypes: String;
    function GetConfig: String;
    procedure SetConfig(const AstrConfig: String);
    procedure InternalConfig(const AnApplicationHandle: Integer;
        const AstrExt: String = '');
    function Connect: Boolean;
    procedure Disconnect;
    function IsConnected: Boolean;
    function OpenShift(const AnOperatorNum: Integer;
        const AstrOperatorName: String;
        const AstrExt: String = ''): Boolean;
    function IsShiftOpened(const AstrExt: String = ''): Boolean;
    function XReport(const AstrExt: String = ''): Boolean;
    function ZReport(const AstrExt: String = ''): Boolean;
    function CashIn(const AfSum: Currency;
        const AstrAccount: String;
        const AstrExt: String = ''): Boolean;
    function CashOut(const AfSum: Currency;
        const AstrAccount: String;
        const AstrExt: String = ''): Boolean;
    function StartSale(const AstrExt: String = ''): Boolean;
    function StartRefund(const AstrExt: String = ''): Boolean;
    function AddItem(const AstrName: String;
        const AfPrice: Currency;
        const AbIsTare: Boolean;
        const AnDepartment: Integer;
        const AnCode: Integer;
        const AnQuantity: Integer;
        const AnQuantityPerc: Integer;
        const AnTaxIndex: Integer;
        const AstrUnitName: String;
        const AfPercent: Double;
        const AfAmount: Currency;
        const AstrExt: String = ''): Boolean;
    function EndSale(
        const AnType: TPayType;
        const AfCash: Currency;
        const AfCashless: Currency;
        const AnTaxIndex: Integer;
        const AfPercent: Double;
        const AfAmount: Currency;
        const AstrExt: String = ''): Boolean;
    function EndRefund(const AstrExt: String = ''): Boolean;
    function PrintNonFiscal(const AstrText: String;
      const AstrExt: String = ''): Boolean;
    function GetLastError: String;
    function GetErrorCount: Integer;
    procedure Final();


    // properties
    property Loaded: Boolean
      read _GetLoaded;
    property Connected: Boolean
      read FbConnected;

  end; // TKKMPlugin

implementation


uses
  // system units
  Windows,
  Forms,
  SysUtils,
  uDebugLog;

const

  // названия методов, экспортируемых из DLL
  STR_IS_KKM_PLUGIN    = 'IsKKMPlugin';
  STR_GET_NAME         = 'GetName';
  STR_GET_VERSION      = 'GetVersion';
  STR_GET_NOTES        = 'GetNotes';
  STR_GET_CONFIG_TYPES = 'GetConfigTypes';
  STR_GET_CONFIG       = 'GetConfig';
  STR_SET_CONFIG       = 'SetConfig';
  STR_INTERNAL_CONFIG  = 'InternalConfig';
  STR_CONNECT          = 'Connect';
  STR_DISCONNECT       = 'Disconnect';
  STR_IS_CONNECTED     = 'IsConnected';
  STR_OPEN_SHIFT       = 'OpenShift';
  STR_IS_SHIFT_OPENED  = 'IsShiftOpened';
  STR_X_REPORT         = 'XReport';
  STR_Z_REPORT         = 'ZReport';
  STR_CASH_IN          = 'CashIn';
  STR_CASH_OUT         = 'CashOut';
  STR_START_SALE       = 'StartSale';
  STR_START_REFUND     = 'StartRefund';
  STR_ADD_ITEM         = 'AddItem';
  STR_END_SALE         = 'EndSale';
  STR_END_REFUND       = 'EndRefund';
  STR_PRINT_NON_FISCAL = 'PrintNonFiscal';
  STR_GET_LAST_ERROR   = 'GetLastError';
  STR_GET_ERROR_COUNT  = 'GetErrorCount';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// overload
constructor TKKMPlugin.Create();
begin
  inherited Create;
  FbConnected := False;
end; // TKKMPlugin.Create

// overload
constructor TKKMPlugin.Create(const AstrDLLFileName: String);
begin
  Create;
  FstrDLLFileName := AstrDLLFileName;
  LoadDll;
end; // TKKMPlugin.Create

constructor TKKMPlugin.Create(const AstrDLLFileName: String;
    const AstrConfig: String);
begin
  Create(AstrDLLFileName);
  if Length(AstrConfig) > 0 then
    SetConfig(AstrConfig);
end; // TKKMPlugin.Create

destructor TKKMPlugin.Destroy();
begin
  Final;
  inherited Destroy;
end; // TKKMPlugin.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// second level initialization / finalization

function TKKMPlugin.LoadDll(): boolean;
begin
  // выгружаем загруженную раньше библиотеку
  Final;
  FhLibrary := LoadLibrary(PChar(FstrDLLFileName));
  Result := (FhLibrary <> 0);
  if Result then begin
    Result := _GetProcAddresses();
    if not Result then
      Final();
  end;
end; // TKKMPlugin.LoadDll

procedure TKKMPlugin.Final();
begin
  if FhLibrary <> 0 then begin
    //для АТОЛ обязательный дисконнект
    if FbConnected or (GetConfigTypes = 'INTERNAL') then
      Disconnect;
    FreeLibrary(FhLibrary);
    FIsKKMPluginProc := Nil;
    FGetNameProc := Nil;
    FGetVersionProc := Nil;
    FGetNotesProc := Nil;
    FGetConfigTypesProc := Nil;
    FGetConfigProc := Nil;
    FSetConfigProc := Nil;
    FInternalConfigProc := Nil;
    FConnectProc := Nil;
    FDisconnectProc := Nil;
    FIsConnectedProc := Nil;
    FOpenShiftProc := Nil;
    FIsShiftOpenedProc := Nil;
    FXReportProc := Nil;
    FZReportProc := Nil;
    FCashInProc := Nil; 
    FCashOutProc := Nil;
    FStartSaleProc := Nil;
    FStartRefundProc := Nil;
    FAddItemProc := Nil;
    FEndSaleProc := Nil;
    FEndRefundProc := Nil;
    FPrintNonFiscalProc := Nil;
    FGetLastErrorProc := Nil;
    FGetErrorCountProc := Nil;
    FhLibrary := 0;
  end;
end; // TKKMPlugin.FreeHookDll


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods
function TKKMPlugin.LoadDll(const AstrDLLFileName: String): Boolean;
begin
  FstrDLLFileName := AstrDLLFileName;
  Result := LoadDll();
end; // TKKMPlugin.LoadDll

function TKKMPlugin.IsKKMPlugin: Boolean;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FIsKKMPluginProc));
  Result := False;
  if FhLibrary <> 0 then
    if Assigned(FIsKKMPluginProc) then begin
      Result := FIsKKMPluginProc;
    end;
end; // TKKMPlugin.IsKKMPlugin

function TKKMPlugin.GetName: String;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetNameProc));
  Result := '';
  if FhLibrary <> 0 then
    if Assigned(FGetNameProc) then begin
      Result := FGetNameProc;
    end;
end; // TKKMPlugin.GetName

function TKKMPlugin.GetVersion: String;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetVersionProc));
  Result := '';
  if FhLibrary <> 0 then
    if Assigned(FGetVersionProc) then begin
      Result := FGetVersionProc;
    end;
end; // TKKMPlugin.GetVersion

function TKKMPlugin.GetNotes: String;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetNotesProc));
  Result := '';
  if FhLibrary <> 0 then
    if Assigned(FGetNotesProc) then begin
      Result := FGetNotesProc;
    end;
end; // TKKMPlugin.GetNotes

function TKKMPlugin.GetConfigTypes: String;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetConfigTypesProc));
  Result := '';
  if FhLibrary <> 0 then
    if Assigned(FGetConfigTypesProc) then begin
      Result := FGetConfigTypesProc;
    end;
end; // TKKMPlugin.GetConfigTypes

function TKKMPlugin.GetConfig: String;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetConfigProc));
  Result := '';
  if FhLibrary <> 0 then
    if Assigned(FGetConfigProc) then begin
      Result := FGetConfigProc;
    end;
end; // TKKMPlugin.GetConfig

procedure TKKMPlugin.SetConfig(const AstrConfig: String);
var
  strConfig: String;
begin
  strConfig := AstrConfig;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FSetConfigProc));
  if FhLibrary <> 0 then
    if Assigned(FSetConfigProc) then begin
      FSetConfigProc(PChar(strConfig));
    end;
end; // TKKMPlugin.GetConfig

procedure TKKMPlugin.InternalConfig(const AnApplicationHandle: Integer;
      const AstrExt: String = '');
var
  strExt: String;
begin
  strExt := AstrExt;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FInternalConfigProc));
  if FhLibrary <> 0 then
    if Assigned(FInternalConfigProc) then begin
      FInternalConfigProc(AnApplicationHandle, PChar(strExt));
    end;
end; // TKKMPlugin.GetConfig

function TKKMPlugin.Connect: Boolean;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FConnectProc));
  Result := False;
  if FhLibrary <> 0 then
    if Assigned(FConnectProc) then begin
      try
        FbConnected := FConnectProc;
        Result := FbConnected;
      except
        Result := True;
      end;
    end;
end; // TKKMPlugin.Connect

procedure TKKMPlugin.Disconnect();
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FDisconnectProc));

  if FhLibrary <> 0 then
    if Assigned(FDisconnectProc) then
      FDisconnectProc();
  FbConnected := False;
end; // TKKMPlugin.

function TKKMPlugin.IsConnected: Boolean;
begin
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FIsConnectedProc));
  Result := False;
  if FhLibrary <> 0 then
    try
      if Assigned(FIsConnectedProc) then begin
        Result := FIsConnectedProc;
      end;
    except
        Result := False;
    end;
end; // TKKMPlugin.

function TKKMPlugin.OpenShift(const AnOperatorNum: Integer;
      const AstrOperatorName: String;
      const AstrExt: String = ''): Boolean;
var
  strOperatorName: String;
  strExt: String;
begin
  strOperatorName := AstrOperatorName;
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FOpenShiftProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FOpenShiftProc) then
      Result := FOpenShiftProc(AnOperatorNum, PChar(strOperatorName),
          PChar(strExt));
end;

function TKKMPlugin.IsShiftOpened(const AstrExt: String = ''): Boolean;
var
  strExt: String;
begin
  strExt := AstrExt;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FIsShiftOpenedProc));
  Result := False;
  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FIsShiftOpenedProc) then begin
      Result := FIsShiftOpenedProc(PChar(strExt));
    end;
end; // TKKMPlugin.

function TKKMPlugin.XReport(const AstrExt: String = ''): Boolean;
var
  strExt: String;
begin
  strExt := AstrExt;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FXReportProc));
  Result := False;
  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FXReportProc) then begin
      Result := FXReportProc(PChar(strExt));
    end;
end; // TKKMPlugin.

function TKKMPlugin.ZReport(const AstrExt: String = ''): Boolean;
var
  strExt: String;
begin
  strExt := AstrExt;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FZReportProc));
  Result := False;
  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FZReportProc) then begin
      Result := FZReportProc(PChar(strExt));
    end;
end; // TKKMPlugin.

function TKKMPlugin.CashIn(const AfSum: Currency;
      const AstrAccount: String;
      const AstrExt: String = ''): Boolean;
var
  strAccount: String;
  strExt: String;
begin
  strAccount := AstrAccount;
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FCashInProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FCashInProc) then
      Result := FCashInProc(AfSum, PChar(strAccount),
          PChar(strExt));
end;

function TKKMPlugin.CashOut(const AfSum: Currency;
      const AstrAccount: String;
      const AstrExt: String = ''): Boolean;
var
  strAccount: String;
  strExt: String;
begin
  strAccount := AstrAccount;
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FCashOutProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FCashOutProc) then
      Result := FCashOutProc(AfSum, PChar(strAccount),
          PChar(strExt));
end;

function TKKMPlugin.StartSale(const AstrExt: String = ''): Boolean;
var
  strExt: String;
begin
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FStartSaleProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FStartSaleProc) then
      Result := FStartSaleProc(PChar(strExt));
end;

function TKKMPlugin.StartRefund(const AstrExt: String = ''): Boolean;
var
  strExt: String;
begin
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FStartRefundProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FStartRefundProc) then
      Result := FStartRefundProc(PChar(strExt));
end;

function TKKMPlugin.AddItem(const AstrName: String;
    const AfPrice: Currency;
    const AbIsTare: Boolean;
    const AnDepartment: Integer;
    const AnCode: Integer;
    const AnQuantity: Integer;
    const AnQuantityPerc: Integer;
    const AnTaxIndex: Integer;
    const AstrUnitName: String;
    const AfPercent: Double;
    const AfAmount: Currency;
    const AstrExt: String = ''): Boolean;
var
  strName: String;
  strUnitName: String;
  strExt: String;
begin
  strName := AstrName;
  strUnitName := AstrUnitName;
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FAddItemProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FAddItemProc) then
      Result := FAddItemProc(PChar(strName),
          AfPrice, AbIsTare, AnDepartment, AnCode, AnQuantity,
          AnQuantityPerc, AnTaxIndex, PChar(strUnitName),
          AfPercent, AfAmount, PChar(strExt));
end;

function TKKMPlugin.EndSale(
    const AnType: TPayType;
    const AfCash: Currency;
    const AfCashless: Currency;
    const AnTaxIndex: Integer;
    const AfPercent: Double;
    const AfAmount: Currency;
    const AstrExt: String = ''): Boolean;
var
  strExt: String;
begin
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FEndSaleProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FEndSaleProc) then
      Result := FEndSaleProc(Integer(AnType), AfCash, AfCashless, AnTaxIndex,
          AfPercent, AfAmount, PChar(strExt));
end;

function TKKMPlugin.EndRefund(const AstrExt: String = ''): Boolean;
var
  strExt: String;
begin
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FEndRefundProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FEndRefundProc) then
      Result := FEndRefundProc(PChar(strExt));
end;

function TKKMPlugin.PrintNonFiscal(const AstrText: String;
      const AstrExt: String = ''): Boolean;
var
  strText: String;
  strExt: String;
begin
  strText := AstrText;
  strExt := AstrExt;
  Result := False;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FPrintNonFiscalProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FPrintNonFiscalProc) then
      Result := FPrintNonFiscalProc(PChar(strText),
          PChar(strExt));
end;

function TKKMPlugin.GetLastError: String;
begin
  Result := '';
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetLastErrorProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FGetLastErrorProc) then
      Result := FGetLastErrorProc;
end;

function TKKMPlugin.GetErrorCount: Integer;
begin
  Result := 0;
  ASSERT(FhLibrary <> 0);
  ASSERT(Assigned(FGetErrorCountProc));

  if FhLibrary <> 0 then
    if _CheckConnect and Assigned(FGetErrorCountProc) then
      Result := FGetErrorCountProc;
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TKKMPlugin._GetProcAddress(const AstrProcName: String;
    var AptrProc: Pointer): boolean;
begin
  AptrProc := GetProcAddress(FhLibrary, PChar(AstrProcName));
  Result := Assigned(AptrProc);
end; // TKKMPlugin._GetProcAddress

function TKKMPlugin._GetProcAddresses(): boolean;
begin
  Result := _GetProcAddress(STR_IS_KKM_PLUGIN, @FIsKKMPluginProc)
        and _GetProcAddress(STR_GET_NAME, @FGetNameProc)
        and _GetProcAddress(STR_GET_VERSION, @FGetVersionProc)
        and _GetProcAddress(STR_GET_NOTES, @FGetNotesProc)
        and _GetProcAddress(STR_GET_CONFIG_TYPES, @FGetConfigTypesProc)
        and _GetProcAddress(STR_GET_CONFIG, @FGetConfigProc)
        and _GetProcAddress(STR_SET_CONFIG, @FSetConfigProc)
        and _GetProcAddress(STR_INTERNAL_CONFIG, @FInternalConfigProc)
        and _GetProcAddress(STR_CONNECT, @FConnectProc)
        and _GetProcAddress(STR_DISCONNECT, @FDisconnectProc)
        and _GetProcAddress(STR_IS_CONNECTED, @FIsConnectedProc)
        and _GetProcAddress(STR_OPEN_SHIFT, @FOpenShiftProc)
        and _GetProcAddress(STR_IS_SHIFT_OPENED, @FIsShiftOpenedProc)
        and _GetProcAddress(STR_X_REPORT, @FXReportProc)
        and _GetProcAddress(STR_Z_REPORT, @FZReportProc)
        and _GetProcAddress(STR_CASH_IN, @FCashInProc)
        and _GetProcAddress(STR_CASH_OUT, @FCashOutProc)
        and _GetProcAddress(STR_START_SALE, @FStartSaleProc)
        and _GetProcAddress(STR_START_REFUND, @FStartRefundProc)
        and _GetProcAddress(STR_ADD_ITEM, @FAddItemProc)
        and _GetProcAddress(STR_END_SALE, @FEndSaleProc)
        and _GetProcAddress(STR_END_REFUND, @FEndRefundProc)
        and _GetProcAddress(STR_PRINT_NON_FISCAL, @FPrintNonFiscalProc)
        and _GetProcAddress(STR_GET_LAST_ERROR, @FGetLastErrorProc)
        and _GetProcAddress(STR_GET_ERROR_COUNT, @FGetErrorCountProc);

end; // TKKMPlugin._GetProcAddresses

function TKKMPlugin._GetLoaded: Boolean;
begin
  Result := (FhLibrary <> 0) and Assigned(FIsKKMPluginProc);
end;

function TKKMPlugin._CheckConnect: Boolean;
begin
  Result := IsConnected;
  if not Result then begin
    try
      Disconnect;
      Result := Connect;
    except
      Result := False;
    end
  end
end;

end. ////////////////////////// end of file //////////////////////////////////

