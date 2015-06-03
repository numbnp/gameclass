//////////////////////////////////////////////////////////////////////////////
//
// Невизуальный компонент TY2KFileVersionInfo.
// Получает полную информацию о версии заданного файла и
// рассылает ее всем своим подписчикам (observer).
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KFileVersionInfo;

interface

uses
  SysUtils,
  Classes,
  Windows;

type

  // forward declaration
  TY2KFileVersionInfo = class;

  //
  // TY2KFileVersionInfoLink
  //

  TY2KFileVersionInfoLink = class(TObject)
  private
    // attributes
    FSender: TY2KFileVersionInfo;
    FOnChange: TNotifyEvent;
  public
    // constructor / destructor
    destructor Destroy; override;

    // public methods
    procedure Change; dynamic;

    // properties
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TY2KFileVersionInfo read FSender write FSender;
  end; // TY2KFileVersionInfoLink


  //
  // TY2KFileVersionInfo
  //

  TY2KFileVersionInfo = class(TComponent)
  private
    // attributes
    FlstClients: TList;
    FstrCompanyName: string;
    FstrFileDescription: string;
    FstrFileVersion: string;
    FstrInternalName: string;
    FstrLegalCopyright: string;
    FstrLegalTradeMarks: string;
    FstrOriginalFilename: string;
    FstrProductName: string;
    FstrProductVersion: string;
    FstrComments: string;
    FstrExeFile: string;
    FstrCountryCode: string;
    FOnChange: TNotifyEvent;

    // private methods
    procedure _Clear;

  protected
    // protected methods
    procedure Change;

  public
    // constructor / destructor
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    // public methods
    procedure FindFileVersionInfo;
    procedure RegisterChanges(Value: TY2KFileVersionInfoLink);
    procedure UnRegisterChanges(Value: TY2KFileVersionInfoLink);
    procedure SetExeFile(AstrFileName : string);

  published
    // properties
    property Comments : string read FstrComments;
    property CompanyName : string read FstrCompanyName;
    property CountryCode : string read FstrCountryCode;
    property ExeFile : string read FstrExeFile write SetExeFile;
    property FileDescription : string read FstrFileDescription;
    property FileVersion : string read FstrFileVersion;
    property InternalName : string read FstrInternalName;
    property LegalCopyright : string read FstrLegalCopyright;
    property LegalTradeMarks : string read FstrLegalTradeMarks;
    property OriginalFilename : string read FstrOriginalFilename;
    property ProductName : string read FstrProductName;
    property ProductVersion : string read FstrProductVersion;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end; // TY2KFileVersionInfo


implementation

uses
  Dialogs;

type
  TTranslation = record
    b1 : byte;
    b2 : byte;
    b3 : byte;
    b4 : byte;
  end;

  PTranslation = ^TTranslation;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TY2KFileVersionInfoLink

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

destructor TY2KFileVersionInfoLink.Destroy();
begin
  if Sender <> nil then
    Sender.UnRegisterChanges(Self);
  inherited Destroy();
end; // TY2KFileVersionInfoLink.Destroy

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TY2KFileVersionInfoLink.Change();
begin
  if Assigned(OnChange) then
    OnChange(Sender);
end; // TY2KFileVersionInfoLink.Change

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TY2KFileVersionInfo

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KFileVersionInfo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  SetExeFile(ParamStr(0));
  FlstClients := TList.Create;
end; // TY2KFileVersionInfo.Create

destructor TY2KFileVersionInfo.Destroy();
begin
  while FlstClients.Count > 0 do
    UnRegisterChanges(TY2KFileVersionInfoLink(FlstClients.Last));
  Change();
  FlstClients.Free;
  FlstClients := nil;
  inherited Destroy();
end; // TY2KFileVersionInfo.Destroy

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TY2KFileVersionInfo.Change();
var i: integer;
begin
  if FlstClients <> nil then
    for i := 0 to FlstClients.Count - 1 do
      TY2KFileVersionInfoLink(FlstClients[i]).Change;
  if Assigned(FOnChange) then
    FOnChange(Self);
