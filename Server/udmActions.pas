unit udmActions;

interface

uses
  SysUtils, Classes, ActnList, XPStyleActnCtrls, ActnMan, System.Actions;

type
  TdmActions = class(TDataModule)
    ActionManager: TActionManager;
    actExit: TAction;
    actConnect: TAction;
    actDisconnect: TAction;
    actAbout: TAction;
    actHelp: TAction;
    actLangRussian: TAction;
    actLangEnglish: TAction;
    actRedrawComps: TAction;
    actPreLogon: TAction;
    actLoadSessions: TAction;
    actAddCheckAccount: TAction;
    actTimeBonus: TAction;
    procedure actExitExecute(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actDisconnectExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actLangRussianExecute(Sender: TObject);
    procedure actLangEnglishExecute(Sender: TObject);
    procedure actRedrawCompsExecute(Sender: TObject);
    procedure actPreLogonExecute(Sender: TObject);
    procedure actLoadSessionsExecute(Sender: TObject);
    procedure actAddCheckAccountExecute(Sender: TObject);
    procedure actTimeBonusExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmActions: TdmActions;

implementation

uses
  ufrmAddCheckAccount,
  gcconst,
  gccomputers,
  gccommon,
  uVirtualTime,
  gclangutils,
  gcfunctions,
  Forms;

{$R *.dfm}

procedure TdmActions.actExitExecute(Sender: TObject);
begin
  ehsLogout;
  Application.Terminate;
end;

procedure TdmActions.actConnectExecute(Sender: TObject);
begin
  ehsLogon;
end;

procedure TdmActions.actDisconnectExecute(Sender: TObject);
begin
  ehsLogout;
end;

procedure TdmActions.actAboutExecute(Sender: TObject);
begin
  ehsAbout;
end;

procedure TdmActions.actHelpExecute(Sender: TObject);
begin
  ehsHelp;
end;

procedure TdmActions.actLangRussianExecute(Sender: TObject);
begin
  ehsLangRussian;
end;

procedure TdmActions.actLangEnglishExecute(Sender: TObject);
begin
  ehsLangEnglish;
end;

procedure TdmActions.actRedrawCompsExecute(Sender: TObject);
begin
  ehsRedrawComps;
end;

procedure TdmActions.actPreLogonExecute(Sender: TObject);
begin
  ehsPreLogon;
end;

procedure TdmActions.actLoadSessionsExecute(Sender: TObject);
begin
  dsLoadSessions;
end;

procedure TdmActions.actAddCheckAccountExecute(Sender: TObject);
var
  frmAddCheckAccount: TfrmAddCheckAccount;
begin
  frmAddCheckAccount := TfrmAddCheckAccount.Create(Self);
  frmAddCheckAccount.ShowModal;
  FreeAndNil(frmAddCheckAccount);
end;

procedure TdmActions.actTimeBonusExecute(Sender: TObject);
var
  nIndex: Integer;
begin
  if (not FunctionAmIRight(FN_TIMEBONUS)) then exit;
  nIndex := ComputersGetIndex(CompsSel[0]);
  Comps[nIndex].session.UpdateOnDB(0, 0, 0, 0, 0, 0, 0, GnMinPenalty);
  SendAllOptionsToClient(nIndex);
  Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_1, translate('Computer') + ' '
      + Comps[nIndex].GetStrNumber + ' / ' + translate('labelUser') + ' '
      + GetAccountName(Comps[nIndex].a) + ' >> ' + DateTimeToSql(GetVirtualTime)
      + ' / Добавлено беслпатно ' + IntToStr(GnMinPenalty) + ' '
      + translate('Minutes'));
  dmActions.actLoadSessions.Execute;
  dmActions.actRedrawComps.Execute;
end;

end.
