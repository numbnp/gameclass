unit frmGCMessageBox;

interface

uses
  GCLangUtils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TformGCMessageBox = class(TForm)
    butOk: TButton;
    lblReadThis: TLabel;
    memoInfo: TMemo;
    cbNotShowAgain: TCheckBox;
    pnTop: TPanel;
    pnBottomOk: TPanel;
    pnBottomDontShow: TPanel;
    pnLeft: TPanel;
    pnRight: TPanel;
    pnBottomSpace: TPanel;
//    procedure FormActivate(Sender: TObject);
    procedure butOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetDontShowAgain(value: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function ShowModal: Integer; override;
    function ShowModalCustom(strCaption: String; nHeight, nWidth: Integer): Integer;
    procedure pnBottomOkResize(Sender: TObject);
  private
    { Private declarations }
    bDontShow: boolean;
  public
    { Public declarations }
  end;

var
  formGCMessageBox: TformGCMessageBox;

implementation

{$R *.dfm}

//procedure TformGCMessageBox.FormActivate(Sender: TObject);
function TformGCMessageBox.ShowModal: Integer;
begin
  Caption := translate('formGCMessageBoxCaption');
  lblReadThis.Caption := translate('lblReadThis');
  cbNotShowAgain.Caption := translate('cbNotShowAgain');
  if (bDontShow) then
  begin
    pnBottomDontShow.Visible := true;
    cbNotShowAgain.Checked := false;
  end
  else
  begin
    pnBottomDontShow.Visible := false;
  end;
  Height := 240;
  Width := 330;
  ShowModal := inherited ShowModal;
end;

function TformGCMessageBox.ShowModalCustom(strCaption: String; nHeight, nWidth: Integer): Integer;
begin
  Caption := strCaption;
  lblReadThis.Caption := translate('lblReadThis');
  cbNotShowAgain.Caption := translate('cbNotShowAgain');
  if (bDontShow) then
  begin
    pnBottomDontShow.Visible := true;
    cbNotShowAgain.Checked := false;
  end
  else
  begin
    pnBottomDontShow.Visible := false;
  end;
  Height := nHeight;
  Width := nWidth;
  ShowModalCustom := inherited ShowModal;
end;

procedure TformGCMessageBox.SetDontShowAgain(value: boolean);
begin
  bDontShow := value;
end;

procedure TformGCMessageBox.butOkClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Hide;
end;

procedure TformGCMessageBox.FormCreate(Sender: TObject);
begin
  bDontShow := false;
end;

procedure TformGCMessageBox.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then
    butOkClick(Sender);
end;

procedure TformGCMessageBox.pnBottomOkResize(Sender: TObject);
begin
  butOk.Left := (pnBottomOk.Width - butOk.Width) div 2;
end;

end.
