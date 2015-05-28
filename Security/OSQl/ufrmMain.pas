unit ufrmMain;

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
  Registry,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  DateUtils,
  Mask,
//  ToolEdit,
  uDBConfigParsingThread;

type
  TfrmMain = class(TForm)
    butClose: TButton;
    memoInfo: TMemo;
    procedure butCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FbCreateBase: Boolean;
    FbUseLoginForm: Boolean;
    FstrXMLConfigFileName: String;
    FDBConfigParsingThread: TDBConfigParsingThread;
    procedure ThreadDone(Sender: TObject);
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent;
        const AstrXMLConfigFileName: String;
        const AbCreateBase: Boolean;
        const AbUseLoginForm: Boolean); reintroduce;
    destructor Destroy; override;
    procedure MessageAdd(AstrText: String);
    procedure MessageAppend(AstrText: String);
  end;


var
  frmMain: TfrmMain;
  // -----------------------------

implementation

{$R *.dfm}
constructor TfrmMain.Create(const AOwner: TComponent;
    const AstrXMLConfigFileName: String;
    const AbCreateBase: Boolean;
    const AbUseLoginForm: Boolean);
begin
  inherited Create(AOwner);
  FstrXMLConfigFileName := AstrXMLConfigFileName;
  FbCreateBase := AbCreateBase;
  FbUseLoginForm := AbUseLoginForm;
end;

destructor TfrmMain.Destroy;
begin
  if Assigned(FDBConfigParsingThread) then begin
    FDBConfigParsingThread.OnTerminate := Nil;
    FDBConfigParsingThread.Terminate;
    FreeAndNil(FDBConfigParsingThread);
  end;
  inherited Destroy;
end;


procedure TfrmMain.MessageAdd(AstrText: String);
begin
  memoInfo.Lines.Add(AstrText);
  Application.ProcessMessages;
end;

procedure TfrmMain.MessageAppend(AstrText: String);
begin
  if memoInfo.Lines.Count > 0 then
    memoInfo.Lines.Strings[memoInfo.Lines.Count - 1] :=
        memoInfo.Lines.Strings[memoInfo.Lines.Count - 1] + AstrText;
end;

procedure TfrmMain.butCloseClick(Sender: TObject);
begin
  FreeAndNil(FDBConfigParsingThread);
  ModalResult := mrCancel;
end;


procedure TfrmMain.FormCreate(Sender: TObject);
begin
  with TDBConfigParsingThread.Create(FstrXMLConfigFileName, FbCreateBase,
      FbUseLoginForm) do
    OnTerminate := ThreadDone;
end;

procedure TfrmMain.ThreadDone(Sender: TObject);
var
  bResult: Boolean;
begin
  bResult := TDBConfigParsingThread(Sender).Result;
  FreeAndNil(FDBConfigParsingThread);
  if bResult then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
end;

end.
