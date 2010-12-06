unit uSyncOptions;

interface

uses
  ADODB,
  // project units
  uY2KCommon,
  uOption,
  uOptionsFolder,
  uOptionsStorage,
  uDBRegistryOptionsStorage,
  uOptions;


type

  //
  // TGeneralOptionsFolder
  //


  TGeneralOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FnSyncInterval: TIntegerOption;
    FstrInitializationDate: TStringOption;
    FbTariffingUseCache: TBooleanOption;
    FbStoppingByStart: TBooleanOption;
    FbStoppingByStop: TBooleanOption;
    FbNoAddUsers: TBooleanOption;
    FbDebugLog: TBooleanOption;
    FstrSerializedString: TStringOption;
  protected

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property SyncInterval: TIntegerOption read FnSyncInterval;
    property InitializationDate: TStringOption read FstrInitializationDate;
    property TariffingUseCache: TBooleanOption read FbTariffingUseCache;
    property StoppingByStart: TBooleanOption read FbStoppingByStart;
    property StoppingByStop: TBooleanOption read FbStoppingByStop;
    property NoAddUsers: TBooleanOption read FbNoAddUsers;
    property DebugLog: TBooleanOption read FbDebugLog;
    property SerializedString: TStringOption read FstrSerializedString;

  end; // TGeneralOptionsFolder

  //
  // TSyncOptions
  //

  TSyncOptions = class(TOptions)
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
        const ARequest: TSingletonOperation): TSyncOptions;
    class procedure ReleaseInstance();

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // singleton realization
    class function Instance(): TSyncOptions;

    procedure SetConnection(const AcnnMain: TADOConnection);

    // properties
    property General: TGeneralOptionsFolder read FGeneralOptionsFolder;
  end; // TSyncOptions


var
  Options: TSyncOptions;

implementation
uses
  // system units
  Graphics,
  Windows,
  SysUtils;


const
  GENERAL_FOLDER_NAME = 'SyncOptions';

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

  FnSyncInterval := CreateAndAddIntegerOption('SyncInterval', 5);
  FstrInitializationDate := CreateAndAddStringOption('InitializationDate', '');
  FbTariffingUseCache := CreateAndAddBooleanOption('TariffingUseCache', False);
  FbStoppingByStart := CreateAndAddBooleanOption('StoppingByStart', True);
  FbStoppingByStop := CreateAndAddBooleanOption('StoppingByStop', True);
  FbNoAddUsers := CreateAndAddBooleanOption('NoAddUsers', False);
  FbDebugLog := CreateAndAddBooleanOption('DebugLog', False);
  FstrSerializedString := CreateAndAddStringOption('SerializedString', '');
end; // TGeneralOptionsFolder.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TSyncOptions

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TSyncOptions.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));

end; // TSyncOptions.Create


constructor TSyncOptions.CreateInstance();
begin
  inherited Create();

  FSystemOptionsStorage := TDBRegistryOptionsStorage.Create(Nil);

  FGeneralOptionsFolder := TGeneralOptionsFolder.Create(
      GENERAL_FOLDER_NAME, FSystemOptionsStorage);
  AddOptionsFolder(FGeneralOptionsFolder);
end; // TGeneralOptionsFolder.CreateInstance


destructor TSyncOptions.Destroy();
begin
  FreeAndNil(FSystemOptionsStorage);

  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  inherited Destroy();

end; // TSyncOptions.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// singleton realization

class function TSyncOptions.AccessInstance(
    const ARequest: TSingletonOperation): TSyncOptions;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TSyncOptions = nil;
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
end; // TSyncOptions.AccessInstance


class function TSyncOptions.Instance(): TSyncOptions;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TSyncOptions.Instance


class procedure TSyncOptions.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TSyncOptions.ReleaseInstance

procedure TSyncOptions.SetConnection(const AcnnMain: TADOConnection);
begin
  TDBRegistryOptionsStorage(FSystemOptionsStorage).Connection := AcnnMAin;
end; // TViewerOptions.ReleaseInstance

initialization

  Options := TSyncOptions.CreateInstance();

finalization

  TSyncOptions.ReleaseInstance();


end.
