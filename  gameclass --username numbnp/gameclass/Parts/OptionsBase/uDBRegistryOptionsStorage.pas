unit uDBRegistryOptionsStorage;

interface

uses
  Windows,
  uOption,
  uOptionsStorage,
  ADODB;

type

  //
  // TDBRegistryOptionsStorage
  //

  TDBRegistryOptionsStorage = class(TOptionsStorage)
  private
    // fields
    FcnnMain: TADOConnection;
    FbUseUserName: Boolean;
    FstrUserName: String;

  public
    // constructor / destructor
    constructor Create(const AcnnMain: TADOConnection;
        const AbUseUserName: Boolean = False;
        const AstrUserName: String = '');

    // public methods
    procedure LoadOption(const AstrFolderName: String;
        var AOption: TOption); override;
    procedure SaveOption(const AstrFolderName: String;
        const AOption: TOption); override;

    property Connection: TADOConnection
        read FcnnMain write FcnnMain;

  end; // TDBRegistryOptionsStorage


implementation

uses
  SysUtils,
  Registry,
  uSQLTools,
  DB;

const
  SP_REGISTRY_LOAD_ALL = 'RegistrySelect';
  SP_REGISTRY_LOAD = 'RegistrySelectByKey';
  SP_REGISTRY_INSERT = 'RegistryInsert';
  SP_REGISTRY_UPDATE = 'RegistryUpdate';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TDBRegistryOptionsStorage.Create(const AcnnMain: TADOConnection;
    const AbUseUserName: Boolean = False;
    const AstrUserName: String = '');
begin
  inherited Create();
  FcnnMain := AcnnMain;
  FbUseUserName := AbUseUserName;
  FstrUserName := AstrUserName;
end; // TDBRegistryOptionsStorage.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TDBRegistryOptionsStorage.LoadOption(const AstrFolderName: String;
    var AOption: TOption);
var
  dstResult: TADODataSet;
  strQuery: string;
  strKey, strValue: String;
begin
  if FcnnMain.Connected then begin
    strKey := AOption.Name;
    if Length(AstrFolderName) > 0 then
      strKey := AstrFolderName + '\' + strKey;
    if FbUseUserName then
      strKey := FstrUserName + '\' + strKey;
    strQuery := SP_REGISTRY_LOAD + ' @key=N''' + strKey + '''';
    dstResult := TADODataSet.Create(nil);
    dsDoQuery(FcnnMain, dstResult, strQuery);
    if not dstResult.Eof then begin
      strValue := dstResult.FieldValues['value'];
      if AOption is TStringOption then begin
        TStringOption(AOption).Value := strValue;
      end else if AOption is TIntegerOption then begin
        TIntegerOption(AOption).Value := StrToIntDef(strValue,
            TIntegerOption(AOption).DefValue);
      end else if AOption is TBooleanOption then begin
        TBooleanOption(AOption).Value := StrToBoolDef(strValue,
            TBooleanOption(AOption).DefValue);
      end;
      AOption.Update();
    end else begin
      AOption.Default;
      SaveOption(AstrFolderName, AOption);
    end;
    dstResult.Close;
    dstResult.Destroy;
  end;
end;

procedure TDBRegistryOptionsStorage.SaveOption(const AstrFolderName: String;
    const AOption: TOption);
var
  dstResult: TADODataSet;
  strQuery: string;
  strKey, strValue: String;
begin
  if FcnnMain.Connected then begin
    strKey := AOption.Name;
    if Length(AstrFolderName) > 0 then
      strKey := AstrFolderName + '\' + strKey;
    if FbUseUserName then
      strKey := FstrUserName + '\' + strKey;
    if AOption is TStringOption then begin
      strValue := TStringOption(AOption).Value;
    end else if AOption is TIntegerOption then begin
      strValue := IntToStr(TIntegerOption(AOption).Value);
    end else if AOption is TBooleanOption then begin
      strValue := BoolToStr(TBooleanOption(AOption).Value);
    end;
    //А вот не зная id записать в Registry без AutoUpdate не так то просто :(
    strQuery := SP_REGISTRY_LOAD_ALL;
    dstResult := TADODataSet.Create(nil);
    dsDoQuery(FcnnMain, dstResult, strQuery);
    dstResult.Filter := 'key = ''' + strKey + '''';
    dstResult.Filtered := True;
    if not dstResult.Eof then begin
      strQuery := SP_REGISTRY_UPDATE
          + ' @id=' + IntToStr(dstResult.FieldValues['id'])
          + ', @key=N''' + strKey
          + ''', @value=N''' + strValue + '''';
    end else begin
      //еще нет такого значения
      strQuery := SP_REGISTRY_INSERT + ' @key=N''' + strKey + ''', @value=N'''
          + strValue + '''';
    end;
    dstResult.Close;
    dstResult.Destroy;
    dsDoCommand(FcnnMain, strQuery);
    AOption.Update();
  end;
end;

end.
