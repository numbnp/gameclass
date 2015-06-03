//////////////////////////////////////////////////////////////////////////////
//
// TY2KLinkedPanel.
//
// TODO:
// 1) Пересоздавать сепараторы после смены свойства "Separator".
//
//////////////////////////////////////////////////////////////////////////////
unit uY2KLinkedPanel;

interface

uses
  // system units
  SysUtils,
  Graphics,
  Windows,
  Classes,
  Contnrs,
  Controls,
  StdCtrls,
  ExtCtrls;


const
  LINKLBL_CLICK = $1001;


type

  TLabelPosition = (LBLPOS_BEGIN, LBLPOS_END);

  TLinkLabelClickMessage = packed record
    Msg: Cardinal;
    Id: Integer;
  end;


  // events types
  TLinkClick = procedure (Sender: TObject; const AnLinkId: Integer) of object;


  //
  // TY2KLinkedPanel
  //

  TY2KLinkedPanel = class(TPanel)
  private
    // fields
    FstrSeparator: String;
    FlstLabels: TComponentList;
    FOnLinkClick: TLinkClick;
    FbNextLine: Boolean;
    FfntLabel: TFont;
    FnLeftIndent: Integer;
    FnRightIndent: Integer;
    FbAutoResize: Boolean;

    // messages handlers
    procedure _LinkLabelClick(var Message: TLinkLabelClickMessage);
        message LINKLBL_CLICK;


    // events handlers
    procedure _LabelClick(Sender: TObject);
    procedure _LabelFontChange(Sender: TObject);

    // private helper methods
    procedure _CreateAndAddText(const AstrText: String;
        const ALabelPosition: TLabelPosition);
    procedure _CreateAndAddLink(const AstrLink: String; const AnId: Integer;
        const ALabelPosition: TLabelPosition);
    procedure _CreateAndAddSeparator(const ALabelPosition: TLabelPosition);
    procedure _InitLabel(const AlblValue: TLabel; const AstrCaption: String);
    procedure _AddLabelToList(const Albl: TLabel;
        const ALabelPosition: TLabelPosition);
    procedure _RecalculateLabelsPositions();
    procedure _SetPanelHeight(const AnLinesCount: Integer);
    procedure _SetLabelsFont();
    procedure _ClearLabels();
    procedure _RealignLabelsTop(const AnPanelHeight: Integer);

    // fire methods
    procedure _FireLinkClick(const AnLinkId: Integer);

  protected
    // overrided methods
    procedure Resize(); override;

    // properties methods
    function GetSeparator(): String; virtual;
    procedure SetSeparator(const AstrSeparator: String); virtual;

    procedure SetFont(const AfntLabel: TFont);

    procedure SetLeftIndent(const AnLeftIndent: Integer);

    procedure SetRightIndent(const AnRightIndent: Integer);

    procedure SetAutoResize(const AbAutoResize: Boolean);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // public methods
    procedure AddFirstLink(const AstrLink: String; const AnId: Integer);
    procedure AddFirstText(const AstrText: String);
    procedure AddFirstSeparator();

    procedure AddLink(const AstrLink: String; const AnId: Integer);
    procedure AddText(const AstrText: String);
    procedure AddSeparator();

    procedure SetIndents(const AnLeftIndent: Integer;
        const AnRightIndent: Integer);

    function GetLinksAsString(): String;

    procedure ClearLinks();

    procedure CopyToClipboard();

  published
    // properties
    property AutoResize: Boolean read FbAutoResize write SetAutoResize;
    property LeftIndent: Integer read FnLeftIndent write SetLeftIndent;
    property RightIndent: Integer read FnRightIndent write SetRightIndent;
    property LabelFont: TFont read FfntLabel write SetFont;
    property Separator: String read GetSeparator write SetSeparator;
    property OnLinkClick: TLinkClick read FOnLinkClick write FOnLinkClick;

  end; // TY2KLinkedPanel


implementation

uses
  // system units
  Clipbrd,
  // project units
  uY2KLinkLabel;

