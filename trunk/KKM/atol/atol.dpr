//////////////////////////////////////////////////////////////////////////////
//
// mercury - DLL, реализующая интеграцию GC с ККМ Штрих M
//
//
// Использует библиотеку MercFPrtVCL
//
//////////////////////////////////////////////////////////////////////////////

library atol;

uses
  Windows,
  Messages,
  FprnM1C_TLB,
  Forms,
  Math,
  Types,
  Classes,
  SysUtils,
  uY2KString in '..\..\Parts\Y2KCommon\uY2KString.pas',
  uY2KCommon in '..\..\Parts\Y2KCommon\uY2KCommon.pas';

const
  PLUGIN_NAME = 'Дравер АТОЛ для ККМ';
  PLUGIN_VERSION = '1.1.6';
  PLUGIN_NOTES = 'Должен быть установлен драйвер АТОЛ!';
  DEF_CONFIG_TYPES = 'INTERNAL';
  DEF_CONFIG = '';


var
  FbConnected: Boolean;
  FstrConfig: String;
//  FECR: OleVariant;
  FFprnM45: TFprnM45;
  FFrm: TForm;
  FnRowCount: Integer;
  FlstErrors: TStringList;
  FstrLastError: String;
  FbRefund: Boolean;
//  FbPropertiesShowed: Boolean;
  FbCheckIsOpen: Boolean;

{$R *.res}

{$LIBSUFFIX '116'}

procedure _AddError(AstrError: String);
begin
  FlstErrors.Add(AstrError);
end; // _AddError


// Признак доп.модуля программы GameClass для работы с ККМ
function IsKKMPlugin: Boolean; stdcall; // export
begin
  Result := True;
end; // IsKKMPlugin

// Возвращает название поддреживаемого ККМ
function GetName: PChar; stdcall; // export
begin
  Result := PLUGIN_NAME;
end; // GetName

// Возвращает версию модуля
function GetVersion: PChar; stdcall; // export
begin
  Result := PLUGIN_VERSION;
end; // GetVersion

// Возвращает описание особенностей
function GetNotes: PChar; stdcall; // export
begin
  Result := PLUGIN_NOTES;
end; // GetNotes

// Возвращает конфигурацию параметров
function GetConfigTypes: PChar; stdcall; // export
begin
  Result := DEF_CONFIG_TYPES;
end; // GetConfig

// Возвращает конфигурацию параметров
function GetConfig: PChar; stdcall; // export
begin
  Result := PChar(FstrConfig);
end; // GetConfig

// Устанавливает новую конфигурацию параметров
procedure SetConfig(const AstrConfig: PChar); stdcall; // export
begin
  FstrConfig := AstrConfig;
end; // SetConfig

// Вызывает внутренний диалог настройки параметров
// после вызова форма сама снимается при закрытии приложения
procedure InternalConfig(const AnApplicationHandle: Integer;
    const AstrExt: PChar); stdcall; // export
begin
  if Assigned(FFprnM45) then
    FFprnM45.ShowProperties
  else
    MessageBox(0, 'Драйвер АТОЛ для ККМ не установлен!', 'Ошибка', MB_OK or
    MB_ICONERROR);
end; // InternalConfig

// Устанавливает новую конфигурацию параметров
function Connect: Boolean; stdcall; // export
begin
  Result := False;
  if not Assigned(FFprnM45) then
    exit;
  FFprnM45.DeviceEnabled := True;
  // занимаем порт
  if FFprnM45.ResultCode = 0 then
    // получаем состояние ККМ
    if FFprnM45.GetStatus = 0 then
      // если есть открытый чек, то отменяем его
      if (FFprnM45.CheckState = 0) or (FFprnM45.CancelCheck = 0) then begin
        // входим в режим регистрации
        // устанавливаем пароль кассира
        FFprnM45.Password := '1';
        // входим в режим регистрации
        FFprnM45.Mode := 1;
        if FFprnM45.SetMode = 0 then
          Result := True;
      end;
  if not Result then
    _AddError(String(FFprnM45.ResultDescription));
end; // SetConfig

// Устанавливает новую конфигурацию параметров
procedure Disconnect; stdcall; // export
begin
  if Assigned(FFprnM45) then
    FFprnM45.DeviceEnabled := False;
end; // SetConfig

// Устанавливает новую конфигурацию параметров
function IsConnected: Boolean; stdcall; // export
begin
  Result := False;
  if not Assigned(FFprnM45) then
    exit;
  if FbCheckIsOpen then
    Result := True
  else if FFprnM45.ResetMode = 0 then begin
    FFprnM45.Password := '1';
    FFprnM45.Mode := 1;
    if FFprnM45.SetMode = 0 then
      Result := True
  end;
  if not Result then
    _AddError(String(FFprnM45.ResultDescription));
