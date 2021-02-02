unit FrameOptions;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes, DateTimeCalendarPickersEh, BaseFrame,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  DBCtrlsEh, Mask, PlannerCalendarPickerEh, PlannersEh,
  SpreadGridsEh, ComCtrls;

type
  TfrFrameOptions = class(TMyBaseFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    chbHighlightWeekend: TDBCheckBoxEh;
    chbHighlightHolidays: TDBCheckBoxEh;
    cbxCountryCode: TDBComboBoxEh;
    ColorDialog1: TColorDialog;
    PaintBox2: TPaintBox;
    Button1: TButton;
    Label2: TLabel;
    MonthCalendar1: TMonthCalendar;
    PlannerControlEh1: TPlannerControlEh;
    PlannerDayViewEh1: TPlannerDayViewEh;
    PlannerCalendarPickerEh1: TPlannerCalendarPickerEh;
    bDefaultHolidayFontColor: TButton;
    pbCurDateTimeFrame: TPaintBox;
    Label3: TLabel;
    bCurDateTimeFrame: TButton;
    bCurDateTimeFrameDefault: TButton;
    cbHighlightToday: TDBCheckBoxEh;
    cbShowRefToToday: TDBCheckBoxEh;
    cbHideNotworkHours: TDBCheckBoxEh;
    dteStartWorkTime: TDBDateTimeEditEh;
    dteEndWorkTime: TDBDateTimeEditEh;
    Label4: TLabel;
    chbSun: TDBCheckBoxEh;
    chbMon: TDBCheckBoxEh;
    chbTue: TDBCheckBoxEh;
    chbWed: TDBCheckBoxEh;
    chbThu: TDBCheckBoxEh;
    chbFri: TDBCheckBoxEh;
    chbSat: TDBCheckBoxEh;
    procedure PaintBox1Paint(Sender: TObject);
    procedure chbHighlightWeekendClick(Sender: TObject);
    procedure chbHighlightHolidaysClick(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxCountryCodeChange(Sender: TObject);
    procedure bDefaultHolidayFontColorClick(Sender: TObject);
    procedure pbCurDateTimeFramePaint(Sender: TObject);
    procedure bCurDateTimeFrameClick(Sender: TObject);
    procedure bCurDateTimeFrameDefaultClick(Sender: TObject);
    procedure cbShowRefToTodayClick(Sender: TObject);
    procedure cbHighlightTodayClick(Sender: TObject);
    procedure cbHideNotworkHoursClick(Sender: TObject);
    procedure dteStartWorkTimeChange(Sender: TObject);
    procedure dteEndWorkTimeChange(Sender: TObject);
    procedure chbSunClick(Sender: TObject);
  private
  protected
    mc: TDateTimeCalendarPickerEh;
    DataInit: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateSettings; override;
  end;

implementation

uses Unit1, Unit_ToolsDataModule;

{$R *.dfm}

{ TfrFrameOptions }

constructor TfrFrameOptions.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  DataInit := True;
  Panel1.Height := 36;
  chbHighlightWeekend.Checked := ToolsDataModule.HighlightWeekEnd;
  chbHighlightHolidays.Checked := ToolsDataModule.UseSpecDays;
  dteStartWorkTime.Value := ToolsDataModule.WorkingTimeStart;
  dteStartWorkTime.OnChange := dteStartWorkTimeChange;
  dteEndWorkTime.Value := ToolsDataModule.WorkingTimeEnd;
  dteEndWorkTime.OnChange := dteEndWorkTimeChange;

  chbSun.Checked := wwdSundayEh in EhLibManager.WeekWorkingDays;
  chbMon.Checked := wwdMondayEh in EhLibManager.WeekWorkingDays;
  chbMon.Left := chbSun.Left + 60;
  chbTue.Checked := wwdTuesdayEh in EhLibManager.WeekWorkingDays;
  chbTue.Left := chbMon.Left + 60;
  chbWed.Checked := wwdWednesdayEh in EhLibManager.WeekWorkingDays;
  chbWed.Left := chbTue.Left + 60;
  chbThu.Checked := wwdThursdayEh in EhLibManager.WeekWorkingDays;
  chbThu.Left := chbWed.Left + 60;
  chbFri.Checked := wwdFridayEh in EhLibManager.WeekWorkingDays;
  chbFri.Left := chbThu.Left + 60;
  chbSat.Checked := wwdSaturdayEh in EhLibManager.WeekWorkingDays;
  chbSat.Left := chbFri.Left + 60;

  mc := TDateTimeCalendarPickerEh.Create(Self);
  mc.Parent := Self;
  mc.SetBounds(chbHighlightWeekend.Left, PlannerCalendarPickerEh1.Top + PlannerCalendarPickerEh1.Height + 40, 160, 160);
  mc.DateTime := EncodeDate(2016,1,1);
  mc.TimeUnits := [cdtuYearEh, cdtuMonthEh, cdtuDayEh, cdtuHourEh, cdtuMinuteEh, cdtuSecondEh];

  MonthCalendar1.Top := mc.Top;

  MonthCalendar1.Visible := False;
  mc.Visible := False;
  DataInit := False;
end;

procedure TfrFrameOptions.dteStartWorkTimeChange(Sender: TObject);
begin
  ToolsDataModule.WorkingTimeStart := dteStartWorkTime.Value;
  UpdateSettings;
end;

procedure TfrFrameOptions.dteEndWorkTimeChange(Sender: TObject);
begin
  ToolsDataModule.WorkingTimeEnd := dteEndWorkTime.Value;
  UpdateSettings;
end;

procedure TfrFrameOptions.chbHighlightWeekendClick(Sender: TObject);
begin
  ToolsDataModule.HighlightWeekEnd := chbHighlightWeekend.Checked;
  UpdateSettings;
end;

procedure TfrFrameOptions.chbSunClick(Sender: TObject);
var
  wd: TWeekDaysEh;
begin
  if DataInit then Exit;

  wd := [];
  if chbSun.Checked then
    wd := wd + [wwdSundayEh];
  if chbMon.Checked then
    wd := wd + [wwdMondayEh];
  if chbTue.Checked then
    wd := wd + [wwdTuesdayEh];
  if chbWed.Checked then
    wd := wd + [wwdWednesdayEh];
  if chbThu.Checked then
    wd := wd + [wwdThursdayEh];
  if chbFri.Checked then
    wd := wd + [wwdFridayEh];
  if chbSat.Checked then
    wd := wd + [wwdSaturdayEh];

  EhLibManager.WeekWorkingDays := wd;
end;

procedure TfrFrameOptions.chbHighlightHolidaysClick(Sender: TObject);
begin
  ToolsDataModule.UseSpecDays := chbHighlightHolidays.Checked;
end;

procedure TfrFrameOptions.bCurDateTimeFrameClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    PlannerDrawStyleEh.TodayFrameColor := ColorDialog1.Color;
    pbCurDateTimeFrame.Invalidate;
  end;
end;

procedure TfrFrameOptions.bCurDateTimeFrameDefaultClick(Sender: TObject);
begin
  PlannerDrawStyleEh.TodayFrameColor := clDefault;
  pbCurDateTimeFrame.Invalidate;
end;

procedure TfrFrameOptions.Button1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    PlannerCalendarPickerDrawStyleEh.HolidayBaseFontColor := ColorDialog1.Color;
    PaintBox2.Invalidate;
  end;
end;

procedure TfrFrameOptions.bDefaultHolidayFontColorClick(Sender: TObject);
begin
  PlannerCalendarPickerDrawStyleEh.HolidayBaseFontColor := clDefault;
  PaintBox2.Invalidate;
end;

procedure TfrFrameOptions.cbHideNotworkHoursClick(Sender: TObject);
begin
  ToolsDataModule.HideNotworkHours := cbHideNotworkHours.Checked;
  UpdateSettings;
end;

procedure TfrFrameOptions.cbHighlightTodayClick(Sender: TObject);
begin
  ToolsDataModule.HighlightToday := cbHighlightToday.Checked;
  UpdateSettings;
end;

procedure TfrFrameOptions.cbShowRefToTodayClick(Sender: TObject);
begin
  ToolsDataModule.ShowRefToToday := cbShowRefToToday.Checked;
  UpdateSettings;
end;

procedure TfrFrameOptions.cbxCountryCodeChange(Sender: TObject);
begin
  ToolsDataModule.CountryCode := cbxCountryCode.Text;
end;

procedure TfrFrameOptions.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrameOptions.PaintBox2Paint(Sender: TObject);
begin
  PaintBox2.Canvas.Brush.Color := PlannerCalendarPickerDrawStyleEh.GetActlHolidayBaseFontColor;
  PaintBox2.Canvas.FillRect(Rect(0,0,PaintBox2.Width,PaintBox2.Height));
end;

procedure TfrFrameOptions.pbCurDateTimeFramePaint(Sender: TObject);
begin
  pbCurDateTimeFrame.Canvas.Brush.Color := PlannerDrawStyleEh.GetActlTodayFrameColor;
  pbCurDateTimeFrame.Canvas.FillRect(Rect(0,0,pbCurDateTimeFrame.Width,pbCurDateTimeFrame.Height));

end;

procedure TfrFrameOptions.UpdateSettings;
begin
  inherited UpdateSettings;

  if ToolsDataModule.HighlightWeekEnd
    then PlannerCalendarPickerEh1.Options := PlannerCalendarPickerEh1.Options + [pcpoHighlightHolidaysEh]
    else PlannerCalendarPickerEh1.Options := PlannerCalendarPickerEh1.Options - [pcpoHighlightHolidaysEh];

  if ToolsDataModule.ShowRefToToday
    then PlannerCalendarPickerEh1.Options := PlannerCalendarPickerEh1.Options + [pcpoShowRefToTodayEh]
    else PlannerCalendarPickerEh1.Options := PlannerCalendarPickerEh1.Options - [pcpoShowRefToTodayEh];

  if ToolsDataModule.HighlightToday then
  begin
    PlannerCalendarPickerEh1.Options := PlannerCalendarPickerEh1.Options + [pcpoHighlightTodayEh];
    PlannerControlEh1.Options := PlannerControlEh1.Options + [pvoHighlightTodayEh];
  end else
  begin
    PlannerCalendarPickerEh1.Options := PlannerCalendarPickerEh1.Options - [pcpoHighlightTodayEh];
    PlannerControlEh1.Options := PlannerControlEh1.Options - [pvoHighlightTodayEh];
  end;

  PlannerDayViewEh1.ShowWorkingTimeOnly := ToolsDataModule.HideNotworkHours;
  PlannerControlEh1.WorkingTimeStart := ToolsDataModule.WorkingTimeStart;
  PlannerControlEh1.WorkingTimeEnd := ToolsDataModule.WorkingTimeEnd;
end;

end.
