unit uUsersDataSet;


interface
uses uGCDataSet, ADODB;

type
  TUsersDataSet = class(TGCDataSet)
  protected
    function DoSelectAll(
        var AdtsResult: TADODataSet): Boolean; override;
    function DoUpdate(const AnId: Integer): Boolean; override;
    function DoDelete (const AnId: Integer): Boolean; override;
    function DoInsert(var AdtsResult: TADODataSet): Boolean; override;
    function DoSelect(const AnId: Integer;
        var AdtsResult: TADODataSet): Boolean; override;
  end;

implementation

uses uSQLTools, SysUtils, DB;

function TUsersDataSet.DoSelectAll(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult, 'exec UsersSelect');
end;

function TUsersDataSet.DoUpdate(const AnId: Integer): Boolean;
begin
end;

function TUsersDataSet.DoDelete(const AnId: Integer): Boolean;
begin
  Result := dsDoCommand(Connection,
      'exec UsersDelete @idUsers=' + IntToStr(AnId));
end;

function TUsersDataSet.DoInsert(var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec UsersCreate @login_name=''z'' , @group_name=''Staff''' +
      ', @password=''''');
end;

function TUsersDataSet.DoSelect(const AnId: Integer;
  var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec UsersSelectById @Id=' + IntToStr(AnId));
end;
end.
