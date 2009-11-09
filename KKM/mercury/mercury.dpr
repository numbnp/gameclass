//////////////////////////////////////////////////////////////////////////////
//
// mercury - DLL, реализующая интеграцию GC с ККМ Меркурий MS-K
//
//
// Использует библиотеку MercFPrtVCL
//
//////////////////////////////////////////////////////////////////////////////

library mercury;

uses
  Windows,
  Messages,
  MercuryFPrt,
  Forms,
  Math,
  Types,
  Classes,
  SysUtils,
  uY2KString in '..\..\Parts\Y2KCommon\uY2KString.pas',
  uY2KCommon in '..\..\Parts\Y2KCommon\uY2KCommon.pas';

const
  PLUGIN_NAME = 'Меркурий MS-K';
  PLUGIN_VERSION = '1.0.1';
  PLUGIN_NOTES = 'Скорость должна совпадать с установленной в ККМ!';
  DEF_CONFIG_TYPES = 'COMPort/Порт/Название COM-порта,'
      + ' к которому подключен ККМ.=lst/COM1/COM2/COM3/COM4'
      + '&Speed/Скорость/Скорость обмена данными=lst/9600/19200/57600/115200'
      +  '&Password/Пароль/Пароль для подключения к ККМ=str';
  DEF_CONFIG = 'COMPort=0'
      + '&Speed=2'
      +  '&Password=0000';


var
  FbConnected: Boolean;
  FstrConfig: String;
  FMercuryFPrt: TMercuryFPrtCtrl;
  FFrm: TForm;
  FnRowCount: Integer;
  FlstErrors: TStringList;
  FstrLastError: String;

{$R *.res}

//Добавляет ошибку в список
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
procedure InternalConfig(const AnApplicationHandle: Integer;
    const AstrExt: PChar); stdcall; // export
begin
end; // InternalConfig

// Устанавливает новую конфигурацию параметров
function Connect: Boolean; stdcall; // export
var
  nCOMIndex, nSpeedIndex: Integer;
  strPassword: String;
begin
  Result := False;
  nCOMIndex := 0;
  TryStrToInt(GetValueFromConfig(FstrConfig, 'COMPort'), nCOMIndex);
  nSpeedIndex := 0;
  TryStrToInt(GetValueFromConfig(FstrConfig, 'Speed'), nSpeedIndex);
  strPassword := GetValueFromConfig(FstrConfig, 'Password');
{  nCOMIndex := 0;
  nSpeedIndex := 2;
  strPassword := '0000';}
  // Настраиваем параметры соединения
  FMercuryFPrt.PortNum := nCOMIndex + 1;
  case nSpeedIndex of
    0:  FMercuryFPrt.BaudRate := CBR_9600;
    1:  FMercuryFPrt.BaudRate := CBR_19200;
    2:  FMercuryFPrt.BaudRate := CBR_57600;
    3:  FMercuryFPrt.BaudRate := CBR_115200;
  end;
  FMercuryFPrt.Password := strPassword;
  // Открываем соединение с ККМ
  try
    FMercuryFPrt.Open;
    FbConnected := True;
    Result := True;
  except
    on E: Exception do
      _AddError(E.Message);
  end;
end; // SetConfig

// Устанавливает новую конфигурацию параметров
procedure Disconnect; stdcall; // export
begin
  try
    FMercuryFPrt.Close(False);
  except
    on E: Exception do
      _AddError(E.Message);
  end;
end; // SetConfig

// Устанавливает новую конфигурацию параметров
function IsConnected: Boolean; stdcall; // export
begin
  Result := False;
  try
//    FMercuryFPrt.TestConnection; не прокатывает
    FMercuryFPrt.QueryEcrDateTime;
    Result := True;
  except
    on E: Exception do
      _AddError(E.Message);
  end;
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
  try
    FMercuryFPrt.OpenDay(AnOperatorNumber, strOperatorName, False,
        FMercuryFPrt.Protocol);
    Result := True;
  except
    on E: Exception do
      _AddError(E.Message);
  end;
end; // OpenShift

