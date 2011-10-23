unit uViewerOptions;

interface

uses
  // project units
  uY2KCommon,
  uOption,
  uOptionsFolder,
  uOptionsStorage,
  uOptions,
  ADODB;


type

  TTariffingMode = (TariffingModeTraffic = 1, TariffingModeCost = 2);
  TStoppingMode = (StoppingModeAll = 1, StoppingModeOnlyGC = 2);
  //
  // TGeneralOptionsFolder
  //


  TGeneralOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FstrUnblockPasswordHash: TStringOption;
    FstrFont: TStringOption;
    FnSpaceLimitMin: TIntegerOption;
    FnBusyLimitMin: TIntegerOption;
    FbTime05: TBooleanOption;
    FbTime1: TBooleanOption;
    FbTime15: TBooleanOption;
    FbTime2: TBooleanOption;
    FbTime3: TBooleanOption;
    FbTime4: TBooleanOption;
    FbTime: TBooleanOption;
    FbUseLargeIcons: TBooleanOption;
    FbMarkBusyLimited: TBooleanOption;
    FbMarkFreeLimited: TBooleanOption;
    FbCustomFirstColumnTitle: TBooleanOption;
    FbCustomSecondColumnTitle: TBooleanOption;
    FstrFirstColumnTitle: TStringOption;
    FstrSecondColumnTitle: TStringOption;
    FbSortByNumber: TBooleanOption;
    FbShowTime: TBooleanOption;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    function OnlyOneTimeColumnVisible: Boolean;
    function SingleTimeColumnIndex: Integer;
    // properties
    property UnblockPasswordHash: TStringOption read FstrUnblockPasswordHash;
    property Font: TStringOption read FstrFont;
    property SpaceLimitMin: TIntegerOption read FnSpaceLimitMin;
    property BusyLimitMin: TIntegerOption read FnBusyLimitMin;
    property Time05: TBooleanOption read FbTime05;
    property Time1: TBooleanOption read FbTime1;
    property Time15: TBooleanOption read FbTime15;
    property Time2: TBooleanOption read FbTime2;
    property Time3: TBooleanOption read FbTime3;
    property Time4: TBooleanOption read FbTime4;
    property Time: TBooleanOption read FbTime;
    property UseLargeIcons: TBooleanOption read FbUseLargeIcons;
    property MarkBusyLimited: TBooleanOption read FbMarkBusyLimited;
    property MarkFreeLimited: TBooleanOption read FbMarkFreeLimited;
    property CustomFirstColumnTitle: TBooleanOption
        read FbCustomFirstColumnTitle;
    property CustomSecondColumnTitle: TBooleanOption
        read FbCustomSecondColumnTitle;
    property FirstColumnTitle: TStringOption read FstrFirstColumnTitle;
    property SecondColumnTitle: TStringOption read FstrSecondColumnTitle;
    property SortByNumber: TBooleanOption read FbSortByNumber;
    property ShowTime: TBooleanOption read FbShowTime;

  end; // TGeneralOptionsFolder

  //
  // TViewerOptions
  //

  TViewerOptions = class(TOptions)
  private
    // fields
    FSystemOptionsStorage: TOptionsStorage;
    FGeneralOptionsFolder: TGeneralOptionsFolder;

  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    // singleton realization
    class function AccessInstance(
        const ARequest: TSingletonOperation): TViewerOptions;
    class procedure ReleaseInstance();

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // singleton realization
    class function Instance(): TViewerOptions;

    procedure SetConnection(const AcnnMain: TADOConnection);

    // properties
    property General: TGeneralOptionsFolder read FGeneralOptionsFolder;
  end; // TViewerOptions


var
  Options: TViewerOptions;

implementation
uses
  // system units
  Graphics,
  Windows,
  SysUtils,
  udmMain,
  uDBRegistryOptionsStorage,
  ufrmMain,
  Forms;


