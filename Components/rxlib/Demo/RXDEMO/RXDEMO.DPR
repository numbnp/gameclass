program RxDemo;

uses
  Forms,
  RxExcptDlg,
  RxDBExcpt,
  Main in 'MAIN.PAS' {MainForm},
  Dbaware in 'DBAWARE.PAS' {DBAwareForm},
  Tools in 'TOOLS.PAS' {ToolsForm},
  Ctrls in 'CTRLS.PAS' {ControlsForm},
  About in 'ABOUT.PAS' {AboutForm},
  PageDemo in 'PAGEDEMO.PAS' {ClientAssistant};

{$R *.RES}

{$I RX.INC}
begin
  Application.Initialize;
  {$IFDEF RX_D11}
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.Title := 'RX Demo';
  RxErrorIntercept;
  DBErrorIntercept;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
