unit frmWI;

interface

{$I cef.inc}


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uClientWebInterface,
  cefvcl,Unit2;

type
  TForm1 = class(TForm)
    pnlWeb: TPanel;
    pnlControl: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    crm : TWebInterface;
    { Public declarations }
  end;

  ClCore = class
    class function test:string;

  end;

var
  Form1: TForm1;


implementation

{$R *.dfm}

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

procedure TForm1.FormCreate(Sender: TObject);
begin
  crm := TWebInterface.Create(pnlWeb);
  crm.Start
end;

{ ClCore }

class function ClCore.test: string;
begin
  Result := 'ok';
end;

end.
