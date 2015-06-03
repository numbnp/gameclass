{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{                                                       }
{       TFormADOConnProviderEdit (Build 7.0.01)         }
{                                                       }
{     Copyright (c) 2011-2012 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit ADOConnectionProviderDesignEdit;

{$I EHLIB.INC}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DBGridEhToolCtrls, MemTableDataEh, Db, MemTableEh,
  StdCtrls, ExtCtrls, Mask, DBCtrlsEh, ComCtrls, GridsEh, DBGridEh,
  ADODataDriverEh, ADODb, StrUtils, ToolCtrlsEh;

type
  TFormADOConnProviderEdit = class(TForm)
    GroupBox2: TGroupBox;
    DBGridEh2: TDBGridEh;
    rbUseMacros: TRadioButton;
    rbUseFile: TRadioButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    Label1: TLabel;
    Label2: TLabel;
    DBGridEh1: TDBGridEh;
    Bevel1: TBevel;
    bEditConnection: TButton;
    Button2: TButton;
    Button3: TButton;
    dsMacros: TDataSource;
    dsConnParams: TDataSource;
    mtMacros: TMemTableEh;
    mtMacrosName: TStringField;
    mtMacrosValue: TStringField;
    mtConnParams: TMemTableEh;
    mtConnParamsName: TWideStringField;
    mtConnParamsValue: TWideStringField;
    bTestConn: TButton;
    procedure bEditConnectionClick(Sender: TObject);
    procedure DBGridEh2Columns1UpdateData(Sender: TObject; var Text: string;
      var Value: Variant; var UseText, Handled: Boolean);
    procedure bTestConnClick(Sender: TObject);
    procedure rbUseFileClick(Sender: TObject);
    procedure rbUseMacrosClick(Sender: TObject);
  private
    FADOConnProvider: TADOConnectionProviderEh;
    FInternalSet: Boolean;
    FDesignConnectionString: WideString;
    procedure UpdateButtonsState;
    function GetParameter(ParName: WideString): WideString;
    function GetConnectionStringFromUdlFile(FileName: WideString): WideString;
    procedure PutConnectionStringToUdlFile(ConnStr: WideString; FileName: WideString);
    procedure UpdateConnectionStringFromMemTableConnParams;
  public
    procedure FillData;
    procedure InitData;
    function CheckReplacePathToMacro(ACommStr: WideString): WideString;
    function Edit(ADOConnProvider: TADOConnectionProviderEh): Boolean;
  end;

var
  FormADOConnProviderEdit: TFormADOConnProviderEdit;

function EditFormADOConnProvider(ADOConnProvider: TADOConnectionProviderEh): Boolean;

implementation

{$R *.dfm}

uses AdoConEd, ADOInt, OleDB, ComObj, ActiveX;

type
  WideStringArr = array of WideString;

function EditFormADOConnProvider(ADOConnProvider: TADOConnectionProviderEh): Boolean;
begin
  FormADOConnProviderEdit := TFormADOConnProviderEdit.Create(Application);
  Result := FormADOConnProviderEdit.Edit(ADOConnProvider);
  FreeAndNil(FormADOConnProviderEdit);
end;

function MakeConnectionString(var StrKeywords, StrValues: WideStringArr): WideString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Length(StrKeywords)-1 do
  begin
    StrKeywords[i] := StringReplace(StrKeywords[i],'=','==', [rfReplaceAll]);
    if Pos(StrValues[i],'"') > 0 then
    begin
      StrValues[i] := StringReplace(StrValues[i],'''','''''', [rfReplaceAll]);
      StrValues[i] := '''' + StrValues[i] + '''';
    end else if Pos(StrValues[i],'''') > 0 then
    begin
      StrValues[i] := StringReplace(StrValues[i],'"','""', [rfReplaceAll]);
      StrValues[i] := '"' + StrValues[i] + '"';
    end else if (Pos(StrValues[i],';') > 0) or (Pos(StrValues[i],'=') > 0) then
    begin
      StrValues[i] := StringReplace(StrValues[i],'"','""', [rfReplaceAll]);
      StrValues[i] := '"' + StrValues[i] + '"';
    end;
    if Result = '' then
      Result := StrKeywords[i] + '=' + StrValues[i]
    else
      Result := Result + ';' + StrKeywords[i] + '=' + StrValues[i]
  end;
end;

procedure ConnectionStringToArrayOfStrings(ConnStr: WideString;
  var StrKeywords, StrValues: WideStringArr);
var
  Eos: Boolean;
  ConnPos, ConnLength: Integer;
  NewReadKeyword, NewValue: WideString;

  procedure ReadKeyword;
  begin
    while ConnPos <= ConnLength do
    begin
      if ConnStr[ConnPos] <> '=' then
        NewReadKeyword := NewReadKeyword + ConnStr[ConnPos]
      else if (ConnPos+1 <= ConnLength) and (ConnStr[ConnPos+1] = '=') then
        Inc(ConnPos)
      else
        Exit;
      Inc(ConnPos);
    end;
  end;

  procedure ReadValue;
  var
    FirstSign: Boolean;
    QuoteChar: WideString;
    IsFinish: Boolean;
  begin
    FirstSign := True;
    IsFinish := False;
    QuoteChar := '';
    while ConnPos <= ConnLength do
    begin
      if (ConnStr[ConnPos] = ' ') and FirstSign then
      begin
        Inc(ConnPos);
        Continue;
      end;
      if FirstSign and (ConnStr[ConnPos] = '"') then
          QuoteChar := '"'
      else if FirstSign and (ConnStr[ConnPos] = '''') then
          QuoteChar := ''''
      else if (ConnStr[ConnPos] = '"') and (QuoteChar = '"') then
        if (ConnPos+1 <= ConnLength) and (ConnStr[ConnPos+1] = '"') then
          Inc(ConnPos)
        else
          IsFinish := True
      else if (ConnStr[ConnPos] = '''') and (QuoteChar = '''') then
        if (ConnPos+1 <= ConnLength) and (ConnStr[ConnPos+1] = '''') then
          Inc(ConnPos)
        else
          IsFinish := True
      else if (QuoteChar = '') and (ConnStr[ConnPos] = ';') then
        IsFinish := True
      else
        NewValue := NewValue + ConnStr[ConnPos];

      Inc(ConnPos);
      FirstSign := False;
      if IsFinish then
        Exit;
    end;
  end;

  procedure SkipRest(AndChar: WideString);
  begin
    while ConnPos <= ConnLength do
    begin
      if (ConnStr[ConnPos] = ' ') or (ConnStr[ConnPos] = AndChar) then
        Inc(ConnPos)
      else
        Exit;
    end;
  end;

begin
  SetLength(StrKeywords, 0);
  SetLength(StrValues, 0);
  ConnLength := Length(ConnStr);
  Eos := False;
  ConnPos := 1;
  if ConnStr = '' then
    Eos := True;
  while not Eos do
  begin
    NewReadKeyword := '';
    NewValue := '';

    ReadKeyword;
    SkipRest('=');
    ReadValue;
    SkipRest(';');

    if NewReadKeyword <> '' then
    begin
      SetLength(StrKeywords, Length(StrKeywords)+1);
      StrKeywords[Length(StrKeywords)-1] := NewReadKeyword;
      SetLength(StrValues, Length(StrValues)+1);
      StrValues[Length(StrValues)-1] := NewValue;
    end else
      Break;
  end;
end;

procedure TFormADOConnProviderEdit.bTestConnClick(Sender: TObject);
var
  TestADOConnection: TADOConnection;
  AConnectionString: WideString;
  FileName: String;
begin
  TestADOConnection := TADOConnection.Create(nil);
  TestADOConnection.LoginPrompt := False;
  try
    UpdateConnectionStringFromMemTableConnParams;
    if rbUseFile.Checked then
    begin
      FileName := GetParameter('FILE NAME');
      FileName := FADOConnProvider.UnmacrosConnectionString(FileName);
      AConnectionString := GetConnectionStringFromUdlFile(FileName);
    end else
    begin
      UpdateConnectionStringFromMemTableConnParams;
      AConnectionString := FADOConnProvider.UnmacrosConnectionString(FDesignConnectionString);
    end;
    TestADOConnection.ConnectionString := AConnectionString;
    TestADOConnection.Open;
    ShowMessage('Test connetion succeeded');
  finally
    FreeAndNil(TestADOConnection);
  end;
  if FADOConnProvider.InlineConnection.Connected
    then FADOConnProvider.InlineConnection.Close
    else FADOConnProvider.InlineConnection.Open;
  UpdateButtonsState;
end;

procedure TFormADOConnProviderEdit.bEditConnectionClick(Sender: TObject);
var
  FileName: WideString;
  AConnectionString: WideString;
  NewAConnectionString: WideString;
begin
//  if EditConnectionString(FADOConnProvider.FInlineConnection) then
  if rbUseFile.Checked then
  begin
    FileName := GetParameter('FILE NAME');
    FileName := FADOConnProvider.UnmacrosConnectionString(FileName);
    AConnectionString := GetConnectionStringFromUdlFile(FileName);
  end else
  begin
    UpdateConnectionStringFromMemTableConnParams;
    AConnectionString := FDesignConnectionString;
  end;

  NewAConnectionString := PromptDataSource(Handle, AConnectionString);
  if NewAConnectionString <> AConnectionString then
  begin
    NewAConnectionString := CheckReplacePathToMacro(NewAConnectionString);
    if rbUseFile.Checked then
      PutConnectionStringToUdlFile(NewAConnectionString, FileName)
    else
    begin
      FDesignConnectionString := NewAConnectionString;
      FillData;
    end;
  end;
end;

function TFormADOConnProviderEdit.CheckReplacePathToMacro(
  ACommStr: WideString): WideString;
var
  i: Integer;
  StrKeywords, StrValues: WideStringArr;
  Path: String;
  PathL: Integer;
begin
  ConnectionStringToArrayOfStrings(
    ACommStr, StrKeywords, StrValues);

  Path := FADOConnProvider.Path;
  PathL := Length(Path);
  if Path = '' then
  begin
    Result := ACommStr;
    Exit;
  end;
  for i := 0 to Length(StrKeywords)-1 do
  begin
    if Copy(StrValues[i], 1, PathL) = Path then
      if MessageDlg('Parameter "' + StrKeywords[i] + '" contains a string of "' + Path +  '" path' + #13 +
           'Do you want to replace the path by the macro variable %PROJECT_PATH% ?', mtConfirmation, [mbYes, mbNo], -1) = mrYes then
      begin
        StrValues[i] := '%PROJECT_PATH%' + Copy(StrValues[i], PathL+1, Length(StrValues[i]));
      end;
  end;

  Result :=  MakeConnectionString(StrKeywords, StrValues);
end;

procedure TFormADOConnProviderEdit.DBGridEh2Columns1UpdateData(Sender: TObject;
  var Text: string; var Value: Variant; var UseText, Handled: Boolean);
var
  Col: TColumnEh;
begin
  Col := TColumnEh(Sender);
  Col.Field.AsString := Text;
  Col.Field.DataSet.Post;
  Handled := True;
end;

function TFormADOConnProviderEdit.Edit(
  ADOConnProvider: TADOConnectionProviderEh): Boolean;
begin
  FADOConnProvider := ADOConnProvider;
  FDesignConnectionString := ADOConnProvider.InlineConnection.ConnectionString;
  InitData;
  FillData;
  mtConnParams.MergeChangeLog;

  Result := (FormADOConnProviderEdit.ShowModal = mrOk);
  
  if Result and mtConnParams.HasCachedChanges then
  begin
    UpdateConnectionStringFromMemTableConnParams;
    FADOConnProvider.InlineConnection.ConnectionString := FDesignConnectionString;
  end;
end;

procedure TFormADOConnProviderEdit.FillData;
var
  i: Integer;
  StrKeywords, StrValues: WideStringArr;
begin
  mtConnParams.EmptyTable;
  ConnectionStringToArrayOfStrings(
    FDesignConnectionString, StrKeywords, StrValues);
  for i := 0 to Length(StrKeywords)-1 do
    mtConnParams.AppendRecord([StrKeywords[i], StrValues[i]]);

  mtConnParams.First;
//  mtConnParams.MergeChangeLog;

  mtMacros.EmptyTable;
  mtMacros.AppendRecord(['%PROJECT_PATH%', FADOConnProvider.Path]);
  mtMacros.First;

  UpdateButtonsState;
end;

function TFormADOConnProviderEdit.GetConnectionStringFromUdlFile(
  FileName: WideString): WideString;
var
  DataInit: IDataInitialize;
  InnerConnStr: POleStr;
begin
  DataInit := CreateComObject(CLSID_DataLinks) as IDataInitialize;
  if Succeeded(DataInit.LoadStringFromStorage(PWideChar(FileName), InnerConnStr)) then
//    Result := ExtractUserID(InnerConnStr);
    Result := InnerConnStr;
end;

procedure TFormADOConnProviderEdit.PutConnectionStringToUdlFile(ConnStr,
  FileName: WideString);
var
  DataInit: IDataInitialize;
begin
  DataInit := CreateComObject(CLSID_DataLinks) as IDataInitialize;
  OleCheck(DataInit.WriteStringToStorage(PWideChar(FileName),
              PWideChar(ConnStr), CREATE_ALWAYS));
end;

function TFormADOConnProviderEdit.GetParameter(ParName: WideString): WideString;
var
  StrKeywords, StrValues: WideStringArr;
  i: Integer;
begin
  Result := '';
  if mtConnParams.HasCachedChanges then
    UpdateConnectionStringFromMemTableConnParams;
  ConnectionStringToArrayOfStrings(FDesignConnectionString, StrKeywords, StrValues);
  for i := 0 to Length(StrKeywords)-1 do
    if StrKeywords[i] = ParName then
    begin
      Result := StrValues[i];
      Exit;
    end;
end;

procedure TFormADOConnProviderEdit.InitData;
begin
  FInternalSet := True;
  if Pos(WideString(CT_FILENAME), FDesignConnectionString) = 1 then
  begin
    rbUseFile.Checked := True;
  end else
  begin
    rbUseMacros.Checked := True;
  end;
  FInternalSet := False;
end;

procedure TFormADOConnProviderEdit.rbUseFileClick(Sender: TObject);
begin
  if not FInternalSet and rbUseFile.Checked then
  begin
    mtConnParams.EmptyTable;
    mtConnParams.AppendRecord(['FILE NAME', '%PROJECT_PATH%\DesignConnectionParamsEh.Udl']);
    UpdateConnectionStringFromMemTableConnParams;
  end;
end;

procedure TFormADOConnProviderEdit.rbUseMacrosClick(Sender: TObject);
var
  AConnectionString: WideString;
  FileName: String;
begin
  if not FInternalSet and rbUseMacros.Checked then
  begin
    UpdateConnectionStringFromMemTableConnParams;
    FileName := GetParameter('FILE NAME');
    if FileName <> '' then
    begin
      FileName := FADOConnProvider.UnmacrosConnectionString(FileName);
      AConnectionString := GetConnectionStringFromUdlFile(FileName);
    end;
    FDesignConnectionString := AConnectionString;
    FillData;
  end;
end;

procedure TFormADOConnProviderEdit.UpdateButtonsState;
begin
(*  if FADOConnProvider.FDesignConnection.Connected then
  begin
    bEditConnection.Enabled := False;
//    bTestConn.Caption := 'Disconnect';
  end else
  begin
    bEditConnection.Enabled := True;
//    bConnDisconn.Caption := 'Connect';
  end;*)
end;

procedure TFormADOConnProviderEdit.UpdateConnectionStringFromMemTableConnParams;
var
  StrKeywords, StrValues: WideStringArr;
  i: Integer;
begin
  mtConnParams.First;
  SetLength(StrKeywords, mtConnParams.RecordCount);
  SetLength(StrValues, mtConnParams.RecordCount);
  i := 0;
  while not mtConnParams.Eof do
  begin
{$IFDEF EH_LIB_10}
    StrKeywords[i] := mtConnParams.Fields[0].AsWideString;
    StrValues[i] := mtConnParams.Fields[1].AsWideString;
{$ELSE}
    StrKeywords[i] := mtConnParams.Fields[0].AsString;
    StrValues[i] := mtConnParams.Fields[1].AsString;
{$ENDIF}
    Inc(i);
    mtConnParams.Next;
  end;

  FDesignConnectionString := MakeConnectionString(StrKeywords, StrValues);
end;

end.
