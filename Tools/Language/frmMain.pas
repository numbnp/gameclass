unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TformMain = class(TForm)
    lbPhrases: TListBox;
    memoEnglish: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    memoOther: TMemo;
    Label3: TLabel;
    butFileOpen: TButton;
    butApply: TButton;
    OpenDialog: TOpenDialog;
    GroupBox1: TGroupBox;
    editText: TEdit;
    butPhraseAdd: TButton;
    butPhraseDel: TButton;
    butPhraseRen: TButton;
    GroupBox2: TGroupBox;
    cbFilterEmpty: TCheckBox;
    Label4: TLabel;
    editFilter: TEdit;
    Button1: TButton;
    procedure butPhraseAddClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lbPhrasesClick(Sender: TObject);
    procedure butPhraseDelClick(Sender: TObject);
    procedure editTextChange(Sender: TObject);
    procedure butApplyClick(Sender: TObject);
    procedure butFileOpenClick(Sender: TObject);
    procedure butPhraseRenClick(Sender: TObject);
    procedure memoOtherKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memoEnglishKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbFilterEmptyClick(Sender: TObject);
    procedure lbPhrasesDblClick(Sender: TObject);
    procedure editFilterChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function GetSelected:integer;
    procedure UpdateCaption;
    procedure RedrawData;    
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMain: TformMain;
  curFile: string;

implementation
uses
  GCLangUtils;

{$R *.dfm}

// update caption text of formMain
procedure TformMain.UpdateCaption;
var
  AddText:string;
begin
  if ( curFile = '' ) then AddText := '[ new file ]' else AddText := '[ ' + curFile + ' ]';
  formMain.Caption := 'GameClass Language Center' + ' ' + AddText;
end;

// returns index of selected Phrase in listbox or -1 otherwise
function TformMain.GetSelected:integer;
var
  i:integer;
begin
  for i:=0 to lbPhrases.Items.Count-1 do
    if (lbPhrases.Selected[i]) then
    begin
      GetSelected := i;
      currentPhrase := GetPhraseIndex(lbPhrases.Items.Strings[i]);
      exit;
    end;
    GetSelected := -1;
end;

procedure TformMain.butPhraseAddClick(Sender: TObject);
var
  i:integer;
begin
  // search in lbPhrases
  for i:=0 to countPhrases-1 do
    if (Phrases[i,0] = editText.Text) then
    begin
      MessageBox(HWND_TOP,'Phrase already exist','error',MB_OK or MB_ICONERROR);
      exit;
    end;
  lbPhrases.Items.Add(editText.Text);
  GCPhraseAdd(editText.Text);
  butApply.Enabled := true;
end;

procedure TformMain.FormActivate(Sender: TObject);
begin
  butPhraseDel.Enabled := false;
  butPhraseAdd.Enabled := false;
  butPhraseRen.Enabled := false;
  butApply.Enabled := false;
  curFile := '';
  formMain.UpdateCaption;
end;

procedure TformMain.lbPhrasesClick(Sender: TObject);
begin
  if (GetSelected = -1) then exit;
  editText.Text := '';
  butPhraseDel.Enabled := true;  
  memoEnglish.Clear;
  memoEnglish.Lines.Text := Phrases[currentPhrase,1];
  memoOther.Clear;
  memoOther.Lines.Text := Phrases[currentPhrase,2];
end;

procedure TformMain.butPhraseDelClick(Sender: TObject);
var
  index:integer;
begin
  if (MessageBox(HWND_TOP,'Are you sure to delete this phrase?','Wow!',MB_OKCANCEL or MB_ICONQUESTION) = IDOK) then
    if (MessageBox(HWND_TOP,'Are you sure sure sure ???????????','Oops!',MB_OKCANCEL or MB_ICONQUESTION) = IDOK) then
    begin
      // delete phrase from listbox
      index := GetSelected;
      if (index <> -1) then
      begin
        GCPhraseDelete(currentPhrase);
        lbPhrases.DeleteSelected;                 
        butApply.Enabled := true;
      end;  
    end;
end;

procedure TformMain.editTextChange(Sender: TObject);
var
 b:boolean;
begin
  if (editText.Text = '') then b:=false else b:=true;
  butPhraseRen.Enabled := b;
  butPhraseAdd.Enabled := b;
