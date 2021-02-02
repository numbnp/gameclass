unit Unit1;

{$I EhLib.Inc}

//Comment or uncomment defs below to use embedded or external language resources

{$DEFINE EMBEDDED_LANGUAGE_RESOURCES}
{$DEFINE EMBEDDED_LANGUAGE_RESOURCES_ALL}

interface

uses
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics,
  MemTableEh,
  IniFiles, LanguageResManEh,
  Controls, Forms, Dialogs, StdCtrls, Menus, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, MemTableDataEh, DB, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh, PrnDbgeh;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Language1: TMenuItem;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;
    procedure CheckActiveLanguage;
  public
    AutoDetectMi: TMenuItem;

    procedure MenuItemSelectLanguage(Sender: TObject);
    procedure WriteEhLibConstsToMemo;

    procedure ResourceLanguageChanged();
  published

  end;

var
  Form1: TForm1;
  LanguageAutoselected: Boolean;

implementation

uses EhLibLangConsts,
{$IFDEF EMBEDDED_LANGUAGE_RESOURCES}
  {$IFDEF EMBEDDED_LANGUAGE_RESOURCES_ALL}
    EhLibEmbeddedLangConsts,
  {$ENDIF}
{$ENDIF}
  AppLangConsts, PrvFrmEh, PrnDgDlg;

{$R *.dfm}

{$IFDEF EMBEDDED_LANGUAGE_RESOURCES}

  {$IFDEF EMBEDDED_LANGUAGE_RESOURCES_ALL}
// All Resources

//  uses EhLibEmbeddedLangConsts is used;

    {$IFDEF EH_LIB_12}
      {$R Res\AppLangConsts.DEU.dfm}
      {$R Res\AppLangConsts.ENU.dfm}
      {$R Res\AppLangConsts.FRA.dfm}
      {$R Res\AppLangConsts.RUS.dfm}
      {$R Res\AppLangConsts.UKR.dfm}
    {$ELSE}
      {$R Res.Ansi\AppLangConsts.ENU.dfm}
      {$R Res.Ansi\AppLangConsts.FRA.dfm}
      {$R Res.Ansi\AppLangConsts.RUS.dfm}
      {$R Res.Ansi\AppLangConsts.UKR.dfm}
    {$ENDIF}

  {$ELSE}
// Selected Resources


    {$IFDEF EH_LIB_12}
      {$R Res\AppLangConsts.ENU.dfm}
      {$R Res\AppLangConsts.RUS.dfm}
      {$R Res\AppLangConsts.UKR.dfm}

      {$R Res\EhLibLangConsts.ENU.dfm}
      {$R Res\EhLibLangConsts.RUS.dfm}
      {$R Res\EhLibLangConsts.UKR.dfm}
    {$ELSE}
      {$R Res.Ansi\AppLangConsts.ENU.dfm}
      {$R Res.Ansi\AppLangConsts.RUS.dfm}
      {$R Res.Ansi\AppLangConsts.UKR.dfm}

      {$R Res.Ansi\EhLibLangConsts.ENU.dfm}
      {$R Res.Ansi\EhLibLangConsts.RUS.dfm}
      {$R Res.Ansi\EhLibLangConsts.UKR.dfm}
    {$ENDIF}

  {$ENDIF}
{$ENDIF}

procedure InitUnit;
var
  IniFile: TIniFile;
  StoredLanguage: String;
  AutoLang: String;
begin
{$IFDEF EMBEDDED_LANGUAGE_RESOURCES}
  LanguageResourceManagerEh.ResourcePlacement := lrpEmbeddedEh;
  LanguageResourceManagerEh.LoadListOfAvailableLanguages('TEhLibLanguageConsts');
{$ELSE}
  LanguageResourceManagerEh.ResourcePlacement := lrpExternalEh;
  LanguageResourceManagerEh.LoadListOfAvailableLanguages('EhLibLangConsts');
{$ENDIF}

  IniFile := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\Project1.Ini');
  StoredLanguage := IniFile.ReadString('LanguageResources', 'ActiveLanguage', '');
  if (StoredLanguage <> '') and (LanguageResourceManagerEh.IndexOfLanguage(StoredLanguage) >= 0) then
    LanguageResourceManagerEh.ActiveLanguageAbbr := StoredLanguage
  else
  begin
    AutoLang := LanguageResourceManagerEh.AutoselectLanguage();
    if AutoLang <> '' then
      LanguageResourceManagerEh.ActiveLanguageAbbr := AutoLang;
    LanguageAutoselected := True;
  end;
end;

procedure FinalizeUnit;
begin
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
  ln: String;
  mi: TMenuItem;
