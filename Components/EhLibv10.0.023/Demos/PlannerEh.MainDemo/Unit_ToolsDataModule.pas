unit Unit_ToolsDataModule;

interface

uses
  SysUtils, Classes, Graphics, Forms, Windows, Controls, Messages,
  PlannerDataEh, DateTimeCalendarPickersEh, ToolCtrlsEh,
  DateUtils, MemTableDataEh, DB, MemTableEh;

type
  TToolsDataModule = class(TDataModule)
    mtSpecDays: TMemTableEh;
    procedure DataModuleCreate(Sender: TObject);
  private
    FUseSpecDays: Boolean;
    FCountryCode : String;
    FShowRefToToday: Boolean;
    FHighlightToday: Boolean;
    FHighlightWeekEnd: Boolean;
    FHideNotworkHours: Boolean;
    FWorkingTimeStart: TTime;
    FWorkingTimeEnd: TTime;
    procedure SetCountryCode(const Value: String);
    procedure SetUseSpecDays(const Value: Boolean);
    procedure SetShowRefToToday(const Value: Boolean);
    procedure SetHighlightToday(const Value: Boolean);
    procedure SetHighlightWeekEnd(const Value: Boolean);
    procedure SetHideNotworkHours(const Value: Boolean);
    procedure SetWorkingTimeEnd(const Value: TTime);
    procedure SetWorkingTimeStart(const Value: TTime);
  public
    function IsSpecialDay(ADate: TDateTime; var DayType: Integer): Boolean;

    property HighlightWeekEnd: Boolean read FHighlightWeekEnd write SetHighlightWeekEnd;
    property UseSpecDays: Boolean read FUseSpecDays write SetUseSpecDays;
    property CountryCode: String read FCountryCode write SetCountryCode;
    property ShowRefToToday: Boolean read FShowRefToToday write SetShowRefToToday;
    property HighlightToday: Boolean read FHighlightToday write SetHighlightToday;
    property HideNotworkHours: Boolean read FHideNotworkHours write SetHideNotworkHours;
    property WorkingTimeStart: TTime read FWorkingTimeStart write SetWorkingTimeStart;
    property WorkingTimeEnd: TTime read FWorkingTimeEnd write SetWorkingTimeEnd;
  end;

{ TDBWorkingTimeCalendarEh }

  TDBWorkingTimeCalendarEh = class(TWorkingTimeCalendarEh)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsWorkday(ADate: TDateTime): Boolean; override;
  end;

var
  ToolsDataModule: TToolsDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

// http://codes-sources.commentcamarche.net/source/51550-paques-1-0-0
function Easter(Annee : Integer) : TDateTime;
var
  Y,G,C,C_4,E,H,K,P,Q,I,B,J1,J2,R,M : Integer;
begin
  // Y = l'année définie
  Y := Annee;
  // Diviser l'année par 19 et garder le reste
  // 2010/19=105 or 105*19=1995 donc l'écart avec 2010 vaut G=15
  G := Trunc(Y mod 19);
  // C et C_4 permettent le suivi des années bissextiles
  C := Trunc(Y DIV 100);
  // On divise l'année par 100 puis par 4
  // C=2010/100=20 et C_4=20/4=5
  C_4 := Trunc(C DIV 4);
  // Diviser (8*C+13) par 25 , E=8*20+13=173/25=6
  E := Trunc((8 * C + 13) DIV 25);
  // H dépend de l'épacte, H=309/30=10 on garde l'écart donc H=9
  H := Trunc(19 * G + C - C_4 - E + 15) mod 30;
  // K = 9/28 = -0
  K := Trunc(H DIV 28);
  // P = 29/10 = 2
  P := Trunc(29 DIV (H + 1));
  // Q = 21-15 = 6 / 11 = 0
  Q := Trunc((21 - G) DIV 11);
  // I représente le nombre de jours entre la pleine lune pascale et le 21 Mars
  I := Trunc((K * P * Q - 1) * K + H);
  // B = 2010 /4 = 502 + 2010 = 2512
  B := Trunc((Y DIV 4) + Y);
  // J1 = 2508
 J1 := Trunc((B + I + 2 + C_4)- C);
  // Calcule le jour de la lune pascale
  // J2 = 2508/7 = 358 or 358*7 = 2506 donc on garde le reste J = 2
 J2 := Trunc(J1 mod 7);
  // R représente la date du mois de Mars  (R = 35)
  R := Trunc(28 + I - J2);
  // s'il dépasse 31 alors
 if R > 31 then
  begin
  // On déborde sur Avril
    M := 4;
  // Retrancher 31 pour obtenir la date d'Avril (R = 4)
    R := R - 31;
  end
  // s'il ne dépasse pas 31 alors on est en Mars
 else M := 3;
  // renvoie une valeur de type TDateTime à partir des paramètres Annee, Mois et Jour
  Result := EncodeDate(Annee, M, R);
