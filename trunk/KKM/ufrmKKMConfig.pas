unit ufrmKKMConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  ufrmDinamicConfig,
  uKKMPlugin;

type
  TfrmKKMConfig = class(TForm)
    pnlDynamicConfig: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    gbConfig: TGroupBox;
    gbTestConnect: TGroupBox;
    btnTestConnect: TButton;
    edtTestResult: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnTestConnectClick(Sender: TObject);
  private
    FfrmDinamicConfig: TfrmDinamicConfig;
    FKKMPlugin: TKKMPlugin;
    function GetConfig: String;
  public
    constructor Create(AOwner: TComponent); overload;
    constructor Create(const AOwner: TComponent;
        const AKKMPlugin: TKKMPlugin); overload;
    destructor Destroy(); override;

    property Config: String read GetConfig;
  end;

var
  frmKKMConfig: TfrmKKMConfig;

implementation

{$R *.dfm}
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor
constructor TfrmKKMConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FfrmDinamicConfig := TfrmDinamicConfig.Create(pnlDynamicConfig);
  FfrmDinamicConfig.Parent := pnlDynamicConfig;
  FfrmDinamicConfig.Align := alClient;
  FfrmDinamicConfig.Show;
  FKKMPlugin := Nil;
end;

constructor TfrmKKMConfig.Create(const AOwner: TComponent;
    const AKKMPlugin: TKKMPlugin);
begin
  Create(AOwner);
  FKKMPlugin := AKKMPlugin;
  FfrmDinamicConfig.ConfigTypes := FKKMPlugin.GetConfigTypes;
  FfrmDinamicConfig.Config := FKKMPlugin.GetConfig;
end;

destructor TfrmKKMConfig.Destroy();
begin
  FreeAndNil(FfrmDinamicConfig);
  inherited Destroy;
end;

function TfrmKKMConfig.GetConfig: String;
begin
  Result := FfrmDinamicConfig.Config;
end;

procedure TfrmKKMConfig.Button1Click(Sender: TObject);
begin
  FKKMPlugin.SetConfig(FfrmDinamicConfig.Config);
  ModalResult := mrOk;
end;

procedure TfrmKKMConfig.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmKKMConfig.btnTestConnectClick(Sender: TObject);
begin
  FKKMPlugin.SetConfig(FfrmDinamicConfig.Config);
  FKKMPlugin.Connect;
  if FKKMPlugin.Connected then begin
    edtTestResult.Font.Color := clGreen;
    edtTestResult.Text := 'Подключение выполнено !';
  end else begin
    edtTestResult.Font.Color := clMaroon;
    edtTestResult.Text := 'Ошибка! ' + FKKMPlugin.GetLastError;
  end;
  FKKMPlugin.Disconnect;
end;

end.
