unit gcutils;

interface

uses
  ADODB, Classes, Variants,Windows;

type
  ConnAttr = record
    ScriptType: string;
    ScriptFile: string;
    Login: string;
    Pass: string;
    Target: string;
    // encode, decode
    sourcepath: string;
    destpath: string;
  end;

  PTADODataSet = ^TADODataSet;

function CheckAndConnecting(var AbGCBaseExist:Boolean; var AstrGCBaseVersion: String): Boolean;
//procedure ParseDBConfigFile(AbCreateBase : Boolean);
function IsNull(Parameter: OleVariant; Replacement: OleVariant): OleVariant;
function GetBaseVersion: string;

var
  mode: string;
  Conn: ConnAttr;
  dbVer: string;
  cnnMain: TADOConnection;
  GstrCompName: array [0..MAX_COMPUTERNAME_LENGTH] of char;

implementation

uses
  Forms,
  SysUtils,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc,
  ufrmMain,
  ufrmLogon,
  Controls,
  gcosqlexecute;

procedure dsDoQuery(str: string; pdts: PTADODataSet);
begin
//  try
    if (cnnMain.Connected) then
    begin
      pdts^.Connection := cnnMain;
      pdts^.LockType := ltOptimistic;
      pdts^.CursorLocation := clUseClient;
      pdts^.CursorType := ctStatic;
      pdts^.CommandText := str;
      pdts^.ParamCheck := false;
      pdts^.Open;
    end;
//  except
    // сперва остановим таймер, чтобы бардака не было
//  end;
end;

function GetBaseVersion: string;
var
  dts: TADODataSet;
begin
  GetBaseVersion := 'emptybaseversion';
  dts := TADODataSet.Create(nil);
  try
    cnnMain.Execute('use Gameclass');
    dsDoQuery('select * from Registry where [key]=''BaseVersion''', @dts);
    if (dts.Recordset.RecordCount > 0) then
      GetBaseVersion := dts.Recordset.Fields.Item['Value'].Value;
    dts.Close;
    dts.Destroy;
  except
  end;
end;

// функция пытается подключиться к sql-серверу, и определить номер версии базы

function CheckAndConnecting(var AbGCBaseExist:Boolean; var AstrGCBaseVersion: String): Boolean;
var
  Mess: string;
begin
  try
    CheckAndConnecting := False;
    AbGCBaseExist := False;
    if (cnnMain <> nil) then cnnMain.Destroy;
    cnnMain := TADOConnection.Create(nil);
    cnnMain.CommandTimeout := 30;
    cnnMain.ConnectionTimeout := 30;
    cnnMain.ConnectOptions := coConnectUnspecified;
    cnnMain.CursorLocation := clUseClient;
    cnnMain.IsolationLevel := ilUnspecified;
    cnnMain.KeepConnection := True;
    cnnMain.LoginPrompt := false;
    cnnMain.Mode := cmReadWrite;
    cnnMain.Provider := 'SQLOLEDB.1';
    cnnMain.ConnectionString := 'Provider=SQLOLEDB.1;' +
      'Persist Security Info=True;' +
      'User ID=' + Conn.Login + ';' +
   //   'Initial Catalog=GameClass;' +
      'Data Source =' + Conn.Target + ';' +
      'Password=' + Conn.Pass;
    cnnMain.Open;
    cnnMain.Execute('set dateformat ymd');
    CheckAndConnecting := True;
    // get base version...
    AstrGCBaseVersion := GetBaseVersion;
    if (AstrGCBaseVersion<>'emptybaseversion') then
      AbGCBaseExist := True;
    exit;
  except
    if cnnMain.Errors.Count>0 then begin
        Mess := 'Error='+ IntToStr(cnnMain.Errors[0].Number)+Chr(13)+
        'Source='+cnnMain.Errors[0].Source+Chr(13)+
        'Description=' + cnnMain.Errors[0].Description;
//        MessageBox(0,PChar(Mess),'Error connecting to SQL-Server!',MB_OK);
        Application.MessageBox(PChar(Mess),'Error connecting to SQL-Server!',MB_OK);
    end; // cnnMain.Errors.Count>0
  end; // try
end;


function IsNull(Parameter: OleVariant; Replacement: OleVariant): OleVariant;
begin
  IsNull := Replacement;
  if not VarIsNull(Parameter) then
    IsNull := Parameter;
end;

end.










