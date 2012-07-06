unit uAccountsReferalsRecord;

interface

uses
  Graphics,
  uAccountsReferalsDataSet;

type
  TAccountsReferalsRecord = class(TObject)
  private
    FAccountsReferalsDataSet: TAccountsReferalsDataSet;
    function GetId: Integer;
    function GetLevel: Integer;
    procedure SetLevel(AValue: Integer);
    function GetPercent: Integer;
    procedure SetPercent(AValue: Integer);
  public
    constructor Create(AAccountsReferalsDataSet: TAccountsReferalsDataSet);

    // Public property
    property Id: Integer
        read GetId;
    property Level: Integer
        read GetLevel write SetLevel;
    property Percent: Integer
        read GetPercent write SetPercent;
  end;

implementation

uses
  SysUtils,
  Classes;

constructor TAccountsReferalsRecord.Create(AAccountsReferalsDataSet: TAccountsReferalsDataSet);
begin
  FAccountsReferalsDataSet := AAccountsReferalsDataSet;
end;

function TAccountsReferalsRecord.GetId: Integer;
begin
  Result := FAccountsReferalsDataSet.FieldValues['id'];
end;

function TAccountsReferalsRecord.GetLevel: Integer;
begin
  Result := FAccountsReferalsDataSet.FieldValues['level'];
end;

procedure TAccountsReferalsRecord.SetLevel(AValue: Integer);
begin
  FAccountsReferalsDataSet.Edit;
  FAccountsReferalsDataSet.FieldValues['level'] := AValue;
  FAccountsReferalsDataSet.Post;
end;


function TAccountsReferalsRecord.GetPercent: Integer;
begin
  Result := FAccountsReferalsDataSet.FieldValues['percent'];
end;

procedure TAccountsReferalsRecord.SetPercent(AValue: Integer);
begin
  FAccountsReferalsDataSet.Edit;
  FAccountsReferalsDataSet.FieldValues['percent'] := AValue;
  FAccountsReferalsDataSet.Post;
end;

end.
