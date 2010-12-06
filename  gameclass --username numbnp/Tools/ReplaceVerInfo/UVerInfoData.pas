{ ##
  @FILE                     UVerInfoData.pas
  @COMMENTS                 Defines a class that encapsulates the binary
                            representation of version information and exposes
                            properties and methods that permit this data to be
                            read and modified.
  @PROJECT_NAME             Binary Version Information Manipulator Library.
  @PROJECT_DESC             Enables binary version information data to be read
                            from and written to streams and to be updated.
  @DEPENDENCIES             None.
  @HISTORY(
    @REVISION(
      @VERSION              1.0
      @DATE                 04/08/2002
      @COMMENTS             Original version.
    )
    @REVISION(
      @VERSION              1.1
      @DATE                 22//06/2003
      @COMMENTS             Now ensures that root nodes are named
                            'VS_VERSION_INFO'.
    )
  )
}


{
 * ***** BEGIN LICENSE BLOCK *****
 * 
 * Version: MPL 1.1
 * 
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with the
 * License. You may obtain a copy of the License at http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 * 
 * The Original Code is UVerInfoData.pas
 * 
 * The Initial Developer of the Original Code is Peter Johnson
 * (http://www.delphidabbler.com/).
 * 
 * Portions created by the Initial Developer are Copyright (C) 2002-2003 Peter
 * Johnson. All Rights Reserved.
 * 
 * Contributor(s):
 * 
 * ***** END LICENSE BLOCK *****
}


unit UVerInfoData;

interface

uses
  // Delphi
  SysUtils, Windows, ActiveX, Classes,
  // Project
  IntfBinaryVerInfo, UVerInfoRec;

type

  {
  TVerResType:
    Enumeration that indicates either a 16 or 32 bit version information
    resource.
  }
  TVerResType =(
    vrtAnsi,       // Ansi resource type
    vrtUnicode     // Unicode resource type
  );

  {
  TVerInfoData:
    Class that encapsulates the binary representation of version information and
    exposes properties and methods that permit this data to be read and
    modified.

    The version information is maintained as a tree of variable length records,
    each record being interpreted according to the key associated with the
    record. TVerInfoRec objects are used to encapsulate the generic version
    info records and TVerInfoData interprets their meaning. The tree of
    records has a VS_VERSION_INFO record at its root. The heirachy of records is
    shown below:

      VS_VERSION_INFO = record
        wLength       // length of structure inc children (Word)
        wValueLength  // size of TVSFixedFileInfo record (Word)
        wType         // 0 - binary (Word: 32 bit records only)
        szKey         // 'VS_VERSION_INFO' (WideString: 32 bit, String: 16 bit)
        pad1          // padding to DWORD boundary
        value         // fixed file information (TVSFixedFileInfo)
        pad2          // padding to DWORD boundary
        children      // VarFileInfo and StringFileInfo records
      end;

      VarFileInfo = record
        wLength       // length of structure inc children (Word)
        wValueLength  // 0 - there is no value (Word)
        wType         // 0 - binary (Word: 32 bit records only)
        szKey         // 'VarFileInfo' (WideString: 32 bit, String: 16 bit)
        pad1          // padding to DWORD boundary
        children      // array of Var records (usually just one)
      end;

      Var = record
        wLength       // length of structure inc children (Word)
        wValueLength  // length of list of translation ids (Word)
        wType         // 0 - binary (Word: 32 bit records only)
        szKey         // 'Translation' (WideString: 32 bit, String: 16 bit)
        pad1          // padding to DWORD boundary
        value         // list of translation ids (array of DWORD)
      end;

      StringFileInfo = record
        wLength       // length of structure inc children (Word)
        wValueLength  // 0 - no value (Word)
        wType         // 0 - binary (Word: 32 bit records only)
        szKey         // 'StringFileInfo' (WideString: 32 bit, String: 16 bit)
        pad1          // padding to DWORD boundary
        children      // array of StringTable records
      end;

      StringTable = record
        wLength       // length of structure inc children (Word)
        wValueLength  // 0 - no value (Word)
        wType         // 0 - binary (Word: 32 bit records only)
        szKey         // translation code (WideString: 32 bit, String: 16 bit)
        pad1          // padding to DWORD boundary
        children      // array of string records
      end;

      String = record
        wLength       // length of structure inc children (Word)
        wValueLength  // length of string value (Word)
        wType         // 1 - text (Word: 32 bit records only)
        szKey         // name of string (WideString: 32 bit, String: 16 bit)
        pad1          // padding to DWORD boundary
        value         // string's value
      end;

    Inheritance: TVerInfoData -> [TObject]
  }
  TVerInfoData = class(TObject)
  private
    fVerResType: TVerResType;
      {Records whether we're accessing 16 or 32 bit resources}
    fVIRoot: TVerInfoRec;
      {Reference to root ver info record that acts as root of record tree and
      stores fixed file information}
    function VerInfoRecClass: TVerInfoRecClass;
      {Returns class of version info record object to be created}
    procedure Error(const FmtStr: string; const Args: array of const);
      {Raises a EVerInfoData exception formatted from given format string
      and arguments}
    function FindChildByName(const Root: TVerInfoRec;
      const Name: string): TVerInfoRec;
      {Finds the first child record of the given 'root' record that has the
      given 'name' (key) and returns a reference to it. If no such child record
      exists then nil is returned}
    function IndexOfChildByName(const Root: TVerInfoRec;
      const Name: string): Integer;
      {Examines the list of child nodes of the given version info record and
      returns the index in the list of the the child record with the given name,
      or -1 if there is no such child record}
    function GetVarFileInfoRoot: TVerInfoRec;
      {Returns reference to the 'VarFileInfo' record which must exist}
    function GetTranslationRec: TVerInfoRec;
      {Returns a reference to the ver info record that stores information about
      all supported translations - i.e. the 'Translation' record. This record
      must exist}
    function GetStringFileInfoRoot: TVerInfoRec;
      {Returns reference to the 'StringFileInfo' record which must exist}
    function GetStringFileInfoTable(TableIdx: Integer): TVerInfoRec;
      {Returns reference to the string file info table at the give index in
      the list of tables. Raises exception if string file info is out of range}
    function GetStringFileInfoItem(TableIdx, StrIdx: Integer): TVerInfoRec;
      {Returns a reference to the ver info record that stores information about
      the string info at the given index in the given translations. Raises
      exception if table or string index are out of bounds}
    function InternalGetTranslationCount(TransRec: TVerInfoRec): Integer;
       {Returns the number of translations in the version information}
    function InternalGetTranslation(TransIdx: Integer): DWORD;
      {Returns the translation code stored at index I in the list of
      translations. Raises exception if the index is out of bounds}
    procedure InternalSetTranslation(TransIdx: Integer; Value: DWORD);
      {Sets the translation at the given index to the given value. An exception
      is raised if the index is out of bounds}
    procedure EnsureRequiredNodes;
      {Ensures that the compulsory version information data nodes are present}
    function CreateNode(Owner: TVerInfoRec;
      const Name: string): TVerInfoRec;
      {Creates a new node (record) of required type (16 or 32 bit) with the
      given name as a child of the given owner record}
  public
    // General methods
    constructor Create(VerResType: TVerResType);
      {Class constructor: creates a new, empty, version information object with
      the required compulsory child nodes. VerResType indicates whether this is
      16 or 32 bit version info}
    destructor Destroy; override;
      {Class destructor: destroys root ver info record (which destroys all its
      child records)}
    procedure Reset;
      {Resets the version information object to the default state: a root
      record with empty fixed file info, an empty string information sub tree
      and a variable file info subtree with an empty translation entry}
    procedure ReadFromStream(const Stream: IStream);
      {Reads the binary representation of the version information from the given
      stream}
    procedure WriteToStream(const Stream: IStream);
      {Writes the binary representation of the version information to the given
      stream}
    procedure Assign(const Source: TVerInfoData);
      {Assigns the contents of the given source object to this object, making
      the content of the two objects the same. This method canbe used to convert
      a 16 bit resource into a 32 bit resource and vice versa if one object is
      created as 16 bit and the other 32 bit}
    // Fixed file info methods
    function GetFixedFileInfo: TVSFixedFileInfo;
      {Returns the version information's fixed file information record}
    procedure SetFixedFileInfo(const Value: TVSFixedFileInfo);
      {Sets the version information's ficed file information record to the given
      value, ensuring that the structure's version and signature are correct}
    // Variable info methods
    function GetTranslationCount: Integer;
      {Returns number of translations in the version information}
    function GetLanguageID(TransIdx: Integer): Word;
      {Returns the language id of the translation at the given index: exception
      if index is out of range}
    function GetCharSet(TransIdx: Integer): Word;
      {Returns the character set of the translation at the given index:
      exception if index is out of range}
    function GetTranslationString(TransIdx: Integer): string;
      {Returns the translation code string of the translation at the given
      index: exception if index is out of range}
    procedure SetTranslation(TransIdx: Integer; LanguageID, CharSet: Word);
      {Sets the translation at the given index to have the given language ID and
      character set. An exception is raised if the index is out of range}
    function AddTranslation(LanguageID, CharSet: Word): Integer;
      {Adds a new translation with the given language id and character set. The
      index of the new translation is returned}
    procedure DeleteTranslation(TransIdx: Integer);
      {Deletes the translation at the given index: exception if index is out of
      range}
    function IndexOfTranslation(LanguageID, CharSet: Word): Integer;
      {Returns the index of the translation with the given language id and
      character set in the list of translations. -1 is returned if there is no
      such translation}
    // String tables methods
    function GetStringTableCount: Integer;
      {Returns the number of string tables in the version information}
    function GetStringTableTransStr(TableIdx: Integer): string;
      {Returns the translation code string that identifies the string table at
      the given index: exception if the index is out of range}
    function AddStringTable(TransStr: string): Integer;
      {Adds a new string table indentified by the given translation code string
      and returns the index of the new entry}
    procedure DeleteStringTable(TableIdx: Integer);
      {Deletes the string table at the given index: exception if index is out of
      bounds}
    function IndexOfStringTable(const TransStr: string): Integer;
      {Returns the index of the string table identified by the given translation
      code string, or -1 if there is no such table}
    // String information methods
    function GetStringCount(TableIdx: Integer): Integer;
      {Returns the number of string information items in the string table with
      the given index: exception if table index out of bounds}
    function GetStringValue(TableIdx, StringIdx: Integer): string;
      {Returns the value of the string information item at the given index in
      the string table with the given table index: exception if either index is
      out of bounds}
    function GetStringName(TableIdx, StringIdx: Integer): string;
      {Returns the name of the string information item at the given index in the
      string table with the given table index: exception if either index is out
      of bounds}
    function IndexOfString(TableIdx: Integer; const Name: string): Integer;
      {Returns the index of the the string info item with the given name in the
      string table at the given index: exception if string table index is out of
      bounds}
    function AddString(TableIdx: Integer; const Name, Value: string): Integer;
      {Adds a new string with the given name to the string table at the given
      index and returns new string item's index in string table. Exceptions are
      raised if string table index is out of bounds or if a string item with
      given name already exists in table}
    procedure SetStringValue(TableIdx, StringIdx: Integer;
      const Value: string);
      {Sets the string item at the given index in the string table at the given
      table index to the given value: exception if either index is out of bounds}
    procedure DeleteString(TableIdx, StringIdx: Integer);
      {Delete the string info item at the given index in the string table at the
      given table index: exception if either index is out of bounds}
  end;

  {
  EVerInfoData:
    Class of exceptions raised by methods of TVerInfoData class.

    Inheritance: EVerInfoData -> [Exception] -> [TObject]
  }
  EVerInfoData = class(Exception);


{ Helper routines }

function TransToString(const Language, CharSet: WORD): string;
  {Returns a string representation of the translation identified by the given
  language and character set codes}

implementation

resourcestring
  // Error messages
  sStrIndexOutOfBounds = 'String information item at index %0:d is out of '
    + 'bounds in string table %1:d';
  sStrTableIndexOutOfBounds = 'String table index %0:d is out of bounds';
  sStrItemExists = 'String item in table %0:d with name "%1:s" already exists';
  sTransIndexOutOfBounds = 'Translation index %0:d is out of bounds';

const
  // Version info data record names
  cVarFileInfo = 'VarFileInfo';
  cTranslation = 'Translation';
  cStringFileInfo = 'StringFileInfo';

{ Helper routines }

function TransToString(const Language, CharSet: WORD): string;
  {Returns a string representation of the translation identified by the given
  language and character set codes}
begin
  Result := IntToHex(Language, 4) + IntToHex(CharSet, 4);
end;

procedure DecodeTrans(const Trans: DWORD; out Language, CharSet: WORD);
  {Decodes the translation encoded in Trans into its langauge and character set
  components. If WORD(Nil^) is passed for either Language or CharSet then the
  value is not returned}
begin
  if Assigned(@Language) then
    Language := LoWord(Trans);
  if Assigned(@CharSet) then
    CharSet := HiWord(Trans);
end;

function EncodeTrans(const OldTrans: DWORD;
  const Language, CharSet: WORD): DWORD;
  {Updates the given translation code OldTrans with the either or both of the
  given lanaguage and character set codes. If either of these codes are $FFFF
  they are ignored}
begin
  Result := OldTrans;
  if Language <> $FFFF then
    LongRec(Result).Lo := Language;
  if CharSet <> $FFFF then
    LongRec(Result).Hi := CharSet;
end;

procedure StampFFI(var FFI: TVSFixedFileInfo);
  {Ensures that given fixed file info structure has correct version (1.0) and
  signature}
begin
  FFI.dwSignature := $FEEF04BD;
  FFI.dwStrucVersion := $00010000;
end;

type
  {
  TDWORDArray:
    Type used to permit access to an area of memory as a DWORD array.
  }
  TDWORDArray = array[0..MaxInt div SizeOf(DWORD) - 1] of DWORD;


{ TVerInfoData }

function TVerInfoData.AddString(TableIdx: Integer; const Name,
  Value: string): Integer;
  {Adds a new string with the given name to the string table at the given index
  and returns new string item's index in string table. Exceptions are raised if
  string table index is out of bounds or if a string item with given name
  already exists in table}
var
  StrTable: TVerInfoRec;    // string table record at given index
  StrRec: TVerInfoRec;      // string info record with given name
begin
  // New string is added to end of string table
  Result := GetStringCount(TableIdx);
  // Get reference to root string file info record for given translation
  StrTable := GetStringFileInfoTable(TableIdx);
  Assert(Assigned(StrTable));
  // Find the string info rec for given name: its a child of translation record
  StrRec := FindChildByName(StrTable, Name);
  if Assigned(StrRec) then
    Error(sStrItemExists, [TableIdx, Name]);
  // Create new string item in table and set name and value
  StrRec := CreateNode(StrTable, Name);
  StrRec.SetStringValue(Value);
end;

function TVerInfoData.AddStringTable(TransStr: string): Integer;
  {Adds a new string table indentified by the given translation code string and
  returns the index of the new entry}
begin
  // New string table will be added to end of list of tables
  Result := GetStringTableCount;
  // Add a new string table entry under the 'StringFileInfo' record named with
  // given translation string
  CreateNode(GetStringFileInfoRoot, TransStr);
end;

function TVerInfoData.AddTranslation(LanguageID, CharSet: Word): Integer;
  {Adds a new translation with the given language id and character set. The
  index of the new translation is returned}
var
  TransRec: TVerInfoRec;  // reference to 'Translation' record
  TempBuf: PByte;         // temp buffer for new translation list
  TempBufSize: Integer;   // size of temp buffer
begin
  // New translation is added to end of list => index is current last item
  Result := GetTranslationCount;
  // Get reference to 'Translation' record, which must exist
  TransRec := GetTranslationRec;
  Assert(TransRec <> nil);
  // Create a buffer to hold all current translation list + new entry
  TempBufSize := TransRec.GetValueSize + SizeOf(DWORD);
  GetMem(TempBuf, TempBufSize);
  try
    // Store old translation list at start of new storage
    Move(TransRec.Value^, TempBuf^, TransRec.GetValueSize);
    // Store new extended list as translation's value: the new entry is at the
    // the end of the list and has undefined value
    TransRec.SetBinaryValue(TempBuf^, TempBufSize);
    // Store the new translation's value, created from given language and char
    // set, at the end of the translation list
    InternalSetTranslation(Result, EncodeTrans(0, LanguageID, CharSet));
  finally
    // Free the temporary buffer
    FreeMem(TempBuf, TempBufSize);
  end;
end;

procedure TVerInfoData.Assign(const Source: TVerInfoData);
  {Assigns the contents of the given source object to this object, making the
  content of the two objects the same. This method canbe used to convert a 16
  bit resource into a 32 bit resource and vice versa if one object is created as
  16 bit and the other 32 bit}
var
  SrcStrTableIdx: Integer;  // index of a string table in source object
  NewTableIdx: Integer;     // index of a new string table in this object
  SrcStrIdx: Integer;       // index of a string in source object
  SrcTransIdx: Integer;     // index of a translation in source object
begin
  // Clear all existing data from this object
  Self.Reset;
  // Set fixed file info to be same as source object
  Self.SetFixedFileInfo(Source.GetFixedFileInfo);
  // Add translations to match those in source object
  for SrcTransIdx := 0 to Pred(Source.GetTranslationCount) do
    Self.AddTranslation(
      Source.GetLanguageID(SrcTransIdx),
      Source.GetCharSet(SrcTransIdx)
    );
  // Add string tables and string entries to match those in source object
  for SrcStrTableIdx := 0 to Pred(Source.GetStringTableCount) do
  begin
    // add new string table and record its index
    NewTableIdx := Self.AddStringTable(
      Source.GetStringTableTransStr(SrcStrTableIdx)
    );
    // add strings from source string table to new string table
    for SrcStrIdx := 0 to Pred(Source.GetStringCount(SrcStrTableIdx)) do
      Self.AddString(
        NewTableIdx,
        Source.GetStringName(SrcStrTableIdx, SrcStrIdx),
        Source.GetStringValue(SrcStrTableIdx, SrcStrIdx)
      );
  end;
end;

constructor TVerInfoData.Create(VerResType: TVerResType);
  {Class constructor: creates a new, empty, version information object with the
  required compulsory child nodes. VerResType indicates whether this is 16 or 32
  bit version info}
begin
  inherited Create;
  // Record type of version infor records we're dealing with
  // (required before root record created)
  fVerResType := VerResType;
  // Create the root object
  fVIRoot := VerInfoRecClass.Create;
  // Ensure FFI record is zero with required signature and required child nodes
  // are created of fVIRoot
  Reset;
end;

function TVerInfoData.CreateNode(Owner: TVerInfoRec;
  const Name: string): TVerInfoRec;
  {Creates a new node (record) of required type (16 or 32 bit) with the given
  name as a child of the given owner record}
begin
  Result := VerInfoRecClass.Create(Owner);
  Result.Name := Name;
end;

procedure TVerInfoData.DeleteString(TableIdx, StringIdx: Integer);
  {Delete the string info item at the given index in the string table at the
  given table index: exception if either index is out of bounds}
var
  StrRec: TVerInfoRec;  // reference to required string info item
begin
  // Get reference to required string info item
  StrRec := GetStringFileInfoItem(TableIdx, StringIdx);
  Assert(Assigned(StrRec));
  // Freeing string item unlinks from string table's list
  StrRec.Free;
end;

procedure TVerInfoData.DeleteStringTable(TableIdx: Integer);
  {Deletes the string table at the given index: exception if index is out of
  bounds}
var
  StrTableRec: TVerInfoRec; // reference to required string table record
begin
  // Get reference to string table
  StrTableRec := GetStringFileInfoTable(TableIdx);
  Assert(Assigned(StrTableRec));
  // Freeing record unlink from list
  StrTableRec.Free;
end;

procedure TVerInfoData.DeleteTranslation(TransIdx: Integer);
  {Deletes the translation at the given index: exception if index is out of
  range}
var
  TransRec: TVerInfoRec;    // ref to 'Translation' record
  TempBuf: Pointer;         // temp buffer to hold updated translation list
  TempBufSize: Integer;     // size of temp buffer
  I: Integer;               // loops through current translations
  NumTrans: Integer;        // current number of translations
  TransName: string;        // name of translation at given index
begin
  // Get translation as string and number of translations
  TransName := GetTranslationString(TransIdx);
  NumTrans := GetTranslationCount;
  // Record reference to translation record
  TransRec := GetTranslationRec;
  Assert(TransRec <> nil);
  // Create a temp buffer to hold current translation table
  TempBufSize := TransRec.GetValueSize;
  GetMem(TempBuf, TempBufSize);
  try
    Move(TransRec.Value^, TempBuf^, TransRec.GetValueSize);
    // Shuffle down translation elements in table above deleted item
    for I := Pred(NumTrans) downto TransIdx + 1 do
      // move element down list
      TDWORDArray(TempBuf^)[I - 1] := TDWORDArray(TempBuf^)[I];
    // Rewrite translation table, leaving out last item
    TransRec.SetBinaryValue(TempBuf^, TempBufSize - SizeOf(DWORD));
  finally
    // Free temporary buffer
    FreeMem(TempBuf, TempBufSize);
  end;
end;

destructor TVerInfoData.Destroy;
  {Class destructor: destroys root ver info record (which destroys all its child
  records)}
begin
  fVIRoot.Free;
  inherited;
end;

procedure TVerInfoData.EnsureRequiredNodes;
  {Ensures that the compulsory version information data nodes are present}

  // ---------------------------------------------------------------------------
  function EnsureNode(Owner: TVerInfoRec;
    const Name: string): TVerInfoRec;
    {Checks if a version info record with the given name exists as a child of
    the given owner record. If the node dosen't exist it is created. A reference
    to the required node is returned}
  begin
    // Check if record (node) exists
    Result := FindChildByName(Owner, Name);
    if not Assigned(Result) then
      // Node doesn't exist so create it
      Result := CreateNode(Owner, Name);
  end;
  // ---------------------------------------------------------------------------

var
  VarFileInfoRoot: TVerInfoRec;     // root record for variable info
begin
  // Ensure root node has required name
  fVIRoot.Name := 'VS_VERSION_INFO';
  // Make sure 'VarFileInfo' node exists under root
  VarFileInfoRoot := EnsureNode(fVIRoot, cVarFileInfo);
  // Make sure 'Translation' node exists under 'VarFileInfo'
  EnsureNode(VarFileInfoRoot, cTranslation);
  // Make sure 'StringFileInfo' exists under root
  EnsureNode(fVIRoot, cStringFileInfo);
end;

procedure TVerInfoData.Error(const FmtStr: string;
  const Args: array of const);
  {Raises a EVerInfoData exception formatted from given format string and
  arguments}
begin
  raise EVerInfoData.CreateFmt(FmtStr, Args);
end;

function TVerInfoData.FindChildByName(const Root: TVerInfoRec;
  const Name: string): TVerInfoRec;
  {Finds the first child record of the given 'root' record that has the given
  'name' (key) and returns a reference to it. If no such child record exists
  then nil is returned}
var
  ChildIdx: Integer;  // Index of child in parent's Children property
begin
  // Get index of child in parent's Children property (-1 on error)
  ChildIdx := IndexOfChildByName(Root, Name);
  // Now return reference to child object or nil if doesn't exist
  if ChildIdx > -1 then
    Result := Root.Children[ChildIdx]
  else
    Result := nil;
end;

function TVerInfoData.GetCharSet(TransIdx: Integer): Word;
  {Returns the character set of the translation at the given index: exception if
  index is out of range}
begin
  // Decode the translation value at given index to get just the char set
  DecodeTrans(InternalGetTranslation(TransIdx), Word(nil^), Result);
end;

function TVerInfoData.GetFixedFileInfo: TVSFixedFileInfo;
  {Returns the version information's fixed file information record}
var
  Ptr: ^TVSFixedFileInfo; // pointer to fixed file info record
begin
  Assert(Assigned(fVIRoot));
  // Fixed file info is stored as root record's value
  Ptr := fVIRoot.Value;
  if Ptr = nil then
  begin
    // we have no value, so return a zeroed FFI record, with correct signature
    FillChar(Result, SizeOf(Result), 0);
    StampFFI(Result);
  end
  else
    // copy date from record into result
    Result := Ptr^;
end;

function TVerInfoData.GetLanguageID(TransIdx: Integer): Word;
  {Returns the language id of the translation at the given index: exception if
  index is out of range}
begin
  // Decode the translation value at index  to get just the language id
  DecodeTrans(InternalGetTranslation(TransIdx), Result, Word(nil^));
end;

function TVerInfoData.GetStringCount(TableIdx: Integer): Integer;
  {Returns the number of string information items in the string table with the
  given index: exception if table index out of bounds}
var
  StrTable: TVerInfoRec;  // reference to require string table record
begin
  // Get reference to required string table record
  StrTable := GetStringFileInfoTable(TableIdx);
  Assert(Assigned(StrTable));
  // Return its number of children
  Result := StrTable.NumChildren;
end;

function TVerInfoData.GetStringFileInfoItem(TableIdx,
  StrIdx: Integer): TVerInfoRec;
  {Returns a reference to the ver info record that stores information about the
  string info at the given index in the given translations. Raises exception if
  table or string index are out of bounds}
var
  StrTable: TVerInfoRec;  // required string file info table
begin
  // Get string table: will raise exception if doesn't exist
  StrTable := GetStringFileInfoTable(TableIdx);
  Assert(Assigned(StrTable));
  // Check string item index in bounds
  if (StrIdx < 0) or (StrIdx >= StrTable.NumChildren) then
    Error(sStrIndexOutOfBounds, [StrIdx, TableIdx]);
  // We have required item: return reference to it
  Result := StrTable.Children[StrIdx]
end;

function TVerInfoData.GetStringFileInfoRoot: TVerInfoRec;
  {Returns reference to the 'StringFileInfo' record which must exist}
begin
  // The 'StringFileInfo' record is a child of the root record: must exist
  Result := FindChildByName(fVIRoot, cStringFileInfo);
  Assert(Assigned(Result));
end;

function TVerInfoData.GetStringFileInfoTable(
  TableIdx: Integer): TVerInfoRec;
  {Returns reference to the string file info table at the give index in the list
  of tables. Raises exception if string file info is out of range}
var
  StrRoot: TVerInfoRec; // root ver info record for all string file info
begin
  // Get root record for all string file info ('StringFileInfo'): must exist
  StrRoot := GetStringFileInfoRoot;
  // Check index in bounds
  if (TableIdx < 0) or (TableIdx >= StrRoot.NumChildren) then
    Error(sStrTableIndexOutOfBounds, [TableIdx]);
  // Return reference to required table record
  Result := StrRoot.Children[TableIdx]
end;

function TVerInfoData.GetStringName(TableIdx,
  StringIdx: Integer): string;
  {Returns the name of the string information item at the given index in the
  string table with the given table index: exception if either index is out of
  bounds}
var
  StrRec: TVerInfoRec;  // the ver info string record for the string
begin
  // Get the required ver info string record
  StrRec := GetStringFileInfoItem(TableIdx, StringIdx);
  Assert(Assigned(StrRec));
  // Return its name
  Result := StrRec.Name
end;

function TVerInfoData.GetStringTableCount: Integer;
  {Returns the number of string tables in the version information}
var
  StrRoot: TVerInfoRec; // root ver info record for all string file info
begin
  // Number of string info tables is number of children of string info root rec
  StrRoot := GetStringFileInfoRoot;
  Assert(Assigned(StrRoot));
  Result := StrRoot.NumChildren;
end;

function TVerInfoData.GetStringTableTransStr(TableIdx: Integer): string;
  {Returns the translation code string that identifies the string table at the
  given index: exception if the index is out of range}
var
  StrTable: TVerInfoRec;  // refers to string table's ver info record
begin
  // Translation string is key associated with string info table at given index
  StrTable := GetStringFileInfoTable(TableIdx);
  Assert(Assigned(StrTable));
  Result := StrTable.Name;
end;

function TVerInfoData.GetStringValue(TableIdx,
  StringIdx: Integer): string;
  {Returns the value of the string information item at the given index in the
  string table with the given table index: exception if either index is out of
  bounds}
var
  StrRec: TVerInfoRec;  // string item record referece
begin
  // Get reference to require string item
  StrRec := GetStringFileInfoItem(TableIdx, StringIdx);
  Assert(Assigned(StrRec));
  // Return its value
  Result := StrRec.GetStringValue;
end;

function TVerInfoData.GetTranslationCount: Integer;
  {Returns number of translations in the version information}
begin
  // Get count of translation from translation record (which must exist)
  Result := InternalGetTranslationCount(GetTranslationRec);
end;

function TVerInfoData.GetTranslationRec: TVerInfoRec;
  {Returns a reference to the ver info record that stores information about all
  supported translations - i.e. the 'Translation' record. This record must
  exist}
begin
  // Get translation root from with VarFileInfo: both these must exist
  Result := FindChildByName(GetVarFileInfoRoot, cTranslation);
  Assert(Assigned(Result));
end;

function TVerInfoData.GetTranslationString(TransIdx: Integer): string;
  {Returns the translation code string of the translation at the given index:
  exception if index is out of range}
var
  Language, CharSet: WORD;  // the language id and charset for the translation
begin
  // Get translation at given index and decode into language and char set
  DecodeTrans(InternalGetTranslation(TransIdx), Language, CharSet);
  // Get translation string for language and char set
  Result := TransToString(Language, CharSet);
end;

function TVerInfoData.GetVarFileInfoRoot: TVerInfoRec;
  {Returns reference to the 'VarFileInfo' record which must exist}
begin
  // The 'VarFileInfo' record is a child of the root record: must exist
  Result := FindChildByName(fVIRoot, cVarFileInfo);
  Assert(Assigned(Result));
end;

function TVerInfoData.IndexOfChildByName(const Root: TVerInfoRec;
  const Name: string): Integer;
  {Examines the list of child nodes of the given version info record and returns
  the index in the list of the the child record with the given name, or -1 if
  there is no such child record}
var
  Child: TVerInfoRec; // reference to each child record of root
  Idx: Integer;           // loops thru list of root's children
begin
  // Assume we don't find record
  Result := -1;
  // Scan all children, looking for required one
  for Idx := 0 to Pred(Root.NumChildren) do
  begin
    // Get reference to current child record
    Child := Root.Children[Idx];
    // Check if we have required name
    if AnsiCompareText(Name, Child.Name) = 0 then
    begin
      // Found it: record its index and stop
      Result := Idx;
      Break;
    end;
  end;
end;

function TVerInfoData.IndexOfString(TableIdx: Integer;
  const Name: string): Integer;
  {Returns the index of the the string info item with the given name in the
  string table at the given index: exception if string table index is out of
  bounds}
var
  StrTable: TVerInfoRec;  // reference to required string table
begin
  // Get reference to string table
  StrTable := Self.GetStringFileInfoTable(TableIdx);
  Assert(Assigned(StrTable));
  // Return index (if any) of child record with required name
  Result := IndexOfChildByName(StrTable, Name)
end;

function TVerInfoData.IndexOfStringTable(const TransStr: string): Integer;
  {Returns the index of the string table identified by the given translation
  code string, or -1 if there is no such table}
var
  StrRoot: TVerInfoRec; // root ver info record for all string file info
begin
  // Get reference to string table identified by translation string
  StrRoot := GetStringFileInfoRoot;
  Assert(Assigned(StrRoot));
  // Find index (if any) of child record with given name
  Result := IndexOfChildByName(StrRoot, TransStr)
end;

function TVerInfoData.IndexOfTranslation(LanguageID,
  CharSet: Word): Integer;
  {Returns the index of the translation with the given language id and character
  set in the list of translations. -1 is returned if there is no such
  translation}
var
  TransRec: TVerInfoRec;  // record that provides info about translations
  TransCode: DWORD;       // translation code for language and char set
  TransIdx: Integer;      // loops thru all translations
begin
  // Get reference to record that provides info about translations
  TransRec := GetTranslationRec;
  // Encode language id and char set into translation code we're looking for
  TransCode := EncodeTrans(0, LanguageID, CharSet);
  // Search for require value
  // assume failure
  Result := -1;
  // loop through all entries in translations array in record's value 'field'
  for TransIdx := 0 to Pred(TransRec.GetValueSize div SizeOf(DWORD)) do
  begin
    // test current array entry against required code
    if TDWORDArray(TransRec.Value^)[TransIdx] = TransCode then
    begin
      // found it: set true result and finish
      Result := TransIdx;
      Break;
    end;
  end;
end;

function TVerInfoData.InternalGetTranslation(TransIdx: Integer): DWORD;
  {Returns the translation code stored at index I in the list of translations.
  Raises exception if the index is out of bounds}
var
  TransRec: TVerInfoRec;  // Ver info record that stores translation info
begin
  // Get ver info record where translation info stored: this must exist
  TransRec := GetTranslationRec;
  Assert(Assigned(TransRec));
  // Check translation index is in bounds
  if (TransIdx < 0) or (TransIdx >= InternalGetTranslationCount(TransRec)) then
    Error(sTransIndexOutOfBounds, [TransIdx]);
  // Translation info is stored as a DWORD array in record's value field
  // return entry at given index in array
  Result := TDWORDArray(TransRec.Value^)[TransIdx];
end;

function TVerInfoData.InternalGetTranslationCount(
  TransRec: TVerInfoRec): Integer;
  {Returns the number of translations in the version information}
begin
  Assert(Assigned(TransRec));
  // Number of translations = number of elements in translation list stored in
  // value (each translation is stored as a DWORD)
  Result := TransRec.GetValueSize div SizeOf(DWORD);
end;

procedure TVerInfoData.InternalSetTranslation(TransIdx: Integer;
  Value: DWORD);
  {Sets the translation at the given index to the given value. An exception is
  raised if the index is out of bounds}
var
  TransRec: TVerInfoRec;  // 'Translation' record reference
begin
  // Get reference to 'Translation' record: stores info about all translations
  // in the value 'field' - there must be such a record
  TransRec := GetTranslationRec;
  Assert(TransRec <> nil);
  // Check translation index is in bounds
  if (TransIdx < 0) or (TransIdx >= InternalGetTranslationCount(TransRec)) then
    Error(sTransIndexOutOfBounds, [TransIdx]);
  // Set the required array element to the given value
  TDWORDArray(TransRec.Value^)[TransIdx] := Value;
end;

procedure TVerInfoData.ReadFromStream(const Stream: IStream);
  {Reads the binary representation of the version information from the given
  stream}
begin
  // Get root record to read itself from stream: this automatically reads the
  // whole tree of version info data
  fVIRoot.ReadFromStream(Stream);
  EnsureRequiredNodes;
end;

procedure TVerInfoData.Reset;
  {Resets the version information object to the default state: a root record
  with empty fixed file info, an empty string information sub tree and a
  variable file info subtree with an empty translation entry}
var
  FFI: TVSFixedFileInfo;  // fixed file info value record of root
begin
  // Clear object: deleting all children
  fVIRoot.Clear;
  // Add empty fixed file info to root node
  FillChar(FFI, SizeOf(FFI), 0);
  SetFixedFileInfo(FFI);
  // Make sure we have all required nodes
  EnsureRequiredNodes;
end;

procedure TVerInfoData.SetFixedFileInfo(const Value: TVSFixedFileInfo);
  {Sets the version information's ficed file information record to the given
  value, ensuring that the structure's version and signature are correct}
var
  FFI: TVSFixedFileInfo;  // copy of data to be written: we update this
begin
  Assert(Assigned(fVIRoot));
  // Record value: we update some field before writing
  FFI := Value;
  // Ensure we have correct version and signature
  StampFFI(FFI);
  // Fixed file info stored as root record's value: update it
  fVIRoot.SetBinaryValue(FFI, SizeOf(FFI));
end;

procedure TVerInfoData.SetStringValue(TableIdx, StringIdx: Integer;
  const Value: string);
  {Sets the string item at the given index in the string table at the given
  table index to the given value: exception if either index is out of bounds}
var
  StrRec: TVerInfoRec;     // string info record with given name
begin
  // Get reference to required string inof item
  StrRec := GetStringFileInfoItem(TableIdx, StringIdx);
  Assert(Assigned(StrRec));
  // Set its value
  StrRec.SetStringValue(Value);
end;

procedure TVerInfoData.SetTranslation(TransIdx: Integer; LanguageID,
  CharSet: Word);
  {Sets the translation at the given index to have the given language ID and
  character set. An exception is raised if the index is out of range}
begin
  InternalSetTranslation(TransIdx, EncodeTrans(0, LanguageID, CharSet));
end;

function TVerInfoData.VerInfoRecClass: TVerInfoRecClass;
  {Returns class of version info record object to be created}
begin
  case fVerResType of
    vrtAnsi: Result := TVerInfoRecA;
    vrtUnicode: Result := TVerInfoRecW;
    else  Result := nil;
  end;
  Assert(Result <> nil);
end;

procedure TVerInfoData.WriteToStream(const Stream: IStream);
  {Writes the binary representation of the version information to the given
  stream}
begin
  // Get the root record to write itself to stream: this automatically writes
  // all the tree of records
  fVIRoot.WriteToStream(Stream);
end;

end.
