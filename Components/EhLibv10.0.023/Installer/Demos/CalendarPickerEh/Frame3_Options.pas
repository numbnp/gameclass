unit Frame3_Options;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes, DateTimeCalendarPickersEh,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  DBCtrlsEh, Mask, ComCtrls;

type
  TfrFrame3_Options = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    DBCheckBoxEh1: TDBCheckBoxEh;
    DBCheckBoxEh2: TDBCheckBoxEh;
    cbxCountryCode: TDBComboBoxEh;
    cbxXEStyle: TDBComboBoxEh;
    ColorDialog1: TColorDialog;
    PaintBox2: TPaintBox;
    Button1: TButton;
    Label2: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure DBCheckBoxEh1Click(Sender: TObject);
    procedure DBCheckBoxEh2Click(Sender: TObject);
    procedure cbxXEStyleChange(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxCountryCodeChange(Sender: TObject);
  private
  protected
    mc: TDateTimeCalendarPickerEh;
  public
    constructor Create(AOwner: TComponent); override;
    function TestInitXE2: Boolean;
  end;

implementation

uses MainUnit,
     Unit_ToolsDataModule;

{$R *.dfm}

{ TfrFrame3_Options }

constructor TfrFrame3_Options.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
  TestInitXE2;
  DBCheckBoxEh1.Checked := EhLibManager.DateTimeCalendarPickerHighlightHolidays;
  DBCheckBoxEh2.Checked := ToolsDataModule.UseSpecDays;


  mc := TDateTimeCalendarPickerEh.Create(Self);
  mc.Parent := Self;
  mc.SetBounds(DBCheckBoxEh1.Left, cbxXEStyle.Top + cbxXEStyle.Height * 2, 160, 160);
  mc.DateTime := EncodeDate(2016,1,1);
  mc.TimeUnits := [cdtuYearEh, cdtuMonthEh, cdtuDayEh, cdtuHourEh, cdtuMinuteEh, cdtuSecondEh];
end;

procedure TfrFrame3_Options.DBCheckBoxEh1Click(Sender: TObject);
begin
  EhLibManager.DateTimeCalendarPickerHighlightHolidays := DBCheckBoxEh1.Checked;
end;

procedure TfrFrame3_Options.DBCheckBoxEh2Click(Sender: TObject);
begin
  ToolsDataModule.UseSpecDays := DBCheckBoxEh2.Checked;
end;

procedure TfrFrame3_Options.Button1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    DateTimeCalendarPickerDrawStyleEh.HolidayBaseFontColor := ColorDialog1.Color;
    PaintBox2.Invalidate;
  end;
end;

procedure TfrFrame3_Options.cbxCountryCodeChange(Sender: TObject);
begin
  ToolsDataModule.CountryCode := cbxCountryCode.Text;
end;

procedure TfrFrame3_Options.cbxXEStyleChange(Sender: TObject);
begin
{$IFDEF EH_LIB_16}
  TStyleManager.TrySetStyle(cbxXEStyle.Items[cbxXEStyle.ItemIndex]);
{$ENDIF}
end;

procedure TfrFrame3_Options.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrFrame3_Options.PaintBox2Paint(Sender: TObject);
begin
  PaintBox2.Canvas.Font.Color := DateTimeCalendarPickerDrawStyleEh.HolidayFontColor;
  PaintBox2.Canvas.Brush.Style := bsClear;
  PaintBox2.Canvas.TextRect(Rect(0,0,PaintBox2.Width,PaintBox2.Height), 0,0, 'Holiday');
end;

function TfrFrame3_Options.TestInitXE2: Boolean;
{$IFDEF EH_LIB_16}
var
  sa: TArray<string>;
  i: Integer;
begin
  Result := True;
  sa := TStyleManager.StyleNames;
  for I := 0 to Length(sa)-1 do
    cbxXEStyle.Items.Add(sa[i]);
  cbxXEStyle.ItemIndex := 0;
end;
{$ELSE}
begin
  Result := False;
end;
{$ENDIF}

end.
