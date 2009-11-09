unit uOptionsFolder;

interface

uses
  // system units
  Classes,
  Contnrs,
  // project units
  uOption,
  uOptionList,
  uOptionsStorage;

type

  // forward declaration
  TOptionsFolder = class;

  // events types
  TOptionsFolderChangeEvent = procedure (Sender: TObject) of object;
  TOptionsFolderSaveEvent = procedure (Sender: TObject) of object;

  //
  // TOptionsFolderLink
  //

  TOptionsFolderLink = class(TObject)
  private
    // fields
    FSender: TOptionsFolder;
    FOnChange: TOptionsFolderChangeEvent;
    FOnSave: TOptionsFolderSaveEvent;

  public
    // constructor / destructor
    constructor Create(const AOptionsFolder: TOptionsFolder);
    destructor Destroy; override;

    // public methods
    procedure Change(); dynamic;
    procedure Save(); dynamic;

    // properties
    property OnChange: TOptionsFolderChangeEvent
        read FOnChange write FOnChange;
    property OnSave: TOptionsFolderSaveEvent
        read FOnSave write FOnSave;

  end; // TOptionsFolderLink


  //
  // TOptionsFolder
  //

  TOptionsFolder = class(TObject)
  private
    // fields
    FstrName: String;
    FlstOptions: TOptionList;
    FlstObservers: TObjectList;
    FOptionsStorage: TOptionsStorage;

    // events handlers
    procedure _OptionChanged(ASender: TObject);

    // fire methods
    procedure _FireChanged();
    procedure _FireSaved();

    // private mehods
    procedure _SubscribeToOptionEvents(AOption: TOption);

  protected
    // protected methods
    function CreateAndAddStringOption(
        const AstrName: String): TStringOption; overload;
    function CreateAndAddIntegerOption(
        const AstrName: String): TIntegerOption; overload;
    function CreateAndAddBooleanOption(
        const AstrName: String): TBooleanOption; overload;

    function CreateAndAddStringOption(const AstrName: String;
        const AstrDefValue: String): TStringOption; overload;
    function CreateAndAddIntegerOption(const AstrName: String;
        const AnDefValue: Integer): TIntegerOption; overload;
    function CreateAndAddBooleanOption(const AstrName: String;
        const AbDefValue: Boolean): TBooleanOption; overload;

  public
    // constructor / destructor
    constructor Create(const AstrName: String;
        AOptionsStorage: TOptionsStorage);
    destructor Destroy(); override;

    // public methods
    procedure Save();
    procedure Load();
    procedure Default();
    procedure Cancel();
    function IsChanged(): Boolean;

    // observer subject realization
    procedure RegisterChanges(Value: TOptionsFolderLink);
    procedure UnregisterChanges(Value: TOptionsFolderLink);

    // properties
    property Name: String read FstrName;

  end; // TOptionsFolder


implementation

uses
  // system units
  SysUtils;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TOptionsFolderLink

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TOptionsFolderLink.Create(const AOptionsFolder: TOptionsFolder);
begin
  inherited Create();
  FSender := AOptionsFolder;
  AOptionsFolder.RegisterChanges(Self); 
end; // TOptionsFolderLink.Create


destructor TOptionsFolderLink.Destroy();
begin
  ASSERT(Assigned(FSender));

  FSender.UnregisterChanges(Self);

  inherited Destroy();
end; // TOptionsFolderLink.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TOptionsFolderLink.Change();
begin
  if Assigned(OnChange) then begin
    OnChange(FSender);
  end;
end; // TOptionsFolderLink.Change


procedure TOptionsFolderLink.Save();
begin
  if Assigned(OnSave) then begin
    OnSave(FSender);
  end;
end; // TOptionsFolderLink.Save



//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TOptionsFolder

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TOptionsFolder.Create(const AstrName: String;
    AOptionsStorage: TOptionsStorage);
begin
  inherited Create();
  FstrName := AstrName;
  FOptionsStorage := AOptionsStorage;
  FlstObservers := TObjectList.Create();
  FlstOptions := TOptionList.Create();
end; // TOptionsFolder.Create


destructor TOptionsFolder.Destroy();
begin
  ASSERT(Assigned(FlstObservers));

  while FlstObservers.Count > 0 do begin
    UnregisterChanges(TOptionsFolderLink(FlstObservers.Last));
  end;

  _FireChanged();

  FreeAndNil(FlstObservers);

  FreeAndNil(FlstOptions);

  inherited Destroy();

end; // TOptionsFolder.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TOptionsFolder.Save();
var
  i: Integer;
  opt: TOption;
  bSaved: Boolean;
begin
  bSaved := FALSE;
  for i := 0 to FlstOptions.Count - 1 do begin
    opt := FlstOptions[i];
    if opt.Storaged then begin
      if opt.IsChanged() then begin
        bSaved := TRUE;
        FOptionsStorage.SaveOption(Name, opt);
      end;
    end;
  end;
  if bSaved then begin
    _FireSaved();
  end;
