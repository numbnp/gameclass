unit ufrmLogon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uGCBackupRestore;

type
  TformLogon = class(TForm)
    editPass: TEdit;
    lblPass: TLabel;
    lblLogin: TLabel;
    editLogin: TEdit;
    editServer: TEdit;
    lblServer: TLabel;
    butOk: TButton;
    butCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formLogon: TformLogon;

implementation

{$R *.dfm}

end.
