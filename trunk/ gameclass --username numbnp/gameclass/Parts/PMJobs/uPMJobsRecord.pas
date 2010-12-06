unit uPMJobsRecord;

interface

uses
  Graphics,
  uPMJobsDataSet;

type
  TPMJobsRecord = class(TObject)
  private
    FPMJobsDataSet: TPMJobsDataSet;
    function GetId: Integer;
    function GetIPAddress: String;
    function GetPagesCount: Integer;
    function GetPrinterName: String;
    function GetMoment: TDateTime;
    function GetCost: Double;
  public
    constructor Create(APMJobsDataSet: TPMJobsDataSet);

    // Public property
    property Id: Integer
        read GetId;
    property IPAddress: String
        read GetIPAddress;
    property PagesCount: Integer
        read GetPagesCount;
    property PrinterName: String
        read GetPrinterName;
    property Moment: TDateTime
        read GetMoment;
    property Cost: Double
        read GetCost;

  end;

implementation

uses
  SysUtils,
  Classes;

constructor TPMJobsRecord.Create(APMJobsDataSet: TPMJobsDataSet);
begin
  FPMJobsDataSet := APMJobsDataSet;
end;

function TPMJobsRecord.GetId: Integer;
begin
  Result := FPMJobsDataSet.FieldValues['id'];
end;

function TPMJobsRecord.GetIPAddress: String;
begin
  Result := FPMJobsDataSet.FieldValues['ip'];
end;

function TPMJobsRecord.GetPagesCount: Integer;
begin
  Result := FPMJobsDataSet.FieldValues['ppages'];
end;

function TPMJobsRecord.GetPrinterName: String;
begin
  Result := FPMJobsDataSet.FieldValues['printer'];
end;

function TPMJobsRecord.GetMoment: TDateTime;
begin
  Result := FPMJobsDataSet.FieldValues['dt'];
end;

function TPMJobsRecord.GetCost: Double;
begin
  Result := FPMJobsDataSet.FieldValues['Cost'];
end;

end.
