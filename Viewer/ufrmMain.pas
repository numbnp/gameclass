unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Grids, DBGridEh, StdCtrls, udmMain, ADODB, DB,
  Menus, ActnList, ToolWin, ImgList,framCompStatesList;

const
  WM_USER_UNBLOCK_PASSWORD = WM_USER+11;

resourcestring
  FORM_MAIN_CAPTION = 'Просмотр состояния клуба "%s" <оператор: %s>';
  ISMANAGER_WARNING =
      'Недостаточно прав!'#10#13
      + 'Выполните подключение под пользователем с правами группы manager.';
  WARNING = 'Предупреждение';


type
  TCompState = (csFree = 0, csFreeLimited = 1, csBusyLimited = 2, csBusy = 3);
  TfrmMain = class(TForm)
    pnlMain: TPanel;
    pnlLeft: TPanel;
    pnlMiddle: TPanel;
    pnlTimeBottom: TPanel;
    pnlTime: TPanel;
    lblTime: TLabel;
    tmrMain: TTimer;
    pnlTimeCaption: TPanel;
    pnlTimeRight: TPanel;
    grdCompStatesSecond: TDBGridEh;
    MainMenu1: TMainMenu;
    mnuSettings: TMenuItem;
    mnuActions: TMenuItem;
    mnuAbout: TMenuItem;
    mnuLock: TMenuItem;
    mnuUnlock: TMenuItem;
    mnuExit: TMenuItem;
    ActionList: TActionList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    actExit: TAction;
    actLock: TAction;
    actUnlock: TAction;
    actSettings: TAction;
    actAbout: TAction;
    imglstToolBar: TImageList;
    imglstCompState: TImageList;
    imglstComps: TImageList;
    lblSize: TLabel;

    procedure tmrMainTimer(Sender: TObject);
    procedure grdCompStatesFirstDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure grdReleaseDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure actExitExecute(Sender: TObject);
    procedure actLockExecute(Sender: TObject);
    procedure actUnlockExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FnFree: Integer;
    FnFreeLimited: Integer;
    FnBusyLimited: Integer;
    FnBusy: Integer;
    FnSpaceLimitMin: Integer;
    FnBusyLimitMin: Integer;
    FnSecondPos: Integer;
    FCompStates: array of Integer;

    CompStatesList: TCompStatesList;
    grdCompStatesFirst: TDBGridEh;


    function _GetGridCellRow(const AGrid: TDBGridEh;
        const Rect: TRect): Integer;
    function _GridCellRectToColRow(const AGrid: TDBGridEh;
        const Rect: TRect; var AnCol: Integer; var AnRow: Integer): Boolean;
    procedure _RefreshCompStates;
    function _GetCompState(const AnCompId: Integer;
        const AdstSessionsSelect: TADOStoredProc;
        var AdtLimit: TDateTime): TCompState;
    procedure _AddReleaseRow(const AnCount: Integer;
        const AstrCount: String);
    procedure _RefreshCompRelease;
    function _GetReleaseTime(const AnCount: Integer;
        const AdtTimeLength: TDateTime; var AstrTime: String): String;
    function _IsFreeTime(const AnCount: Integer;
        const AdtTimeLength: TDateTime; const AdtTime: TDateTime): Boolean;
    function _GetVisibleRowCount(const AGrid: TDBGridEh): Integer;
    procedure _SetTableFont(const AFont: TFont);
    procedure _Unlock;
  public
    procedure ApplySettings;
    procedure HotKey(var Message: TMessage);
        message WM_HOTKEY;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Types,
  DateUtils,
  ufrmSettings,
  uViewerOptions,
  uY2KCommon,
  uWinhkg,
  ufrmUnblockPassword,
  ufrmAbout,
  Math;

{$R *.dfm}

procedure TfrmMain.tmrMainTimer(Sender: TObject);
var
  strTime: String;
begin
  if (SecondOf(Now) mod 5 = 0) then begin
    _RefreshCompStates;
    _RefreshCompRelease;
  end;
  if (SecondOf(Now) mod 2 = 0) then
    DateTimeToString(strTime, 'HH:mm', Now)
  else
    DateTimeToString(strTime, 'HH mm', Now);
  lblTime.Caption := strTime;
end;


function TfrmMain._GetGridCellRow(const AGrid: TDBGridEh;
    const Rect: TRect): Integer;
var
  i, j: Integer;
begin
  Result := -1;
  for i := 0 to AGrid.Columns.Count - 1 do
    for j := 0 to AGrid.RowCount - 1 do
      if (Rect.Top = AGrid.CellRect(i, j).Top) then
        Result := j;
