//////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////

unit ufrmManageOptionsFrame;

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
  // project units
  uLanguagesManager,
  ufrmBaseOptionsFrame, ExtCtrls;


type

  //
  // TfrmManageOptionsFrame
  //

  TfrmManageOptionsFrame = class(TfrmBaseOptionsFrame)
    cbxOneClickSelect: TCheckBox;
    btnClearTempData: TButton;
    cbxAutoclearDatabaseSettings: TCheckBox;
    cbxAutocheckUpdates: TCheckBox;
    edtUpdateURL: TEdit;
    lblUpdateURL: TLabel;
    lblHTTP: TLabel;
    pnlUpdateSettings: TGroupBox;
    procedure ControlValueChange(Sender: TObject);
    procedure btnClearTempDataClick(Sender: TObject);
    procedure cbxAutoclearDatabaseSettingsClick(Sender: TObject);

  private
    // fields
    FLanguagesManagerLink: TLanguagesManagerLink;

    // localized constants
    CLEAR_TEMP_DATA_QUERY: String;

    // events handlers
    procedure _OptionChange(ASender: TObject);
    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _SubscribeToLanguagesManagerEvents();

  protected
    // protected methods
    procedure InitValues(); override;

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

  end; // TfrmManageOptionsFrame


implementation

uses
  // project units
  uOption,
  uNavigatorOptions,
  udmMain;

{$R *.dfm}

const
  // используем константу, так как в конструкторе
  // поле ClassName еще не определено
  CLASS_NAME = 'TfrmManageOptionsFrame';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmManageOptionsFrame.Create(AOwner: TComponent);
begin
  CLEAR_TEMP_DATA_QUERY := 'Clear All Old Database Settings?';

  inherited Create(AOwner);

  _SubscribeToLanguagesManagerEvents();

end; // TfrmManageOptionsFrame.Create


destructor TfrmManageOptionsFrame.Destroy();
begin
  FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmManageOptionsFrame.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TfrmManageOptionsFrame.InitValues();
var
  OptionForSubscribe: TOption;
begin
  // init visual components
  cbxOneClickSelect.Checked := not Options.Manage.DblClickActionEnable.Value;
  cbxAutoclearDatabaseSettings.Checked :=
      Options.Manage.AutoclearDatabaseSettings.Value;
  cbxAutocheckUpdates.Checked :=
      Options.Manage.AutocheckUpdates.Value;
  edtUpdateURL.Text := Options.Manage.UpdateURL.Value;

  lblHelp.CommandString := 'HTML/options_manage.htm';

  // subscribe to options changes
  OptionForSubscribe := Options.Manage.DblClickActionEnable;
  SubscribeToChanges(OptionForSubscribe).OnChange := _OptionChange;

  OptionForSubscribe := Options.Manage.AutoclearDatabaseSettings;
  SubscribeToChanges(OptionForSubscribe).OnChange := _OptionChange;

  OptionForSubscribe := Options.Manage.AutocheckUpdates;
  SubscribeToChanges(OptionForSubscribe).OnChange := _OptionChange;

  OptionForSubscribe := Options.Manage.UpdateURL;
  SubscribeToChanges(OptionForSubscribe).OnChange := _OptionChange;

  _LanguageChange(Self);

end; // TfrmManageOptionsFrame.InitValues


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmManageOptionsFrame.cbxAutoclearDatabaseSettingsClick(
  Sender: TObject);
const
  AUTOCLEAR_QUERY = 'Вы действительно хотите автоматически удалять ' + Chr(10)
      + 'настройки старых баз данных?';
begin
  if cbxAutoclearDatabaseSettings.Checked
      and not Options.Manage.AutoclearDatabaseSettings.Value then begin
    if MessageDlg(AUTOCLEAR_QUERY, mtWarning, [mbYes, mbNo], 0) = mrYes then begin
      Options.Manage.AutoclearDatabaseSettings.Value :=
          cbxAutoclearDatabaseSettings.Checked;
    end else begin
      cbxAutoclearDatabaseSettings.Checked := FALSE;
    end;
  end else begin
    Options.Manage.AutoclearDatabaseSettings.Value :=
        cbxAutoclearDatabaseSettings.Checked;
  end;
end; // TfrmManageOptionsFrame.cbxAutoclearDatabaseSettingsClick


procedure TfrmManageOptionsFrame.btnClearTempDataClick(Sender: TObject);
begin
  if MessageDlg(CLEAR_TEMP_DATA_QUERY,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    dmMain.ClearTempData();
  end;
end; // TfrmManageOptionsFrame.btnClearTempDataClick


procedure TfrmManageOptionsFrame.ControlValueChange(
  Sender: TObject);
begin
  if Sender = cbxOneClickSelect then begin
    Options.Manage.DblClickActionEnable.Value := not cbxOneClickSelect.Checked;

  end else if Sender = cbxAutocheckUpdates then begin
    Options.Manage.AutocheckUpdates.Value := cbxAutocheckUpdates.Checked;

  end else if Sender = edtUpdateURL then begin
    Options.Manage.UpdateURL.Value := edtUpdateURL.Text;

  end else begin
    ASSERT(FALSE,
        'TfrmManageOptionsFrame.ControlValueChange error! Unknown sender!');
  end;
end; // TfrmManageOptionsFrame.ControlValueChange


procedure TfrmManageOptionsFrame._OptionChange(ASender: TObject);
begin
  if ASender = Options.Manage.DblClickActionEnable then begin
    cbxOneClickSelect.Checked := not Options.Manage.DblClickActionEnable.Value;

  end else if ASender = Options.Manage.AutoclearDatabaseSettings then begin
    cbxAutoclearDatabaseSettings.Checked :=
        Options.Manage.AutoclearDatabaseSettings.Value;

  end else if ASender = Options.Manage.AutocheckUpdates then begin
    cbxAutocheckUpdates.Checked :=
        Options.Manage.AutocheckUpdates.Value;

  end else if ASender = Options.Manage.UpdateURL then begin
    edtUpdateURL.Text := Options.Manage.UpdateURL.Value;

  end else begin
    ASSERT(FALSE,
        'TfrmManageOptionsFrame._OptionChange error! Unknown sender!');
  end;
end; // TfrmManageOptionsFrame._OptionChange


procedure TfrmManageOptionsFrame._LanguageChange(ASender: TObject);
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, cbxOneClickSelect);
    GetString(CLASS_NAME, cbxAutoclearDatabaseSettings);
    GetString(CLASS_NAME, cbxAutocheckUpdates);
    GetString(CLASS_NAME, btnClearTempData);
    GetString(CLASS_NAME, lblUpdateURL);
    GetString(CLASS_NAME, pnlUpdateSettings);
    GetString(CLASS_NAME, TLabel(lblHelp));
    GetString(CLASS_NAME, 'CLEAR_TEMP_DATA_QUERY', '', CLEAR_TEMP_DATA_QUERY);
  end;
end; // TfrmManageOptionsFrame._LanguageChange


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmManageOptionsFrame._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmManageOptionsFrame._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');
  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmManageOptionsFrame._SubscribeToLanguagesManagerEvents


end.
