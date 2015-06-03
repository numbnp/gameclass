{Драйвер для компонентов Unified InterBase                                                                }
{TUIBDataDriverEh is a data driver for firebird/interbase data acces components "Unified InterBase" (UIB) }
{                                                                                                         }
{ UIB download: http://sourceforge.net/projects/uib/files/                                                }
{ UIB SVN: https://uib.svn.sourceforge.net/svnroot/uib                                                    }
{                                                                                                         }
{ Bug reports and requests for changes send to olegenty@gmail.com                                         }
unit UIBDataDriverEh;

interface

uses
      Windows
    , SysUtils
    , Classes
    , Controls
    , DB
    , Variants
    , Contnrs
    , ToolCtrlsEh
    , DBCommon
    , MemTableDataEh
    , DataDriverEh
    , uib
    , uibdataset
    , uiblib
    , Dialogs
    ;

type

TUIBDataDriverEh = class;

// UIBCommandEh
TUIBCommandEh = class(TBaseSQLCommandEh)
private
    Transaction_          : TUIBTransaction;
    ManualTransaction_    : boolean;

    function GetDataDriver: TUIBDataDriverEh;

    procedure SetManualTransaction(
        _ManualTransaction: boolean
        );

public
    function Execute(
          var _Cursor: TDataSet
        ; var _FreeOnEof: Boolean
        ): integer; override;

    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;

    constructor Create(_DataDriver: TUIBDataDriverEh); virtual;

    function Transaction: TUIBTransaction;

    property DataDriver: TUIBDataDriverEh read GetDataDriver;
published
    property Params;
    //property ParamCheck;
    property CommandText;
    property CommandType;
    property ManualTransaction: boolean read ManualTransaction_ write SetManualTransaction;
end;

// TUIBDataDriverEh
TUIBDataDriverEh = class(TBaseSQLDataDriverEh)
private

    Database_               : TUIBDataBase;
    ReadTransactionParams_  : TTransParams;
    WriteTransactionParams_ : TTransParams;

    procedure SetDatabase
    (_Database: TUIBDataBase);

    protected
    function CreateDeleteCommand: TCustomSQLCommandEh; override;
    function CreateInsertCommand: TCustomSQLCommandEh; override;
    function CreateSelectCommand: TCustomSQLCommandEh; override;
    function CreateGetrecCommand: TCustomSQLCommandEh; override;
    function CreateUpdateCommand: TCustomSQLCommandEh; override;

    procedure SetAutoIncFields(
          _Fields: TFields
        ; _DataStruct: TMTDataStructEh
        ); override;

public
    constructor Create(_Owner: TComponent); override;

    function CreateDesignCopy: TCustomSQLDataDriverEh; override;

    procedure GetBackUpdatedValues(
          _MemRec: TMemoryRecordEh
        ; _Command: TCustomSQLCommandEh
        ; _ResDataSet: TDataSet
        ); override;

    procedure DoServerSpecOperations(
          _MemRec: TMemoryRecordEh
        ; _Command: TCustomSQLCommandEh
        ; _ResDataSet: TDataSet); virtual;
published
    property Database: TUIBDataBase read Database_ write SetDatabase;

    property SelectCommand;
    property UpdateCommand;
    property InsertCommand;
    property DeleteCommand;
    property GetrecCommand;

    property ReadTransParams: TTransParams  read ReadTransactionParams_ write ReadTransactionParams_;
    property WriteTransParams: TTransParams  read WriteTransactionParams_ write WriteTransactionParams_;

    property SelectSQL;
    property UpdateSQL;
    property InsertSQL;
    property DeleteSQL;
    property GetrecSQL;
    property ProviderDataSet;
    property KeyFields;
    property SpecParams;

    property OnExecuteCommand;
    property OnBuildDataStruct;
    property OnGetBackUpdatedValues;
    property OnProduceDataReader;
    property OnAssignFieldValue;
    property OnReadRecord;
    property OnRefreshRecord;
    property OnUpdateRecord;
    property OnAssignCommandParam;
    property OnUpdateError;
end;

function DefaultExecuteUIBCommand(
      _DataDriver   : TUIBDataDriverEh
    ; _Command      : TUIBCommandEh
    ; var _Cursor   : TDataSet
    ; var _FreeOnEof: boolean
    ; var _Processed: boolean
   ): integer;

procedure Register;

implementation

///////////////////////////////////////////////////////////////////////////////
//
procedure Params2UIBQuery(
  _Params: TParams
; _Query : TUIBQuery
);
var ParamCount: integer;
var i         : integer;
var Param     : TParam;
begin
    ParamCount := _Params.Count;
    for i := 0 to ParamCount - 1 do begin
        Param := _Params[i];
        if    (ftBlob = Param.DataType)
           or (ftMemo = Param.DataType)
        then begin
            _Query.ParamsSetBlob(Param.Name, Param.AsStream);
        end else begin
            _Query.Params.ByNameAsVariant[Param.Name] := Param.Value;
        end;
    end;
end;

///////////////////////////////////////////////////////////////////////////////
//
procedure Params2UIBCursor(
  _Params: TParams
; _Cursor: TUIBDataSet
);
var ParamCount: integer;
var i         : integer;
var Param     : TParam;
begin
    ParamCount := _Params.Count;
    for i := 0 to ParamCount - 1 do begin
        Param := _Params[i];
        if    (ftBlob = Param.DataType)
           or (ftMemo = Param.DataType)
        then begin
            _Cursor.ParamsSetBlob(Param.Name, Param.AsStream);
        end else begin
            _Cursor.Params.ByNameAsVariant[Param.Name] := Param.Value;
        end;
    end;
end;

///////////////////////////////////////////////////////////////////////////////
//
procedure UIBQuery2Params(
  _Query : TUIBQuery
; _Params: TParams
);
var ParamCount: integer;
var i         : integer      ;
var Param     : TParam       ;
var Stream    : TMemoryStream;
begin
    ParamCount := _Query.Params.ParamCount;
    for i := 0 to ParamCount - 1 do begin
        if _Query.Params.IsBlob[i] then begin
            try
                Stream := TMemoryStream.Create;
                _Query.ReadBlob(i, Stream);
                Param := _Params.ParamByName(_Query.Params.FieldName[i]);
                Param.LoadFromStream(Stream, Param.DataType);
            finally
                FreeAndNil(Stream);
            end;
        end else begin
            _Params.ParamByName(_Query.Params.FieldName[i]).Value := _Query.Params.AsVariant[i];
        end;
    end;
end;

///////////////////////////////////////////////////////////////////////////////
//
procedure UIBCursor2Params(
  _Cursor: TUIBDataSet
; _Params: TParams
);
var ParamCount: integer;
var i         : integer      ;
var Param     : TParam       ;
var Stream    : TMemoryStream;
begin
    ParamCount := _Cursor.Params.ParamCount;
    for i := 0 to ParamCount - 1 do begin
        if _Cursor.Params.IsBlob[i] then begin
            try
                Stream := TMemoryStream.Create;
                _Cursor.ReadBlob(i, Stream);
                Param := _Params.ParamByName(_Cursor.Params.FieldName[i]);
                Param.LoadFromStream(Stream, Param.DataType);
            finally
                FreeAndNil(Stream);
            end;
        end else begin
            _Params.ParamByName(_Cursor.Params.FieldName[i]).Value := _Cursor.Params.AsVariant[i];
        end;
    end;
end;

///////////////////////////////////////////////////////////////////////////////
//
function ExecuteSQLCommand(
  _Command      : TUIBCommandEh
; _Database     : TUIBDataBase
; _Transaction  : TUIBTransaction
; var _Cursor   : TDataSet
; var _FreeOnEof: boolean
): integer;
var Cursor: TUIBDataSet;
var Query : TUIBQuery;
begin
    Result := -1;
    if _Database = nil then raise Exception.Create('Database property is null');

    _FreeOnEof := false;
    _Cursor    := nil;

    case _Command.CommandType of
        cthSelectQuery, cthTable: begin
            _FreeOnEof := true;
            Cursor     := TUIBDataSet.Create(_Database );

            Cursor.Database       := _Database;
            Cursor.Transaction    := _Transaction;
            Cursor.UniDirectional := true;

            Cursor.SQL.Assign(_Command.CommandText);

            if (cthSelectQuery = _Command.CommandType) then begin
                Params2UIBCursor(_Command.Params, Cursor);
            end;

            if (not _Database.Connected) then begin
                _Database.Connected := true;
            end;

            Cursor.Open();
            if (cthSelectQuery = _Command.CommandType) then begin
                UIBCursor2Params(Cursor, _Command.Params);
            end;

            _Cursor    := Cursor;
        end;
        cthUpdateQuery, cthStoredProc: begin
            try
                Query := TUIBQuery.Create(_Database);

                Query.DataBase    := _Database;
                Query.Transaction := _Transaction;

                Query.SQL.Assign(_Command.CommandText);

                Params2UIBQuery(_Command.Params, Query);

                if (not _Database.Connected) then begin
                    _Database.Connected := true;
                end;

                Query.Execute;

                Result := Query.RowsAffected;

                UIBQuery2Params(Query, _Command.Params);
            finally
                FreeAndNil(Query);
            end;
        end;
    end;
end;

///////////////////////////////////////////////////////////////////////////////
//
function DefaultExecuteUIBCommand(
      _DataDriver : TUIBDataDriverEh
;     _Command    : TUIBCommandEh
; var _Cursor     : TDataSet
; var _FreeOnEof  : boolean
; var _Processed  : boolean
): integer;
begin

    Result := -1;
    if ((_Command <> nil) and (_DataDriver <> nil)) then begin
        if ((_Command = _DataDriver.SelectCommand) or (_Command = _DataDriver.GetrecCommand)) then begin
            _Command.Transaction.Options := _DataDriver.ReadTransParams;
        end else begin
            _Command.Transaction.Options := _DataDriver.WriteTransParams;
        end;
        Result := ExecuteSQLCommand(
              _Command
            , _DataDriver.Database
            , _Command.Transaction
            , _Cursor
            , _FreeOnEof
            );
        _Processed := true;
    end;
end;

///////////////////////////////////////////////////////////////////////////////
//
procedure DoInterbaseServerSpecOperations (
  _DataDriver: TUIBDataDriverEh
; _MemRec    : TMemoryRecordEh
; _Command   : TCustomSQLCommandEh
; _ResDataSet: TDataSet
);
var GENSQL      : string         ;
var Generator   : string         ;
var IDField     : string         ;
var Transaction : TUIBTransaction;
var Query       : TUIBQuery      ;
begin
    GENSQL := 'select gen_id(%s, %d) from rdb$database';  //do not localize
    if (_Command = _DataDriver.InsertCommand) then begin
        Generator := _DataDriver.SpecParams.Values['GENERATOR'];
        IDField   := _DataDriver.SpecParams.Values['ID_FIELD'];
        if (   (0 <> Length(Trim(Generator)))
           and (0 <> Length(Trim(IDField)))
           and (nil <> _MemRec.DataStruct.FindField(IDField))
           )
        then begin
            try
                Transaction               := TUIBTransaction.Create(_DataDriver.Database_);
                Transaction.DataBase      := _DataDriver.Database;
                Transaction.Options       := _DataDriver.ReadTransParams;
                Transaction.AutoStart     := true;
                Transaction.AutoStop      := true;
                Transaction.DefaultAction := etmCommit;

                Query := TUIBQuery.Create(_DataDriver.Database_);
                Query.DataBase := _DataDriver.Database;
                Query.Transaction := Transaction;
                Query.SQL.Text := Format(GENSQL, [Generator, 1]);
                Query.Execute;
                _MemRec.DataValues[IDField, dvvValueEh] := Query.Fields.AsVariant[0];
            finally
                FreeAndNil(Query);
                FreeAndNil(Transaction);
            end;
        end;
    end;
end;

///////////////////////////////////////////////////////////////////////////////
//
constructor TUIBCommandEh.Create(
_DataDriver: TUIBDataDriverEh
);
begin
    inherited Create(_DataDriver);

    Transaction_               := TUIBTransaction.Create(_DataDriver.Database);
    Transaction_.DefaultAction := etmCommit;
end;

///////////////////////////////////////////////////////////////////////////////
//
function TUIBCommandEh.Transaction: TUIBTransaction;
begin
    Result := Transaction_;
end;

///////////////////////////////////////////////////////////////////////////////
//
function TUIBCommandEh.Execute(
  var _Cursor: TDataSet
; var _FreeOnEof: Boolean
): integer;
begin
    if ((self = DataDriver.SelectCommand) or (self = DataDriver.GetrecCommand)) then begin
        Transaction_.Options := DataDriver.ReadTransParams;
    end else begin
        Transaction_.Options := DataDriver.WriteTransParams;
    end;

    Result := ExecuteSQLCommand(
          self
        , DataDriver.Database
        , Transaction_
        , _Cursor
        , _FreeOnEof
        );
end;

function TUIBCommandEh.GetDataDriver: TUIBDataDriverEh;
begin
    Result := inherited DataDriver as TUIBDataDriverEh;
end;

procedure TUIBCommandEh.SetManualTransaction(
_ManualTransaction: boolean
);
begin
    ManualTransaction_     := _ManualTransaction;
    Transaction_.AutoStart := not ManualTransaction_;
    Transaction_.AutoStop  := not ManualTransaction_;
end;

procedure TUIBCommandEh.StartTransaction;
begin
    if (true = ManualTransaction_) and (not Transaction_.InTransaction) then begin
        Transaction_.StartTransaction;
    end;
end;

procedure TUIBCommandEh.CommitTransaction;
begin
    if (true = ManualTransaction_) and (Transaction_.InTransaction) then begin
        Transaction_.Commit;
    end;
end;

procedure TUIBCommandEh.RollbackTransaction;
begin
    if (true = ManualTransaction_) and (Transaction_.InTransaction) then begin
        Transaction_.RollBack;
    end;
end;

constructor TUIBDataDriverEh.Create(_Owner: TComponent);
begin
    inherited Create(_Owner);
    Include(ReadTransactionParams_, tpRead);
    Include(ReadTransactionParams_, tpReadCommitted);
    Include(ReadTransactionParams_, tpNoWait);
    Include(ReadTransactionParams_, tpRecVersion);

    Include(WriteTransactionParams_, tpWrite);
    Include(WriteTransactionParams_, tpReadCommitted);
    Include(WriteTransactionParams_, tpNoWait);
    Include(WriteTransactionParams_, tpRecVersion);
end;

procedure TUIBDataDriverEh.SetDatabase(
_Database: TUIBDataBase
);
begin
    Database_ := _Database;
    with SelectCommand as TUIBCommandEh do Transaction.DataBase := Database_;
    with InsertCommand as TUIBCommandEh do Transaction.DataBase := Database_;
    with DeleteCommand as TUIBCommandEh do Transaction.DataBase := Database_;
    with UpdateCommand as TUIBCommandEh do Transaction.DataBase := Database_;
    with GetrecCommand as TUIBCommandEh do Transaction.DataBase := Database_;
end;

function TUIBDataDriverEh.CreateDeleteCommand: TCustomSQLCommandEh;
begin
    Result := TUIBCommandEh.Create(self);
end;

function TUIBDataDriverEh.CreateInsertCommand: TCustomSQLCommandEh;
begin
    Result := TUIBCommandEh.Create(self);
end;

function TUIBDataDriverEh.CreateSelectCommand: TCustomSQLCommandEh;
begin
    Result := TUIBCommandEh.Create(self);
end;

function TUIBDataDriverEh.CreateGetrecCommand: TCustomSQLCommandEh;
begin
    Result := TUIBCommandEh.Create(self);
end;

function TUIBDataDriverEh.CreateUpdateCommand: TCustomSQLCommandEh;
begin
    Result := TUIBCommandEh.Create(self);
end;

procedure TUIBDataDriverEh.SetAutoIncFields(
  _Fields    : TFields
; _DataStruct: TMTDataStructEh
);
var FieldName   : string;
var Field       : TMTDataFieldEh;
begin
    FieldName := SpecParams.Values['AUTO_INCREMENT_FIELD'];
    if (Length(Trim(FieldName)) > 0) then begin
        Field := _DataStruct.FindField(FieldName);
        if (Field <> nil) then begin
            if (Field is TMTNumericDataFieldEh) then begin
                with Field as TMTNumericDataFieldEh do begin
                    NumericDataType := fdtAutoIncEh;
                end;
            end;
        end;
    end;
end;

function TUIBDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
    Result := TUIBDataDriverEh.Create(nil);
    with Result as TUIBDataDriverEh do begin
        SelectCommand := self.SelectCommand;
        UpdateCommand := self.UpdateCommand;
        GetrecCommand := self.GetrecCommand;
        DeleteCommand := self.DeleteCommand;
        InsertCommand := self.InsertCommand;
    end;
end;

procedure TUIBDataDriverEh.GetBackUpdatedValues(
  _MemRec    : TMemoryRecordEh
; _Command   : TCustomSQLCommandEh
; _ResDataSet: TDataSet
);
begin
    inherited GetBackUpdatedValues(
      _MemRec
    , _Command
    , _ResDataSet
    );
    DoServerSpecOperations(
      _MemRec
    , _Command
    , _ResDataSet
    );
end;

procedure TUIBDataDriverEh.DoServerSpecOperations(
  _MemRec    : TMemoryRecordEh
; _Command   : TCustomSQLCommandEh
; _ResDataSet: TDataSet
);
begin
    if (nil <> Database) then begin
        DoInterbaseServerSpecOperations(
              self
            , _MemRec
            , _Command
            , _ResDataSet
            );
    end;
end;

procedure Register;
begin
    RegisterComponents('EhLib', [TUIBDataDriverEh]);
end;

end.