end; // IsCconnected

// Устанавливает новую конфигурацию параметров
function OpenShift(const AnOperatorNumber: Integer;
    const AstrOperatorName: PChar;
    const AstrExt: PChar): Boolean; stdcall; // export
var
  strOperatorName: String;
begin
  Result := False;
  strOperatorName := AstrOperatorName;
  if not FFprnM45.SessionOpened then begin
    if FFprnM45.OpenSession = 0 then
      Result := True
    else
      _AddError(String(FFprnM45.ResultDescription));
//    FMercuryFPrt.OpenDay(AnOperatorNumber, strOperatorName, False,
//        FMercuryFPrt.Protocol);
  end;
end; // OpenShift

// Устанавливает новую конфигурацию параметров
function IsShiftOpened(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := FFprnM45.SessionOpened;
end; // OpenShift

// Устанавливает новую конфигурацию параметров
function XReport(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  // X - отчет
  // устанавливаем пароль администратора ККМ
  FFprnM45.Password := '29';
  // входим в режим отчетов без гашения
  FFprnM45.Mode := 2;
  if FFprnM45.SetMode = 0 then begin
    // снимаем отчет
    FFprnM45.ReportType := 2;
    if FFprnM45.Report = 0 then
      Result := True;
    FFprnM45.ResetMode;
  end;
  if not Result then
    _AddError(String(FFprnM45.ResultDescription));
end; // XReport

// Устанавливает новую конфигурацию параметров
function ZReport(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  // X - отчет
  // устанавливаем пароль администратора ККМ
  FFprnM45.Password := '30';
  // входим в режим отчетов без гашения
  FFprnM45.Mode := 3;
  if FFprnM45.SetMode = 0 then begin
    // снимаем отчет
    FFprnM45.ReportType := 1;
    if FFprnM45.Report = 0 then
      Result := True;
    FFprnM45.ResetMode;
  end;
  if not Result then
    _AddError(String(FFprnM45.ResultDescription));
end; // ZReport

function CashIn(const AfSum: Currency;
    const AstrAccount: PChar;
    const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  FFprnM45.Summ := AfSum;
  if FFprnM45.CashIncome = 0 then
      Result := True
  else
    _AddError(String(FFprnM45.ResultDescription));
end;

function CashOut(const AfSum: Currency;
    const AstrAccount: PChar;
    const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  FFprnM45.Summ := AfSum;
  if FFprnM45.CashOutcome = 0 then
      Result := True
  else
    _AddError(String(FFprnM45.ResultDescription));
end;

function StartSale(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := True;
  FbRefund := False;
  if FFprnM45.NewDocument <> 0 then begin
    Result := False;
    _AddError(String(FFprnM45.ResultDescription));
  end;
  FFprnM45.CheckType := 1; //продажа
  if FFprnM45.OpenCheck <> 0 then begin
    Result := False;
    _AddError(String(FFprnM45.ResultDescription));
  end;
  if Result then
    FbCheckIsOpen := True;
end;

function StartRefund(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := True;
  FbRefund := True;;
  if FFprnM45.NewDocument <> 0 then begin
    Result := False;
    _AddError(String(FFprnM45.ResultDescription));
  end;
  FFprnM45.CheckType := 2; //продажа
  if FFprnM45.OpenCheck <> 0 then begin
    Result := False;
    _AddError(String(FFprnM45.ResultDescription));
  end;
  if Result then
    FbCheckIsOpen := True;
end;

function AddItem(
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
    const AstrExt: PChar): Boolean; stdcall; // export
var
  nPercents: Integer;
begin
  Result := True;
  with FFprnM45 do begin
    Name := AstrName;
    Price := AfPrice;
    AdvancedRegistration := True; //печать суммы в одну строку с наимен.
    if AnQuantityPerc <= 0 then
      Quantity := AnQuantity
    else
      Quantity := AnQuantity * Power(10, - AnQuantityPerc);
    Department := AnDepartment;
    if FbRefund then begin
      if Return <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end else begin
      if Registration <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end;
    nPercents := Round(AfPercent * 100);
    if nPercents > 0 then begin
      // Добавляем процентную скидку на позицию
      Percents := nPercents;
      Destination := 1;
      if PercentsDiscount <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end else if nPercents < 0 then begin
      // Добавляем процентную надбавку на позицию
      Percents := - nPercents;
      Destination := 1;
      if PercentsCharge <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end;
    if CompareValue(AfAmount, 0.00001) = GreaterThanValue then begin
      // Добавляем денежную надбавку на позицию
      Summ := AfAmount;
      Destination := 1;
      if SummCharge <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end else if CompareValue(AfAmount, -0.00001) = LessThanValue then begin
      // Добавляем денежную скидку на позицию
      Summ := - AfAmount;
      Destination := 1;
      if SummDiscount <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end;
  end;
  if not Result then
    FbCheckIsOpen := False;
end;

function EndSale(
    const AnType: Integer;
//      0: Cash;
//      1: Credit;
//      2: Card;
//      3: CashCredit;
//      4: CashCard;
    const AfCash: Currency;
    const AfCashless: Currency;
    const AnTaxIndex: Integer;
    const AfPercent: Double;
    const AfAmount: Currency;
    const AstrExt: PChar): Boolean; stdcall; // export
var
  nPercents: Integer;
begin
  Result := True;
  with FFprnM45 do begin
    nPercents := Round(AfPercent * 100);
    if nPercents > 0 then begin
      // Добавляем процентную скидку на позицию
      Percents := nPercents;
      Destination := 0;
      if PercentsDiscount <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end else if nPercents < 0 then begin
      // Добавляем процентную надбавку на позицию
      Percents := - nPercents;
      Destination := 0;
      if PercentsCharge <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end;
    if CompareValue(AfAmount, 0.00001) = GreaterThanValue then begin
      // Добавляем денежную надбавку на позицию
      Summ := AfAmount;
      Destination := 0;
      if SummCharge <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end else if CompareValue(AfAmount, -0.00001) = LessThanValue then begin
      // Добавляем денежную скидку на позицию
      Summ := - AfAmount;
      Destination := 0;
      if SummDiscount <> 0 then begin
        Result := False;
        _AddError(String(ResultDescription));
      end;
    end;
//    Summ := AfCash;
    TypeClose := 0;
//    if Delivery <> 0 then begin
    if CloseCheck <> 0 then begin
      Result := False;
      _AddError(String(ResultDescription));
    end;
  end;
  FbCheckIsOpen := False;
end;


function EndRefund(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := True;
  with FFprnM45 do begin
    TypeClose := 0;
    if CloseCheck <> 0 then begin
      Result := False;
      _AddError(String(ResultDescription));
    end;
  end;
  FbCheckIsOpen := False;
end;

function PrintNonFiscal(const AstrText: PChar;
    const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  with FFprnM45 do begin
    Caption := AstrText;
    if PrintString = 0 then
      Result := True;
    if not Result then
      _AddError(String(ResultDescription));
  end;
end;

function GetLastError: PChar; stdcall; // export
var
  nPos: Integer;
begin
  nPos := FlstErrors.Count - 1;
  FstrLastError := '';
  if nPos >= 0 then begin
    FstrLastError := FlstErrors[0];
    FlstErrors.Delete(nPos);
  end;
  Result := PChar(FstrLastError);
end; // GetNotes

function GetErrorCount: Integer; stdcall; // export
begin
  Result := FlstErrors.Count;
end;


procedure DLLEntryPoint(dwReason: DWORD);
begin
  case dwReason Of
    DLL_PROCESS_ATTACH: begin
      FbConnected := False;
      FbCheckIsOpen := False;
//      FbPropertiesShowed := False;
      FstrConfig := DEF_CONFIG;
      FlstErrors := TStringList.Create;
      FFrm := TForm.Create(Nil);
      //Не хочет работать без Parent Window
      FFprnM45 := Nil;
      try
        FFprnM45 := TFprnM45.Create(FFrm);
        FFprnM45.Parent := FFrm;
        FFprnM45.ApplicationHandle := FFrm.Handle;
      except
      end;
    end;
    DLL_PROCESS_DETACH: begin
      if Assigned(FFprnM45) then begin
        FFprnM45.DeviceEnabled := False;
        FreeAndNil(FFprnM45);
      end;
      FreeAndNil(FFrm);
      FreeAndNil(FlstErrors);
    end;
//		DLL_THREAD_ATTACH: ;
//    DLL_THREAD_DETACH:;
  end; // case
end; // DLLEntryPoint

exports
  IsKKMPlugin,
  GetName,
  GetVersion,
  GetNotes,
  GetConfigTypes,
  GetConfig,
  SetConfig,
  InternalConfig,
  Connect,
  Disconnect,
  IsConnected,
  OpenShift,
  IsShiftOpened,
  XReport,
  ZReport,
  CashIn,
  CashOut,
  StartSale,
  StartRefund,
  AddItem,
  EndSale,
  EndRefund,
  PrintNonFiscal,
  GetLastError,
  GetErrorCount;

begin

  DLLProc := @DLLEntryPoint;
  DLLEntryPoint(DLL_PROCESS_ATTACH);

end. ////////////////////////// end of file //////////////////////////////////

