unit frmTrial;

interface

uses
  GClangutils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ShellAPI;

type
  TformTrial = class(TForm)
    Label1: TLabel;
    lblBuy: TLabel;
    butOK: TButton;
    memoInfo: TMemo;
    pbLeft: TProgressBar;
    lblLeft: TLabel;
    lblInfo: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formTrial: TformTrial;

implementation

{$R *.dfm}

procedure TformTrial.Label1Click(Sender: TObject);
begin
  ShellExecute(0,'open',pChar('http://www.gameclass.ru/products/gc'),NIL,NIL,SW_SHOWNORMAL);
end;

procedure TformTrial.FormActivate(Sender: TObject);
begin
  lblInfo.Caption := translate('Information');
  lblLeft.Caption := translate('TrialPeriod');
  lblBuy.Caption := translate('BuyProgram');
end;

end.
