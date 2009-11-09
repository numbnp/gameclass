unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit,
  uKKMPlugin,
  ufrmKKMConfig, CurrEdit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    cbxIsKKMPlugin: TCheckBox;
    edtName: TEdit;
    edtVersion: TEdit;
    edtConfigParamaters: TEdit;
    edtFileName: TFilenameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    edtOpNum: TEdit;
    edtOpName: TEdit;
    CheckBox2: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    btnXReport: TButton;
    btnZReport: TButton;
    Label7: TLabel;
    Label8: TLabel;
    edtAccount: TEdit;
    btnCasheIn: TButton;
    edtSum: TCurrencyEdit;
    Button6: TButton;
    Memo1: TMemo;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure btnXReportClick(Sender: TObject);
    procedure btnZReportClick(Sender: TObject);
    procedure btnCasheInClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FfrmKKM: TfrmKKMConfig;
  KKM: TKKMPlugin;


implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  KKM := TKKMPlugin.Create(edtFileName.FileName);
  cbxIsKKMPlugin.Checked := KKM.IsKKMPlugin;
  edtName.Text := KKM.GetName;
  edtVersion.Text := KKM.GetVersion;
  edtConfigParamaters.Text := KKM.GetConfigTypes;
  FfrmKKM := TfrmKKMConfig.Create(Owner, KKM);
  FfrmKKM.ShowModal;
  CheckBox1.Checked := KKM.Connect;

  FreeAndNil(FfrmKKM);
//  FreeAndNil(KKM);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  KKM.Disconnect;
  CheckBox1.Checked := KKM.IsConnected;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  CheckBox1.Checked := KKM.IsConnected;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CheckBox1.Checked := KKM.Connect;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  nNum: Integer;
begin
  nNum := 0;
  TryStrToInt(edtOpNum.Text, nNum);
   CheckBox2.Checked := KKM.OpenShift(nNum, edtOpName.Text);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
   CheckBox2.Checked := KKM.IsShiftOpened;
end;

procedure TForm1.btnXReportClick(Sender: TObject);
begin
  KKM.XReport();
end;

procedure TForm1.btnZReportClick(Sender: TObject);
begin
  KKM.ZReport();
end;

procedure TForm1.btnCasheInClick(Sender: TObject);
begin
  KKM.CashIn(edtSum.Value, edtAccount.Text);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  KKM.StartSale;
  KKM.AddItem('Персики моченые', 15.45, False, 1,100201, 3, 0 ,4, 'шт.', 0, 0);
  KKM.AddItem('Персики моченые3', 15.45, False, 1,100203, 3, 0 ,4, 'шт.', -5, -5);
  KKM.EndSale(ptCashe, 1000, 0, 4, 0, 0);
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  t: String;
begin
  t := WrapText(Memo1.Text,#13#10, ['.',' ',#9,'-'], 20);
  KKM.ProntNonFiscal(Memo1.Text);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  KKM.StartRefund;
  KKM.AddItem('Персики моченые', 15.45, False, 1,100201, 3, 0 ,4, 'шт.', 0, 0);
  KKM.AddItem('Персики моченые3', 15.45, False, 1,100203, 3, 0 ,4, 'шт.', -5, -5);
  KKM.EndRefund;

end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  KKM.CashOut(edtSum.Value, edtAccount.Text);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  FreeAndNil(KKM);
end;

end.
