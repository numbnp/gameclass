unit udmMain;

interface

uses
  SysUtils,
  Classes,
//  bsPolyglotUn,
  DB,
  ADODB,
  uReportManager;

type
  TdmMain = class(TDataModule)
    cnnMain: TADOConnection;
    dstOnInitDatabase: TADOStoredProc;
    dstGetLogonInfo: TADOStoredProc;
    dstCurrentReport: TADOStoredProc;
  private
    // fields
    FReportManager: TReportManager;
  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // properties
    property ReportManager: TReportManager
        read FReportManager write FReportManager;

  end;

var
  dmMain: TdmMain;

implementation

{$R *.dfm}

constructor TdmMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FReportManager := TReportManager.Create(cnnMain);
end; // TdmMain.Create


destructor TdmMain.Destroy();
begin
  FreeAndNil(FReportManager);
  inherited Destroy();
end; // TdmMain.Destroy


end.
