unit uGCTIOptions;

interface

uses
  // project units
  uY2KCommon,
  uOption,
  uOptionsFolder,
  uOptionsStorage,
  uRegistryOptionsStorage,
  uOptions;


type

  TTariffingMode = (TariffingModeTraffic = 1, TariffingModeCost = 2);
  TStoppingMode = (StoppingModeAll = 1, StoppingModeOnlyGC = 2);
  //
  // TGeneralOptionsFolder
  //


  TGeneralOptionsFolder = class(TOptionsFolder)
  private
    // fields
    FstrPassword: TStringOption;
    FnTariffingMode: TIntegerOption;
    FbTariffingUseCache: TBooleanOption;
    FbStoppingByStart: TBooleanOption;
    FbStoppingByStop: TBooleanOption;
    FnStoppingByStartMode: TIntegerOption;
    FnStoppingByStopMode: TIntegerOption;
    FbNoAddUsers: TBooleanOption;
    FbDebugLog: TBooleanOption;
    FstrSerializedString: TStringOption;
  protected
    function GetDecriptedPassword: String;
    function GetPasswordNotEmpty: Boolean;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);

    // properties
    property Password: TStringOption read FstrPassword;
    property TariffingMode: TIntegerOption read FnTariffingMode;
    property TariffingUseCache: TBooleanOption read FbTariffingUseCache;
    property StoppingByStart: TBooleanOption read FbStoppingByStart;
    property StoppingByStop: TBooleanOption read FbStoppingByStop;
    property StoppingByStartMode: TIntegerOption read FnStoppingByStartMode;
    property StoppingByStopMode: TIntegerOption read FnStoppingByStopMode;
    property NoAddUsers: TBooleanOption read FbNoAddUsers;
    property DebugLog: TBooleanOption read FbDebugLog;
    property SerializedString: TStringOption read FstrSerializedString;
    property DecriptedPassword: String read GetDecriptedPassword;
    property PasswordNotEmpty: Boolean read GetPasswordNotEmpty;


  end; // TGeneralOptionsFolder

  //
  // TGCTIOptions
  //

  TGCTIOptions = class(TOptions)
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
        const ARequest: TSingletonOperation): TGCTIOptions;
    class procedure ReleaseInstance();

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // singleton realization
    class function Instance(): TGCTIOptions;

    // properties
    property Genaral: TGeneralOptionsFolder read FGeneralOptionsFolder;
  end; // TGCTIOptions


var
  Options: TGCTIOptions;

implementation
uses
  // system units
  Graphics,
  Windows,
  SysUtils,
  uCoder;


const
  REGISTRY_PATH = 'Software\NodaSoft\GameClass3 TrafficInspector PlugIn\Options';

  GENERAL_FOLDER_NAME = 'General';

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

  FstrPassword := CreateAndAddStringOption('Password', '');
  FnTariffingMode := CreateAndAddIntegerOption('TariffingMode',
      Ord(TariffingModeTraffic));
  FbTariffingUseCache := CreateAndAddBooleanOption('TariffingUseCache', False);
  FbStoppingByStart := CreateAndAddBooleanOption('StoppingByStart', True);
  FbStoppingByStop := CreateAndAddBooleanOption('StoppingByStop', True);
  FnStoppingByStartMode := CreateAndAddIntegerOption('StoppingByStartMode',
      Ord(StoppingModeOnlyGC));
  FnStoppingByStopMode := CreateAndAddIntegerOption('StoppingByStopMode',
      Ord(StoppingModeOnlyGC));
  FbNoAddUsers := CreateAndAddBooleanOption('NoAddUsers', False);
  FbDebugLog := CreateAndAddBooleanOption('DebugLog', False);
  FstrSerializedString := CreateAndAddStringOption('SerializedString', '');
end; // TGeneralOptionsFolder.Create

function TGeneralOptionsFolder.GetDecriptedPassword: String;
var
  coder: TCoder;
  strPassword: String;
begin
  if (Length(Options.Genaral.Password.Value) > 0) then begin
    coder := TCoder.Create;
    strPassword := Options.Genaral.Password.Value;
    strPassword := coder.SimpleDecodeString(strPassword);
    coder._RemoveZeroBytes(strPassword);
    coder.Free;
  end else begin
    strPassword := '';
  end;
  Result := strPassword;
end;

function TGeneralOptionsFolder.GetPasswordNotEmpty: Boolean;
begin
  Result := (Length(Options.Genaral.Password.Value) > 0);
end;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TGCTIOptions

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TGCTIOptions.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));

end; // TGCTIOptions.Create


constructor TGCTIOptions.CreateInstance();
begin
  inherited Create();

  FSystemOptionsStorage := TRegistryOptionsStorage.Create(
      HKEY_LOCAL_MACHINE, REGISTRY_PATH);

  FGeneralOptionsFolder := TGeneralOptionsFolder.Create(
      GENERAL_FOLDER_NAME, FSystemOptionsStorage);
  AddOptionsFolder(FGeneralOptionsFolder);
end; // TGeneralOptionsFolder.CreateInstance


destructor TGCTIOptions.Destroy();
begin
  FreeAndNil(FSystemOptionsStorage);

  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;

  inherited Destroy();

end; // TGCTIOptions.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// singleton realization

class function TGCTIOptions.AccessInstance(
    const ARequest: TSingletonOperation): TGCTIOptions;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TGCTIOptions = nil;
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
end; // TGCTIOptions.AccessInstance


class function TGCTIOptions.Instance(): TGCTIOptions;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TGCTIOptions.Instance


class procedure TGCTIOptions.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TGCTIOptions.ReleaseInstance


initialization

  Options := TGCTIOptions.CreateInstance();

finalization

  TGCTIOptions.ReleaseInstance();


end.