end;

function TfrmMain._GridCellRectToColRow(const AGrid: TDBGridEh;
    const Rect: TRect; var AnCol: Integer; var AnRow: Integer): Boolean;
var
  i, j: Integer;
begin
  Result := False;
  for i := 0 to AGrid.Columns.Count - 1 do
    for j := 0 to AGrid.RowCount - 1 do
      if (Rect.Top = grdCompStatesFirst.CellRect(i, j).Top) and
        (Rect.Left = grdCompStatesFirst.CellRect(i, j).Left) then begin
        AnCol := i;
        AnRow := j;
        Result := True;
      end;
end;

procedure TfrmMain._RefreshCompStates;
var
  nComps, nId :Integer;
  strTime: String;
  dtLimit: TDateTime;
  cs: TCompState;
  nCompState: Integer;
begin
  with dmMain do begin
    dstCompStates.DisableControls;
    dstCompStates.Close;
    dstCompStates.CreateDataSet;
    if Options.General.SortByNumber.Value then begin
      dstCompStates.Sort := 'number ASC';
    end else begin
      dstCompStates.Sort := 'state ASC, number ASC';
    end;
    if cnnMain.Connected then begin
      dstCompsSelect.Close;
      dstCompsSelect.Parameters[1].Value := -1;
      dstCompsSelect.Open;
      SetSessionsSelect(cnnMain);
      dstSessionsSelect.Close;
      SetSessionsSelectMoment(Now);
//      dstSessionsSelect.Parameters[1].Value := Now;
      dstSessionsSelect.Open;
      SetLength(FCompStates, dstCompsSelect.RecordCount);
      nComps := 0;
      FnFree := 0;
      FnFreeLimited := 0;
      FnBusyLimited := 0;
      FnBusy := 0;
      dstCompsSelect.First;
      while not dstCompsSelect.Eof do begin
        dstCompStates.Append;
        Inc(nComps);
        dstCompStates.FieldValues['icon'] := 0;
        dstCompStates.FieldValues['id'] := nComps;
        dstCompStates.FieldValues['idComp'] :=
            dstCompsSelect.FieldValues['id'];
        dstCompStates.FieldValues['number'] :=
            dstCompsSelect.FieldValues['number'];
        cs := _GetCompState(dstCompsSelect.FieldValues['id'],
            dstSessionsSelect, dtLimit);
        nCompState := Integer(cs);
        if not Options.General.MarkBusyLimited.Value
            and (cs = csBusyLimited) then
          nCompState := Integer(csBusy);
        if not Options.General.MarkFreeLimited.Value
            and (cs = csFreeLimited) then
          nCompState := Integer(csFree);
        dstCompStates.FieldValues['state'] := nCompState;
        if cs <> csFree then
          DateTimeToString(strTime , 'HH:mm', dtLimit);
        case cs of
          csFree: begin
            Inc(FnFree);
            dstCompStates.FieldValues['description'] := 'Свободен';
          end;
          csFreeLimited: begin
            Inc(FnFreeLimited);
            dstCompStates.FieldValues['description'] := 'Свободен до ' + strTime;
          end;
          csBusyLimited: begin
            Inc(FnBusyLimited);
            dstCompStates.FieldValues['description'] := 'Свободен с ' + strTime;
          end;
          csBusy: begin
            Inc(FnBusy);
            dstCompStates.FieldValues['description'] := 'Занят до ' + strTime;
          end;
        end;
        dstCompStates.Post;
        dstCompsSelect.Next;
      end;
      nComps := 0;
      dstCompStates.First;
      while not dstCompStates.Eof do begin
        FCompStates[nComps] := dstCompStates.FieldValues['state'];
        dstCompStates.Next;
        Inc(nComps);
      end;
    end;
    dstCompStatesSecond.Close;
    dstCompStatesSecond.CreateDataSet;
    if Options.General.SortByNumber.Value then begin
      dstCompStatesSecond.Sort := 'number ASC';
    end else begin
      dstCompStatesSecond.Sort := 'state ASC, number ASC';
    end;
    FnSecondPos := _GetVisibleRowCount(grdCompStatesFirst);
    nComps := 0;
    if FnSecondPos < dstCompStates.RecordCount then begin
      pnlMiddle.Visible := True;
      dstCompStates.First;
      dstCompStates.MoveBy(FnSecondPos);
      while not (dstCompStates.Eof or (nComps > FnSecondPos)) do begin
        with dstCompStates do
          dstCompStatesSecond.AppendRecord([FieldValues['id'],
              FieldValues['idComp'],
              FieldValues['number'],
              FieldValues['state'],
              FieldValues['description'],
              FieldValues['icon']]);
        Inc(nComps);
        dstCompStates.Next;
      end;
    end else
      pnlMiddle.Visible := False;
    dstCompStatesSecond.First;
    dstCompStates.First;
    dstCompStates.EnableControls;
  end;
