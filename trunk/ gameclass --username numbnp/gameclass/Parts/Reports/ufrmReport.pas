unit ufrmReport;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  uReport;


type

  //
  // TfrmReport
  //

  TfrmReport = class(TForm)
  private

  public
    // public methods
    procedure SetReport(const AReport: TReport); virtual; abstract;
    procedure Storage(); virtual; abstract;

  end; // TfrmReport


implementation

{$R *.dfm}

end.