const
  AUTORESIZE_DEF = TRUE;
  STR_SEPARATOR = '\';
  LEFT_INDENT_DEF = 5;
  RIGHT_INDENT_DEF = 5;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KLinkedPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FbAutoResize := AUTORESIZE_DEF;

  FnLeftIndent := LEFT_INDENT_DEF;
  FnRightIndent := RIGHT_INDENT_DEF;

  Separator  := STR_SEPARATOR;
  FfntLabel := TFont.Create();
  FfntLabel.OnChange := _LabelFontChange;

  FlstLabels := TComponentList.Create(FALSE);

  FbNextLine := FALSE;

end; // TY2KLinkedPanel.Create


destructor TY2KLinkedPanel.Destroy();
begin
  FreeAndNil(FfntLabel);
  FreeAndNil(FlstLabels);

  inherited Destroy();

end; // TY2KLinkedPanel.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TY2KLinkedPanel.AddFirstLink(
    const AstrLink: String; const AnId: Integer);
begin
  _CreateAndAddLink(AstrLink, AnId, LBLPOS_BEGIN);
end; // TY2KLinkedPanel.AddFirstLink


procedure TY2KLinkedPanel.AddFirstText(const AstrText: String);
begin
  _CreateAndAddText(AstrText, LBLPOS_BEGIN);
end; // TY2KLinkedPanel.AddFirstText


procedure TY2KLinkedPanel.AddFirstSeparator();
begin
  _CreateAndAddSeparator(LBLPOS_BEGIN);
end; // TY2KLinkedPanel.AddFirstSeparator


procedure TY2KLinkedPanel.AddLink(
    const AstrLink: String; const AnId: Integer);
begin
  _CreateAndAddLink(AstrLink, AnId, LBLPOS_END);
end; // TY2KLinkedPanel.AddLink


procedure TY2KLinkedPanel.AddText(const AstrText: String);
begin
  _CreateAndAddText(AstrText, LBLPOS_END);
end; // TY2KLinkedPanel.AddText


procedure TY2KLinkedPanel.AddSeparator();
begin
  _CreateAndAddSeparator(LBLPOS_END);
end; // TY2KLinkedPanel.AddSeparator


procedure TY2KLinkedPanel.SetIndents(const AnLeftIndent: Integer;
    const AnRightIndent: Integer);
begin
  FnLeftIndent := AnLeftIndent;
  FnRightIndent := AnRightIndent;
  _RecalculateLabelsPositions();
end; // TY2KLinkedPanel.SetIndents


function TY2KLinkedPanel.GetLinksAsString(): String;
var
  i: Integer;
  strResult: String;
begin
  strResult := '';
  for i := 0 to FlstLabels.Count - 1 do begin
    strResult := strResult + (FlstLabels[i] as TLabel).Caption;
  end;
  Result := strResult;
end; // TY2KLinkedPanel.GetLinksAsString


procedure TY2KLinkedPanel.ClearLinks();
begin
  _ClearLabels();
  _RecalculateLabelsPositions();
end; // TY2KLinkedPanel.ClearLinks


procedure TY2KLinkedPanel.CopyToClipboard();
var
  strLinks: String;
begin
  strLinks := GetLinksAsString();
  Clipboard.AsText := strLinks;
end; // TY2KLinkedPanel.CopyToClipboard


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected overrided methods

procedure TY2KLinkedPanel.Resize();
begin
  _RecalculateLabelsPositions();
  inherited Resize();
end; // TY2KLinkedPanel.Resize


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TY2KLinkedPanel.GetSeparator(): String;
begin
  Result := FstrSeparator;
end; // TY2KLinkedPanel.GetSeparator


procedure TY2KLinkedPanel.SetSeparator(const AstrSeparator: String);
begin
  FstrSeparator := AstrSeparator;
end; // TY2KLinkedPanel.SetSeparator


procedure TY2KLinkedPanel.SetFont(const AfntLabel: TFont);
begin
  FfntLabel := AfntLabel;
end; // TY2KLinkedPanel.SetFont


procedure TY2KLinkedPanel.SetLeftIndent(const AnLeftIndent: Integer);
begin
  FnLeftIndent := AnLeftIndent;
  _RecalculateLabelsPositions();
end; // TY2KLinkedPanel.SetLeftIndent


procedure TY2KLinkedPanel.SetRightIndent(const AnRightIndent: Integer);
begin
  FnRightIndent := AnRightIndent;
  _RecalculateLabelsPositions();
end; // TY2KLinkedPanel.SetRightIndent


