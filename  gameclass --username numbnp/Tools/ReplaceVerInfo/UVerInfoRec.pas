{ ##
  @FILE                     UVerInfoRec.pas
  @COMMENTS                 Defines classes that encapsulate general version
                            information records and exposes properties for the
                            key record elements. It can also read and write its
                            data from and to a stream. There are classes for
                            both 16 and 32 bit version information records.
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
      @DATE                 31/05/2003
      @COMMENTS             + Modified input method to be able to read wide
                              string values without using value length from
                              version info since this can't be relied upon to be
                              consistent.
                            + Set DataType to 0 in ANSI ReadHeader method (this
                              was missing).
    )
    @REVISION(
      @VERSION              1.2
      @DATE                 17/08/2003
      @COMMENTS             Modified input method to correct stream position to
                            deal with version info that has incorrect structure
                            and invalid wValueLength value. The main changes
                            were:
                            + to explicitly set stream position to start of
                              child records rather than assume correct number
                              of value bytes are read.
                            + to explicitly set stream position to end of record
                              (per wLength value in header rather than relying
                              on correct number of bytes to be read.
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
 * The Original Code is UVerInfoRec.pas
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


unit UVerInfoRec;


interface


uses
  // Delphi
  SysUtils, Classes, Windows, ActiveX,
  // Project
  UVerInfoBinIO;


type

  {
  TVerInfoRecClass:
    Class reference to TVerInfoRec and descendant classes.
  }
  TVerInfoRecClass = class of TVerInfoRec;

  {
  TVersInfoRec:
    Abstract base class for 16 and 32 bit version information record classes.
    Version information records are represented in binary format as a heirachy
    of variable length records. The structure of 16 and 32 bit version
    information records varies slightly, but has the following general
    structure:

    record
      wLength       // length of structure including any children (Word)
      wValueLength  // length of value member (0 if no value) (Word)
                    //   may be inconsistent for wide string types (i.e. it
                    //   may be either number of wide chars in string (+ #0#0)
                    //   or may be size of string in bytes - so don't rely on
                    //   this value when reading in wide string values)
      wType         // 32 bit records only:
                    //   type of value (1=>wide string, 0=>binary) (Word)
      szKey         // identifies record type
                    //  (32 bit records: zero terminated WChar array)
                    //  (16 bit records: zero terminated AnsiChar array)
      padding1      // array of bytes padding structure to DWORD boundary
      value         // optional value (type/structure depends on record type)
      padding2      // array of bytes padding structure to DWORD boundary
      children      // optional list of child version info structures
    end;

    This class encapsulates a general version information record and exposes
    properties for the key record elements. It can also read and write its data
    from and to a stream. It provides the functionality common to both 16 and 32
    bit versions of the records and declares abstract methods that specialised
    descendants override to account for the differences between versions.

    Inheritance: TVerInfoRec -> [TObject]
  }
  TVerInfoRec = class(TObject)
  private // properties
    fName: string;
    fDataType: Word;
    function GetChild(I: Integer): TVerInfoRec;
    function GetNumChildren: Integer;
    function GetValue: Pointer;
  private
    fList: TList;
      {Stores list of child record structures}
    fValueBuffer: PByte;
      {Buffer that stores the value associated with this record}
    fValueBufferSize: WORD;
      {Size of the value buffer}
    fParent: TVerInfoRec;
      {Pointer to version info record that is the parent of this one: nil if
      this is the root record}
  protected
    function ClassRef: TVerInfoRecClass; virtual; abstract;
      {Returns reference to the type of class this is (used to create child
      instances). Sub classes return their own classes when overriding}
    procedure SetDataType(AValue: Word);
      {Sets data type to given value: for use in descendant classes}
    procedure UnLink(const Child: TVerInfoRec);
      {Deletes the given child from the list of child objects}
    procedure AllocateValueBuffer(const Size: Integer);
      {Allocates a buffer of given size to hold a value. Deallocates any
      existing buffer first}
    procedure DeallocateValueBuffer;
      {Deallocates any existing value buffer}
    function ReadObject(const Reader: TVerInfoBinIO): Integer;
      {Reads the version information record object using the given reader and
      returns the number of bytes read}
    function WriteObject(const Writer: TVerInfoBinIO): Integer;
      {Writes the version information record object's binary data using the
      given writer and returns the number of bytes written}
    function ReadPadding(const Reader: TVerInfoBinIO;
      const BytesRead: Integer): Integer;
      {Reads any "padding" bytes necessary to round BytesRead up to a DWORD
      boundary. Returns the number of bytes read}
    function WritePadding(const Writer: TVerInfoBinIO;
      const BytesWritten: Integer): Integer;
      {Writes sufficent zero bytes to using given writer to pad given number of
      bytes written to a DWORD boundary. Returns number of bytes written}
    function ReadHeader(const Reader: TVerInfoBinIO;
      out RecSize, ValueSize, DataType: Word; out KeyName: string): Integer;
      virtual; abstract;
      {Reads the common header fields, and any padding characters, from any
      version info structure. Returns number of bytes read. Descendants must
      implement since header format varies between 16 and 32 bit}
    function WriteHeader(const Writer: TVerInfoBinIO;
      out RecSizePos: LongInt): Integer; virtual; abstract;
      {Writes the common header fields, and any padding characters, from any
      version info structure. The position where the record size is written is
      passed back in RecSizePos (the actual value is written later once size
      of record is known). Returns number of bytes written. Descendants must
      implement since header format varies between 16 and 32 bit}
  public
    constructor Create; overload;
      {Class constructor: create version info record with no parent (i.e. top
      level record)}
    constructor Create(const Parent: TVerInfoRec); overload;
      {Class constructor: creates version info record that has given parent}
    destructor Destroy; override;
      {Class destructor: frees any allocated buffer, all child objects and
      owned list object}
    procedure Clear;
      {Clears record, destroying all data and child records}
    function GetValueSize: Integer;
      {Returns size of value buffer}
    procedure SetBinaryValue(const Buffer; const Size: Integer);
      {Sets value buffer to given binary value - also sets data type to 0}
    procedure SetStringValue(const Str: string); virtual; abstract;
      {Sets value buffer to given string: descendants must set data type to 0 in
      16 bit (ansi strings) and 1 for 32 bit (wide strings)}
    function GetStringValue: string;
      {Gets the data from the value buffer as a string and returns it as a
      string. Internally this will be stored as either a ansi string or a wide
      string}
    procedure ReadFromStream(const Stream: IStream);
      {Reads a version info record structure, along with any child structures,
      from given stream}
    procedure WriteToStream(const Stream: IStream);
      {Writes encapsulated ver info record structure, along with any child
      record structures, to given stream}
    property Children[I: Integer]: TVerInfoRec read GetChild;
      {List of child version info record structures}
    property NumChildren: Integer read GetNumChildren;
      {Number of Children}
    property Name: string read fName write fName;
      {Name of this record}
    property Value: Pointer read GetValue;
      {Pointer to value associated with this record}
    property DataType: Word read fDataType;
      {Type of data associated with this record}
  end;

  {
  TVerInfoRecA:
    Implements a generalised ANSI version information record. Simply provides
    implementations for abstract methods of base class.

    Inheritance: TVerInfoRecA -> TVerInfoRec -> [TObject]
  }
  TVerInfoRecA = class(TVerInfoRec)
  protected
    function ClassRef: TVerInfoRecClass; override;
      {Returns reference to the type of this class (used to create child
      instances)}
    function ReadHeader(const Reader: TVerInfoBinIO;
      out RecSize, ValueSize, DataType: Word; out KeyName: string): Integer;
      override;
      {Reads the common header fields, and any padding characters, from any
      version info structure. Returns number of bytes read}
    function WriteHeader(const Writer: TVerInfoBinIO;
      out RecSizePos: LongInt): Integer; override;
      {Writes the common header fields, and any padding characters, from any
      version info structure. The position where the record size is written is
      passed back in RecSizePos (the actual value is written later once size
      of record is known). Returns number of bytes written}
  public
    procedure SetStringValue(const Str: string); override;
      {Sets value buffer to given string - also sets data type to 0}
  end;

  {
  TVerInfoRecW:
    Implements a generalised Unicode version information record. Simply provides
    implementations for abstract methods of base class.

    Inheritance: TVerInfoRecW -> TVerInfoRec -> [TObject]
  }
  TVerInfoRecW = class(TVerInfoRec)
  protected
    function ClassRef: TVerInfoRecClass; override;
      {Returns reference to the type of this class (used to create child
      instances)}
    function ReadHeader(const Reader: TVerInfoBinIO;
      out RecSize, ValueSize, DataType: Word; out KeyName: string): Integer;
      override;
      {Reads the common header fields, and any padding characters, from any
      version info structure. Returns number of bytes read}
    function WriteHeader(const Writer: TVerInfoBinIO;
      out RecSizePos: LongInt): Integer; override;
      {Writes the common header fields, and any padding characters, from any
      version info structure. The position where the record size is written is
      passed back in RecSizePos (the actual value is written later once size
      of record is known). Returns number of bytes written}
  public
    procedure SetStringValue(const Str: string); override;
      {Sets value buffer to given string - also sets data type to 1}
  end;

  {
  EVerInfoRec:
    Class of exception raised by TVersionInfoRec16 objects.

    Inheritance: EVerInfoRec -> [Exception] -> [TObject]
  }
  EVerInfoRec = class(Exception);

implementation

resourcestring
  // Error messages
  sNoVerInfo = 'No version information present.';
  sVerInfoCorrupt = 'Version information data is corrupt.';

{ Support routine }

function PaddingRequired(const ANum, PadTo: Integer): Integer;
  {Returns number of bytes padding required to increase ANum to a multiple of
  PadTo}
begin
  if ANum mod PadTo = 0 then
    Result := 0
  else
    Result := PadTo - ANum mod PadTo;
end;

{ TVerInfoRec }

procedure TVerInfoRec.AllocateValueBuffer(const Size: Integer);
  {Allocates a buffer of given size to hold a value. Deallocates any existing
  buffer first}
begin
  DeallocateValueBuffer;
  fValueBufferSize := Size;
  GetMem(fValueBuffer, fValueBufferSize);
end;

procedure TVerInfoRec.Clear;
  {Clears record, destroying all data and child records}
var
  I: Integer; // loops thru all child objects
begin
  // Free any currently allocated value buffer
  DeallocateValueBuffer;
  // Free all child objects
  for I := fList.Count - 1 downto 0 do
    GetChild(I).Free;
  Assert(fList.Count = 0);  // should all have unlinked themselves
  // Reset other fields - leave name field unchanged
  SetDataType(0);
end;

constructor TVerInfoRec.Create;
  {Class constructor: create version info record with no parent (i.e. top level
  record)}
begin
  // Simply create with nil owner
  Create(nil);
end;

constructor TVerInfoRec.Create(const Parent: TVerInfoRec);
  {Class constructor: creates version info record that has given parent}
begin
  inherited Create;
  // Create list to store child records
  fList := TList.Create;
  // Record parent, and add self into any parent's list of children
  fParent := Parent;
  if fParent <> nil then
    fParent.fList.Add(Self);
  // Clear this new record to default values
  Clear;
end;

procedure TVerInfoRec.DeallocateValueBuffer;
  {Deallocates any existing value buffer}
begin
  if fValueBufferSize > 0 then
  begin
    FreeMem(fValueBuffer, fValueBufferSize);
    fValueBufferSize := 0;
  end;
end;

destructor TVerInfoRec.Destroy;
  {Class destructor: frees any allocated buffer, all child objects and owned
  list object}
begin
  // Get rid of owned objects
  Clear;
  // Free owned list
  fList.Free;
  // Unlink from parent's list
  if fParent <> nil then
    fParent.Unlink(Self);
  inherited Destroy;
end;

function TVerInfoRec.GetChild(I: Integer): TVerInfoRec;
  {Read access method for Children property}
begin
  Result := TVerInfoRec(fList[I]);
end;

function TVerInfoRec.GetNumChildren: Integer;
  {Read access method for NumChildren property}
begin
  Result := fList.Count;
end;

function TVerInfoRec.GetStringValue: string;
  {Gets the data from the value buffer as a string and returns it as a string.
  Internally this will be stored as either a ansi string or a wide string}
var
  ValuePtr: Pointer;  // points to buffer containing string value
begin
  // Get pointer to value buffer (has value nil if there is no value buffer)
  ValuePtr := GetValue;
  if Assigned(ValuePtr) then
  begin
    // Value buffer exists: read either a string or wide string per data type
    if fDataType = 0 then
      Result := PChar(ValuePtr)
    else
      Result := WideCharToString(PWideChar(ValuePtr));
  end
  else
    // No value buffer: return empty string
    Result := '';
end;

function TVerInfoRec.GetValue: Pointer;
  {Read access method for Value property}
begin
  if fValueBufferSize = 0 then
    // There is no value, return nil
    Result := nil
  else
    // There is a value, return a pointer to it
    Result := fValueBuffer;
end;

function TVerInfoRec.GetValueSize: Integer;
  {Returns size of value buffer}
begin
  Result := fValueBufferSize;
end;

procedure TVerInfoRec.ReadFromStream(const Stream: IStream);
  {Reads a version info record structure, along with any child structures, from
  given stream}
var
  Reader: TVerInfoBinIO;  // reader used to do actual reading from stream
begin
  // Use a reader object to read from stream
  Reader := TVerInfoBinIO.Create(Stream);
  try
    // Get object to read itself using reader
    ReadObject(Reader);
  finally
    Reader.Free;
  end;
end;

function TVerInfoRec.ReadObject(const Reader: TVerInfoBinIO): Integer;
  {Reads the version information record object using the given reader and
  returns the number of bytes read}
var
  wLength, wValueLength: WORD;  // length of strucure and Value member
  Child: TVerInfoRec;           // reference to child record objects
  WC: WideChar;                 // wide character read from value string
  WValue: WideString;           // wide string to hold wide string value
  WVIdx: Integer;               // index into wide string buffer
  StartPos: Integer;            // stream position of start of record
  HeaderSize: Integer;          // size of header inc padding
  ValueSize: Integer;           // size of value adjusted for WChare exc padding
  ChildrenOffset: Integer;      // offset of start of any child records
  ChildrenSize: Integer;        // total size of all child records
  ChildrenBytesRead: Integer;   // number of bytes read from child data
begin
  // Check there's something to read
  if Reader.GetSize = 0 then
    raise EVerInfoRec.Create(sNoVerInfo);
  try
    // Clear the existing contents
    Clear;
    // Record position of start of record in stream
    StartPos := Reader.GetPosition;
    // Read header: i.e. record size, value length, data type  & key name
    HeaderSize := ReadHeader(Reader, wLength, wValueLength, fDataType, fName);
    // Calculate size of value (adjust for WChars if data type = 1)
    if fDataType = 0 then
      ValueSize := wValueLength
    else
      ValueSize := SizeOf(WChar) * wValueLength;
    // Calculate offset of any child records and total size of the records
    ChildrenOffset := HeaderSize + ValueSize
      + PaddingRequired(ValueSize, SizeOf(DWORD));
    ChildrenSize := wLength - ChildrenOffset;
    // Check if we need to read in a value
    if wValueLength > 0 then
    begin
      // We are reading in a value - method we use depends on type of data
      if fDataType = 0 then
      begin
        // We are reading in ansi data - simply read number of bytes per
        //   wValueLength
        //
        // this code assumes that bytes and ansi chars have size 1
        Assert(SizeOf(Byte) = 1);
        Assert(SizeOf(AnsiChar) = 1);
        // we're reading a value - allocate required buffer size
        AllocateValueBuffer(wValueLength);    // binary bytes or ansi char value
        // read in the buffer and count the bytes
        Reader.ReadBuffer(fValueBuffer^, fValueBufferSize);
      end
      else
      begin
        // We are reading in wide char data. We can't rely on wValueLength to
        //   tell us amount of data to read since some ver info compilers set
        //   this value to length of string and some to size of buffer (i.e.
        //   length of string * SizeOf(WideChar) and some even pad with rubbish
        //   characters following end of string #0#0 to the (wrong) size of the
        //   value (e.g. Wise installer files)!!
        // So we create a wide string of sufficient size to hold value and read
        //   each wide character into it until terminating #0#0 is read. We then
        //   store this string in value buffer. This method (rather than direct
        //   read into buffer) creates a buffer of correct size to store value,
        //   thereby ensuring that correct value length is written when data is
        //   output, regardless of wValueLength.
        //
        // create wide string of sufficent size (may be either correct size or
        //   twice size required depending on meaning of wValueLength)
        SetLength(WValue, wValueLength);
        // read in wide string up to and including terminating #0#0
        // .. initialise index into wide string
        WVIdx := 1;
        repeat
          // .. read a single char and record in string
          Reader.ReadBuffer(WC, SizeOf(WideChar));
          WValue[WVIdx] := WC;
          // .. move up string and count bytes read
          Inc(WVIdx);
        until Ord(WC) = 0;
        // .. set string to actual length
        SetLength(WValue, WVIdx);
        // .. store string in value buffer (ensures buffer of correct size)
        SetStringValue(WValue);
      end;
    end;
    // Now read in any Children records
    if ChildrenSize > 0 then
    begin
      // initialise: no bytes read and set stream pointer to start of child data
      ChildrenBytesRead := 0;
      Reader.Seek(StartPos + ChildrenOffset, STREAM_SEEK_SET);
      // loop while there are still bytes to be read from child data
      while ChildrenBytesRead < ChildrenSize do
      begin
        // create next child and add to list
        Child := ClassRef.Create(Self);
        // get child to read itself, counting bytes read
        ChildrenBytesRead := ChildrenBytesRead + Child.ReadObject(Reader);
      end;
    end;
    // Seek to start of next record (if any) and return bytes read
    Result := wLength + PaddingRequired(wLength, SizeOf(DWORD));
    Reader.Seek(StartPos + Result, STREAM_SEEK_SET);
  except
    // Convert any stream errors into a version info record corrupt exception
    on E: EStreamError do
      raise EVerInfoRec.Create(sVerInfoCorrupt);
    on E: Exception do
      raise;
  end;
end;

function TVerInfoRec.ReadPadding(const Reader: TVerInfoBinIO;
  const BytesRead: Integer): Integer;
  {Reads any "padding" bytes necessary to round BytesRead up to a DWORD
  boundary. Returns the number of bytes read}
var
  PadBuf: array[0..SizeOf(DWORD)-1] of Byte;    // buffer to read padding into
begin
  // Find padding required
  Result := PaddingRequired(BytesRead, SizeOf(DWORD));
  if Result > 0 then
    // Some padding required: read and discard it
    Reader.ReadBuffer(PadBuf, Result);
end;

procedure TVerInfoRec.SetBinaryValue(const Buffer; const Size: Integer);
  {Sets value buffer to given binary value - also sets data type to 0}
begin
  // Allocate value buffer of required size and copy the given data buffer to it
  AllocateValueBuffer(Size);
  Move(Buffer, fValueBuffer^, Size);
  // Data type is 0
  SetDataType(0);
end;

procedure TVerInfoRec.SetDataType(AValue: Word);
  {Sets data type to given value: for use in descendant classes}
begin
  fDataType := AValue;
end;

procedure TVerInfoRec.UnLink(const Child: TVerInfoRec);
  {Deletes the given child from the list of child objects}
var
  Index: Integer; // index of child in list of children
begin
  // Find index of child in list of children: it must be in list
  Index := fList.IndexOf(Child);
  Assert(Index <> -1);
  // Delete the list entry for the child
  fList.Delete(Index);
end;

function TVerInfoRec.WriteObject(const Writer: TVerInfoBinIO): Integer;
  {Writes the version information record object's binary data using the given
  writer and returns the number of bytes written}
var
  RecSize: WORD;            // size of header section of record
  I: Integer;               // loops thru children
  RecSizePos: LongInt;      // marks position of record size field in stream
  ValuePadding: WORD;       // bytes needed to pad Value to DWORD boundary
begin
  // Write header with dummy record size field, record position of this field
  Result := WriteHeader(Writer, RecSizePos);
  // Write out any value
  if fValueBufferSize > 0 then
  begin
    // write out the data
    Writer.WriteBuffer(fValueBuffer^, fValueBufferSize);
    Inc(Result, fValueBufferSize);
    // pad out value to DWORD boundary, recording how many byes written
    ValuePadding := WritePadding(Writer, Result);
    Result := Result + ValuePadding;
  end
  else
    // no value => no padding
    ValuePadding := 0;
  // Write out any children, recording bytes written
  for I := 0 to NumChildren - 1 do
    Result := Result + Children[I].WriteObject(Writer);
  // Now update record size
  // record size is number of bytes written less any padding after value
  RecSize := Result - ValuePadding;
  // rewind stream
  Writer.Seek(RecSizePos, STREAM_SEEK_SET);
  // write new value
  Writer.WriteBuffer(RecSize, SizeOf(RecSize));
  // go back to end of stream
  Writer.Seek(0, STREAM_SEEK_END);
end;

function TVerInfoRec.WritePadding(const Writer: TVerInfoBinIO;
  const BytesWritten: Integer): Integer;
  {Writes sufficent zero bytes to using given writer to pad given number of
  bytes written to a DWORD boundary. Returns number of bytes written}
var
  PadBuf: array[0..SizeOf(DWORD)-1] of Byte;    // buffer holding padding bytes
begin
  // Find padding required
  Result := PaddingRequired(BytesWritten, SizeOf(DWORD));
  if Result > 0 then
  begin
    // Some padding is required - output required no of zero bytes
    FillChar(PadBuf, Result, #0);
    Writer.WriteBuffer(PadBuf, Result);
  end;
end;

procedure TVerInfoRec.WriteToStream(const Stream: IStream);
  {Writes encapsulated ver info record structure, along with any child record
  structures, to given stream}
var
  Writer: TVerInfoBinIO;  // writer object used to write to stream
begin
  // We use a writer object to perform actual writing to stream
  Writer := TVerInfoBinIO.Create(Stream);
  try
    // Get object to write itself using writer object
    WriteObject(Writer);
  finally
    Writer.Free;
  end;
end;

{ TVerInfoRecA }

function TVerInfoRecA.ClassRef: TVerInfoRecClass;
  {Returns reference to the type of this class (used to create child instances)}
begin
  Result := TVerInfoRecA;
end;

function TVerInfoRecA.ReadHeader(const Reader: TVerInfoBinIO; out RecSize,
  ValueSize, DataType: Word; out KeyName: string): Integer;
  {Reads the common header fields, and any padding characters, from any version
  info structure. Returns number of bytes read}
var
  KeyChar: AnsiChar;  // character in key name
begin
  // Read first three word values
  Reader.ReadBuffer(RecSize, SizeOf(Word));
  Reader.ReadBuffer(ValueSize, SizeOf(Word));
  DataType := 0;
  Result := 2 * SizeOf(Word);
  // Read key name
  KeyName := '';
  repeat
    Reader.ReadBuffer(KeyChar, SizeOf(AnsiChar));
    Inc(Result, SizeOf(AnsiChar));
    if KeyChar <> #0 then
      KeyName := KeyName + KeyChar;
  until KeyChar = #0;
  // Skip any padding to DWORD boundary
  Result := Result + ReadPadding(Reader, Result);
end;

procedure TVerInfoRecA.SetStringValue(const Str: string);
  {Sets value buffer to given string - also sets data type to 0}
var
  BufLen: Integer;  // required value buffer size
begin
  // Allocate value buffer of required size
  BufLen := SizeOf(AnsiChar) * (Length(Str) + 1);
  AllocateValueBuffer(BufLen);
  // Store given string as a wide string in buffer
  Move(PChar(Str)^, fValueBuffer^, BufLen);
  // Data type is always 0
  SetDataType(0);
end;

function TVerInfoRecA.WriteHeader(const Writer: TVerInfoBinIO;
  out RecSizePos: Integer): Integer;
  {Writes the common header fields, and any padding characters, from any version
  info structure. The position where the record size is written is passed back
  in RecSizePos (the actual value is written later once size of record is
  known). Returns number of bytes written}
var
  RecSize: Word;    // dummy value for record: written as a placeholder
  ValueSize: Word;  // size of value buffer as a Word value
  Key: AnsiString;  // the key to be written out as ansi string
begin
  // Don't know record size yet - mark place & write dummy value to come back to
  RecSize := 0;                                       // dummy record size value
  RecSizePos := Writer.GetPosition;              // gets current stream position
  Writer.WriteBuffer(RecSize, SizeOf(Word));               // writes dummy value
  // Write size of value data
  ValueSize := GetValueSize;
  Writer.WriteBuffer(ValueSize, SizeOf(Word));
  // Record number of bytes written
  Result := 2 * SizeOf(Word);
  // write key as zero term ansi string (assumes ansi char has length 1)
  Assert(SizeOf(AnsiChar) = 1);
  Key := Name;
  Writer.WriteBuffer(PChar(Key)^, Length(Key) + 1);
  Inc(Result, Length(Key) + 1);
  // pad key out to DWORD boundary
  Result := Result + WritePadding(Writer, Result);
end;

{ TVerInfoRecW }

function TVerInfoRecW.ClassRef: TVerInfoRecClass;
  {Returns reference to the type of this class (used to create child instances)}
begin
  Result := TVerInfoRecW;
end;

function TVerInfoRecW.ReadHeader(const Reader: TVerInfoBinIO; out RecSize,
  ValueSize, DataType: Word; out KeyName: string): Integer;
  {Reads the common header fields, and any padding characters, from any version
  info structure. Returns number of bytes read}
var
  KeyChar: WideChar;  // character in key name
begin
  // Read first three word values
  Reader.ReadBuffer(RecSize, SizeOf(RecSize));
  Reader.ReadBuffer(ValueSize, SizeOf(ValueSize));
  Reader.ReadBuffer(DataType, SizeOf(DataType));
  Result := 3 * SizeOf(Word);
  // Read key name
  KeyName := '';
  repeat
    Reader.ReadBuffer(KeyChar, SizeOf(WChar));
    Inc(Result, SizeOf(KeyChar));
    if KeyChar <> #0 then
      KeyName := KeyName + WideCharLenToString(@KeyChar, 1);
  until KeyChar = #0;
  // Skip any padding to DWORD boundary
  Result := Result + ReadPadding(Reader, Result);
end;

procedure TVerInfoRecW.SetStringValue(const Str: string);
  {Sets value buffer to given string - also sets data type to 1}
var
  BufLen: Integer;  // required value buffer size
begin
  // Allocate value buffer of required size
  BufLen := SizeOf(WideChar) * (Length(Str) + 1);
  AllocateValueBuffer(BufLen);
  // Store given string as a wide string in buffer
  StringToWideChar(Str, PWideChar(fValueBuffer), Length(Str) + 1);
  // Data type is 1
  SetDataType(1);
end;

function TVerInfoRecW.WriteHeader(const Writer: TVerInfoBinIO;
  out RecSizePos: Integer): Integer;
  {Writes the common header fields, and any padding characters, from any version
  info structure. The position where the record size is written is passed back
  in RecSizePos (the actual value is written later once size of record is
  known). Returns number of bytes written}
var
  RecSize: Word;            // dummy record size: this is actually written later
  ValueSize: Word;          // size of value data
  UnicodeBufSize: Integer;  // size of buffer to store key as wide string
  UnicodeBuf: PWideChar;    // buffer to store key as wide string
  Key: string;              // name of key as string
  DataTypeVal: Word;        // value used to write data type as word
begin
  // Don't know record size yet - mark place & write dummy value to come back to
  RecSize := 0;                                       // dummy record size value
  RecSizePos := Writer.GetPosition;              // gets current stream position
  Writer.WriteBuffer(RecSize, SizeOf(Word));               // writes dummy value
  // Write size of value data
  if DataType = 0 then
    ValueSize := GetValueSize                          // number of bytes in buf
  else
    ValueSize := GetValueSize div SizeOf(WChar);      // number of wchars in buf
  Writer.WriteBuffer(ValueSize, SizeOf(Word));
  // Write record data type
  DataTypeVal := DataType;
  Writer.WriteBuffer(DataTypeVal, SizeOf(Word));
  // Record number of bytes written
  Result := 3 * SizeOf(Word);
  // Write key as Unicode
  Key := Name;
  UnicodeBufSize := SizeOf(WideChar) * (Length(Key) + 1);
  GetMem(UnicodeBuf, UnicodeBufSize);
  try
    StringToWideChar(Key, UnicodeBuf, (Length(Key) + 1));
    Writer.WriteBuffer(UnicodeBuf^, UnicodeBufSize);
    Inc(Result, UnicodeBufSize);
  finally
    FreeMem(UnicodeBuf, UnicodeBufSize);
  end;
  // pad key out to DWORD boundary
  Result := Result + WritePadding(Writer, Result);
end;

end.
