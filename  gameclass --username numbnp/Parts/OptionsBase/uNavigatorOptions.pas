//////////////////////////////////////////////////////////////////////////////
//
// Модуль настроек приложения.
//
//////////////////////////////////////////////////////////////////////////////

unit uNavigatorOptions;

interface

uses
  // project units
  uY2KCommon,
  uOption,
  uOptionsFolder,
  uOptionsStorage,
  uOptions;

const
  DEFAULT_ICONS = 'default';
  CUSTOM_THEME = 'custom';
  DEFAULT_INTERFACE_THEME = 'default';

  BACKGROUND_SUBFOLDER = 'Res\Background';
  FRONT_SUBFOLDER = 'Res\Front';

//  UPDATE_LINK = 'd:\temp\update.html';
  UPDATE_LINK = 'data/tkznavup.html';
//  UPDATE_LINK = 'http://www.tkz.su/data/update3.html';

type

  //
  // TGeneralOptionsFolder
  //

  TGeneralOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FHelpFile: TStringOption;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property HelpFile: TStringOption read FHelpFile;

  end; // TGeneralOptionsFolder


  //
  // TManageOptionsFolder
  //

  TManageOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FDblClickActionEnable: TBooleanOption;
    FAutoclearDatabaseSettings: TBooleanOption;
    FAutocheckUpdates: TBooleanOption;
    FUpdateURL: TStringOption;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property DblClickActionEnable: TBooleanOption read FDblClickActionEnable;
    property AutoclearDatabaseSettings: TBooleanOption
        read FAutoclearDatabaseSettings;
    property AutocheckUpdates: TBooleanOption
        read FAutocheckUpdates;
    property UpdateURL: TStringOption read FUpdateURL;

  end; // TManageOptionsFolder


  //
  // TDisplayOptionsFolder
  //

  TDisplayOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FRubricatorTreeWidth: TIntegerOption;
    FAboutCompanyTabHeight: TIntegerOption;
    FLocalRubricatorWidth: TintegerOption;
    FListDescriptionPanelHeight: TIntegerOption;
    FListPreviewImageWidth: TIntegerOption;
    FBlankHeaderPanelHeight: TIntegerOption;
    FBlankPreviewImageWidth: TIntegerOption;
    FBlankLinksPanelWidth: TIntegerOption;
    FGeneralActiveTab: TIntegerOption;

    FBrowserTop: TIntegerOption;
    FBrowserLeft: TIntegerOption;
    FBrowserWidth: TIntegerOption;
    FBrowserHeight: TIntegerOption;
    FBrowserMaximized: TBooleanOption;

    FGraphFeaturesTop: TIntegerOption;
    FGraphFeaturesLeft: TIntegerOption;
    FGraphFeaturesWidth: TIntegerOption;
    FGraphFeaturesHeight: TIntegerOption;
    FGraphFeaturesMaximized: TBooleanOption;

    FViewToolbar: TBooleanOption;
    FViewStatusbar: TBooleanOption;
    FViewNavigationBar: TBooleanOption;
    FViewRubricator: TBooleanOption;

    FViewTitleType: TIntegerOption;
    FShowViewIdentificator: TBooleanOption;
    FShowHints: TBooleanOption;
    FLockDoubleRun: TBooleanOption;
    FFullRowSelectRubricator: TBooleanOption;
    FShowLinkPanel: TBooleanOption;
    FExpandRubrics: TBooleanOption;

    FStartPageBackground: TStringOption;
    FStartImage: TStringOption;
    FRandomBackground: TBooleanOption;
    FRandomStartImage: TBooleanOption;

    FGridShowIndicator: TBooleanOption;
    FGridHorizontalLines: TBooleanOption;
    FGridVerticalLines: TBooleanOption;
    FAutofitColumns: TBooleanOption;
    FGridShowPreviews: TBooleanOption;
    FGridTitleRowsCount: TIntegerOption;
    FStrippedGrid: TBooleanOption;
    FAddDataStrippedGrid: TBooleanOption;

    FCaptionColor: TIntegerOption;
    FBackgroundColor: TIntegerOption;
    FTitleColor: TIntegerOption;
    FOddRowsColor: TIntegerOption;
    FAddDataBackgroundColor: TIntegerOption;
    FAddDataTitleColor: TIntegerOption;
    FAddDataOddRowsColor: TIntegerOption;

    FCaptionFontColor: TIntegerOption;
    FBackgroundFontColor: TIntegerOption;
    FTitleFontColor: TIntegerOption;
    FOddRowsFontColor: TIntegerOption;
    FAddDataBackgroundFontColor: TIntegerOption;
    FAddDataTitleFontColor: TIntegerOption;
    FAddDataOddRowsFontColor: TIntegerOption;

    FCaptionFontBold: TBooleanOption;
    FBackgroundFontBold: TBooleanOption;
    FTitleFontBold: TBooleanOption;
    FOddRowsFontBold: TBooleanOption;
    FAddDataBackgroundFontBold: TBooleanOption;
    FAddDataTitleFontBold: TBooleanOption;
    FAddDataOddRowsFontBold: TBooleanOption;

    FCaptionFontItalic: TBooleanOption;
    FBackgroundFontItalic: TBooleanOption;
    FTitleFontItalic: TBooleanOption;
    FOddRowsFontItalic: TBooleanOption;
    FAddDataBackgroundFontItalic: TBooleanOption;
    FAddDataTitleFontItalic: TBooleanOption;
    FAddDataOddRowsFontItalic: TBooleanOption;

    FIconFile: TStringOption;
    FInterfaceTheme: TStringOption;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property RubricatorTreeWidth: TIntegerOption read FRubricatorTreeWidth;
    property AboutCompanyTabHeight: TIntegerOption read FAboutCompanyTabHeight;
    property LocalRubricatorWidth: TIntegerOption read FLocalRubricatorWidth;
    property ListDescriptionPanelHeight: TIntegerOption
        read FListDescriptionPanelHeight;
    property ListPreviewImageWidth: TIntegerOption
        read FListPreviewImageWidth;
    property BlankHeaderPanelHeight: TIntegerOption
        read FBlankHeaderPanelHeight;
    property BlankPreviewImageWidth: TIntegerOption
        read FBlankPreviewImageWidth;
    property BlankLinksPanelWidth: TIntegerOption
        read FBlankLinksPanelWidth;
    property GeneralActiveTab: TIntegerOption
        read FGeneralActiveTab;

    property BrowserTop: TIntegerOption read FBrowserTop;
    property BrowserLeft: TIntegerOption read FBrowserLeft;
    property BrowserWidth: TIntegerOption read FBrowserWidth;
    property BrowserHeight: TIntegerOption read FBrowserHeight;
    property BrowserMaximized: TBooleanOption read FBrowserMaximized;

    property GraphFeaturesTop: TIntegerOption read FGraphFeaturesTop;
    property GraphFeaturesLeft: TIntegerOption read FGraphFeaturesLeft;
    property GraphFeaturesWidth: TIntegerOption read FGraphFeaturesWidth;
    property GraphFeaturesHeight: TIntegerOption read FGraphFeaturesHeight;
    property GraphFeaturesMaximized: TBooleanOption
        read FGraphFeaturesMaximized;

    property ViewToolbar: TBooleanOption read FViewToolbar;
    property ViewStatusbar: TBooleanOption read FViewStatusbar;
    property ViewNavigationBar: TBooleanOption read FViewNavigationBar;
    property ViewRubricator: TBooleanOption read FViewRubricator;

    property ViewTitleType: TIntegerOption read FViewTitleType;
    property ShowViewIdentificator: TBooleanOption read FShowViewIdentificator;
    property ShowHints: TBooleanOption read FShowHints;
    property LockDoubleRun: TBooleanOption read FLockDoubleRun;
    property FullRowSelectRubricator: TBooleanOption
        read FFullRowSelectRubricator;
    property ShowLinkPanel: TBooleanOption read FShowLinkPanel;
    property ExpandRubrics: TBooleanOption read FExpandRubrics;

    property StartPageBackground: TStringOption read FStartPageBackground;
    property StartImage: TStringOption read FStartImage;
    property RandomBackground: TBooleanOption read FRandomBackground;
    property RandomStartImage: TBooleanOption read FRandomStartImage;

    property GridShowIndicator: TBooleanOption read FGridShowIndicator;
    property GridHorizontalLines: TBooleanOption read FGridHorizontalLines;
    property GridVerticalLines: TBooleanOption read FGridVerticalLines;
    property AutofitColumns: TBooleanOption read FAutofitColumns;
    property GridShowPreviews: TBooleanOption read FGridShowPreviews;
    property GridTitleRowsCount: TIntegerOption read FGridTitleRowsCount;
    property StrippedGrid: TBooleanOption read FStrippedGrid;
    property AddDataStrippedGrid: TBooleanOption read FAddDataStrippedGrid;

    property CaptionColor: TIntegerOption read FCaptionColor;
    property BackgroundColor: TIntegerOption read FBackgroundColor;
    property TitleColor: TIntegerOption read FTitleColor;
    property OddRowsColor: TIntegerOption read FOddRowsColor;
    property AddDataBackgroundColor: TIntegerOption read FAddDataBackgroundColor;
    property AddDataTitleColor: TIntegerOption read FAddDataTitleColor;
    property AddDataOddRowsColor: TIntegerOption read FAddDataOddRowsColor;

    property CaptionFontColor: TIntegerOption read FCaptionFontColor;
    property BackgroundFontColor: TIntegerOption read FBackgroundFontColor;
    property TitleFontColor: TIntegerOption read FTitleFontColor;
    property OddRowsFontColor: TIntegerOption read FOddRowsFontColor;
    property AddDataBackgroundFontColor: TIntegerOption
        read FAddDataBackgroundFontColor;
    property AddDataTitleFontColor: TIntegerOption
        read FAddDataTitleFontColor;
    property AddDataOddRowsFontColor: TIntegerOption
        read FAddDataOddRowsFontColor;

    property CaptionFontBold: TBooleanOption read FCaptionFontBold;
    property BackgroundFontBold: TBooleanOption read FBackgroundFontBold;
    property TitleFontBold: TBooleanOption read FTitleFontBold;
    property OddRowsFontBold: TBooleanOption read FOddRowsFontBold;
    property AddDataBackgroundFontBold: TBooleanOption
        read FAddDataBackgroundFontBold;
    property AddDataTitleFontBold: TBooleanOption
        read FAddDataTitleFontBold;
    property AddDataOddRowsFontBold: TBooleanOption
        read FAddDataOddRowsFontBold;

    property CaptionFontItalic: TBooleanOption read FCaptionFontItalic;
    property BackgroundFontItalic: TBooleanOption read FBackgroundFontItalic;
    property TitleFontItalic: TBooleanOption read FTitleFontItalic;
    property OddRowsFontItalic: TBooleanOption read FOddRowsFontItalic;
    property AddDataBackgroundFontItalic: TBooleanOption
        read FAddDataBackgroundFontItalic;
    property AddDataTitleFontItalic: TBooleanOption
        read FAddDataTitleFontItalic;
    property AddDataOddRowsFontItalic: TBooleanOption
        read FAddDataOddRowsFontItalic;

    property IconFile: TStringOption read FIconFile;
    property InterfaceTheme: TStringOption read FInterfaceTheme;

  end; // TDisplayOptionsFolder


  //
  // TLanguageOptionsFolder
  //

  TLanguageOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FLngIndex: TStringOption;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property LngIndex: TStringOption read FLngIndex;

  end; // TLanguageOptionsFolder


  //
  // TPrintOptionsFolder
  //

  TPrintOptionsFolder = class(TOptionsFolder)
  private
    // class constants
    // константы для свойства PrintObjectIndex
    FpoList: Integer;
    FpoSelectedBlanks: Integer;
    FpoAllBlanks: Integer;
    FpoCurrentBlank: Integer;

    // fields
    FPrintObjectIndex: TIntegerOption;
    FPrintPreviewImage: TBooleanOption;
    FPrintDescription: TBooleanOption;
    FPrintTable: TBooleanOption;
    FPrintAdditionalInformation: TBooleanOption;
    FPrintBlankInNewPage: TBooleanOption;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // class constants
    property poList: Integer read FpoList;
    property poSelectedBlanks: Integer read FpoSelectedBlanks;
    property poAllBlanks: Integer read FpoAllBlanks;
    property poCurrentBlank: Integer read FpoCurrentBlank;

    // properties
    property PrintObjectIndex: TIntegerOption read FPrintObjectIndex;
    property PrintPrevirewImage: TBooleanOption read FPrintPreviewImage;
    property PrintDescription: TBooleanOption read FPrintDescription;
    property PrintTable: TBooleanOption read FPrintTable;
    property PrintAdditionalInformation: TBooleanOption
        read FPrintAdditionalInformation;
    property PrintBlankInNewPage: TBooleanOption
        read FPrintBlankInNewPage;

  end; // TPrintOptionsFolder


  //
  // TDebugOptionsFolder
  //

  TDebugOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FDebugLogEnable: TBooleanOption;
    FDebugLevel: TIntegerOption;
    FClearDebugLogAfterStart: TBooleanOption;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property DebugLogEnable: TBooleanOption read FDebugLogEnable;
    property DebugLevel: TIntegerOption read FDebugLevel;
    property ClearDebugLogAfterStart: TBooleanOption
        read FClearDebugLogAfterStart;

  end; // TDebugOptionsFolder


  //
  // TDatabaseOptionsFolder
  //

  TDatabaseOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FLastDatabaseFile: TStringOption;
    FDatabaseFile: TStringOption;
    FTempDatabaseFolder: TStringOption;
    FLocalDatabaseFolder: TStringOption;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property LastDatabaseFile: TStringOption read FLastDatabaseFile;
    property DatabaseFile: TStringOption read FDatabaseFile;
    property TempDatabaseFolder: TStringOption read FTempDatabaseFolder;
    property LocalDatabaseFolder: TStringOption read FLocalDatabaseFolder;

  end; // TDatabaseOptionsFolder


  //
  // TSearchOptionsFolder
  //

  TSearchOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FSearchInBlanks: TBooleanOption;

  public
    // cosntructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property SearchInBlanks: TBooleanOption read FSearchInBlanks;

  end; // TSearchOptionsFolder


  //
  // TDefaultOptionsFolder
  //

  TDefaultOptionsFolder = class(TOptionsFolder)
    private
      // fields
      FDefaultDatabaseFile: TStringOption;

    public
      // constructor / destructor
      constructor Create(const AstrName: String;
          AOptionsStorage: TOptionsStorage);

      // properties
      property DefaultDatabaseFile: TStringOption
          read FDefaultDatabaseFile write FDefaultDatabaseFile;

  end; // TDefaultOptionsFolder


  //
  // TNavigatorOptions
  //

  TNavigatorOptions = class(TOptions)
  private
    // fields
    FSystemOptionsStorage: TOptionsStorage;
    FUserOptionsStorage: TOptionsStorage;

    FGeneralOptionsFolder: TGeneralOptionsFolder;
    FManageOptionsFolder: TManageOptionsFolder;
    FDisplayOptionsFolder: TDisplayOptionsFolder;
    FLanguageOptionsFolder: TLanguageOptionsFolder;
    FDatabaseOptionsFolder: TDatabaseOptionsFolder;
    FDebugOptionsFolder: TDebugOptionsFolder;
    FPrintOptionsFolder: TPrintOptionsFolder;
    FSearchOptionsFolder: TSearchOptionsFolder;
    FDefaultOptionsFolder: TDefaultOptionsFolder;

  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    // singleton realization
    class function AccessInstance(
        const ARequest: TSingletonOperation): TNavigatorOptions;
    class procedure ReleaseInstance();

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // singleton realization
    class function Instance(): TNavigatorOptions;

    // properties
    property General: TGeneralOptionsFolder read FGeneralOptionsFolder;
    property Manage: TManageOptionsFolder read FManageOptionsFolder;
    property Display: TDisplayOptionsFolder read FDisplayOptionsFolder;
    property Language: TLanguageOptionsFolder read FLanguageOptionsFolder;
    property Debug: TDebugOptionsFolder read FDebugOptionsFolder;
    property Database: TDatabaseOptionsFolder read FDatabaseOptionsFolder;
    property Print: TPrintOptionsFolder read FPrintOptionsFolder;
    property Search: TSearchOptionsFOlder read FSearchOptionsFolder;
    property DefaultData: TDefaultOptionsFolder read FDefaultOptionsFolder;

  end; // TNavigatorOptions