// Устанавливает новую конфигурацию параметров
function IsShiftOpened(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  try
    Result := FMercuryFPrt.CheckEcrStatus(MERC_SBIT_DAY_OPENED) > 0;
  except
    on E: Exception do
      _AddError(E.Message);
  end;
end; // OpenShift

// Устанавливает новую конфигурацию параметров
function XReport(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  try
    FMercuryFPrt.XReport(MERC_REPF_NO_ZEROES);
    Result := True;
  except
    on E: Exception do
      _AddError(E.Message);
  end;
end; // IsCconnected

// Устанавливает новую конфигурацию параметров
function ZReport(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  try
    FMercuryFPrt.ZReport(MERC_REPF_NO_ZEROES);
    Result := True;
  except
    on E: Exception do
      _AddError(E.Message);
  end;
end; // IsCconnected

// Печатает строку заголовка составного чека, если это необходимо
procedure _FiscalPrintHeader(var AnRowCount: Integer);
var
  I: Integer;
  PrintNeeded: array [1..4] of Boolean;
begin
  // Для ККМ, не поддерживающих упреждающую печать заголовка добавляем строки
  // клише в чек явным образом
  if (FMercuryFPrt.Generation <> 7)
      or (FMercuryFPrt.EcrSubVersion < $0300) then
  begin
    for I := 1 to 4 do
    begin
      FMercuryFPrt.AddHeaderLine(I, 0, 0, AnRowCount);
      Inc(AnRowCount);
    end;
  end
  else
  begin
    // Если ККМ поддерживает упреждающую печать заголовка, то проверяем, печать
    // каких строк клише включена
    PrintNeeded[1] := FMercuryFPrt.QueryParameterBool(
        MERC_PARAM_AUTOHEADER_LINE1);
    PrintNeeded[2] := FMercuryFPrt.QueryParameterBool(
        MERC_PARAM_AUTOHEADER_LINE2);
    PrintNeeded[3] := FMercuryFPrt.QueryParameterBool(
        MERC_PARAM_AUTOHEADER_LINE3);
    PrintNeeded[4] := FMercuryFPrt.QueryParameterBool(
        MERC_PARAM_AUTOHEADER_LINE4);
    // Если упреждающая печать выключена для всех строк, то добавляем строки
    // клише в чек явным образом
    if not PrintNeeded[1] and not PrintNeeded[2] and not PrintNeeded[3] and
       not PrintNeeded[4] then
    begin
      for I := 1 to 4 do
      begin
        FMercuryFPrt.AddHeaderLine(I, 0, 0, AnRowCount);
        Inc(AnRowCount);
      end;
    end
    else
    begin
      // Если включена упреждающая печать, то проверяем, есть ли ненапечатанные
      // строки клише; если есть - печатаем заголовок чека вызовом метода
      // PrintHeader (метод напечатает только те строки, для которых включена
      // упреждающая печать); счетчик строк AnRowCount здесь
      // в любом случае увеличивать
      // не нужно, т.к. заголовок не входит в состав чека
      for I := 1 to 4 do
      begin
        if PrintNeeded[I] and
           not FMercuryFPrt.QueryParameterBool(MERC_PARAM_HEADER_PRINTED_LINE1
           + I - 1) then
        begin
          FMercuryFPrt.PrintHeader;
          Break;
        end;
      end;
    end;
  end;
end;

procedure _FiscalPrintFullHeader(var AnRowCount: Integer);
begin
  // Счетчик вертикальной координаты
  AnRowCount := 0;
  // Добавляем строки заголовка
  _FiscalPrintHeader(AnRowCount);
  // Добавляем номер ККМ и номер документа (на одной строке)
  FMercuryFPrt.AddSerialNumber(0, 0, AnRowCount);
  FMercuryFPrt.AddDocNumber(0, 31, AnRowCount);
  Inc(AnRowCount);
  // Добавляем ИНН
  FMercuryFPrt.AddTaxPayerNumber(0, 0, AnRowCount);
  Inc(AnRowCount);
  // Добавляем дату / время и номер чека (на одной строке)
  FMercuryFPrt.AddDateTime(0, 0, AnRowCount);
  FMercuryFPrt.AddReceiptNumber(0, 31, AnRowCount);
  Inc(AnRowCount);
  // Добавляем информацию об операторе
  FMercuryFPrt.AddOperInfo(moiNumberName, 0, 0, AnRowCount);
  Inc(AnRowCount);
end;

// Устанавливает новую конфигурацию параметров
function _CashInOut(const AbIn: Boolean; const AfSum: Currency;
    const AstrAccount: PChar): Boolean;
var
  nRowCount: Integer;
  strAccount: String;
begin
  Result := False;
  try
    // Составной чек на внесение наличности (выплата - аналогично)
    if AbIn then
      FMercuryFPrt.OpenFiscalDoc(motCashIn)
    else
      FMercuryFPrt.OpenFiscalDoc(motCashOut);
    try
      // Добавляем строки заголовка и прочей информации
      _FiscalPrintFullHeader(nRowCount);
      // Добавляем позицию
      strAccount := AstrAccount;
      if Length(strAccount) > 0 then begin
        FMercuryFPrt.AddCustom(strAccount, 0, 0, nRowCount);
        Inc(nRowCount);
      end;
      FMercuryFPrt.AddItem(
        mitItem,          // - другие значения для данного типа документа недопустимы
        AfSum,            // - сумма внесения / выплаты
        False, 0, 0, 0, 0,// - параметры игнорируются для чека внесения / выплаты
        0, 0, '',
        0,                // - игнорируется для данного типа документа
        0,                // - смещение по вертикали
        nRowCount,               // - смещение по горизонтали
        0                 // - игнорируется
      );
      Inc(nRowCount);
      // Добавляем итог
      FMercuryFPrt.AddTotal(0, 0, nRowCount, 0); Inc(nRowCount);
      // Для молдавской версии добавляем регистрационный номер
      if FMercuryFPrt.EcrModel = mem114_1FMD then
        FMercuryFPrt.AddRegNumber(0, 0, nRowCount);
      // Закрываем документ
      FMercuryFPrt.CloseFiscalDoc;
    except
      // В случае ошибки отменяем открытый документ
      FMercuryFPrt.CancelFiscalDoc(False);
      raise;
    end;
    Result := True;
  except
    on E: Exception do
      _AddError(E.Message);
  end;
end;

function CashIn(const AfSum: Currency;
    const AstrAccount: PChar;
    const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := _CashInOut(True, AfSum, AstrAccount);
end;

function CashOut(const AfSum: Currency;
    const AstrAccount: PChar;
    const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := _CashInOut(False, AfSum, AstrAccount);
end;


function _StartSaleRefund(const AbSale: Boolean): Boolean;
begin
  Result := False;
  try
    // Составной чек на продажу
    if AbSale then
      FMercuryFPrt.OpenFiscalDoc(motSale)
    else
      FMercuryFPrt.OpenFiscalDoc(motRefund);
    try
      // Добавляем строки заголовка и прочей информации
      _FiscalPrintFullHeader(FnRowCount);
    except
      // В случае ошибки отменяем открытый документ
      FMercuryFPrt.CancelFiscalDoc(False);
      raise;
    end;
      Result := True;
  except
    on E: Exception do
      _AddError(E.Message);
  end;
end;

function StartSale(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := _StartSaleRefund(True);
end;

function StartRefund(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := _StartSaleRefund(False);
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
  nAdjustment: Integer;
begin
  Result := False;
  try
    // Составной чек на продажу
    // Добавляем позицию
    // - наименование товара, как дополнительный реквизит
    FMercuryFPrt.AddCustom(AstrName, 0, 0, FnRowCount);
    Inc(FnRowCount);
    FMercuryFPrt.AddItem(
      mitItem,          // - услуга или товар
      AfPrice,              // - цена товара
      AbIsTare,            // - товар не является тарой
      AnDepartment,                // - номер отдела
      AnCode,              // - код товара
      0,                // - игнорируется
      AnQuantity,         // - количество
      AnQuantityPerc,    // - количество знаков после десятичной точки
      AnTaxIndex,                // - индекс налоговой группы
      AstrUnitName,            // - единица измерения
      0,                // - флаги
      0,                // - смещение по вертикали
      FnRowCount,               // - смещение по горизонтали
      0                 // - игнорируется
    );
    Inc(FnRowCount);
    // Добавляем процентную скидку на позицию
    nAdjustment := Round(AfPercent * 100);
    if nAdjustment <> 0 then begin
      FMercuryFPrt.AddItem(
          mitPercentAdj,    // - процентная скидка / надбавка
          AfPrice,              // - цена товара
          AbIsTare,            // - товар не является тарой
          AnDepartment,                // - номер отдела
          AnCode,              // - код товара
          nAdjustment,                // - скидка
          AnQuantity,         // - количество
          AnQuantityPerc,    // - количество знаков после десятичной точки
          AnTaxIndex,                // - индекс налоговой группы
          '',            // - игнорируется для скидок / надбавок
          0,                // - флаги
          0,                // - смещение по вертикали
          FnRowCount,               // - смещение по горизонтали
          0                 // - игнорируется
      );
      Inc(FnRowCount);
    end;
    if not (CompareValue(AfAmount, 0) = EqualsValue) then begin
      // Добавляем денежную надбавку на позицию
      FMercuryFPrt.AddItem(
          mitAmountAdj,     // - денежная скидка / надбавка
          AfAmount,               // - сумма надбавки
          False,            // - не имеет значения
          AnDepartment,                // - номер отдела
          AnCode,              // - код товара
          0,                // - игнорируется
          0, 0,             // - не имеет значения
          AnTaxIndex,                // - индекс налоговой группы
          '',               // - игнорируется для скидок / надбавок
          0,                // - флаги
          0,                // - смещение по вертикали
          FnRowCount,               // - смещение по горизонтали
          0                 // - игнорируется
      );
      Inc(FnRowCount);
    end;
    Result := True;
  except
    on E: Exception do begin
      _AddError(E.Message);
      // В случае ошибки отменяем открытый документ
      try
        FMercuryFPrt.CancelFiscalDoc(False);
      except
      end;
    end;
  end;
end;

function EndSale(
    const AnType: Integer;
    // 0 -
    const AfCash: Currency;
    const AfCashless: Currency;
    const AnTaxIndex: Integer;
    const AfPercent: Double;
    const AfAmount: Currency;
    const AstrExt: PChar): Boolean; stdcall; // export
var
  mpt: TMercPayType;
  nAdjustment: Integer;
begin
  Result := False;
  try
    // Составной чек на продажу
    // Добавляем итог
    FMercuryFPrt.AddTotal(0, 0, FnRowCount, 0);
    Inc(FnRowCount);
    // Добавляем процентную надбавку на чек
    nAdjustment := Round(AfPercent * 100);
    if nAdjustment <> 0 then begin
      FMercuryFPrt.AddDocPercentAdj(
          nAdjustment,              // - надбавка 4.5%
          AnTaxIndex,                // - индекс налоговой группы
          0,                // - флаги
          0,                // - смещение по вертикали
          FnRowCount,               // - смещение по горизонтали
          0                 // - игнорируется
      );
      Inc(FnRowCount);
    end;
    if not (CompareValue(AfAmount, 0) = EqualsValue) then begin
      // Добавляем денежную скидку на чек
      FMercuryFPrt.AddDocAmountAdj(
          AfAmount,             // - сумма скидки
          AnTaxIndex,                // - индекс налоговой группы
          0,                // - флаги
          0,                // - смещение по вертикали
          FnRowCount,               // - смещение по горизонтали
          0                 // - игнорируется
      );
      Inc(FnRowCount);
    end;
    case AnType of
      0: mpt := mptCash;
      1: mpt := mptCredit;
      2: mpt := mptCard;
      3: mpt := mptCashCredit;
      4: mpt := mptCashCard;
    else
      mpt := mptCash;
    end;
    // Добавляем информацию об оплате
    FMercuryFPrt.AddPay(
      mpt,      // - оплата: наличные + платежная карта
      AfCash,             // - сумма оплаты наличными
      AfCashless,               // - сумма оплаты по безналу
      '',               // - дополнительная информация по оплате - игнорируется
                        //   для комбинированной оплаты
      0, 0, FnRowCount, 0);
    Inc(FnRowCount);
    // Добавляем сумму сдачи
    FMercuryFPrt.AddChange(0, 0, FnRowCount, 0);
    Inc(FnRowCount);
    // Для молдавской версии добавляем регистрационный номер
    if FMercuryFPrt.EcrModel = mem114_1FMD then
      FMercuryFPrt.AddRegNumber(0, 0, FnRowCount);
    // Закрываем документ
    FMercuryFPrt.CloseFiscalDoc;
    Result := True;
  except
    on E: Exception do begin
      _AddError(E.Message);
      // В случае ошибки отменяем открытый документ
      try
        FMercuryFPrt.CancelFiscalDoc(False);
      except
      end;
    end;
  end;
end;


function EndRefund(const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  try
  // Составной чек на возврат
    // Добавляем итог
    FMercuryFPrt.AddTotal(0, 0, FnRowCount, 0);
    Inc(FnRowCount);
    // Для молдавской версии добавляем регистрационный номер
    if FMercuryFPrt.EcrModel = mem114_1FMD then
      FMercuryFPrt.AddRegNumber(0, 0, FnRowCount);
    // Закрываем документ
    FMercuryFPrt.CloseFiscalDoc;
    Result := True;
  except
    on E: Exception do begin
      _AddError(E.Message);
      // В случае ошибки отменяем открытый документ
      try
        FMercuryFPrt.CancelFiscalDoc(False);
      except
      end;
    end;
  end;
end;

function PrintNonFiscal(const AstrText: PChar;
    const AstrExt: PChar): Boolean; stdcall; // export
begin
  Result := False;
  try
    // Печатаем нефискальный документ
    FMercuryFPrt.PrintNonFiscal(AstrText, True, True);
    // Выполняем прогон и отрез бумаги, если поддерживается
    if FMercuryFPrt.Generation >= 2 then
      FMercuryFPrt.FeedAndCut(5, True);
    Result := True;
  except
    on E: Exception do begin
      _AddError(E.Message);
    end;
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
      FstrConfig := DEF_CONFIG;
      FlstErrors := TStringList.Create;
      FFrm := TForm.Create(Nil);
      //Не хочет работать без Parent Window
      FMercuryFPrt := TMercuryFPrtCtrl.Create(FFrm);
      FMercuryFPrt.Parent := FFrm;
    end;
    DLL_PROCESS_DETACH: begin
      FreeAndNil(FMercuryFPrt);
      FreeAndNil(FFrm);
      FreeAndNil(FlstErrors);
    end;
//		DLL_THREAD_ATTACH: ;
//		DLL_THREAD_DETACH: ;
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

