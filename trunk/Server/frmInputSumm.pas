unit frmInputSumm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  GCLangUtils, gccommon;

type
  TformInputSumm = class(TForm)
    lblAccount: TLabel;
    lblAccountInfo: TLabel;
    lblInputSumm: TLabel;
    editSumma: TEdit;
    butOK: TButton;
    butCancel: TButton;
    procedure editSummaChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure butOKClick(Sender: TObject);
    procedure editSummaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    typefrm:integer;    // 0 - пополнение баланса, 1 - снятие со счета
  end;

var
  formInputSumm: TformInputSumm;

implementation

uses
  uAccountSystem,
  uAccounts;
{$R *.dfm}

procedure TformInputSumm.editSummaChange(Sender: TObject);
var
  res: double;
begin
  res := StrToFloatGC(editSumma.Text);
  butOK.Enabled := (res > 0);
end;

procedure TformInputSumm.FormActivate(Sender: TObject);
begin
  if (typefrm = 1) then
    editSumma.Text := FloatToStr(GAccountsCopy.Current.Balance);
  editSummaChange(Sender);
end;

procedure TformInputSumm.butOKClick(Sender: TObject);
var
  res: double;
begin
  res := StrToFloatGC(editSumma.Text);
  if ((typefrm = 0) and (res<GAccountSystem.MinAddedSumma)) then begin
    MessageBox(HWND_TOP,PChar('Минимальная сумма пополнения счета = '
        + FloatToStr(GAccountSystem.MinAddedSumma)),
        PChar(translate('Warning')), MB_OK);
    exit;
  end;
  if ((typefrm = 0) and (res>=GAccountSystem.WarningAddedSumma)) then
    if (MessageBox(HWND_TOP,PChar('Вы пополняете счет на сумму '
        + FloatToStr(res) + ' ?'), PChar(translate('Warning')),
        MB_YESNO or MB_ICONQUESTION)<>IDYES) then
      exit;
  if ((typefrm = 1) and (res>GAccountsCopy.Current.Balance))
      then begin
    MessageBox(HWND_TOP, PChar('Нельзя снять больше, чем есть на счете'),
        PChar(translate('Warning')), MB_OK);
    exit;
  end;
  ModalResult := mrOK;
end;

procedure TformInputSumm.editSummaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then ModalResult := mrCancel; 
end;

end.