var
  Options: TNavigatorOptions;


implementation

uses
  // system units
  Graphics,
  Windows,
  SysUtils;


const
  REGISTRY_PATH = 'Software\PJSC Krasniy kotelshchik\TKZ Navigator\Options';

  GEENRAL_FOLDER_NAME = 'General';
  MANAGE_FOLDER_NAME = 'Manage';
  DISPLAY_FOLDER_NAME = 'Display';
  LANGUAGE_FOLDER_NAME = 'Language';
  DATABASE_FOLDER_NAME = 'Database';
  DEBUG_FOLDER_NAME = 'Debug';
  PRINT_FOLDER_NAME = 'Print';
  SEARCH_FOLDER_NAME = 'Search';
  DEFAULT_FOLDER_NAME = 'Default';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TGeneralOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TGeneralOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create(AstrName, AOptionsStorage);

  FHelpFile := CreateAndAddStringOption('HelpFile');

end; // TGeneralOptionsFolder.Create



//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TManageOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TManageOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create(AstrName, AOptionsStorage);

  FDblClickActionEnable := CreateAndAddBooleanOption(
      'DblClickActionEnable', TRUE);
  FAutoclearDatabaseSettings := CreateAndAddBooleanOption(
      'AutoclearDatabaseSettings', FALSE);
  FAutocheckUpdates := CreateAndAddBooleanOption(
      'AutocheckUpdates', TRUE);
  FUpdateURL := CreateAndAddStringOption(
      'UpdateURL', 'www.tkz.su')