procedure TY2KLinkedPanel.SetAutoResize(const AbAutoResize: Boolean);
begin
  FbAutoResize := AbAutoResize;
  if FbAutoResize then begin
    _RecalculateLabelsPositions();

    // Способ обновления информации.
    // Invalidate не дает нужного эффекта.
    Self.Resize();

  end;
end; // TY2KLinkedPanel.SetAutoResize


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events and messages handlers

procedure TY2KLinkedPanel._LinkLabelClick(
    var Message: TLinkLabelClickMessage);
begin
  _FireLinkClick(Message.Id);
end; // TY2KLinkedPanel._LinkLabelClick


procedure TY2KLinkedPanel._LabelFontChange(Sender: TObject);
begin
  _SetLabelsFont();
  _RecalculateLabelsPositions();
end; // TY2KLinkedPanel._LabelFontChange


procedure TY2KLinkedPanel._LabelClick(Sender: TObject);
var
  Message: TLinkLabelClickMessage;
begin
  if Sender is TY2KLinkLabel then begin
    Message.Msg := LINKLBL_CLICK;
    Message.Id := (Sender as TY2KLinkLabel).Tag;
    PostMessage(Self.Handle, LINKLBL_CLICK,
        (Sender as TY2KLinkLabel).Tag, 0);
  end;
end; // TY2KLinkedPanel._OnLabelClick


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TY2KLinkedPanel._InitLabel(const AlblValue: TLabel;
    const AstrCaption: String);
begin
  AlblValue.Parent := Self;
  AlblValue.Font.Color := FfntLabel.Color;
  AlblValue.Font.Style := FfntLabel.Style;
  AlblValue.AutoSize := True;
  AlblValue.Caption := AstrCaption;
end; // TY2KLinkedPanel._InitLabel


procedure TY2KLinkedPanel._CreateAndAddLink(
    const AstrLink: String; const AnId: Integer;
    const ALabelPosition: TLabelPosition);
var
  lbl: TY2KLinkLabel;
begin
  lbl := TY2KLinkLabel.Create(Self);
  _InitLabel(lbl, AstrLink);
  lbl.FontIn.Color := FfntLabel.Color;
  lbl.FontIn.Style := FfntLabel.Style + [fsUnderline];
  lbl.FontOut.Color := FfntLabel.Color;
  lbl.FontOut.Style := FfntLabel.Style;
  lbl.Tag := AnId;
  lbl.OnClick := _LabelClick;
  lbl.Show();

  _AddLabelToList(lbl, ALabelPosition);

  if FbAutoResize then begin
    _RecalculateLabelsPositions();
  end;

end; // TY2KLinkedPanel._CreateAndAddLink


procedure TY2KLinkedPanel._CreateAndAddSeparator(
    const ALabelPosition: TLabelPosition);
var
  lbl: TLabel;
begin
  lbl := TLabel.Create(Self);
  _InitLabel(lbl, Separator);
  lbl.Show();

  _AddLabelToList(lbl, ALabelPosition);

  if FbAutoResize then begin
    _RecalculateLabelsPositions();
  end;

end; // TY2KLinkedPanel._CreateAndAddSeparator


procedure TY2KLinkedPanel._CreateAndAddText(const AstrText: String;
    const ALabelPosition: TLabelPosition);
var
  lbl: TLabel;
begin
  lbl := TLabel.Create(Self);
  _InitLabel(lbl, AstrText);
  lbl.Show();

  _AddLabelToList(lbl, ALabelPosition);

  if FbAutoResize then begin
    _RecalculateLabelsPositions();
  end;

end; // TY2KLinkedPanel._CreateAndAddText


procedure TY2KLinkedPanel._AddLabelToList(const Albl: TLabel;
    const ALabelPosition: TLabelPosition);
begin
  if ALabelPosition = LBLPOS_END then begin
    FlstLabels.Add(Albl);
  end else if ALabelPosition = LBLPOS_BEGIN then begin
    FlstLabels.Insert(0, Albl);
  end else begin
    ASSERT(FALSE, 'Unknown label position!');
  end;
end; // TY2KLinkedPanel._AddLabelToList


procedure TY2KLinkedPanel._RecalculateLabelsPositions();
var
  i: Integer;
  nLastLeft: Integer;
  nLastTop: Integer;
  nLinesCount: Integer;
