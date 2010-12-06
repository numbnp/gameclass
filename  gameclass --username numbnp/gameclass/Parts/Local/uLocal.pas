unit uLocal;

interface

procedure Initialize();

implementation

uses
  SysUtils;

procedure Initialize();
begin
  CurrencyFormat := 3; // 1 $
  NegCurrFormat := 8;// -1 $
  ThousandSeparator := #0;
  DecimalSeparator := '.';
  CurrencyDecimals := 2;
  DateSeparator := '.';
  TimeSeparator := ':';
  ListSeparator := ';';
  ShortDateFormat := 'dd.mm.yyyy';
  ShortTimeFormat := 'hh:mm';
  LongTimeFormat := 'hh:mm:ss';
  TwoDigitYearCenturyWindow := 50;
end;

initialization
  Initialize;
  
end.
 