end; // TManageOptionsFolder.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TDisplayOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TDisplayOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create(AstrName, AOptionsStorage);

  FRubricatorTreeWidth :=
      CreateAndAddIntegerOption('RubricatorTreeWidth', 280);
  FRubricatorTreeWidth.Defaulted := FALSE;
  FAboutCompanyTabHeight :=
      CreateAndAddIntegerOption('AboutCompanyTabHeight', 170);
  FAboutCompanyTabHeight.Defaulted := FALSE;
  FLocalRubricatorWidth :=
      CreateAndAddIntegerOption('LocalRubricatorWidth', 280);
  FLocalRubricatorWidth.Defaulted := FALSE;
  FListDescriptionPanelHeight :=
      CreateAndAddIntegerOption('ListDescriptionPanelHeight', 245);
  FListDescriptionPanelHeight.Defaulted := FALSE;
  FListPreviewImageWidth :=
      CreateAndAddIntegerOption('ListPreviewImageWidth', 250);
  FListPreviewImageWidth.Defaulted := FALSE;
  FGeneralActiveTab := CreateAndAddIntegerOption('GeneralActiveTab', 0);
  FGeneralActiveTab.Defaulted := FALSE;

  FBrowserTop := CreateAndAddIntegerOption('BrowserTop', 0);
  FBrowserTop.Defaulted := FALSE;
  FBrowserLeft := CreateAndAddIntegerOption('BrowserLeft', 0);
  FBrowserLeft.Defaulted := FALSE;
  FBrowserWidth := CreateAndAddIntegerOption('BrowserWidth', 0);
  FBrowserWidth.Defaulted := FALSE;
  FBrowserHeight := CreateAndAddIntegerOption('BrowserHeight', 0);
  FBrowserHeight.Defaulted := FALSE;
  FBrowserMaximized := CreateAndAddBooleanOption('BrowserMaximized', FALSE);
  FBrowserMaximized.Defaulted := FALSE;

  FGraphFeaturesTop := CreateAndAddIntegerOption('GraphFeaturesTop', 0);
  FGraphFeaturesTop.Defaulted := FALSE;
  FGraphFeaturesLeft := CreateAndAddIntegerOption('GraphFeaturesLeft', 0);
  FGraphFeaturesLeft.Defaulted := FALSE;
  FGraphFeaturesWidth := CreateAndAddIntegerOption('GraphFeaturesWidth', 0);
  FGraphFeaturesWidth.Defaulted := FALSE;
  FGraphFeaturesHeight := CreateAndAddIntegerOption('GraphFeaturesHeight', 0);
  FGraphFeaturesHeight.Defaulted := FALSE;
  FGraphFeaturesMaximized :=
      CreateAndAddBooleanOption('GraphFeaturesMaximized', FALSE);
  FGraphFeaturesMaximized.Defaulted := FALSE;

  FBlankHeaderPanelHeight := CreateAndAddIntegerOption(
      'BlankHeaderPanelHeight', 250);
  FBlankHeaderPanelHeight.Defaulted := FALSE;
  FBlankPreviewImageWidth := CreateAndAddIntegerOption(
      'BlankPreviewImageWidth', 300);
  FBlankPreviewImageWidth.Defaulted := FALSE;
  FBlankLinksPanelWidth := CreateAndAddIntegerOption(
      'BlankLinksPanelWidth', 80);
  FBlankLinksPanelWidth.Defaulted := FALSE;

  FViewToolbar := CreateAndAddBooleanOption('ViewToolbar', TRUE);
  FViewStatusbar := CreateAndAddBooleanOption('ViewStatusbar', TRUE);
  FViewNavigationBar := CreateAndAddBooleanOption('ViewNavigationBar', TRUE);
  FViewRubricator := CreateAndAddBooleanOption('ViewRubricator', TRUE);

  FViewTitleType := CreateAndAddIntegerOption('ViewTitleType', 0);
  FShowViewIdentificator := CreateAndAddBooleanOption(
      'ShowViewIdentificator', FALSE);
  FShowHints := CreateAndAddBooleanOption('ShowHints', TRUE);
  FLockDoubleRun := CreateAndAddBooleanOption('LockDoubleRun', TRUE);
  FFullRowSelectRubricator := CreateAndAddBooleanOption(
      'FullRowSelectRubricator', TRUE);
  FShowLinkPanel := CreateAndAddBooleanOption('ShowLinkPanel', TRUE);
  FExpandRubrics := CreateAndAddBooleanOPtion('ExpandRubrics', TRUE);

  FStartPageBackground := CreateAndAddStringOption('StartPageBackground', 'general_back.jpg');
  FStartImage := CreateAndAddStringOption('StartImage', 'general_front.bmp');
  FRandomBackground := CreateAndAddBooleanOption('RandomBackground', FALSE);
  FRandomStartImage := CreateAndAddBooleanOption('RandomStartImage', FALSE);

  FGridShowIndicator := CreateAndAddBooleanOption('GridShowIndicator', TRUE);
  FGridHorizontalLines := CreateAndAddBooleanOption('GridHorizontalLines', TRUE);
  FGridVerticalLines := CreateAndAddBooleanOption('GridVerticalLines', TRUE);
  FAutofitColumns := CreateAndAddBooleanOption('AutofitColumns', TRUE);
  FGridShowPreviews := CreateAndAddBooleanOption('GridShowPreviews', TRUE);
  FGridTitleRowsCount := CreateAndAddIntegerOption('GridTitleRowsCount', 0);
  FStrippedGrid := CreateAndAddBooleanOption('StrippedGrid', FALSE);
  FAddDataStrippedGrid := CreateAndAddBooleanOption('AddDataStrippedGrid', FALSE);

  FCaptionColor := CreateAndAddIntegerOption('CaptionColor', clBtnFace);
  FBackgroundColor := CreateAndAddIntegerOption('BackgroundColor', clWhite);
  FTitleColor := CreateAndAddIntegerOption('TitleColor', clBtnFace);
  FOddRowsColor := CreateAndAddIntegerOption('OddRowsColor', clWhite);
  FAddDataBackgroundColor := CreateAndAddIntegerOption(
      'AddDataBackgroundColor', clWhite);
  FAddDataTitleColor := CreateAndAddIntegerOption(
      'AddDataTitleColor', clBtnFace);
  FAddDataOddRowsColor := CreateAndAddIntegerOption(
      'AddDataOddRowsColor', clWhite);

  FCaptionFontColor := CreateAndAddIntegerOption('CaptionFontColor', clBtnText);
  FBackgroundFontColor := CreateAndAddIntegerOption('BackgroundFontColor', clBtnText);
  FTitleFontColor := CreateAndAddIntegerOption('TitleFontColor', clBtnText);
  FOddRowsFontColor := CreateAndAddIntegerOption('OddRowsFontColor', clBtnText);
  FAddDataBackgroundFontColor := CreateAndAddIntegerOption(
      'AddDataBackgroundFontColor', clBtnText);
  FAddDataTitleFontColor := CreateAndAddIntegerOption(
      'AddDataTitleFontColor', clBtnText);
  FAddDataOddRowsFontColor := CreateAndAddIntegerOption(
      'AddDataOddRowsFontColor', clBtnText);

  FCaptionFontBold := CreateAndAddBooleanOption('CaptionFontBold', TRUE);
  FBackgroundFontBold := CreateAndAddBooleanOption('BackgroundFontBold', FALSE);
  FTitleFontBold := CreateAndAddBooleanOption('TitleFontBold', FALSE);
  FOddRowsFontBold := CreateAndAddBooleanOption('OddRowsFontBold', FALSE);
  FAddDataBackgroundFontBold := CreateAndAddBooleanOption(
      'AddDataBackgroundFontBold', FALSE);
  FAddDataTitleFontBold := CreateAndAddBooleanOption(
      'AddDataTitleFontBold', FALSE);
  FAddDataOddRowsFontBold := CreateAndAddBooleanOption(
      'AddDataOddRowsFontBold', FALSE);

  FCaptionFontItalic := CreateAndAddBooleanOption('CaptionFontItalic', FALSE);
  FBackgroundFontItalic := CreateAndAddBooleanOption('BackgroundFontItalic', FALSE);
  FTitleFontItalic := CreateAndAddBooleanOption('TitleFontItalic', FALSE);
  FOddRowsFontItalic := CreateAndAddBooleanOption('OddRowsFontItalic', FALSE);
  FAddDataBackgroundFontItalic := CreateAndAddBooleanOption(
      'AddDataBackgroundFontItalic', FALSE);
  FAddDataTitleFontItalic := CreateAndAddBooleanOption(
      'AddDataTitleFontItalic', FALSE);
  FAddDataOddRowsFontItalic := CreateAndAddBooleanOption(
      'AddDataOddRowsFontItalic', FALSE);

  FIconFile := CreateAndAddStringOption('IconFile', DEFAULT_ICONS);
  FInterfaceTheme := CreateAndAddStringOption(
      'InterfaceTheme', DEFAULT_INTERFACE_THEME);

