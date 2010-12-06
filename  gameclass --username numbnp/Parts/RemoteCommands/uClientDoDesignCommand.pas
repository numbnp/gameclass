//////////////////////////////////////////////////////////////////////////////
//
// TClientDoDesignCommand
// Класс поступающих от управляющего сервера команд, которые
// связаны с перерисовкой визуальной части клиента.
//
//
//////////////////////////////////////////////////////////////////////////////

unit uClientDoDesignCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TClientDoDesignCommand
  //

  TClientDoDesignCommand = class(TRemoteCommand)
  private
    // fields
    FbDoDesign: Boolean;
    FbUpdateData: Boolean;
    FbNavigate: Boolean;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AbDoDesign: Boolean;
        const AbUpdateData: Boolean; const AbNavigate: Boolean); overload;

    // public methods
    procedure Execute(); override;

    // properties
    property DoDesign: Boolean read FbDoDesign write FbDoDesign;
    property UpdateData: Boolean read FbUpdateData write FbUpdateData;
    property Navigate: Boolean read FbNavigate write FbNavigate;

  end; // TClientDoDesignCommand


implementation

uses
  SysUtils,
  uSafeStorage,
  uClientConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TClientDoDesignCommand.Create();
begin
  ASSERT(FALSE,
      'TClientDoDesignCommand.Create need AstrHostForResend parameter');
end; // TClientDoDesignCommand.Create

constructor TClientDoDesignCommand.Create(const AbDoDesign: Boolean;
    const AbUpdateData: Boolean; const AbNavigate: Boolean);
begin
  inherited Create();

  FbDoDesign := AbDoDesign;
  FbUpdateData := AbUpdateData;
  FbNavigate := AbNavigate;

end; // TClientDoDesignCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TClientDoDesignCommand.Execute();
begin
  if FbDoDesign then
    TSafeStorage.Instance().Push(ThreadSafeOperation_DoDesign,0); //frmMain.Show;
  if FbUpdateData then
    TSafeStorage.Instance().Push(ThreadSafeOperation_UpdateData,0); //frmMain.UpdateData;
  if FbNavigate then
    TSafeStorage.Instance().Push(ThreadSafeOperation_NavigateWebBrousers,0); //frmMain.Navigate;
end; // TClientDoDesignCommand.Execute


end.