end;

procedure TformMain.butApplyClick(Sender: TObject);
begin
  // new file
  if (curFile = '') then
  begin
    MessageBox(HWND_TOP,'File GCLang.lng was created...','Info',MB_OK);
    curFile := 'GCLang.lng';
    UpdateCaption;
  end;
  GCSaveLang(curFile);
  butApply.Enabled := false;
  editText.Text := '';
end;

procedure TformMain.butFileOpenClick(Sender: TObject);
var
  f:integer;
begin
  if not OpenDialog.Execute then exit;
  // else open file
  f := FileOpen(OpenDialog.FileName, fmOpenRead or fmShareDenyNone);
  if not (f > 0) then
  begin
    MessageBox(HWND_TOP,'File open error','Error',MB_OK or MB_ICONERROR);
    exit;
  end;
  GCReadLang(f);
  FileClose(f); 
  curFile := OpenDialog.FileName;  
  UpdateCaption;
  RedrawData;
end;

procedure TformMain.butPhraseRenClick(Sender: TObject);
var
  i:integer;
begin
  // search in lbPhrases
  for i:=0 to countPhrases-1 do
    if (Phrases[i,0] = editText.Text) then
    begin
      MessageBox(HWND_TOP,'Phrase with these name already exist','error',MB_OK or MB_ICONERROR);
      exit;
    end;
  lbPhrases.Items.Strings[GetSelected] := editText.Text;
  Phrases[currentPhrase,0] := editText.Text;
  butApply.Enabled := true;
end;

procedure TformMain.memoOtherKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Phrases[currentPhrase,2] := memoOther.Lines.Text;
  butApply.Enabled := true;
end;

procedure TformMain.memoEnglishKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Phrases[currentPhrase,1] := memoEnglish.Lines.Text;
  butApply.Enabled := true;
end;

procedure TformMain.cbFilterEmptyClick(Sender: TObject);
begin
  RedrawData;
end;

procedure TformMain.RedrawData;
var
  i:integer;
  s0,s1,s2: string;
  filtered: boolean;
begin
  lbPhrases.Clear;
  memoEnglish.Clear;
  memoOther.Clear;
  for i:=0 to countPhrases-1 do
  begin
  s0 := Phrases[i,0];
  s1 := Phrases[i,1];
  s2 := Phrases[i,2];    
  filtered := true;
  if (editFilter.Text <> '') then 
  begin
    if ((StrPos(PChar(s0),PChar(editFilter.Text))=nil) and
        (StrPos(PChar(s1),PChar(editFilter.Text))=nil) and
        (StrPos(PChar(s2),PChar(editFilter.Text))=nil))
      then filtered := false;
  end;
  
  if (not (cbFilterEmpty.Checked)) or (cbFilterEmpty.Checked and ((Phrases[i,1] = '') and (Phrases[i,2] = ''))) then
    if (filtered)
      then 
        formMain.lbPhrases.items.add(Phrases[i,0]);
  end;
end;

procedure TformMain.lbPhrasesDblClick(Sender: TObject);
begin
  if (GetSelected = -1) then exit;
  editText.Text := Phrases[currentPhrase,0];
end;

procedure TformMain.editFilterChange(Sender: TObject);
begin
  RedrawData;
end;

procedure TformMain.Button1Click(Sender: TObject);
var
  f:integer;  // file handle
  i:integer;
  str:WideString;
  len:integer;
begin
  f := FileCreate('aaa');
  if not (f>0) then
  begin
    MessageBox(HWND_TOP,'Lng-file save error','Error',MB_OK or MB_ICONERROR);
    exit;
  end;
  // write (c)header of file
  str := 'Generated by GCLanguage Center (C) Dmitry Novikov 2002';
  GCWriteWideString(f,str);
  // write count of phrases
  len := countPhrases;
  FileWrite(f, len , SizeOf(len));
  // write phrases
  for i:=0 to countPhrases-1 do
  begin
    // write phrase key
    GCWriteWideString(f,Phrases[i,0]);
    // write phrase eng
    GCWriteWideString(f,Phrases[i,1]);
    // write phrase other lang
    GCWriteWideString(f,Phrases[i,2]);
  end;
  FileClose(f);
  // end write
end;

end.
