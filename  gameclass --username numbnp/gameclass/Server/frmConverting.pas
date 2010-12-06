unit frmConverting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gcconst, gccommon;

type
  TformConverting = class(TForm)
    butStart: TButton;
    butCancel: TButton;
    memoInfo: TMemo;
    labelConverting: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure butStartClick(Sender: TObject);
    procedure Convert(frombase,tobase: string);
    function ConvertPossible(frombase,tobase: string):boolean;
    procedure c35to36;
  private
    { Private declarations }
  public
    { Public declarations }
    curBaseVer: string;
  end;

var
  formConverting: TformConverting;

implementation

uses
  gcfunctions, udmActions;

{$R *.dfm}

procedure TformConverting.FormActivate(Sender: TObject);
begin
  memoInfo.Lines.Clear;
  memoInfo.Lines.Add('Converting database from ' + curBaseVer + ' to ' + BASE_VERSION);
  if (ConvertPossible(curBaseVer,BASE_VERSION)) then begin
    memoInfo.Lines.Add('Convertation possible!');
    memoInfo.Lines.Add('Press Start button for converting...');
    butStart.Caption := 'Start';
  end
  else
  begin
    memoInfo.Lines.Add('Convertation unpossible!');
    memoInfo.Lines.Add('Press Close button to exit..');
    butStart.Caption := 'Close';
  end;
end;

procedure TformConverting.butStartClick(Sender: TObject);
begin
  Convert(curBaseVer, BASE_VERSION);
  //MessageBox(HWND_TOP, 'Restarting GCServer ...', 'Information', MB_OK);
  Sleep(5000);
  dmActions.actExit.Execute;
  ModalResult := mrOK;
end;

function TformConverting.ConvertPossible(frombase,tobase: string):boolean;
begin
  ConvertPossible := false;
  if ((frombase = '3.5')and(tobase='3.6')) then ConvertPossible := true;
end;

procedure TformConverting.Convert(frombase,tobase: string);
begin
  butStart.Enabled := false;
  butCancel.Enabled := false;
  if ((frombase = '3.5')and(tobase='3.6')) then c35to36;
  memoInfo.Lines.Add('Restarting after 5 seconds ...');
end;

procedure TformConverting.c35to36;
begin
  // upgrade 3.5 to 3.6
  dsDoCommandSQLQuery('if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[HardwareSelect]'') and OBJECTPROPERTY(id, N''IsProcedure'') = 1) drop procedure [dbo].[HardwareSelect]');
  dsDoCommandSQLQuery('if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[SessionsUpdate]'') and OBJECTPROPERTY(id, N''IsProcedure'') = 1) drop procedure [dbo].[SessionsUpdate]');
  dsDoCommandSQLQuery(memo35to36_1.Text);
  dsDoCommandSQLQuery('GRANT  EXECUTE  ON [dbo].[HardwareSelect]  TO [public]');
  dsDoCommandSQLQuery(memo35to36_2.Text);
  dsDoCommandSQLQuery('GRANT  EXECUTE  ON [dbo].[SessionsUpdate]  TO [public]');
  dsDoCommandSQLQuery('Update Registry set Value=''3.6'' where [Key]=''BaseVersion''');
  memoInfo.Lines.Add('...');
  memoInfo.Lines.Add('Converting database to 3.6 version ready...');
end;

end.