end;

function TfrmMain._GetCompState(const AnCompId: Integer;
    const AdstSessionsSelect: TADOStoredProc;
    var AdtLimit: TDateTime): TCompState;
var
  dtStart, dtStop: TDateTime;
begin
  Result := csFree;
  with dmMain do begin
    AdstSessionsSelect.Filter := 'idComp = ' + IntToStr(AnCompId);
    AdstSessionsSelect.Filtered := True;
    AdstSessionsSelect.Sort := 'start ASC';
    AdstSessionsSelect.First;
      if AdstSessionsSelect.RecordCount > 0 then begin
      dtStart := AdstSessionsSelect.FieldValues['start'];
      dtStop := AdstSessionsSelect.FieldValues['stop'];
      // уже занят
      if CompareDateTime(dtStart, Now) <> GreaterThanValue then begin
        // занят менее чем на FnBusyLimited
        if MinutesBetween(dtStop, Now) <= FnBusyLimitMin then begin
          Result := csBusyLimited;
        end else begin
          Result := csBusy;
        end;
        AdtLimit := dtStop;
      // бронь
      end else begin
        if MinutesBetween(dtStart, Now) <= FnSpaceLimitMin then begin
          Result := csBusy;
          AdtLimit := dtStop;
        end else begin
          Result := csFreeLimited;
          AdtLimit := dtStart;
        end;
      end;
      if (Result = csBusy) or (Result = csBusyLimited) then begin
        // если интервалы меньше FnSpaceLimitMin увеличиваем stop
        while not dstSessionsSelect.Eof do begin
          dstSessionsSelect.Next;
          dtStart := dstSessionsSelect.FieldValues['start'];
          dtStop := dstSessionsSelect.FieldValues['stop'];
          if MinutesBetween(dtStart, AdtLimit) <= FnSpaceLimitMin then
            AdtLimit := dtStop
          else
            Break;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.grdCompStatesFirstDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  nCol, nRow: Integer;
