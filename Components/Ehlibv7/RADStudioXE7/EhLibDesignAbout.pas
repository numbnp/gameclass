{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{           Design Time window - About EhLib            }
{                      Build 7.0.001                    }
{                                                       }
{      Copyright (c) 2013 by Dmitry V. Bolshakov        }
{                                                       }
{*******************************************************}

unit EhLibDesignAbout;

{$I EhLib.Inc}

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC}
  EhLibLCL, LCLType,
  {$ELSE}
  XPMan, EhLibVCL, jpeg, Windows,
  {$ENDIF}
  Dialogs, ExtCtrls, StdCtrls, Buttons, ShellAPI;

type
  TfAbout = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    bbClose: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel3: TBevel;
    lBuild: TLabel;
    Shape1: TShape;
    lSupportRef: TLabel;
    lForumRef: TLabel;
    lHomePage: TLabel;
    Shape2: TShape;
    Image2: TImage;
    lVer: TLabel;
    lEditionInfo: TLabel;
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
  lEditionInfo.Caption := EhLibEditionInfo;
end;

procedure TfAbout.lForumRefClick(Sender: TObject);
begin
  {$IFDEF FPC}
  ShellExecute(Handle, 'Open', 'http://forum.ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ELSE}
  ShellExecute(Application.Handle, 'Open', 'http://forum.ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TfAbout.lHomePageClick(Sender: TObject);
begin
  {$IFDEF FPC}
  ShellExecute(Handle, 'Open', 'http://www.ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ELSE}
  ShellExecute(Application.Handle, 'Open', 'http://www.ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TfAbout.lSupportRefClick(Sender: TObject);
begin
  {$IFDEF FPC}
  ShellExecute(Handle, 'open', 'mailto:support@ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ELSE}
  ShellExecute(Application.Handle, 'open', 'mailto:support@ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TfAbout.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if FindDragTarget(Point(Message.XPos, Message.YPos), False) is TLabel then
    Message.Result := HTCLIENT
  else
    Message.Result := HTCAPTION;
end;

end.

