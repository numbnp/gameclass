//////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////

unit uOptions;

interface

uses
  // system units
  Classes,
  Contnrs,
  // project units
  uOption,
  uOptionsFolder,
  uOptionsFolderList;

  
type

  // forward declaration
  TOptions = class;

  
  // events types
  TOptionsChangeEvent = procedure (Sender: TObject;
      const AbChanged: boolean) of object;
  TOptionsSaveEvent = procedure (Sender: TObject) of object;


  //
  // TOptionsLink
  //

  TOptionsLink = class(TObject)
  private
    // fields
    FSender: TOptions;
    FOnChange: TOptionsChangeEvent;
    FOnSave: TOptionsSaveEvent;

  public
    // constructor / destructor
    constructor Create(const AOptions: TOptions);
    destructor Destroy(); override;

    // public methods
    procedure Change(const AbChanged: Boolean); dynamic;
    procedure Save(); dynamic;

    // properties
    property OnChange: TOptionsChangeEvent read FOnChange write FOnChange;
    property OnSave: TOptionsSaveEvent read FOnSave write FOnSave;

  end; // TOptionsLink


  //
  // TOptions
  //

  TOptions = class(TObject)
  private
    // fields
    FlstOptionsFolders: TOptionsFolderList;
    FlstObservers: TObjectList;

    // events handlers
    procedure _OptionsFolderChanged(ASender: TObject);
    procedure _OptionsFolderSaved(ASender: TObject);

    // fire methods
    procedure _FireChanged();
    procedure _FireSaved();

  protected
    // protected methods
    procedure AddOptionsFolder(AOptionsFolder: TOptionsFolder);

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    procedure Save();
    procedure Load();
    procedure Default();
    procedure Cancel();
    function IsChanged(): Boolean;

    // observer subject realization
    procedure RegisterChanges(Value: TOptionsLink);
    procedure UnregisterChanges(Value: TOptionsLink);

  end; // TOptions


implementation

uses
  // system units
  SysUtils,
  Dialogs;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TOptionsLink

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TOptionsLink.Create(const AOptions: TOptions);
begin
  inherited Create();
  FSender := AOptions;
  AOptions.RegisterChanges(Self);
end; // TOptionsLink.Create


destructor TOptionsLink.Destroy();
begin
  ASSERT(Assigned(FSender));

  FSender.UnregisterChanges(Self);

  inherited Destroy();
end; // TOptionsLink.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TOptionsLink.Change(const AbChanged: Boolean);
begin
  if Assigned(OnChange) then begin
    OnChange(FSender, AbChanged);
  end;
end; // TOptionsLink.Change


procedure TOptionsLink.Save();
begin
  if Assigned(OnSave) then begin
    OnSave(FSender);
  end;
end; // TOptionsLink.Save



//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TOptions


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TOptions.Create();
begin
  inherited Create();
  FlstObservers := TObjectList.Create(FALSE);
  FlstOptionsFolders := TOptionsFolderList.Create(TRUE);
end; // TOptions.Create


destructor TOptions.Destroy();
begin
  ASSERT(Assigned(FlstObservers));

  while FlstObservers.Count > 0 do begin
    UnregisterChanges(TOptionsLink(FlstObservers.Last));
  end;

  _FireChanged();

  FreeAndNil(FlstObservers);

  FreeAndNil(FlstOptionsFolders);

  inherited Destroy();

end; // TOptions.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TOptions.Save();
var
  i: Integer;
begin
  for i := 0 to FlstOptionsFolders.Count - 1 do begin
    FlstOptionsFolders[i].Save();
  end;
end; // TOptions.Save


procedure TOptions.Load();
var
  i: Integer;
begin
  for i := 0 to FlstOptionsFolders.Count - 1 do begin
    FlstOptionsFolders[i].Load();
  end;
end; // TOptions.Load


procedure TOptions.Default();
var
  i: Integer;
begin
  for i := 0 to FlstOptionsFolders.Count - 1 do begin
    FlstOptionsFolders[i].Default();
  end;
end; // TOptions.Default


procedure TOptions.Cancel();
var
  i: Integer;
begin
  for i := 0 to FlstOptionsFolders.Count - 1 do begin
    FlstOptionsFolders[i].Cancel();
  end;
end; // TOptions.Cancel


function TOptions.IsChanged(): Boolean;
var
  i: Integer;
begin
  Result := FALSE;
  for i := 0 to FlstOptionsFolders.Count - 1 do begin
    if FlstOptionsFolders[i].IsChanged() then begin
      Result := TRUE;
      break;
    end;
  end;
end; // TOptions.IsChanged


//////////////////////////////////////////////////////////////////////////////
// observer subject realization

procedure TOptions.RegisterChanges(Value: TOptionsLink);
begin
  ASSERT(Assigned(Value));
  ASSERT(Assigned(FlstObservers));

  if Assigned(FlstObservers) then begin
    FlstObservers.Add(Value);
  end;
end; // TOptions.RegisterChanges


procedure TOptions.UnregisterChanges(Value: TOptionsLink);
begin
  ASSERT(Assigned(Value));
  ASSERT(Assigned(FlstObservers));

  FlstObservers.Remove(Value);
end; // TOptions.UnregisterChanges


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TOptions.AddOptionsFolder(AOptionsFolder: TOptionsFolder);
var
  OptionsFolderLink: TOptionsFolderLink;
begin
  OptionsFolderLink := TOptionsFolderLink.Create(AOptionsFolder);

  OptionsFolderLink.OnChange := _OptionsFolderChanged;
  OptionsFolderLink.OnSave := _OptionsFolderSaved;

  FlstOptionsFolders.Add(AOptionsFolder);

end; // TOptions.AddOptionsFolder


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TOptions._OptionsFolderChanged(ASender: TObject);
begin
  _FireChanged();
end; // TOptions._OptionsFolderChanged


procedure TOptions._OptionsFolderSaved(ASender: TObject);
begin
  _FireSaved();
end; // TOptions._OptionsFolderSaved


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// fire metods

procedure TOptions._FireChanged();
var
  i: Integer;
begin
  ASSERT(Assigned(FlstObservers));

  for i := 0 to FlstObservers.Count - 1 do begin
    TOptionsLink(FlstObservers[i]).Change(IsChanged());
  end;

end; // TOptions._FireChanged


procedure TOptions._FireSaved();
var
  i: Integer;
begin
  ASSERT(Assigned(FlstObservers));

  for i := 0 to FlstObservers.Count - 1 do begin
    TOptionsLink(FlstObservers[i]).Save();
  end;

end; // TOptions._FireSaved


end.
