unit ufrmGetMoney;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, jpeg;

type
  TfrmGetMoney = class(TForm)
    Image1: TImage;
    butGetMoney: TButton;
    butCancel: TButton;
    lblSumma: TLabel;
    Label1: TLabel;
    edtMoney: TCurrencyEdit;
    edtRemovedMoney: TCurrencyEdit;
    function ShowModal: Integer;
    procedure butGetMoneyClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure edtRemovedMoneyChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGetMoney: TfrmGetMoney;

implementation

uses
  gcconst,
  gccommon,
  gccomputers,
  gclangutils,
  uRegistry,
  uServerScripting;

{$R *.dfm}

procedure TfrmGetMoney.butGetMoneyClick(Sender: TObject);
var
  fMoney: Double;
  strQuestion: String;
begin
  strQuestion := 'Вы забираете из кассы ' + edtRemovedMoney.Text
      + ' ' + GRegistry.Options.Currency + '?';
  if (MessageBox(HWND_TOP,PChar(strQuestion),
      PChar(translate('Warning')),
      MB_YESNO or MB_ICONQUESTION) = IDYES) then begin
    GRegistry.Options.RemovedMoney := GRegistry.Options.RemovedMoney
        + edtRemovedMoney.Value;
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_0, 'Менеджер '
        + CurOperatorName + ' забрал из кассы ' + edtRemovedMoney.Text);
    RunServerScript(aMoneyRemoved, CurOperatorName + ' '
        + edtRemovedMoney.Text);
    ModalResult := mrOk;
  end;
end;

procedure TfrmGetMoney.butCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmGetMoney.edtRemovedMoneyChange(Sender: TObject);
begin
  butGetMoney.Enabled := (edtMoney.Value >= edtRemovedMoney.Value)
    and (edtRemovedMoney.Value > 0);
end;

function TfrmGetMoney.ShowModal: Integer;
var
  curMoney: double;
  totalTime, totalService, totalTraffic, totalPrinted: double;
  nAccountPayed, nAccountAdded, nAccountReturned: double;
  LastShiftPoint: TDateTime;
begin
  curMoney := dsGetCurrentShiftTotal(totalTime, totalService, totalTraffic, totalPrinted,
              nAccountAdded, nAccountPayed, nAccountReturned, LastShiftPoint);
  edtMoney.Value := curMoney - GRegistry.Options.RemovedMoney;
  edtRemovedMoney.Value := 0;
  butGetMoney.Enabled := False;
  Result := inherited ShowModal;
end;


end.
