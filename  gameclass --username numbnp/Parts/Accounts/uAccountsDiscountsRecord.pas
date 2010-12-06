unit uAccountsDiscountsRecord;

interface

uses
  Graphics,
  uAccountsDiscountsDataSet;

type
  TAccountsDiscountsRecord = class(TObject)
  private
    FAccountsDiscountsDataSet: TAccountsDiscountsDataSet;
    function GetId: Integer;
    function GetSummary: Double;
    procedure SetSummary(AValue: Double);
    function GetDiscount: Integer;
    procedure SetDiscount(AValue: Integer);
  public
    constructor Create(AAccountsDiscountsDataSet: TAccountsDiscountsDataSet);

    // Public property
    property Id: Integer
        read GetId;
    property Summary: Double
        read GetSummary write SetSummary;
    property Discount: Integer     
        read GetDiscount write SetDiscount;
  end;

implementation

uses
  SysUtils,
  Classes;

constructor TAccountsDiscountsRecord.Create(AAccountsDiscountsDataSet: TAccountsDiscountsDataSet);
begin
  FAccountsDiscountsDataSet := AAccountsDiscountsDataSet;
end;

function TAccountsDiscountsRecord.GetId: Integer;
begin
  Result := FAccountsDiscountsDataSet.FieldValues['id'];
end;
function TAccountsDiscountsRecord.GetSummary: Double;
begin
  Result := FAccountsDiscountsDataSet.FieldValues['summary'];
end;

procedure TAccountsDiscountsRecord.SetSummary(AValue: Double);
begin
  FAccountsDiscountsDataSet.Edit;
  FAccountsDiscountsDataSet.FieldValues['summary'] := AValue;
  FAccountsDiscountsDataSet.Post;
end;


function TAccountsDiscountsRecord.GetDiscount: Integer;
begin
  Result := FAccountsDiscountsDataSet.FieldValues['discount'];
end;

procedure TAccountsDiscountsRecord.SetDiscount(AValue: Integer);
begin
  FAccountsDiscountsDataSet.Edit;
  FAccountsDiscountsDataSet.FieldValues['discount'] := AValue;
  FAccountsDiscountsDataSet.Post;
end;

end.
