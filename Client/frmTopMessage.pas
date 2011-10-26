unit frmTopMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmMessage = class(TForm)
    tmrBliking: TTimer;
    tmrStop: TTimer;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tmrBlikingTimer(Sender: TObject);
    procedure tmrStopTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMessage: TfrmMessage;

procedure ShowTopMessage(StrMessage:string; Period:integer);

implementation

{$R *.dfm}

procedure TfrmMessage.FormShow(Sender: TObject);
begin
SetWindowPos(self.Handle,HWND_TOPMOST,self.Left,self.top,self.Width,self.Height,
      SWP_NOACTIVATE );
end;

procedure TfrmMessage.tmrBlikingTimer(Sender: TObject);
begin
SetWindowPos(self.Handle,HWND_TOPMOST,self.Left,self.top,self.Width,self.Height,
      SWP_NOACTIVATE );
end;

procedure ShowTopMessage(StrMessage:string; Period:integer);
begin
  frmMessage.Label1.Caption := StrMessage;
  SetWindowPos(frmMessage.Handle,
             HWND_TOPMOST,
             round((Screen.Width-frmMessage.Label1.Width)/2),
             0,
             frmMessage.Width,
             frmMessage.Height,
             SWP_NOACTIVATE );
  ShowWindow(frmMessage.Handle,SW_SHOWNA);
  frmMessage.tmrStop.Interval := Period*1000;
  frmMessage.tmrStop.Enabled := True;
  frmMessage.tmrBliking.Enabled := True;
end;

procedure TfrmMessage.tmrStopTimer(Sender: TObject);
begin
  ShowWindow(self.Handle,SW_HIDE);
  frmMessage.tmrStop.Enabled := False;
  frmMessage.tmrBliking.Enabled := False;
end;

end.
