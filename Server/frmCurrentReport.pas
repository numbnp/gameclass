unit frmCurrentReport;

interface

uses
  GCLangutils, GCComputers, GCCommon, GCConst,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TformCurrentReport = class(TForm)
    butCancel: TButton;
    Image1: TImage;
    butCloseShift: TButton;
    memoComment: TMemo;
    lblComment: TLabel;
    memoResult: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure butCloseShiftClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  formCurrentReport: TformCurrentReport;


implementation

{$R *.dfm}
uses
  GCFunctions,
  StrUtils,
  uVirtualTime,
  uServerScripting,
  uRegistry,
  uKKMTools;

procedure TformCurrentReport.FormActivate(Sender: TObject);
begin
  ModalResult := mrCancel;
  Caption := translate('mnuCurrentReport');
  butCloseShift.Caption := translate('butCloseShift');
  lblComment.Caption := translate('lblComment');
  butCancel.Caption := translate('butCancel');
  MakeCurrentReport(memoResult.Lines);
  memoComment.Text := '';
  butCloseShift.Enabled := (Not FunctionAmIRight(FN_REMOTE_CONTROL));
end;

procedure TformCurrentReport.butCloseShiftClick(Sender: TObject);
var
  curMoney, fRemovedMoney: double;
  totalTime, totalService, totalTraffic, totalPrinted: double;
  nAccountPayed, nAccountAdded, nAccountReturned: double;
  LastShiftPoint: TDateTime;
  str: string;
  bActionCanceled: Boolean;
begin
  curMoney := dsGetCurrentShiftTotal(totalTime, totalService, totalTraffic, totalPrinted,
              nAccountAdded, nAccountPayed, nAccountReturned, LastShiftPoint);
  fRemovedMoney := GRegistry.Options.RemovedMoney;
  str := FilterString(memoComment.Text);
  bActionCanceled := False;
  if GRegistry.Modules.KKM.Active then begin
    if GRegistry.Modules.KKM.PrintNonFiscal then
      bActionCanceled := not GKKMPlugin.PrintNonFiscal(memoResult.Text)
          and GRegistry.Modules.KKM.DisconnectBlock;
    if not bActionCanceled and GRegistry.Modules.KKM.ZOrderByCloseShift then
      bActionCanceled := not GKKMPlugin.ZReport
          and GRegistry.Modules.KKM.DisconnectBlock;
  end;
  if bActionCanceled then
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
        'Операция отменена из-за ошибки ККМ: ' + GKKMPlugin.GetLastError)
  else begin
    if GRegistry.Options.SendReportAfterClozeChange then
      MakeAndSendCurrentReportEx;
    dsCloseCurrentShift(curMoney, GetVirtualTime, str);
    RunServerScript(aCloseShift, CurOperatorName + ' ' + FloatToStr(curMoney)
        + ' ' + FloatToStr(fRemovedMoney)
        + ' ' + FloatToStr(curMoney - fRemovedMoney));
    ModalResult := mrOk;
    if FunctionAmIRight(FN_VIEW_FINANCE_ON_SHIFT_REPORT) then
    begin
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          translate('CompleteShiftOk') + ', '
          + translate('summa') + ' ' + FormatFloat('0.00', curMoney)
          + ' (' + translate('Computers') + '='
          +  FormatFloat('0.00', curMoney-totalService) + ' / '
          + translate('Sideline') + '='
          +  FormatFloat('0.00', totalService) +')');
    end else begin
      Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1,
          translate('CompleteShiftOk'));
    end;
  end;
end;


procedure TformCurrentReport.butCancelClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TformCurrentReport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((key=27) or (key=116)) then ModalResult := mrCancel;
end;

procedure TformCurrentReport.Button1Click(Sender: TObject);
begin
  MakeAndSendCurrentReportEx;
end;

end.
