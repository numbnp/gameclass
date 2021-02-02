unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, DBCtrlsEh, ExtCtrls,
  Mask;

type
  TForm4 = class(TForm)
    cbExportTitle: TDBCheckBoxEh;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    cbFontFormat: TDBCheckBoxEh;
    cbFillColors: TDBCheckBoxEh;
    cbAutoFilter: TDBCheckBoxEh;
    cbExportFooter: TDBCheckBoxEh;
    cbFreezeTitleRow: TDBCheckBoxEh;
    EditCaption: TDBEditEh;
    EditSubcaption: TDBEditEh;
    cbGridCaption: TDBCheckBoxEh;
    cbSubcation: TDBCheckBoxEh;
    cbSumsAsFormula: TDBCheckBoxEh;
    cbDisplayFormat: TDBCheckBoxEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

end.
