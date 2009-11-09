unit ufrmAddCheckAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, CurrEdit, DBCtrlsEh;

type
  TfrmAddCheckAccount = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    lblSumma: TLabel;
    edtMoney: TCurrencyEdit;
    lblAccountNumber: TLabel;
    lblAccountName: TLabel;
    editAccountNumber: TEdit;
    editAccountName: TEdit;
    lblAccountPassword: TLabel;
    edtAccountPassword: TEdit;
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure edtMoneyChange(Sender: TObject);
  private
    FbControlsEnabled: Boolean;
    procedure Init;
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ShowModal: Integer; override;
  end;

var
  frmAddCheckAccount: TfrmAddCheckAccount;

implementation

uses
  Math,
  Types,
  uRegistry,
  uAccounts,
  gccomputers,
  uKKMTools,
  uErrors,
  gcconst,
  gccommon,
  DateUtils,
  uVirtualTime;
{$R *.dfm}

constructor TfrmAddCheckAccount.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  GAccountsCopy.Append;
  GAccountsCopy.Current.GenerateSecCodes;
  GAccountsCopy.Current.Name := GAccountsCopy.GetFreeCheckAccountsName;
  GAccountsCopy.Current.SecurityBlocked := False;
  GAccountsCopy.Current.Password := GAccountsCopy.GetCheckAccountsPassword;
  GAccountsCopy.Current.PeriodOfValidity :=
      GRegistry.AccountSystem.UsePeriodOfValidity;
  GAccountsCopy.Current.ExpirationDate :=
    IncDay(GetVirtualTime, GRegistry.AccountSystem.PeriodOfValidityInDays);
  editAccountNumber.Text := IntToStr(GAccountsCopy.Current.Id);
  editAccountName.Text := GAccountsCopy.Current.Name;
  Init();
  ControlsEnabled := True;
end;

destructor TfrmAddCheckAccount.Destroy;
begin
  inherited Destroy;
end;

function TfrmAddCheckAccount.ShowModal: Integer;
begin
  Init;
  Result := inherited ShowModal;
end;


procedure TfrmAddCheckAccount.Init;
begin
  edtMoneyChange(Nil);
end;

procedure TfrmAddCheckAccount.btnOkClick(Sender: TObject);
begin
  if (edtMoney.Value < GRegistry.Options.StartMoneyMinimum) then
    Application.MessageBox('Сообщение',
      'Введенная сумма меньше суммы минимальной оплаты', MB_OK)
  else begin
    if GRegistry.Modules.KKM.Active
        and GKKMPlugin.CashIn(edtMoney.Value, 'Внесение денег на счет '
        + GAccountsCopy.Current.Name + ' Пароль: '
        + GAccountsCopy.Current.Password) then begin
      GAccountsCopy.Current.MoneyPut(edtMoney.Value);
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_0, 'Учетная запись '
          + GAccountsCopy.Current.Name + '. Внесение денег на счет :'
          + FloatToStrGC(edtMoney.Value));
      ModalResult := mrOk;
    end else begin
      Application.MessageBox(PChar('Операция отменена из-за ошибки ККМ: '
        + GKKMPlugin.GetLastError), PChar(ERR_CAPTION), MB_OK or MB_ICONERROR);
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          'Операция отменена из-за ошибки ККМ: ' + GKKMPlugin.GetLastError);
    end;
  end;
end;

procedure TfrmAddCheckAccount.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 27) then
    btnCancelClick(Nil);
end;

procedure TfrmAddCheckAccount.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TfrmAddCheckAccount.DisableControls;
begin
  FbControlsEnabled := False;
end;

procedure TfrmAddCheckAccount.btnCancelClick(Sender: TObject);
begin
  GAccountsCopy.Current.Enabled := False;
  ModalResult := mrCancel;
end;

procedure TfrmAddCheckAccount.edtMoneyChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  btnOk.Enabled := (CompareValue(edtMoney.Value, 0) = GreaterThanValue);
  EnableControls;
end;

end.