end; // TDisplayOptionsFolder.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TLanguageOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TLanguageOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create(AstrName, AOptionsStorage);

  FLngIndex := CreateAndAddStringOption('LngIndex', 'English');
  FLngIndex.Defaulted := FALSE;

end; // TLanguageOptionsFolder.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TPrintOptionsFolder


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TPrintOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  // init class constants
  FpoList := 0;
  FpoSelectedBlanks := 1;
  FpoAllBlanks := 2;
  FpoCurrentBlank := 3;

  inherited Create(AstrName, AOptionsStorage);

  FPrintObjectIndex := CreateAndAddIntegerOption('PrintObjectIndex', 0);
  FPrintPreviewImage := CreateAndAddBooleanOption('PrintPreviewImage', TRUE);
  FPrintDescription := CreateAndAddBooleanOption('PrintDescription', TRUE);
  FPrintTable := CreateAndAddBooleanOption('PrintTable', TRUE);
  FPrintAdditionalInformation :=
      CreateAndAddBooleanOption('PrintAdditionalInformation', FALSE);
  FPrintBlankInNewPage :=
      CreateAndAddBooleanOption('PrintBlankInNewPage', TRUE);

end; // TPrintOptionsFolder.Create

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TDatabaseOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TDatabaseOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create(AstrName, AOptionsStorage);

  FLastDatabaseFile := CreateAndAddStringOption('LastDatabaseFile', '');
  FLastDatabaseFile.Defaulted := FALSE;
  FDatabaseFile := CreateAndAddStringOption('DatabaseFile', '');
  FDatabaseFile.Defaulted := FALSE;
  FTempDatabaseFolder := CreateAndAddStringOption('TempDatabaseFolder', '');
  FTempDatabaseFolder.Defaulted := FALSE;
  FTempDatabaseFolder.Storaged := FALSE;
  FLocalDatabaseFolder := CreateAndAddStringOption('LocalDatabaseFolder', '');
  FLocalDatabaseFolder.Defaulted := FALSE;
  FLocalDatabaseFolder.Storaged := FALSE;

