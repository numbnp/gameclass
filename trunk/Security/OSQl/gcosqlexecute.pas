unit gcosqlexecute;

interface

uses
  ADODB;

const
  GCOSQL_COMMAND_TIMEOUT = 120;

function DecryptAndExecute(const AcnnMain: TADOConnection;
    const AstrSQPFileName: String): Boolean;
function Execute(const AcnnMain: TADOConnection;
    const AstrSQLFileName: String): Boolean;

function EncodeScript(const AstrSQLFileName, AstrSQPFileName: String): Boolean;
function UpdateCustomReport(const AcnnMain: TADOConnection;
    const AstrXMLFileName: String): Boolean;

function UpdateCustomReportOld(const AcnnMain: TADOConnection;
    const AstrXMLFileName: String): Boolean;

implementation

Uses
  Forms,
  SysUtils,
  Windows,
  uCoder,
  XMLDoc,
  xmldom,
  XMLIntf,
  StrUtils,
  GCConst,
  uSQLTools;

function DecryptAndExecute(const AcnnMain: TADOConnection;
    const AstrSQPFileName: String): Boolean;
var
  fScript: File;
  rs: String;
  Buffer: TLongCodeArray;
  Fcoder : TCoder;
  i,size8: longword;
  strAll: String;
begin
  Result := True;
  try
    AcnnMain.CommandTimeout := GCOSQL_COMMAND_TIMEOUT;
    strAll := '';
    Fcoder := TCoder.Create;
    AssignFile(fScript, AstrSQPFileName);
    Reset(fScript, 1);
    while not Eof(fScript) do
    begin
      BlockRead(fScript, size8, 4);
      SetLength(Buffer, size8);
      for i:=0 to High(Buffer) do
        BlockRead(fScript, Buffer[i], 4);
      // encode string
      FCoder.DeCode(Buffer,rs);
      FCoder._RemoveZeroBytes(rs);
      SetLength(Buffer,0);
      // ---------------------------------
      if rs <> '' then begin
        If UpperCase(Trim(rs)) = 'GO' then begin
          AcnnMain.Execute(strAll);
          strAll := '';
        end
        else
          strAll := strAll + rs + ' ' + Char(13)+ Char(10);
      end;
      // ----------------------------------
    end;
    CloseFile(fScript);
    Fcoder.Free;
  except
    on E: Exception do begin
      MessageBox(0,PChar(E.Message), PChar(E.HelpContext), MB_OK);
      Result := False;
    end;
  end;
end;

function Execute(const AcnnMain: TADOConnection;
    const AstrSQLFileName: String): Boolean;
var
  fScript: TextFile;
  rs: String;
  //Buffer: String[256];
  strAll: String;
begin
  Result := True;
  try
    AcnnMain.CommandTimeout := GCOSQL_COMMAND_TIMEOUT;
    strAll := '';
    AssignFile(fScript, AstrSQLFileName);
    Reset(fScript);
    while not Eof(fScript) do
    begin
      Readln(fScript,rs);
      if rs <> '' then begin
        If UpperCase(Trim(rs)) = 'GO' then begin
          AcnnMain.Execute(strAll);
          strAll := '';
        end
        else
          strAll := strAll + rs + ' ' + Char(13)+ Char(10);
      end;
      // ----------------------------------
    end;
    CloseFile(fScript);
    Result := True;
  except
    on E: Exception do begin
      MessageBox(0,PChar(E.Message), PChar(E.HelpContext), MB_OK);
      Result := False;
    end;
  end;
end;


function EncodeScript(const AstrSQLFileName, AstrSQPFileName: String): Boolean;
var
  fSQL: textfile;
  fSQP: file;
  rs: string;
  Buffer: TLongCodeArray;
  Fcoder : TCoder;
  i, size8: longword;
begin
  Result := True;
  try
    Fcoder := TCoder.Create;
    // read and encode source to dest
    AssignFile(fSQL, AstrSQLFileName);
    Reset(fSQL);
    AssignFile(fSQP, AstrSQPFileName);
    Rewrite(fSQP, 1);
      while not SeekEof(fSQL) do
    begin
      Readln(fSQL, rs);
      rs := AnsiReplaceText(rs, '/*WITH ENCRYPTION*/', 'WITH ENCRYPTION');
      // encode string
      FCoder.Code(rs,Buffer);
      size8 := Length(Buffer);
      // вначале пишем количество блоков longword'ов
      BlockWrite(fSQP, size8, 4);
      // потом пишем все longword'ы
      for i:=0 to High(Buffer) do
        BlockWrite(fSQP,Buffer[i],4);
      SetLength(Buffer,0);
    end;
    CloseFile(fSQP);
    CloseFile(fSQL);
    Fcoder.Free;
  except
    Result := False;
  end;
end;

function UpdateCustomReportOld(const AcnnMain: TADOConnection;
    const AstrXMLFileName: String): Boolean;
var
  XMLDocReport: TXMLDocument;
  NodeList: IXMLNodeList;
  i: Integer;
  str: String;
  strSQLCode: String;
begin
  Result := True;
  AcnnMain.CommandTimeout := 120;
  //cnnMain.ConnectionTimeout := 30;
  XMLDocReport := TXMLDocument.Create(Application);
  XMLDocReport.LoadFromFile(AstrXMLFileName);
    NodeList := XMLDocReport.DocumentElement.ChildNodes;
    for i:=0 to (NodeList.Count-1) do // begin
      with NodeList.Nodes[i] do begin
        str := 'delete from CustomReports WHERE [id]=N''' + Attributes['id']
            + '''';
        if not dsDoCommand(AcnnMain, str) then begin
          Result := False;
          Exit;
        end;
        strSQLCode := AnsiReplaceStr(Attributes['sqlcode'],#$A,#$D#$A);
        strSQLCode := AnsiReplaceText(strSQLCode,'''','''''');
        str := 'exec ' + DS_CUSTOMREPORTS_IMPORT + ' @id=''' + Attributes['id']
            + ''', @name='''+ Attributes['name'] + ''', @description='''
            + AnsiReplaceStr(Attributes['description'],#$A,#$D#$A)
            + ''', @sqlcode=''' + strSQLCode + ''', @tabindex='
            + IntToStr(Attributes['tabindex'])
            + ', @version=' + IntToStr(Attributes['version']);
        if not dsDoCommand(AcnnMain, str) then begin
          Result := False;
          Exit;
        end;
      end;
end;

function UpdateCustomReport(const AcnnMain: TADOConnection;
    const AstrXMLFileName: String): Boolean;
begin
end;

end.
