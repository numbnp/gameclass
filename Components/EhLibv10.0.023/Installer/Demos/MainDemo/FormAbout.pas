unit FormAbout;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  EhLibVCL,
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, ShellAPI;

type
  TfAbout = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    bbClose: TBitBtn;
    lTechSupport: TLabel;
    lEmail: TLabel;
    lForum: TLabel;
    Bevel3: TBevel;
    lBuild: TLabel;
    Shape1: TShape;
    lSupportRef: TLabel;
    lForumRef: TLabel;
    lHomePage: TLabel;
    Shape2: TShape;
    Image2: TImage;
    lVer: TLabel;
    procedure bbCloseClick(Sender: TObject);
    procedure lHomePageClick(Sender: TObject);
    procedure lForumRefClick(Sender: TObject);
    procedure lSupportRefClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTESt;
  public
    { Public declarations }
  end;

var
  fAbout: TfAbout;

procedure ShowAboutForm;

implementation

{$R *.dfm}

uses
  EhLibLangConsts, AppLangConsts;

procedure ShowAboutForm;
begin
  fAbout := TfAbout.Create(Application);
  try
    fAbout.ShowModal;
  finally
    FreeAndNil(fAbout);
  end
end;

procedure TfAbout.bbCloseClick(Sender: TObject);
begin
  Close;
end;

type
  TControlCrack = class(TControl);

procedure TfAbout.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ControlCount-1 do
  begin
    TControlCrack(Controls[i]).Font.Name := Font.Name;
  end;
  lSupportRef.Font.Style := [fsBold, fsUnderline];
//  lSupportRef.Font.Color := clNavy;
  lForumRef.Font := lSupportRef.Font;
  lHomePage.Font := lSupportRef.Font;

  lVer.Caption := EhLibVerInfo;
  lBuild.Caption := EhLibBuildInfo;

  Memo1.Text := ApplicationLanguageConsts.AboutWin_AboutInfo;
  lTechSupport.Caption := ApplicationLanguageConsts.AboutWin_TechnicalSupport;
  lEmail.Caption := ApplicationLanguageConsts.AboutWin_EMail;
  lForum.Caption := ApplicationLanguageConsts.AboutWin_Forum;
  bbClose.Caption := ApplicationLanguageConsts.AboutWin_Close;

end;

procedure TfAbout.lForumRefClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'Open', 'http://forum.ehlib.com', nil, nil, SW_SHOWNORMAL);
end;

procedure TfAbout.lHomePageClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'Open', 'http://www.ehlib.com', nil, nil, SW_SHOWNORMAL);
end;

procedure TfAbout.lSupportRefClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'mailto:support@ehlib.com', nil, nil, SW_SHOWNORMAL);
end;

procedure TfAbout.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if FindDragTarget(Point(Message.XPos, Message.YPos), False) is TLabel then
    Message.Result := HTCLIENT
  else
    Message.Result := HTCAPTION;
end;

end.