end;

{ TDBWorkingTimeCalendarEh }

constructor TDBWorkingTimeCalendarEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TDBWorkingTimeCalendarEh.Destroy;
begin
  inherited Destroy;
end;

function TDBWorkingTimeCalendarEh.IsWorkday(ADate: TDateTime): Boolean;
var
  DayType: Integer;
  EasterDay : TDateTime;
begin
  Result := inherited IsWorkday(ADate);
  if ToolsDataModule.IsSpecialDay(ADate, DayType) then
    Result := (DayType = 0);

  // ======= Country FR - Formula  Holidays ======
  // Easter + 1 = Lundi de Pâques
  // Easter + 40 = Jeudi de l'Ascension
  // Esater + 50 = Lundi de Pentecôte

  if (ToolsDataModule.CountryCode = 'FR') then
  begin
    EasterDay := Easter(YearOf(ADate));
    if Result then
      Result := Not (EasterDay = IncDay(ADate,-1));
    if Result then
      Result := Not (EasterDay = IncDay(ADate,-39));
    if Result then
      Result := Not (EasterDay = IncDay(ADate,-50));
  end;
end;

{ TToolsDataModule }

procedure TToolsDataModule.DataModuleCreate(Sender: TObject);
begin
  FUseSpecDays := True;
  CountryCode := 'US';
  FShowRefToToday := True;
  FHighlightToday := True;
  FHighlightWeekEnd := True;
  FWorkingTimeStart := TTime(EncodeTime(8, 0, 0, 0));
  FWorkingTimeEnd := TTime(EncodeTime(17, 0, 0, 0));
end;

procedure TToolsDataModule.SetCountryCode(const Value: String);
var
  i: Integer;
begin
  if (value <> FCountryCode) then
  begin
    FCountryCode := Value;
    mtSpecDays.Filter := 'country_code = ' + QuotedStr(Value);
    for I := 0 to Screen.FormCount - 1 do
      Screen.Forms[I].Perform(CM_WININICHANGE, 0, 0);
  end;
end;

procedure TToolsDataModule.SetHideNotworkHours(const Value: Boolean);
begin
  if FHideNotworkHours <> Value then
  begin
    FHideNotworkHours := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

procedure TToolsDataModule.SetHighlightToday(const Value: Boolean);
begin
  if FHighlightToday <> Value then
  begin
    FHighlightToday := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

procedure TToolsDataModule.SetHighlightWeekEnd(const Value: Boolean);
begin
  if FHighlightWeekEnd <> Value then
  begin
    FHighlightWeekEnd := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

procedure TToolsDataModule.SetShowRefToToday(const Value: Boolean);
begin
  if FShowRefToToday <> Value then
  begin
    FShowRefToToday := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

procedure TToolsDataModule.SetUseSpecDays(const Value: Boolean);
begin
  if FUseSpecDays <> Value then
  begin
    FUseSpecDays := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

procedure TToolsDataModule.SetWorkingTimeEnd(const Value: TTime);
begin
  if FWorkingTimeEnd <> Value then
  begin
    FWorkingTimeEnd := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

procedure TToolsDataModule.SetWorkingTimeStart(const Value: TTime);
begin
  if FWorkingTimeStart <> Value then
  begin
    FWorkingTimeStart := Value;
    CheckPostApplicationMessage(WM_THEMECHANGED, 0,0);
  end;
end;

function TToolsDataModule.IsSpecialDay(ADate: TDateTime; var DayType: Integer): Boolean;
var
  y,m,d: Word;
begin
  Result := False;
  if not UseSpecDays then Exit;

  DecodeDate(ADate, y,m,d);
  mtSpecDays.First;
  while not mtSpecDays.Eof do
  begin
    if (mtSpecDays.FieldByName('year_from').AsInteger <= y) and
       (mtSpecDays.FieldByName('year_to').AsInteger >= y) then
    begin
      if (mtSpecDays.FieldByName('date_month').AsInteger = m) and
         (mtSpecDays.FieldByName('date_day').AsInteger = d)
      then
      begin
        Result := True;
        DayType := mtSpecDays.FieldByName('day_type').AsInteger;
        Exit;
      end;
    end;
    mtSpecDays.Next;
  end;
end;

{ TMyDateTimePickCalendarDrawStyleEh }

initialization
  RegisterGlobalWorkingTimeCalendar(TDBWorkingTimeCalendarEh.Create(nil)).Free;
end.