begin
  _GridCellRectToColRow(TDBGridEh(Sender), Rect, nCol, nRow);
  if nCol <> 1 then begin
    if not Options.General.UseLargeIcons.Value then begin
      if TDBGridEh(Sender) = grdCompStatesSecond then
        nRow := nRow + FnSecondPos;
      case TCompState(FCompStates[nRow - 1]) of
        csFree:
          TDBGridEh(Sender).Canvas.Brush.Color := TColor($00FF00);
        csFreeLimited:
          TDBGridEh(Sender).Canvas.Brush.Color := TColor($00FFFF);
        csBusyLimited:
          TDBGridEh(Sender).Canvas.Brush.Color := TColor($1D94F7);
        csBusy:
          TDBGridEh(Sender).Canvas.Brush.Color := TColor($6D9CC6);
      end;
    end;
    Column.Layout := tlCenter;
    TDBGridEh(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ApplySettings;
  _RefreshCompStates;
  _RefreshCompRelease;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  k: TPanel;
begin
  FnSpaceLimitMin := 10;
  FnBusyLimitMin := 10;
  FnSecondPos := 0;
  pnlTime.Color := TColor($F0CAA6);
  pnlTimeCaption.Color := TColor($F6CF6D);

  CompStatesList:= TCompStatesList.Create(self);
  CompStatesList.Parent := pnlLeft;
  CompStatesList.Align := alClient;

  grdCompStatesFirst := CompStatesList.grdCompStatesFirst;

  k:= tpanel.Create(self);
  k.Parent := frmMain;

  k.Width := 100;
  k.Top :=10;
  k.left :=200;
  k.Align := alLeft;

end;

procedure TfrmMain.ApplySettings;
begin
  with Options.General do begin
    _SetTableFont(StrToFont(Font.Value));
    FnSpaceLimitMin := SpaceLimitMin.Value;
    FnBusyLimitMin := SpaceLimitMin.Value;
    if UseLargeIcons.Value then begin
      grdCompStatesFirst.RowHeight := 48;
      grdCompStatesFirst.Columns[1].Visible := True;
      grdCompStatesSecond.RowHeight := 48;
      grdCompStatesSecond.Columns[1].Visible := True;
    end else begin
      grdCompStatesFirst.RowHeight := 0;
      grdCompStatesFirst.Columns[1].Visible := False;
      grdCompStatesSecond.RowHeight := 0;
      grdCompStatesSecond.Columns[1].Visible := False;
    end;
  end;
end;

procedure TfrmMain._RefreshCompRelease;
begin
  with dmMain do begin
    dstCompRelease.DisableControls;
    dstCompRelease.Close;
    dstCompRelease.CreateDataSet;
    _AddReleaseRow(1, '1 комп');
    _AddReleaseRow(2, '2 компа');
    _AddReleaseRow(3, '3 компа');
    _AddReleaseRow(4, '4 компа');
    _AddReleaseRow(5, '5 компов');
    _AddReleaseRow(6, '6 компов');
    _AddReleaseRow(7, '7 компов');
    _AddReleaseRow(8, '8 компов');
    _AddReleaseRow(9, '9 компов');
    _AddReleaseRow(10, '10 компов');
    dstCompRelease.EnableControls;
    dstCompRelease.First;
  end;
end;


procedure TfrmMain._AddReleaseRow(const AnCount: Integer;
    const AstrCount: String);
var
  nComps, nId :Integer;
  strTime: String;
  dtLimit: TDateTime;
  cs: TCompState;
begin
  with dmMain do begin
    dstCompRelease.Append;
    dstCompRelease.FieldValues['count'] := AstrCount;
    if cnnMain.Connected then begin
      dstCompRelease.FieldValues['time0.5'] :=
          _GetReleaseTime(AnCount, EncodeTime(0, 30, 0, 0), strTime);
      dstCompRelease.FieldValues['time1'] :=
          _GetReleaseTime(AnCount, EncodeTime(1, 0, 0, 0), strTime);
      dstCompRelease.FieldValues['time1.5'] :=
          _GetReleaseTime(AnCount, EncodeTime(1, 30, 0, 0), strTime);
      dstCompRelease.FieldValues['time2'] :=
          _GetReleaseTime(AnCount, EncodeTime(2, 0, 0, 0), strTime);
      dstCompRelease.FieldValues['time3'] :=
          _GetReleaseTime(AnCount, EncodeTime(3, 0, 0, 0), strTime);
      dstCompRelease.FieldValues['time'] := strTime;
      dstCompRelease.FieldValues['time4'] :=
          _GetReleaseTime(AnCount, EncodeTime(4, 0, 0, 0), strTime);
    end;
    dstCompRelease.Post;
  end;
end;

function TfrmMain._GetReleaseTime(const AnCount: Integer;
    const AdtTimeLength: TDateTime; var AstrTime: String): String;
var
  nComps, nId :Integer;
  strTime: String;
  dtLimit: TDateTime;
  cs: TCompState;
begin
  Result := '';
  if not _IsFreeTime(AnCount, AdtTimeLength, Now) then begin
    with dmMain do begin
      dstTimes.Close;
      dstTimes.CreateDataSet;
      dstSessionsSelect.Filtered := False;
      dstSessionsSelect.First;
      while not dstSessionsSelect.Eof do begin
        if CompareDateTime(dstSessionsSelect.FieldValues['start'], Now) =
            GreaterThanValue then begin
          dstTimes.Append;
          dstTimes.FieldValues['time'] := dstSessionsSelect.FieldValues['start'];
          dstTimes.Post;
        end;
        if CompareDateTime(dstSessionsSelect.FieldValues['stop'], Now) =
            GreaterThanValue then begin
          dstTimes.Append;
          dstTimes.FieldValues['time'] := dstSessionsSelect.FieldValues['stop'];
          dstTimes.Post;
        end;
        dstSessionsSelect.Next;
      end;
      dstTimes.Sort := 'time ASC';
      dstTimes.First;
      while not dstTimes.Eof do begin
        if _IsFreeTime(AnCount, AdtTimeLength,
            dstTimes.FieldValues['time']) then begin
          DateTimeToString(strTime, 'HH:mm',
              dstTimes.FieldValues['time']);
          DateTimeToString(strTime, 'HH:mm',
              Now);
          DateTimeToString(strTime, 'HH:mm',
              dstTimes.FieldValues['time'] - Now);
          Result := 'через ' + strTime;
          DateTimeToString(AstrTime, 'HH:mm',
              dstTimes.FieldValues['time']);
          Break;
        end;
        dstTimes.Next;
      end;
    end;
  end;
end;

function TfrmMain._IsFreeTime(const AnCount: Integer;
    const AdtTimeLength: TDateTime; const AdtTime: TDateTime): Boolean;
var
  nBusyComps :Integer;
  strTime: String;
  dtLimit: TDateTime;
  cs: TCompState;
begin
  with dmMain.dstSessionsSelect do begin
    Filtered := False;
    Sort := 'start ASC';
    First;
    nBusyComps := 0;
    while not Eof do begin
      if not (((FieldValues['start'] <= AdtTime)
          and (FieldValues['stop'] <= AdtTime))
          or ((FieldValues['start'] >= AdtTime + AdtTimeLength)
          and (FieldValues['stop'] >= AdtTime + AdtTimeLength))) then
        Inc(nBusyComps);
      Next;
    end;
  end;
  Result := (AnCount <= (dmMain.dstCompsSelect.RecordCount - nBusyComps));
end;

function TfrmMain._GetVisibleRowCount(const AGrid: TDBGridEh): Integer;
var
  nRowHeght, nTitleHeight: Integer;
begin
  nTitleHeight := AGrid.CellRect(0,0).Bottom
      - AGrid.CellRect(0,0).Top  + 1;
  nRowHeght := AGrid.CellRect(1,1).Bottom
      - AGrid.CellRect(1,1).Top + 1;
  Result := (AGrid.ClientHeight -  nTitleHeight) div nRowHeght;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  _RefreshCompStates;
end;

procedure TfrmMain.grdReleaseDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  nRow: Integer;
begin
  nRow := _GetGridCellRow(TDBGridEh(Sender), Rect);
  if nRow mod 2 = 0 then
    TDBGridEh(Sender).Canvas.Brush.Color := TColor($D3D3D3)
  else
    TDBGridEh(Sender).Canvas.Brush.Color := TColor($E6E6E6);
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.actLockExecute(Sender: TObject);
begin
  actExit.Enabled := False;
  actLock.Enabled := False;
  actSettings.Enabled := False;
  actAbout.Enabled := False;
  actUnlock.Enabled := True;;
  GWinhkg.LockKeyboard;
  GWinhkg.LockMouse;
end;

procedure TfrmMain.actUnlockExecute(Sender: TObject);
begin
  if frmUnblockPassword.ShowModal <> mrOK then begin
    Application.MessageBox('Нужно ввести пароль разблокирования',
        'Сообщение',MB_OK);
  end else begin
    Application.MessageBox('Компьютер разблокирован!' + Chr(13) + Chr(10)
        + 'Для включения блокировки нажмите еще раз Ctrl+Alt+U!',
        'Сообщение', MB_OK);
    _Unlock;
  end;
end;

procedure TfrmMain._Unlock;
begin
  actExit.Enabled := True;
  actLock.Enabled := True;
  actSettings.Enabled := True;
  actAbout.Enabled := True;
  actUnlock.Enabled := False;
  GWinhkg.UnlockKeyboard;
  GWinhkg.UnlockMouse;
end;

procedure TfrmMain.actSettingsExecute(Sender: TObject);
var
  frmSettings: TfrmSettings;
begin
  if dmMain.IsManager(dmMain.cnnMain) then begin
    frmSettings := TfrmSettings.Create(Self);
    frmSettings.ShowModal;
    FreeAndNil(frmSettings);
  end else
    Application.MessageBox(PChar(ISMANAGER_WARNING), PChar(WARNING),
        MB_OK or MB_ICONWARNING);
end;

procedure TfrmMain._SetTableFont(const AFont: TFont);
begin
  lblSize.Font.Assign(AFont);
  grdCompStatesFirst.Font.Assign(AFont);
  grdCompStatesSecond.Font.Assign(AFont);
  pnlLeft.Width := pnlLeft.BorderWidth * 2
      + grdCompStatesFirst.Columns[0].Width
      + IfThen(Options.General.UseLargeIcons.Value,
      grdCompStatesFirst.Columns[1].Width + 1, 0)
      + lblSize.Width + 16;
  pnlMiddle.Width := pnlLeft.Width;
end;

procedure TfrmMain.HotKey(var Message: TMessage);
begin
  if (Message.LParam = MakeLong(MOD_ALT or MOD_CONTROL, $55{U}))
      // против глюка с множественным открытием
      and not frmUnblockPassword.Visible then begin
    if actLock.Enabled then begin
      actLock.Execute;
    end else begin
      actUnlock.Execute;
    end;
  end;
end;


procedure TfrmMain.actAboutExecute(Sender: TObject);
var
  frmAbout: TfrmAbout;
begin
  frmAbout := TfrmAbout.Create(Self);
  frmAbout.ShowModal;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  tmrMain.Enabled := False;
  OnShow := Nil;
  OnResize := Nil;
end;

end.
