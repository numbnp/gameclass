{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{                                                       }
{           TDataDriverEh, TSQLDataDriverEh             }
{                components (Build 7.0.01)              }
{                                                       }
{     Copyright (c) 2013-14 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit SQLDBDataDriverEh;

{$I EHLIB.INC}

interface

uses SysUtils, Classes, DB,
  //  DBCommon,
  {$IFDEF EH_LIB_6} Variants, {$ENDIF}
  {$IFDEF CIL}
    EhLibVCLNET,
  {$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType, sqldb,
  {$ELSE}
    EhLibVCL,
  {$ENDIF}
  {$ENDIF}
    ToolCtrlsEh, DataDriverEh, DynVarsEh, MemTableDataEh;

type

  { TSQLDBConnectionProviderEh }

    TSQLDBConnectionProviderEh = class(TConnectionProviderEh)
    private
      FConnection: TSQLConnection;
      procedure SetConnection(AValue: TSQLConnection);

    protected
      procedure Loaded; override;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      function DefaultExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; override;

    published
      property Connection: TSQLConnection read FConnection write SetConnection;
      property ServerType;

      property OnExecuteCommand;
      property OnGetBackUpdatedValues;
      property OnGetServerSpecOperations;
      property OnUpdateRecord;
    end;

function DefaultExecuteSQLDBCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
     Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
     Connection: TSQLConnection): Integer;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('EhLib Components', [TSQLDBConnectionProviderEh]);
end;

function DefaultExecuteSQLDBCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
  Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
  Connection: TSQLConnection): Integer;
var
  ACursor: TDataSet;
begin
  Result := -1;
  Cursor := nil;
  FreeOnEof := False;
  ACursor := nil;
  try
    case Command.CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          ACursor := TSQLQuery.Create(nil);
          with ACursor as TSQLQuery do
          begin
            UsePrimaryKeyAsKey := False;
            DataBase := Connection;
            SQL.Text := Command.FinalCommandText.Text;
            Params := TBaseSQLCommandEh(Command).Params;
            if Command.CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
            TBaseSQLCommandEh(Command).Params := Params;
          end;
        end;
      cthTable:
        begin
          ACursor := TSQLQuery.Create(nil);
          with ACursor as TSQLQuery do
          begin
            UsePrimaryKeyAsKey := False;
            DataBase := Connection;
            SQL.Text := 'select * from ' + Command.FinalCommandText.Text;
            Open;
          end;
        end;
      cthStoredProc:
        begin
          raise Exception.Create('cthStoredProc is not supported as Command.CommandType.');
        end;
    end;
    if ACursor.Active then
    begin
      Cursor := ACursor;
      FreeOnEof := True;
      ACursor := nil;
    end
  finally
    if ACursor <> nil then
      ACursor.Free;
  end;
end;

{ TSQLDBConnectionProviderEh }

constructor TSQLDBConnectionProviderEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSQLDBConnectionProviderEh.Destroy;
begin
  inherited Destroy;
end;

function TSQLDBConnectionProviderEh.DefaultExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean
  ): Integer;
begin
  Result := inherited DefaultExecuteCommand(SQLDataDriver, Command, Cursor,
    FreeOnEof, Processed);

  if not Processed then
  begin
    Result := DefaultExecuteSQLDBCommandEh(SQLDataDriver, Command,
      Cursor, FreeOnEof, Connection);
    Processed := True;
  end;
end;

procedure TSQLDBConnectionProviderEh.SetConnection(AValue: TSQLConnection);
begin
  if FConnection = AValue then Exit;
  FConnection := AValue;
end;

procedure TSQLDBConnectionProviderEh.Loaded;
begin
  inherited Loaded;
end;

procedure TSQLDBConnectionProviderEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FConnection = AComponent)
  then
    Connection := nil;
end;

end.

