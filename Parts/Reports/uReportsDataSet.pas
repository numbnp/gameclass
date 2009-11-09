unit uReportsDataSet;

interface

uses
  Classes,
  ADODB;

type

  //
  // TReportsDataSet
  //

  TReportsDataSet = class(TADODataSet)
  protected
    // properties methods
    function GetUID(): Integer; virtual;

    procedure SetReportName(const AstrReportName: String); virtual;
    function GetReportName(): String; virtual;

    procedure SetCode(const AstrCode: String); virtual;
    function GetCode(): String; virtual;

    procedure SetDescription(const AstrDescription: String); virtual;
    function GetDescription(): String; virtual;

    procedure SetParentId(const AnParentId: Integer); virtual;
    function GetParentId(): Integer; virtual;

    procedure SetIsFolder(const AbIsFolder: Boolean); virtual;
    function GetIsFolder(): Boolean; virtual;

    procedure SetOrderIndex(const AnOrderIndex: Integer); virtual;
    function GetOrderIndex(): Integer; virtual;

    procedure SetVersion(const AnVersion: Integer);
    function GetVersion(): Integer;

    procedure SetAuthor(const AstrAuthor: String);
    function GetAuthor(): String;

    procedure SetGUID(const AstrGUID: String);
    function GetGUID(): String;

    function GetInvariable(): Boolean; virtual;
  public
    // constructor / destructor
    constructor Create(const AOwner: TComponent;
        const Acnn: TADOConnection); reintroduce;

    // public methods
    procedure OpenDef();
    function LocateById(const AnUID: Integer): Boolean;

    // properties
    property UID: Integer read GetUID;
    property ReportName: String read GetReportName write SetReportName;
    property Code: String read GetCode write SetCode;
    property Description: String read GetDescription write SetDescription;
    property ParentId: Integer read GetParentId write SetParentId;
    property IsFolder: Boolean read GetIsFolder write SetIsFolder;
    property OrderIndex: Integer read GetOrderIndex write SetOrderIndex;
    property Version: Integer read GetVersion write SetVersion;
    property Author: String read GetAuthor write SetAuthor;
    property GUID: String read GetGUID write SetGUID;
    property Invariable: Boolean read GetInvariable;

  end; // TReportsDataSet


implementation

{$IFDEF GC3SERVER}
uses
  gccomputers;
{$ENDIF}

const
  DEF_QUERY_MANAGER = 'SELECT * FROM Reports ORDER BY OrderIndex';
  DEF_QUERY_OTHERS = 'EXEC CustomReportsSelect';

  FLD_UID = 'id';
  FLD_REPORTNAME = 'Name';
  FLD_CODE = 'Code';
  FLD_DESCRIPTION = 'Description';
  FLD_PARENTID = 'ParentId';
  FLD_ISFOLDER = 'IsFolder';
  FLD_ORDER = 'OrderIndex';
  FLD_VERSION = 'Version';
  FLD_AUTHOR = 'Author';
  FLD_GUID = 'GUID';
  FLD_INVARIABLE = 'Invariable';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReportsDataSet.Create(const AOwner: TComponent;
    const Acnn: TADOConnection);
begin
  inherited Create(AOwner);
  Connection := Acnn;
end; // TReportsDataSet.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReportsDataSet.OpenDef();
begin
  CommandType := cmdText;
{$IFDEF GC3SERVER}
  if IsManager then
    CommandText := DEF_QUERY_MANAGER
  else
    CommandText := DEF_QUERY_OTHERS;
{$ELSE}
  CommandText := DEF_QUERY_MANAGER;
{$ENDIF}
  Open();

  ASSERT(Assigned(FieldByName(FLD_UID))
      and Assigned(FieldByName(FLD_REPORTNAME))
      and Assigned(FieldByName(FLD_CODE))
      and Assigned(FieldByName(FLD_DESCRIPTION))
      and Assigned(FieldByName(FLD_PARENTID))
      and Assigned(FieldByName(FLD_ISFOLDER))
      and Assigned(FieldByName(FLD_ORDER))
      and Assigned(FieldByName(FLD_VERSION))
      and Assigned(FieldByName(FLD_AUTHOR))
      and Assigned(FieldByName(FLD_GUID))
      and Assigned(FieldByName(FLD_INVARIABLE)));

end; // TReportsDataSet.OpenDef


