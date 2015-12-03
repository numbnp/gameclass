unit gcclsrv_dbg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,Vcl.SvcMgr,uDebugLog;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses usrvGCCL;

procedure TForm1.Button1Click(Sender: TObject);
var
  bstate: Boolean;
begin
  Debug.Level := 9;
  bstate:= true;
  srvGCCL.ServiceStart(srvGCCL,bstate);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  bstate: Boolean;
begin
  bstate:= true;
  srvGCCL.ServiceStop(srvGCCL,bstate);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  srvGCCL := TsrvGCCL.Create(nil);
end;


end.