end; // TY2KFileVersionInfo.Change

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TY2KFileVersionInfo.UnRegisterChanges(Value: TY2KFileVersionInfoLink);
var i: integer;
begin
  if FlstClients <> nil then
    for i := 0 to FlstClients.Count - 1 do
      if FlstClients[i] = Value then begin
        Value.Sender := nil;
        FlstClients.Delete(i);
        Break;
      end;
end; // TY2KFileVersionInfo.UnRegisterChanges

procedure TY2KFileVersionInfo.RegisterChanges(Value: TY2KFileVersionInfoLink);
begin
  Value.Sender := Self;
  if FlstClients <> nil then
    FlstClients.Add(Value);
end; // TY2KFileVersionInfo.RegisterChanges

procedure TY2KFileVersionInfo.FindFileVersionInfo();
var
  StringBuffer       : PChar;
  VersionPointer     : PChar;
  QueryStr           : string;
  pQueryStr          : array [0..255] of char;
  Size               : DWORD;
  VersionValueLength : DWORD;
begin
  _Clear;
  {get size of fileversioninfo buffer}
  Size := GetFileVersionInfoSize(PChar(FstrExeFile), Size);

  if Size > 0 then begin {fileversioninfo exists}
    {allocate memory for fileversioninfo strings}
    StringBuffer := AllocMem(Size);
    {copy fileversioninfo into buffer}
    GetFileVersionInfo(PChar(FstrExeFile), 0, Size, StringBuffer);

    {convert Translation to correct countrycode}
    VerQueryValue(StringBuffer, PChar('\VarFileInfo\Translation'),
      Pointer(VersionPointer), VersionValueLength);

    FstrCountryCode :=
      IntToHex(PTranslation(VersionPointer)^.b2, 2) +
      IntToHex(PTranslation(VersionPointer)^.b1, 2) +
      IntToHex(PTranslation(VersionPointer)^.b4, 2) +
      IntToHex(PTranslation(VersionPointer)^.b3, 2);

    {get company name}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'CompanyName';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrCompanyName := StrPas(VersionPointer);
    {get file description}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'FileDescription';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrFileDescription := StrPas(VersionPointer);
    {get file version}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'FileVersion';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrFileVersion := StrPas(VersionPointer);
    {get internal name}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'InternalName';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrInternalName := StrPas(VersionPointer);
    {get legal copyright}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'LegalCopyright';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrLegalCopyright := StrPas(VersionPointer);
    {get legal trademarks}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'LegalTradeMarks';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrLegalTradeMarks := StrPas(VersionPointer);
    {get original filename}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'OriginalFilename';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrOriginalFilename := StrPas(VersionPointer);
    {get product name}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'ProductName';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrProductName := StrPas(VersionPointer);
    {get product version}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'ProductVersion';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrProductVersion := StrPas(VersionPointer);
    {get comments}
    QueryStr := '\StringFileInfo\' + FstrCountryCode + '\' + 'Comments';
    StrPCopy(pQueryStr, QueryStr);
    if VerQueryValue(StringBuffer, pQueryStr, Pointer(VersionPointer), VersionValueLength) then
      FstrComments := StrPas(VersionPointer);

    {free previously allocated memory}
    FreeMem(StringBuffer, Size);
  end;
end; // TY2KFileVersionInfo.FindFileVersionInfo


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TY2KFileVersionInfo.SetExeFile(AstrFileName : String);
begin
  FstrExeFile := AstrFileName;
  FindFileVersionInfo;
  Change();
end; // TY2KFileVersionInfo.SetExeFile


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

procedure TY2KFileVersionInfo._Clear();
begin
  FstrCompanyName := '';
  FstrFileDescription := '';
  FstrFileVersion := '';
  FstrInternalName := '';
  FstrLegalCopyright := '';
  FstrLegalTradeMarks := '';
  FstrOriginalFilename := '';
  FstrProductName := '';
  FstrProductVersion := '';
  FstrComments := '';
  FstrCountryCode := '';
end; // TY2KFileVersionInfo._Clear


end. /////////////////////////// end of file /////////////////////////////////
