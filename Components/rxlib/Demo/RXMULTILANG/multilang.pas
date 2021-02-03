unit multilang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, RxTranslate;

type
  TToolsForm = class(TForm)
    GroupBox4: TGroupBox;
    mml_title: TLabel;
    cmTvg2MultiLanguage: TSpeedButton;
    FruitsLabel: TLabel;
    LanguageLabel: TLabel;
    mml_desctription: TLabel;
    FruitList: TListBox;
    LanguageCombo: TComboBox;
    MessageBtn: TButton;
    tl: TRxTranslator;
    procedure LanguageComboChange(Sender: TObject);
    procedure MessageBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetLangFileName(const sLangName: String): String;
  public
    { Public declarations }
  end;

var
  ToolsForm: TToolsForm;

implementation

{$R *.dfm}

procedure TToolsForm.FormCreate(Sender: TObject);
begin
  LanguageCombo.ItemIndex := 0;
  LanguageComboChange(Sender);
end;

function TToolsForm.GetLangFileName(const sLangName : String) : String;
var
  sDir : String;
begin
  sDir := ExtractFilePath(Application.ExeName);
  if (sDir[Length(sDir)] <> '\') then sDir := sDir + '\';
  Result := sDir + sLangName + '.lng';
end;

procedure TToolsForm.LanguageComboChange(Sender: TObject);
begin
  tl.LanguageFileName := GetLangFileName(LanguageCombo.Text);
  tl.Translate;
end;

procedure TToolsForm.MessageBtnClick(Sender: TObject);
var
  sMessage : String;
begin
  if (FruitList.ItemIndex > -1) then
    sMessage := tl.TMsg('Selected fruit is') + ' ' +
                FruitList.Items[FruitList.ItemIndex]
  else
    sMessage := tl.TMsg('No one fruit is selected');

  MessageDlg(sMessage, mtInformation, [mbOK, mbHelp], 0);
end;

end.
