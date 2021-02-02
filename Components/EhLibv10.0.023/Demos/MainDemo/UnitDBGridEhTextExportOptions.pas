unit UnitDBGridEhTextExportOptions;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes,
  EhLibVCL,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Mask, DBCtrlsEh,
  ExtCtrls;

type
  TFormDBGridEhTextExportOptions = class(TForm)
    CheBoxExportTitle: TDBCheckBoxEh;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    CheBoxExportFooter: TDBCheckBoxEh;
    CoBoxCodePage: TDBComboBoxEh;
    CheBoxWriteBOM: TDBCheckBoxEh;
    CoBoxTextQuoteChar: TDBComboBoxEh;
    CoBoxFieldsDelimiter: TDBComboBoxEh;
    CoBoxLineDelimiter: TDBComboBoxEh;
    CheBoxTrailingLineDelimiter: TDBCheckBoxEh;
    RadButEditFormat: TRadioButton;
    RadButDisplayFormat: TRadioButton;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function GetEncoding: TEncoding;
    function GetTextQuoteChar: Char;
    function GetUseEditFormat: Boolean;
    function GetLineDelimiter: String;
    function GetCellDelimiter: String;
  end;

var
  FormDBGridEhTextExportOptions: TFormDBGridEhTextExportOptions;

implementation

{$R *.dfm}

{ TFormDBGridEhTextExportOptions }

procedure TFormDBGridEhTextExportOptions.FormCreate(Sender: TObject);
begin
{$IFDEF EH_LIB_12}
  {$IFDEF EH_LIB_16}
  {$ELSE}
  CoBoxCodePage.Items.Clear;
  CoBoxCodePage.Items.Add('UTF8');
  CoBoxCodePage.Items.Add('UTF7');
  CoBoxCodePage.Items.Add('Unicode');
  {$ENDIF}
{$ELSE}
  CoBoxCodePage.Items.Clear;
  CoBoxCodePage.Items.Add('ANSI');
  CoBoxCodePage.Text := 'ANSI';
{$ENDIF}
end;

function TFormDBGridEhTextExportOptions.GetEncoding: TEncoding;
begin
{$IFDEF EH_LIB_12}
  {$IFDEF EH_LIB_16}
  if (CoBoxCodePage.Text = 'UTF8') then
    Result := TEncoding.UTF8
  else if (CoBoxCodePage.Text = 'UTF7') then
    Result := TEncoding.UTF7
  else if (CoBoxCodePage.Text = 'Unicode') then
    Result := TEncoding.Unicode
  else if (CoBoxCodePage.Text = 'BigEndianUnicode') then
    Result := TEncoding.BigEndianUnicode
  else if (CoBoxCodePage.Text = 'ANSI') then
    Result := TEncoding.ANSI
  else if (CoBoxCodePage.Text = 'ASCII') then
    Result := TEncoding.ASCII
  else
    Result := nil;
  {$ELSE}
  if (CoBoxCodePage.Text = 'UTF8') then
    Result := TEncoding.UTF8
  else if (CoBoxCodePage.Text = 'UTF7') then
    Result := TEncoding.UTF7
  else if (CoBoxCodePage.Text = 'Unicode') then
    Result := TEncoding.Unicode
  else
    Result := nil;
  {$ENDIF}
{$ELSE}
  if (CoBoxCodePage.Text = 'ANSI') then
    Result := TEncoding.ANSI
  else
    Result := nil;
{$ENDIF}

end;

function TFormDBGridEhTextExportOptions.GetCellDelimiter: String;
begin
  if CoBoxFieldsDelimiter.ItemIndex = 0 then
    Result := #09
  else
    Result := CoBoxFieldsDelimiter.Text;
end;

function TFormDBGridEhTextExportOptions.GetLineDelimiter: String;
begin
  if CoBoxLineDelimiter.ItemIndex = 0 then
    Result := #13#10
  else if CoBoxLineDelimiter.ItemIndex = 1 then
    Result := #10
  else
    Result := CoBoxLineDelimiter.Text;
end;

function TFormDBGridEhTextExportOptions.GetTextQuoteChar: Char;
begin
  if Length(CoBoxTextQuoteChar.Text) > 0 then
    Result := CoBoxTextQuoteChar.Text[1]
  else
    Result := #0;
end;

function TFormDBGridEhTextExportOptions.GetUseEditFormat: Boolean;
begin
  if (RadButEditFormat.Checked) then
    Result := True
  else
    Result := False;
end;

end.
