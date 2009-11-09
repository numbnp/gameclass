unit ufrmPrintQuery;

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
  StdCtrls,
//  uLanguagesManager,
  ExtCtrls;


type

  //
  // TfrmPrintQuery
  //

  TfrmPrintQuery = class(TForm)
    lblQuery: TLabel;
    imgWarning: TImage;
    rgrpPrintQueries: TRadioGroup;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);

  private
    // class constants
    RES_PRINT_TABLE_QUERY_0: String;
    RES_PRINT_TABLE_QUERY_1: String;

    // fields
//    FLanguagesManagerLink: TLanguagesManagerLink;

    // events handlers
//    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _TunePrintQueries();
//    procedure _SubscribeToLanguagesManagerEvents();

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

  end; // TfrmPrintQuery


implementation

{$R *.dfm}

const
  CLASS_NAME = 'TfrmPrintQuery';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmPrintQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  RES_PRINT_TABLE_QUERY_0 := 'Print all';
  RES_PRINT_TABLE_QUERY_1 := 'Print only selected rows';

//  _SubscribeToLanguagesManagerEvents();
//  _LanguageChange(Self);

end; // TfrmPrintQuery.Create


destructor TfrmPrintQuery.Destroy();
begin
//  FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmPrintQuery.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmPrintQuery.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end; // TfrmPrintQuery.btnOkClick


procedure TfrmPrintQuery.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end; // TfrmPrintQuery.btnCancelClick


{procedure TfrmPrintQuery._LanguageChange(ASender: TObject);
var
  strCaption: String;
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, '', 'Caption', strCaption);
    GetString(CLASS_NAME, TLabel(lblQuery));
    GetString(CLASS_NAME, TButton(btnOk));
    GetString(CLASS_NAME, TButton(btnCancel));    
    GetString(CLASS_NAME, 'RES_PRINT_TABLE_QUERY_0', '', RES_PRINT_TABLE_QUERY_0);
    GetString(CLASS_NAME, 'RES_PRINT_TABLE_QUERY_1', '', RES_PRINT_TABLE_QUERY_1);
  end;
  Self.Caption := strCaption;
  _TunePrintQueries();
end; // TfrmPrintQuery._LanguageChange
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmPrintQuery._TunePrintQueries();
begin
  ASSERT(rgrpPrintQueries.Items.Count >= 2);

  if rgrpPrintQueries.Items.Count >= 2 then begin
    rgrpPrintQueries.Items[0] := RES_PRINT_TABLE_QUERY_0;
    rgrpPrintQueries.Items[1] := RES_PRINT_TABLE_QUERY_1;
  end;

end; // TfrmPrintQuery._TunePrintQueries


{procedure TfrmPrintQuery._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmReports._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');

  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmPrintQuery._SubscribeToLanguagesManagerEvents
}

end.