end; // TOptionsFolder.Save


procedure TOptionsFolder.Load();
var
  i: Integer;
  opt: TOption;
begin
  for i := 0 to FlstOptions.Count - 1 do begin
    opt := FlstOptions[i];
    FOptionsStorage.LoadOption(Name, opt);
  end;
end; // TOptionsFolder.Load


procedure TOptionsFolder.Default();
var
  i: Integer;
begin
  for i := 0 to FlstOptions.Count - 1 do begin
    FlstOptions[i].Default();
  end;
end; // TOptionsFolder.Default


procedure TOptionsFolder.Cancel();
var
  i: Integer;
begin
  for i := 0 to FlstOptions.Count - 1 do begin
    FlstOptions[i].Cancel();
  end;
end; // TOptionsFolder.Cancel


function TOptionsFolder.IsChanged(): Boolean;
var
  i: Integer;
begin
  Result := FALSE;
  for i := 0 to FlstOptions.Count - 1 do begin
    if FlstOptions[i].IsChanged() then begin
      Result := TRUE;
      break;
    end;
  end;
end; // TOptionsFolder.IsChanged


//////////////////////////////////////////////////////////////////////////////
// observer subject realization

procedure TOptionsFolder.RegisterChanges(Value: TOptionsFolderLink);
begin
  ASSERT(Assigned(Value));
  ASSERT(Assigned(FlstObservers));

  if Assigned(FlstObservers) then begin
    FlstObservers.Add(Value);
  end;
end; // TOptionsFolder.RegisterChanges


procedure TOptionsFolder.UnregisterChanges(Value: TOptionsFolderLink);
begin
  ASSERT(Assigned(Value));
  ASSERT(Assigned(FlstObservers));

  FlstObservers.Remove(Value);
end; // TOptions.UnregisterChanges


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TOptionsFolder._OptionChanged(ASender: TObject);
begin
  _FireChanged();
end; // TOptionsFolder._OptionChanged


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

function TOptionsFolder.CreateAndAddStringOption(
    const AstrName: String): TStringOption;
begin
  Result := TStringOption.Create(AstrName);
  _SubscribeToOptionEvents(Result);
  FlstOptions.Add(Result);
end; // TOptionsFolder.CreateAndAddStringOption


function TOptionsFolder.CreateAndAddIntegerOption(
    const AstrName: String): TIntegerOption;
begin
  Result := TIntegerOption.Create(AstrName);
  _SubscribeToOptionEvents(Result);
  FlstOptions.Add(Result);
end; // TOptionsFolder.CreateAndAddIntegerOption


function TOptionsFolder.CreateAndAddBooleanOption(
    const AstrName: String): TBooleanOption;
begin
  Result := TBooleanOption.Create(AstrName);
  _SubscribeToOptionEvents(Result);
  FlstOptions.Add(Result);
end; // TOptionsFolder.CreateAndAddBooleanOption


function TOptionsFolder.CreateAndAddStringOption(const AstrName: String;
    const AstrDefValue: String): TStringOption;
begin
  Result := CreateAndAddStringOption(AstrName);
  Result.DefValue := AstrDefValue;
end; // TOptionsFolder.CreateAndAddStringOption


function TOptionsFolder.CreateAndAddIntegerOption(const AstrName: String;
    const AnDefValue: Integer): TIntegerOption;
begin
  Result := CreateAndAddIntegerOption(AstrName);
  Result.DefValue := AnDefValue;
end; // TOptionsFolder.CreateAndAddIntegerOption


function TOptionsFolder.CreateAndAddBooleanOption(const AstrName: String;
    const AbDefValue: Boolean): TBooleanOption;
begin
  Result := CreateAndAddBooleanOption(AstrName);
  Result.DefValue := AbDefValue;
end; // TOptionsFolder.CreateAndAddBooleanOption


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// fire methods

procedure TOptionsFolder._FireChanged();
var
  i: Integer;
begin
  ASSERT(Assigned(FlstObservers));

  for i := 0 to FlstObservers.Count - 1 do begin
    TOptionsFolderLink(FlstObservers[i]).Change();
  end;

end; // TOptionsFolder._FireChanged


procedure TOptionsFolder._FireSaved();
var
  i: Integer;
begin
  ASSERT(Assigned(FlstObservers));

  for i := 0 to FlstObservers.Count - 1 do begin
    TOptionsFolderLink(FlstObservers[i]).Save();
  end;

end; // TOptionsFolder._FireSaved


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private mehods

procedure TOptionsFolder._SubscribeToOptionEvents(AOption: TOption);
var
  OptionLink: TOptionLink;
begin
  OptionLink := TOptionLink.Create(AOption);
  OptionLink.OnChange := _OptionChanged;
end; // TOptionsFolder._SubscribeToOptionEvents


end.