function TReportsDataSet.LocateById(const AnUID: Integer): Boolean;
begin
  Result := Locate(FLD_UID, AnUID, []);
end; // TReportsDataSet.LocateById


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TReportsDataSet.GetUID(): Integer;
begin
  Result := FieldByName(FLD_UID).AsInteger;
end; // TReportsDataSet.GetUID


procedure TReportsDataSet.SetReportName(const AstrReportName: String);
begin
  FieldByName(FLD_REPORTNAME).AsString := AstrReportName;
end; // TReportsDataSet.SetReportName


function TReportsDataSet.GetReportName(): String;
begin
  Result := FieldByName(FLD_REPORTNAME).AsString;
end; // TReportsDataSet.GetReportName


procedure TReportsDataSet.SetCode(const AstrCode: String);
begin
  FieldByName(FLD_CODE).AsString := AstrCode;
end; // TReportsDataSet.SetCode


function TReportsDataSet.GetCode(): String;
begin
  Result := FieldByName(FLD_CODE).AsString;
end; // TReportsDataSet.GetCode


procedure TReportsDataSet.SetDescription(const AstrDescription: String);
begin
  FieldByName(FLD_DESCRIPTION).AsString := AstrDescription;
end; // TReportsDataSet.SetDescription


function TReportsDataSet.GetDescription(): String;
begin
  Result := FieldByName(FLD_DESCRIPTION).AsString;
end; // TReportsDataSet.GetDescription


procedure TReportsDataSet.SetParentId(const AnParentId: Integer);
begin
  FieldByName(FLD_PARENTID).AsInteger := AnParentId;
end; // TReportsDataSet.SetParentId


function TReportsDataSet.GetParentId(): Integer;
begin
  Result := FieldByName(FLD_PARENTID).AsInteger;
end; // TReportsDataSet.GetParentId


procedure TReportsDataSet.SetIsFolder(const AbIsFolder: Boolean);
begin
  if AbIsFolder then begin
    FieldByName(FLD_ISFOLDER).AsInteger := 1;
  end else begin
    FieldByName(FLD_ISFOLDER).AsInteger := 0;
  end;
end; // TReportsDataSet.SetIsFolder


function TReportsDataSet.GetIsFolder(): Boolean;
begin
  Result := (FieldByName(FLD_ISFOLDER).AsInteger <> 0);
end; // TReportsDataSet.GetIsFolder


procedure TReportsDataSet.SetOrderIndex(const AnOrderIndex: Integer);
begin
  FieldByName(FLD_ORDER).AsInteger := AnOrderIndex;
end; // TReportsDataSet.SetOrderIndex


function TReportsDataSet.GetOrderIndex(): Integer;
begin
  Result := FieldByName(FLD_ORDER).AsInteger;
end; // TReportsDataSet.GetOrderIndex


procedure TReportsDataSet.SetVersion(const AnVersion: Integer);
begin
  FieldByName(FLD_VERSION).AsInteger := AnVersion;
end; // TReportsDataSet.SetVersion


function TReportsDataSet.GetVersion(): Integer;
begin
  Result := FieldByName(FLD_VERSION).AsInteger;
end; // TReportsDataSet.GetVersion


procedure TReportsDataSet.SetAuthor(const AstrAuthor: String);
begin
  FieldByName(FLD_AUTHOR).AsString := AstrAuthor;
end; // TReportsDataSet.SetAuthor


function TReportsDataSet.GetAuthor(): String;
begin
  Result := FieldByName(FLD_AUTHOR).AsString;
end; // TReportsDataSet.GetAuthor


procedure TReportsDataSet.SetGUID(const AstrGUID: String);
begin
  FieldByName(FLD_GUID).AsString := AstrGUID;
end; // TReportsDataSet.SetGUID


function TReportsDataSet.GetGUID(): String;
begin
  Result := FieldByName(FLD_GUID).AsString;
end; // TReportsDataSet.GetGUID


{procedure TReportsDataSet.SetInvariable(const AbInvariable: Boolean);
begin
  if AbIsFolder then begin
    FieldByName(FLD_ISFOLDER).AsInteger := 1;
  end else begin
    FieldByName(FLD_ISFOLDER).AsInteger := 0;
  end;
end; // TReportsDataSet.SetIsFolder
}

function TReportsDataSet.GetInvariable(): Boolean;
begin
  Result := (FieldByName(FLD_INVARIABLE).AsInteger <> 0);
end; // TReportsDataSet.GetInvariable

end.
