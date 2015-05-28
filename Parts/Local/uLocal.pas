unit uLocal;

interface

procedure Initialize();

implementation

uses
  SysUtils;

procedure Initialize();
begin
  FormatSettings.CurrencyFormat := 3; // 1 $
  FormatSettings.NegCurrFormat := 8;// -1 $
  FormatSettings.ThousandSeparator := #0;
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.CurrencyDecimals := 2;
  FormatSettings.DateSeparator := '.';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.ListSeparator := ';';
  FormatSettings.ShortDateFormat := 'dd.mm.yyyy';
  FormatSettings.ShortTimeFormat := 'hh:mm';
  FormatSettings.LongTimeFormat := 'hh:mm:ss';
  FormatSettings.TwoDigitYearCenturyWindow := 50;
end;

initialization
  Initialize;
  
end.
 