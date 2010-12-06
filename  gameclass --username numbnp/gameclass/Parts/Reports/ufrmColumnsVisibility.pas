unit ufrmColumnsVisibility;

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
  ExtCtrls,
  ActnList,
  StdCtrls,
  CheckLst,
//  uLanguagesManager,
  uReportColumn;


type

  // events types
  TColumnsVisibilityApply = procedure(ASender: TObject) of object;


  //
  // TfrmColumnsVisibility
  //

  TfrmColumnsVisibility = class(TForm)
    lbxColumns: TCheckListBox;
    btnClose: TButton;
    btnApply: TButton;
    actlstColumnsVisibility: TActionList;
    actApply: TAction;
    actClose: TAction;
    imgMain: TImage;
    lblColumns: TLabel;
    procedure actApplyExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actlstColumnsVisibilityUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure lbxColumnsClickCheck(Sender: TObject);

  private
    // fields
    FbIsChanged: Boolean;
    FOnColumnsVisibilityApply: TColumnsVisibilityApply;

//    FLanguagesManagerLink: TLanguagesManagerLink;

    // events handlers
//    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _BuildCheckListBox(const AReportColumns: TReportColumnList);
//    procedure _SubscribeToLanguagesManagerEvents();

    // fire methods
    procedure _FireColumnsVisibilityApply();

  public
    // constructor / destructor
    constructor Create(const AOwner: TComponent;
        const AReportColumns: TReportColumnList); reintroduce;
    destructor Destroy(); override;

    // properties
    property OnApply: TColumnsVisibilityApply
        read FOnColumnsVisibilityApply write FOnColumnsVisibilityApply;

  end; // TfrmColumnsVisibility


implementation

{$R *.dfm}

const
  CLASS_NAME = 'TfrmColumnsVisibility';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmColumnsVisibility.Create(const AOwner: TComponent;
    const AReportColumns: TReportColumnList);
begin
  inherited Create(AOwner);

  FbIsChanged := FALSE;
  _BuildCheckListBox(AReportColumns);

//  _SubscribeToLanguagesManagerEvents();
//  _LanguageChange(Self);

end; // TfrmColumnsVisibility.Create


destructor TfrmColumnsVisibility.Destroy();
begin
//  FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmColumnsVisibility.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmColumnsVisibility.actApplyExecute(Sender: TObject);
var
  i: Integer;
  ReportColumn: TReportColumn;
begin
  for i := 0 to lbxColumns.Count - 1 do begin
    ReportColumn := TReportColumn(lbxColumns.Items.Objects[i]);
    if Assigned(ReportColumn) then begin
      ReportColumn.Visible := lbxColumns.Checked[i];
    end;
  end;
  FbIsChanged := FALSE;
  _FireColumnsVisibilityApply();
end; // TfrmColumnsVisibility.actApplyExecute


procedure TfrmColumnsVisibility.actCloseExecute(Sender: TObject);
begin
  Close();
end; // TfrmColumnsVisibility.actCloseExecute


procedure TfrmColumnsVisibility.actlstColumnsVisibilityUpdate(
  Action: TBasicAction; var Handled: Boolean);
begin
  actApply.Enabled := FbIsChanged;
end; // TfrmColumnsVisibility.actlstColumnsVisibilityUpdate


procedure TfrmColumnsVisibility.lbxColumnsClickCheck(Sender: TObject);
begin
  FbIsChanged := TRUE;
end; // TfrmColumnsVisibility.lbxColumnsClickCheck


{procedure TfrmColumnsVisibility._LanguageChange(ASender: TObject);
var
  strCaption: String;
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, TLabel(lblColumns));
    GetString(CLASS_NAME, TAction(actApply));
    GetString(CLASS_NAME, TAction(actClose));
    GetString(CLASS_NAME, '', 'Caption', strCaption);
  end;
  Self.Caption := strCaption;
end; // TfrmColumnsVisibility._LanguageChange
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmColumnsVisibility._BuildCheckListBox(
    const AReportColumns: TReportColumnList);
var
  i: Integer;
begin
  lbxColumns.Clear();
  for i := 0 to AReportColumns.Count - 1 do begin
    lbxColumns.AddItem(AReportColumns[i].ColumnName, AReportColumns[i]);
    lbxColumns.Checked[i] := AReportColumns[i].Visible;
  end;
end; // TfrmColumnsVisibility._BuildCheckListBox


{procedure TfrmColumnsVisibility._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmColumnsVisibility._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');

  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmColumnsVisibility._SubscribeToLanguagesManagerEvents
}

//////////////////////////////////////////////////////////////////////////////
// fire methods

procedure TfrmColumnsVisibility._FireColumnsVisibilityApply();
begin
  if Assigned(OnApply) then begin
    OnApply(Self);
  end;
end; // TfrmColumnsVisibility._FireColumnsVisibilityApply


end.
