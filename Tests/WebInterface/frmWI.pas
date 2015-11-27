unit frmWI;

interface

{$I cef.inc}


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uClientWebInterface,
  cefvcl,Unit2,uWebServer;

type
  TForm1 = class(TForm)
    pnlWeb: TPanel;
    pnlControl: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    edtCommand: TEdit;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Panel1: TPanel;
    memLog: TMemo;
    ListBox1: TListBox;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    function ExecuteClientEvent (Sender: TObject; Request:HttpRequest):boolean;
    procedure ListBox1Click(Sender: TObject);

    procedure LogoffClick(Sender: TObject);
    procedure ClientSessionStopClick(Sender: TObject);
    procedure AgreeEulaClick(Sender: TObject);
    procedure NotAgreeEulaClick(Sender: TObject);
    procedure ActionLogon(Sender: TObject;sLogin,sPassword,sSecCode:string);
    procedure ActionQueryCostTime(Sender: TObject;sTariff,sSumm:string);
    procedure ActionChangeTariff(Sender: TObject;sTariff:string);

  private
    { Private declarations }
  public
    crm : TWebInterface;
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.dfm}

procedure TForm1.ActionChangeTariff(Sender: TObject; sTariff: string);
begin
  memLog.Lines.Add('ActionChangeTariff '+sTariff );
end;

procedure TForm1.ActionLogon(Sender: TObject;sLogin, sPassword, sSecCode: string);
begin
  ShowMessage('ActionLogon '+sLogin+' '+sPassword+' '+sSecCode );
end;

procedure TForm1.ActionQueryCostTime(Sender: TObject; sTariff, sSumm: string);
begin
  memLog.Lines.Add('ActionQueryCostTime '+sTariff+' '+sSumm );
end;

procedure TForm1.AgreeEulaClick(Sender: TObject);
begin
  ShowMessage('AgreeEulaClick');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  crm.ShowDevTools;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  crm.ReloadSkin;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  crm.ShowUnblock;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  crm.DoJsCommand(edtCommand.Text);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  crm.HideUnblock;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  crm.ShowChangePassword;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  crm.HideChangePassword;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  crm.ShowMessages('Test Тест');
end;

procedure TForm1.ClientSessionStopClick(Sender: TObject);
begin
  ShowMessage('ClientSessionStopClick');
end;

function TForm1.ExecuteClientEvent(Sender: TObject;
  Request: HttpRequest): boolean;
begin
  memLog.Lines.Add(Request.Parametrs.Values['action']);

  result := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  crm := TWebInterface.Create(pnlWeb);
  crm.ExecuteClient := ExecuteClientEvent;
  crm.ActionLogoff := LogoffClick;
  crm.ActionAgreeEula := AgreeEulaClick;
  crm.ActionNotAgreeEula := NotAgreeEulaClick;
  crm.ActionStopSession := ClientSessionStopClick;
  crm.ActionLogon := ActionLogon;
  crm.ActionQueryCostTime := ActionQueryCostTime;
  crm.ActionChangeTariff := ActionChangeTariff;
  crm.Start
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  crm.SetClientState(ListBox1.ItemIndex);
end;

procedure TForm1.LogoffClick(Sender: TObject);
begin
  ShowMessage('LogoffClick');
end;

procedure TForm1.NotAgreeEulaClick(Sender: TObject);
begin
  ShowMessage('NotAgreeEulaClick');
end;

end.