end; // TDatabaseOptionsFolder.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TDebugOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TDebugOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create(AstrName, AOptionsStorage);

  FDebugLogEnable := CreateAndAddBooleanOption('DebugLogEnable', FALSE);
  FDebugLevel := CreateAndAddIntegerOption('DebugLevel', 0);
  FClearDebugLogAfterStart :=
      CreateAndAddBooleanOption('ClearDebugLogAfterStart', TRUE);

end; // TDebugOptionsFolder.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TSearchOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// cosntructor / destructor

constructor TSearchOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create(AstrName, AOptionsStorage);

  FSearchInBlanks := CreateAndAddBooleanOption('SearchInBlanks', TRUE);
  FSearchInBlanks.Defaulted := FALSE;

end; // TSearchOptionsFolder.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TDefaultOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TDefaultOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create(AstrName, AOptionsStorage);

  FDefaultDatabaseFile := CreateAndAddStringOption('DefaultDatabaseFile', '');
  FDefaultDatabaseFile.Defaulted := FALSE;
  FDefaultDatabaseFile.Storaged := FALSE;

end; // TDefaultOptionsFolder.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TNavigatorOptions

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TNavigatorOptions.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));

end; // TNavigatorOptions.Create


constructor TNavigatorOptions.CreateInstance();
begin
  inherited Create();

  FSystemOptionsStorage := TOptionsRegStorage.Create(
      HKEY_LOCAL_MACHINE, REGISTRY_PATH);
  FUserOptionsStorage := TOptionsRegStorage.Create(
      HKEY_CURRENT_USER, REGISTRY_PATH);

  FGeneralOptionsFolder := TGeneralOptionsFolder.Create(
      GEENRAL_FOLDER_NAME, FUserOptionsStorage);
  AddOptionsFolder(FGeneralOptionsFolder);

  FManageOptionsFolder := TManageOptionsFolder.Create(
      MANAGE_FOLDER_NAME, FUserOptionsStorage);
  AddOptionsFolder(FManageOptionsFolder);

  FDisplayOptionsFolder := TDisplayOptionsFolder.Create(
      DISPLAY_FOLDER_NAME, FUserOptionsStorage);
  AddOptionsFolder(FDisplayOptionsFolder);

  FLanguageOptionsFolder := TLanguageOptionsFolder.Create(
      DISPLAY_FOLDER_NAME, FUserOptionsStorage);
  AddOptionsFolder(FLanguageOptionsFolder);

  FDatabaseOptionsFolder := TDatabaseOptionsFolder.Create(
      DATABASE_FOLDER_NAME, FUserOptionsStorage);
  AddOptionsFolder(FDatabaseOptionsFolder);

  FDebugOptionsFolder := TDebugOptionsFolder.Create(
      DEBUG_FOLDER_NAME, FUserOptionsStorage);
  AddOptionsFolder(FDebugOptionsFolder);

  FPrintOptionsFolder := TPrintOptionsFolder.Create(
      PRINT_FOLDER_NAME, FUserOptionsStorage);
  AddOptionsFolder(FPrintOptionsFolder);

  FSearchOptionsFolder := TSearchOptionsFolder.Create(
      SEARCH_FOLDER_NAME, FUserOptionsStorage);
  AddOptionsFolder(FSearchOptionsFolder);

  FDefaultOptionsFolder := TDefaultOptionsFolder.Create(
      DEFAULT_FOLDER_NAME, FSystemOptionsStorage);
  AddOptionsFolder(FDefaultOptionsFolder);

