unit EditVendorUnit;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, GridsEh, DBAxisGridsEh, DBVertGridsEh,
  DropDownFormEh;

type
  TfEditVendor = class(TForm)
    DBVertGridEh1: TDBVertGridEh;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fEditVendor: TfEditVendor;

implementation

uses DDFVendorsUnit;

{$R *.lfm}

procedure TfEditVendor.SpeedButton1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfEditVendor.SpeedButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
