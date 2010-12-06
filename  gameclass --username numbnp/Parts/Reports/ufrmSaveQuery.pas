unit ufrmSaveQuery;

interface

uses
  // system units
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
//  uLanguagesManager,
  StdCtrls;


type

  //
  // TfrmSaveQuery
  //

  TfrmSaveQuery = class(TForm)
    lblQuery: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    rgrpSaveQueries: TRadioGroup;
    imgWarning: TImage;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

  private
    // class constants
    RES_SAVE_TABLE_QUERY_0: String;
    RES_SAVE_TABLE_QUERY_1: String;

    // fields
//    FLanguagesManagerLink: TLanguagesManagerLink;

    // private helper methods
    procedure _TuneSaveQueries();
//    procedure _SubscribeToLanguagesManagerEvents();

    // events handlers
//    procedure _LanguageChange(ASender: TObject);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

  end; // TfrmSaveQuery



implementation


uses
  // project units
  udmMain;

{$R *.dfm}

const
  CLASS_NAME = 'TfrmSaveQuery';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmSaveQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  RES_SAVE_TABLE_QUERY_0 := 'Save all';
  RES_SAVE_TABLE_QUERY_1 := 'Save only selected rows';

  rgrpSaveQueries.Items[0] := RES_SAVE_TABLE_QUERY_0;
  rgrpSaveQueries.Items[1] := RES_SAVE_TABLE_QUERY_1;

//  _SubscribeToLanguagesManagerEvents();
//  _LanguageChange(Self);

end; // TfrmSaveQuery.Create


destructor TfrmSaveQuery.Destroy();
begin
//  FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmSaveQuery.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmSaveQuery.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end; // TfrmSaveQuery.btnOkClick

procedure TfrmSaveQuery.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end; // TfrmSaveQuery.btnCancelClick


{procedure TfrmSaveQuery._LanguageChange(ASender: TObject);
var
  strCaption: String;
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, '', 'Caption', strCaption);
    GetString(CLASS_NAME, TLabel(lblQuery));
    GetString(CLASS_NAME, TButton(btnOk));
    GetString(CLASS_NAME, TButton(btnCancel));
    GetString(CLASS_NAME, 'RES_SAVE_TABLE_QUERY_0', '', RES_SAVE_TABLE_QUERY_0);
    GetString(CLASS_NAME, 'RES_SAVE_TABLE_QUERY_1', '', RES_SAVE_TABLE_QUERY_1);
  end;
  Self.Caption := strCaption;
  _TuneSaveQueries();
end; // TfrmSaveQuery._LanguageChange
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmSaveQuery._TuneSaveQueries();
begin
  ASSERT(rgrpSaveQueries.Items.Count >= 2);

  if rgrpSaveQueries.Items.Count >= 2 then begin
    rgrpSaveQueries.Items[0] := RES_SAVE_TABLE_QUERY_0;
    rgrpSaveQueries.Items[1] := RES_SAVE_TABLE_QUERY_1;
  end;

end; // TfrmSaveQuery._TuneSaveQueries


{procedure TfrmSaveQuery._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmSaveQuery._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');

  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmSaveQuery._SubscribeToLanguagesManagerEvents
}

end.