end; // TGeneralOptionsFolder.CreateInstance


destructor TNavigatorOptions.Destroy();
begin
// закомментированный ниже код не нужен
// папки удаляются в классе-родителе
//  FreeAndNil(FDebugOptionsFolder);
//  FreeAndNil(FDisplayOptionsFolder);
//  FreeAndNil(FManageOptionsFolder);

  FreeAndNil(FUserOptionsStorage);
  FreeAndNil(FSystemOptionsStorage);

  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  inherited Destroy();

end; // TNavigatorOptions.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// singleton realization

class function TNavigatorOptions.AccessInstance(
    const ARequest: TSingletonOperation): TNavigatorOptions;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TNavigatorOptions = nil;
begin
  case ARequest of
    SinglOper_Access: begin
      // do nothing
    end;

    SinglOper_Create: begin
      if not Assigned(FInstance) then begin
        FInstance := CreateInstance();
      end;
    end;

    SinglOper_Destroy: begin
      FInstance := nil;
    end;

    else begin
      ASSERT(FALSE,
          Format('Illegal request %d in AccessInstance', [Ord(ARequest)]));
    end;
  end;

  Result := FInstance;

{$WRITEABLECONST OFF}
end; // TNavigatorOptions.AccessInstance


class function TNavigatorOptions.Instance(): TNavigatorOptions;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TNavigatorOptions.Instance


class procedure TNavigatorOptions.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TNavigatorOptions.ReleaseInstance


initialization

  Options := TNavigatorOptions.CreateInstance();

finalization

  TNavigatorOptions.ReleaseInstance();


end.
