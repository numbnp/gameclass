unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  XPMan,
  EhLibADO, EhLibMTE,
  Dialogs, Unit2, StdCtrls, ExtCtrls, Unit3, Unit4, DBGridEh, Mask,
  DBCtrlsEh;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Edit1: TDBEditEh;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Frame31: TFrame3;
    Frame21: TFrame2;
    Frame41: TFrame4;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (Frame31 <> nil) and Frame31.Visible then
  begin
    Frame31.Visible := False;
    if Frame41 = nil then
    begin
      Frame41 := TFrame4.Create(Self);
      Frame41.Parent := Self;
    end else
      Frame41.Visible := True;
    Edit1.Text := Frame41.Text;
  end else if (Frame21 <> nil) and Frame21.Visible then
  begin
    Frame21.Visible := False;
    if Frame31 = nil then
    begin
      Frame31 := TFrame3.Create(Self);
      Frame31.Parent := Self;
    end else
      Frame31.Visible := True;
    Edit1.Text := Frame31.Text;
  end else if (Frame41 <> nil) and Frame41.Visible then
  begin
    Frame41.Visible := False;
    if Frame21 = nil then
    begin
      Frame21 := TFrame2.Create(Self);
      Frame21.Parent := Self;
    end else
      Frame21.Visible := True;
    Edit1.Text := Frame21.Text;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Frame21 := TFrame2.Create(Self);
  Frame21.Parent := Self;
  Edit1.Text := Frame21.Text;
end;

initialization
  DBGridEhDefaultStyle.IsDrawFocusRect := False;
  DefFontData.Name := 'Tahoma';
//  DefFontData.Height := 20;
end.
