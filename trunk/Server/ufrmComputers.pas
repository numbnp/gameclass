unit ufrmComputers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uAlignEdit, Buttons,
  ufrmComputerSelect,
  gccomputers;

type
  TfrmComputers = class(TForm)
    lblComputer: TLabel;
    lblNumber: TLabel;
    edtCount: TAlignEdit;
    btnSelect: TSpeedButton;
    memComputers: TMemo;
    procedure btnSelectClick(Sender: TObject);
    procedure memComputersChange(Sender: TObject);
  private
    FfrmComputerSelect: TfrmComputerSelect;
    FComputerAction: TComputerAction;
    FOnChangeEvent: TNotifyEvent;
    procedure _ComputerSelectNotifyEvent(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init(const AAction: TComputerAction;
        const AstrDefault: String = '');
    property ComputerAction: TComputerAction
        read FComputerAction write FComputerAction;
    property OnChange: TNotifyEvent
        read FOnChangeEvent write FOnChangeEvent;
  end;

implementation

uses
  gclangutils;

{$R *.dfm}


constructor TfrmComputers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOnChangeEvent := Nil;
  FfrmComputerSelect := TfrmComputerSelect.Create(Nil,
      _ComputerSelectNotifyEvent);
end;

destructor TfrmComputers.Destroy;
begin
  FreeAndNil(FfrmComputerSelect);
  inherited Destroy;
end;

procedure TfrmComputers._ComputerSelectNotifyEvent(Sender: TObject);
var
  nCount: Integer;
begin
  memComputers.Text := TfrmComputerSelect(Sender).SelectedAsText;
  edtCount.Text := IntToStr(TfrmComputerSelect(Sender).Count);
  if (TfrmComputerSelect(Sender).Count > 1) then begin
    lblComputer.Caption := translate('Computers');
    lblNumber.Visible := True;
    edtCount.Visible := True;
  end else begin
    lblComputer.Caption := translate('Computer');
    lblNumber.Visible := False;
    edtCount.Visible := False;
  end;
  if Assigned(FOnChangeEvent) then
    FOnChangeEvent(Self);
end;



procedure TfrmComputers.btnSelectClick(Sender: TObject);
var
  point: TPoint;
begin
  point.X := btnSelect.Width;
  point.Y := 0;
  point := btnSelect.ClientToScreen(point);
  FfrmComputerSelect.FillListAndShow(point, FComputerAction);
end;


procedure TfrmComputers.memComputersChange(Sender: TObject);
var
  nLength: Integer;
  nSize: Integer;
begin
  nSize := 20;
  nLength := Length(memComputers.Text);
  if nLength > 6 then
    nSize := 10;
  if nLength > 30 then
    nSize := 7;
  if nLength > 59 then
    nSize := 5;
  if nLength > 110 then
    nSize := 4;
  memComputers.Font.Size := nSize;
  edtCount.Text := IntToStr(nLength);
end;

procedure TfrmComputers.Init(const AAction: TComputerAction;
    const AstrDefault: String = '');
begin
  FComputerAction := AAction;
  if (AAction = caReserveCancel) or (AAction = caDec) then begin
    btnSelect.Enabled := False;
    lblComputer.Caption := translate('Computer');
    lblNumber.Visible := False;
    edtCount.Visible := False;
    memComputers.Text := AstrDefault;
  end else begin
    FfrmComputerSelect.Init(FComputerAction);
    _ComputerSelectNotifyEvent(FfrmComputerSelect);
  end;
end;

end.
