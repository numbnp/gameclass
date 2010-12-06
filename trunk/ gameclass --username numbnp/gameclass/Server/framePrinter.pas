unit framePrinter;

interface

uses
  GCConst, GCLangUtils, GCComputers,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls;

type
  TframePrinter = class(TFrame)
    cbActive: TCheckBox;
    memoActiveInfo: TMemo;
    gbOptions: TGroupBox;
    lblCost: TLabel;
    editCost: TEdit;
    lblCurrency: TLabel;
    pnlTop: TPanel;
    cbxUsePMCosts: TCheckBox;
    procedure cbActiveClick(Sender: TObject);
    procedure editCostChange(Sender: TObject);
    procedure cbxUsePMCostsClick(Sender: TObject);
  private
    { Private declarations }
    procedure ResetFrame;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
  end;

implementation

uses
  uRegistry,
  uRegistryOptions,
  uY2KString,
  uRegistryPrinter,
  uRegistration;
{$R *.dfm}

function TframePrinter.GetID: integer;
begin
  GetID := FRAME_PRINTER;
end;

// процедура ставит все контролы в исходные позиции
procedure TframePrinter.ResetFrame;
begin
  lblCost.Caption := translate('1PageCost');
  gbOptions.Caption := translate('Options');
  cbActive.Caption := translate('GCPCActivate');
  lblCurrency.Caption := GRegistry.Options.Currency;
  editCost.Text := FloatToStr(GRegistry.Modules.Printer.PrintedPageCost);
  cbxUsePMCosts.Checked := GRegistry.Modules.Printer.UsePMCosts;
  if not Registration.PrinterControl then begin
    cbActive.Checked := false;
    cbActive.Enabled := false;
    memoActiveInfo.Text := translate('infoModuleActivateOff');
  end
  else begin
    cbActive.Checked := GRegistry.Modules.Printer.Active;
    cbActive.Enabled := true;
    memoActiveInfo.Text := translate('infoModuleActivateOn');
  end;
  editCost.Enabled := cbActive.Checked;
  lblCost.Enabled := cbActive.Checked;
  lblCost.Enabled := cbActive.Checked;
  cbxUsePMCosts.Enabled := cbActive.Checked;
end;

procedure TframePrinter.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
end;


procedure TframePrinter.cbActiveClick(Sender: TObject);
begin
 // GCPC.SetActive(cbActive.Checked);
  GRegistry.Modules.Printer.Active := cbActive.Checked;
end;

procedure TframePrinter.editCostChange(Sender: TObject);
begin
 // GCPC.SetCost('', StrToFloatDef(editCost.Text,1));
  GRegistry.Modules.Printer.PrintedPageCost :=
      StrToFloatDefWithReplace(editCost.Text,1);
end;

procedure TframePrinter.cbxUsePMCostsClick(Sender: TObject);
begin
  GRegistry.Modules.Printer.UsePMCosts := cbxUsePMCosts.Checked;
end;

end.