const
  GENERAL_FOLDER_NAME = 'ViewerOptions';

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

  FstrUnblockPasswordHash := CreateAndAddStringOption('UnblockPasswordHash',
      '');
  FstrFont := CreateAndAddStringOption('Font',
    FontToStr(Screen.HintFont));
  FnSpaceLimitMin := CreateAndAddIntegerOption('SpaceLimitMin', 10);
  FnBusyLimitMin := CreateAndAddIntegerOption('BusyLimitMin', 10);
  FbTime05 := CreateAndAddBooleanOption('Time0.5', True);
  FbTime1 := CreateAndAddBooleanOption('Time1', True);
  FbTime15 := CreateAndAddBooleanOption('Time1.5', True);
  FbTime2 := CreateAndAddBooleanOption('Time2', True);
  FbTime3 := CreateAndAddBooleanOption('Time3', True);
  FbTime4 := CreateAndAddBooleanOption('Time4', True);
  FbTime := CreateAndAddBooleanOption('Time', False);
  FbUseLargeIcons := CreateAndAddBooleanOption('UseLargeIcons', False);
  FbMarkBusyLimited := CreateAndAddBooleanOption('MarkBusyLimited', True);
  FbMarkFreeLimited := CreateAndAddBooleanOption('MarkFreeLimited', True);
  FbCustomFirstColumnTitle :=
      CreateAndAddBooleanOption('CustomFirstColumnTitle', False);
  FbCustomSecondColumnTitle :=
      CreateAndAddBooleanOption('CustomSecondColumnTitle', False);
  FstrFirstColumnTitle := CreateAndAddStringOption('FirstColumnTitle', '');
  FstrSecondColumnTitle := CreateAndAddStringOption('SecondColumnTitle', '');
  FbSortByNumber := CreateAndAddBooleanOption('SortByNumber', False);
  FbShowTime := CreateAndAddBooleanOption('ShowTime', True);

end; // TGeneralOptionsFolder.Create

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TViewerOptions

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TViewerOptions.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));

end; // TViewerOptions.Create


constructor TViewerOptions.CreateInstance();
begin
  inherited Create();

  FSystemOptionsStorage := TDBRegistryOptionsStorage.Create(
      Nil);

  FGeneralOptionsFolder := TGeneralOptionsFolder.Create(
      GENERAL_FOLDER_NAME, FSystemOptionsStorage);
  AddOptionsFolder(FGeneralOptionsFolder);
end; // TGeneralOptionsFolder.CreateInstance


destructor TViewerOptions.Destroy();
begin
  FreeAndNil(FSystemOptionsStorage);

  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  inherited Destroy();

end; // TViewerOptions.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// singleton realization

class function TViewerOptions.AccessInstance(
    const ARequest: TSingletonOperation): TViewerOptions;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TViewerOptions = nil;
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
end; // TViewerOptions.AccessInstance


class function TViewerOptions.Instance(): TViewerOptions;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TViewerOptions.Instance


class procedure TViewerOptions.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TViewerOptions.ReleaseInstance

procedure TViewerOptions.SetConnection(const AcnnMain: TADOConnection);
begin
  TDBRegistryOptionsStorage(FSystemOptionsStorage).Connection := AcnnMAin;
end; // TViewerOptions.ReleaseInstance

function TGeneralOptionsFolder.OnlyOneTimeColumnVisible: Boolean;
var
  nCount: Integer;
begin
  nCount := 0;
  if Time05.Value then
    Inc(nCount);
  if Time1.Value then
    Inc(nCount);
  if Time15.Value then
    Inc(nCount);
  if Time2.Value then
    Inc(nCount);
  if Time3.Value then
    Inc(nCount);
  if Time4.Value then
    Inc(nCount);
  Result := (nCount = 1);
end; // TViewerOptions.ReleaseInstance

function TGeneralOptionsFolder.SingleTimeColumnIndex: Integer;
begin
  Result := 0;
  if OnlyOneTimeColumnVisible then begin
    if Time05.Value then
      Result := 2;
    if Time1.Value then
      Result := 3;
    if Time15.Value then
      Result := 4;
    if Time2.Value then
      Result := 5;
    if Time3.Value then
      Result := 6;
    if Time4.Value then
      Result := 7;
  end;
end; // TViewerOptions.ReleaseInstance

initialization

  Options := TViewerOptions.CreateInstance();

finalization

  TViewerOptions.ReleaseInstance();


end.