begin
  for i := 0 to LanguageResourceManagerEh.LanguageList.Count-1 do
  begin
    ln := LanguageResourceManagerEh.LanguageList[i];
    mi := TMenuItem.Create(Self);
    mi.Caption := ln;
    mi.Tag := 1;
    mi.OnClick := MenuItemSelectLanguage;
    mi.AutoHotkeys := maManual;
    Language1.Add(mi);
  end;

  AutoDetectMi := TMenuItem.Create(Self);
  AutoDetectMi.Caption := 'Auto';
  AutoDetectMi.Tag := 0;
  AutoDetectMi.OnClick := MenuItemSelectLanguage;
  AutoDetectMi.AutoHotkeys := maManual;
  AutoDetectMi.Caption := 'Auto (' + LanguageResourceManagerEh.AutoselectLanguage() + ')';
  if LanguageAutoselected then
    AutoDetectMi.Checked := True;
  Language1.Add(AutoDetectMi);

  Language1.InsertNewLineBefore(AutoDetectMi);

  WriteEhLibConstsToMemo;
  Exit1.Enabled := True;
  LanguageResourceManagerEh.AddLocalizableObject(Self, Self.ClassName, 'Unit1', 'ENU');
  CheckActiveLanguage();
  ResourceLanguageChanged;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  LanguageResourceManagerEh.DeleteLocalizableObject(Self);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItemSelectLanguage(Sender: TObject);
var
  //ln: TLanguageResourceItem;
  IniFile: TIniFile;
  lnName: String;
begin
  if (Sender as TMenuItem).Tag = 1 then
    lnName := (Sender as TMenuItem).Caption
  else
    lnName := '';
  lnName := StringReplace(lnName, '&', '', [rfReplaceAll, rfIgnoreCase]);
//  ln := (Sender as TMenuItem).Tag;
//  if (ln = nil)
//    then lnName := ''
//    else lnName := ln.LanguageAbbr;

  IniFile := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\Project1.Ini');
  IniFile.WriteString('LanguageResources', 'ActiveLanguage', lnName);

  if lnName = '' then
  begin
    LanguageResourceManagerEh.ActiveLanguageAbbr := LanguageResourceManagerEh.AutoselectLanguage();
    LanguageAutoselected := True;
  end else
  begin
    LanguageResourceManagerEh.ActiveLanguageAbbr := lnName;
    LanguageAutoselected := False;
  end;
  WriteEhLibConstsToMemo;
  Invalidate;
  CheckActiveLanguage();
end;

procedure TForm1.CheckActiveLanguage();
var
  i: Integer;
  ln: String;
begin
  for i := 0 to Language1.Count-1 do
  begin
    if Language1.Items[i].Tag = 1 then
      ln := StringReplace(Language1.Items[i].Caption, '&', '', [rfReplaceAll, rfIgnoreCase])
    else
      ln := '';
    if LanguageAutoselected and (ln = '') then
      Language1.Items[i].Checked := True
    else if not LanguageAutoselected and (ln = LanguageResourceManagerEh.ActiveLanguageAbbr) then
      Language1.Items[i].Checked := True
    else
      Language1.Items[i].Checked := False;
  end;
end;

procedure TForm1.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TForm1.ResourceLanguageChanged;
begin
  Caption := ApplicationLanguageConsts.Caption;
  File1.Caption := ApplicationLanguageConsts.MenuFile;
  Language1.Caption := ApplicationLanguageConsts.MenuLanguage;
  Exit1.Caption := ApplicationLanguageConsts.MenuExit;
end;

procedure TForm1.WriteEhLibConstsToMemo;
begin
  Memo1.Lines.Clear;
  Memo1.Lines.Add('EhLibLanguageConsts.ClearSelectedCells = '''+ EhLibLanguageConsts.ClearSelectedCells + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.InvalidTextFormat = '''+ EhLibLanguageConsts.InvalidTextFormat + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.InvalidVCLDBIFFormat = '''+ EhLibLanguageConsts.InvalidVCLDBIFFormat + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.ErrorDuringInsertValue = '''+ EhLibLanguageConsts.ErrorDuringInsertValue + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.IgnoreError = '''+ EhLibLanguageConsts.IgnoreError + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.TabularInformation = '''+ EhLibLanguageConsts.TabularInformation + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.PageOfPages = '''+ EhLibLanguageConsts.PageOfPages + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.Preview = '''+ EhLibLanguageConsts.Preview + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.FieldNameNotFound = '''+ EhLibLanguageConsts.FieldNameNotFound + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.FindDialogStringNotFoundMessage = '''+ EhLibLanguageConsts.FindDialogStringNotFoundMessage + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.VisibleColumns = '''+ EhLibLanguageConsts.VisibleColumns + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.Cut = '''+ EhLibLanguageConsts.Cut + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.Copy = '''+ EhLibLanguageConsts.Copy + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.Paste = '''+ EhLibLanguageConsts.Paste + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.Delete = '''+ EhLibLanguageConsts.Delete + '''');
  Memo1.Lines.Add('EhLibLanguageConsts.SelectAll = '''+ EhLibLanguageConsts.SelectAll + '''');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('ApplicationLanguageConsts.Caption = '''+ ApplicationLanguageConsts.Caption + '''');
  Memo1.Lines.Add('ApplicationLanguageConsts.MenuFile = '''+ ApplicationLanguageConsts.MenuFile + '''');
  Memo1.Lines.Add('ApplicationLanguageConsts.MenuLanguage = '''+ ApplicationLanguageConsts.MenuLanguage + '''');
  Memo1.Lines.Add('ApplicationLanguageConsts.MenuExit = '''+ ApplicationLanguageConsts.MenuExit + '''');

end;

initialization
  InitUnit;
finalization
end.