begin
  nLinesCount := 1;

  for i := 0 to FlstLabels.Count - 1 do begin
    if i = 0 then begin
      (FlstLabels[i] as TLabel).Left := LeftIndent;
      (FlstLabels[i] as TLabel).Top := 2;
      continue;
    end;

    FbNextLine := FALSE;

    nLastLeft := (FlstLabels[i-1] as TLabel).Left
      + (FlstLabels[i-1] as TLabel).Width + 5;
    if (nLastLeft + (FlstLabels[i] as TLabel).Width)
        > (Self.Width - RightIndent) then begin

      FbNextLine := TRUE;
      nLinesCount := nLinesCount + 1;
      (FlstLabels[i] as TLabel).Left := LeftIndent;

    end else begin
      (FlstLabels[i] as TLabel).Left := nLastLeft;
    end;

    nLastTop := (FlstLabels[i-1] as TLabel).Top;
    if FbNextLine then begin
      (FlstLabels[i] as TLabel).Top := nLastTop
          + (FlstLabels[i] as TLabel).Canvas.TextHeight('I') + 1;
    end else begin
      (FlstLabels[i] as TLabel).Top := nLastTop;
    end;

  end;

  _SetPanelHeight(nLinesCount);

end; // TY2KLinkedPanel._RecalculateLabelsPositions


procedure TY2KLinkedPanel._RealignLabelsTop(const AnPanelHeight: Integer);
var
  i: Integer;
  nCorrect: Integer;
begin
  nCorrect := (Constraints.MinHeight - AnPanelHeight) div 2;
  if nCorrect <= 2 then begin
    exit;
  end;

  for i := 0 to FlstLabels.Count - 1 do begin
    (FlstLabels[i] as TLabel).Top := (FlstLabels[i] as TLabel).Top + nCorrect;
  end;
end; // TY2KLinkedPanel._RealignLabelsTop


procedure TY2KLinkedPanel._SetPanelHeight(
    const AnLinesCount: Integer);
var
  nTextHeight: Integer;
  nPanelHeight: Integer;
begin
  if FlstLabels.Count > 0 then begin
    // Буква I в TextHeight взята просто так.
    // Вместо нее может быть любая другая буква или текст.
    nTextHeight := (FlstLabels.Last as TLabel).Canvas.TextHeight('I');
    nPanelHeight := (nTextHeight + 1) * AnLinesCount + 4;
    if nPanelHeight < Constraints.MinHeight then begin
      _RealignLabelsTop(nPanelHeight);
      Self.Height := Constraints.MinHeight;
    end else begin
      Self.Height := nPanelHeight;
    end;
  end;
end; // TY2KLinkedPanel._SetPanelHeight


procedure TY2KLinkedPanel._SetLabelsFont();
var
  i: Integer;
begin
  for i := 0 to FlstLabels.Count - 1 do begin
    if FlstLabels[i] is TLabel then begin
      with (FlstLabels[i] as TLabel).Font do begin
        Color := FfntLabel.Color;
        Style := FfntLabel.Style;
      end;
    end;
    if FlstLabels[i] is TY2KLinkLabel then begin
      with (FlstLabels[i] as TY2KLinkLabel).FontIn do begin
        Color := FfntLabel.Color;
        Style := FfntLabel.Style + [fsUnderline];
      end;
      with (FlstLabels[i] as TY2KLinkLabel).FontOut do begin
        Color := FfntLabel.Color;
        Style := FfntLabel.Style + [fsUnderline];
      end;
    end;
  end;
end; // TY2KLinkedPanel._SetLabelsFont


procedure TY2KLinkedPanel._ClearLabels();
var
  i: Integer;
begin
  for i := FlstLabels.Count - 1 downto 0 do begin
    FlstLabels[i].Free();
  end;
end; // TY2KLinkedPanel._ClearLabels


//////////////////////////////////////////////////////////////////////////////
// fire methods

procedure TY2KLinkedPanel._FireLinkClick(const AnLinkId: Integer);
begin
  if Assigned(OnLinkClick) then begin
    OnLinkClick(Self, AnLinkId)
  end;
end; // TY2KLinkedPanel._FireLinkClick


end.
