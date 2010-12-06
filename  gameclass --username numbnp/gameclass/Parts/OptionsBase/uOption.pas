unit uOption;

interface

uses
  // system units
  Classes,
  Contnrs;

type

  // forward declaration
  TOption = class;

  // events types
  TOptionChangeEvent = procedure (Sender: TObject) of object;

  //
  // TOptionsLink
  //

  TOptionLink = class(TObject)
  private
    // attributes
    FSender: TOption;
    FOnChange: TOptionChangeEvent;

  public
    // constructor / destructor
    constructor Create(const AOption: TOption);
    destructor Destroy; override;

    // public methods
    procedure Change(); dynamic;

    // properties
    property OnChange: TOptionChangeEvent read FOnChange write FOnChange;

  end; // TOptionLink


  //
  // TOption
  //

  TOption = class(TObject)
  private
    // fields
    FstrName: String;
    FlstObservers: TObjectList;
    FbIsCritical : Boolean;
    FbStoraged: Boolean;
    FbDefaulted: Boolean;

    // fire methods
    procedure _FireChanged();

  protected
    // property methods
    function GetValue(): Boolean; virtual; abstract;
    procedure SetValue(); virtual;

    function GetDefValue(): Boolean; virtual; abstract;
    procedure SetDefValue(); virtual; abstract;

  public
    // constructor / destructor
    constructor Create(const AstrName: String);
    destructor Destroy(); override;

    // public methods
    procedure Default(); virtual;
    procedure Cancel(); virtual;
    procedure Update(); virtual;
    function IsChanged(): Boolean; virtual; abstract;

    // observer subject realization
    procedure RegisterChanges(Value: TOptionLink);
    procedure UnregisterChanges(Value: TOptionLink);

    // properties
    property Name: String read FstrName;
    property Value: Boolean read GetValue; // abstract
    property DefValue: Boolean read GetDefValue; // abstract
    property IsCritical: Boolean read FbIsCritical write FbIsCritical;
    property Storaged: Boolean read FbStoraged write FbStoraged;
    property Defaulted: Boolean read FbDefaulted write FbDefaulted;

  end; // TOption


  //
  // TIntegerOption
  //

  TIntegerOption = class(TOption)
  private
    // fields
    FnValue: Integer;
    FnOldValue: Integer;
    FnDefValue: Integer;

    // private helper methods

  protected
    // property methods
    function GetValue(): Integer; reintroduce;
    procedure SetValue(const AnValue: Integer); reintroduce;

    function GetDefValue(): Integer; reintroduce;
    procedure SetDefValue(const AnValue: Integer); reintroduce;

  public
    // public methods
    procedure Default(); override;
    procedure Cancel(); override;
    procedure Update(); override;
    function IsChanged(): Boolean; override;

    // properties
    property Value: Integer read GetValue write SetValue;
    property DefValue: Integer read GetDefValue write SetDefValue;

  end; // TIntegerOption


  //
  // TStringOption
  //

  TStringOption = class(TOption)
  private
    // fields
    FstrValue: String;
    FstrOldValue: String;
    FstrDefValue: String;

    // private helper methods

  protected
    // property methods
    function GetValue(): String; reintroduce;
    procedure SetValue(const AstrValue: String); reintroduce;

    function GetDefValue(): String; reintroduce;
    procedure SetDefValue(const AstrValue: String); reintroduce;

  public
    // public methods
    procedure Default(); override;
    procedure Cancel(); override;
    procedure Update(); override;
    function IsChanged(): Boolean; override;

    // properties
    property Value: String read GetValue write SetValue;
    property DefValue: String read GetDefValue write SetDefValue;

  end; // TOption


  //
  // TBooleanOption
  //

  TBooleanOption = class(TOption)
  private
    // fields
    FbValue: Boolean;
    FbOldValue: Boolean;
    FbDefValue: Boolean;

  protected
    // property methods
    function GetValue(): Boolean; reintroduce;
    procedure SetValue(const AbValue: Boolean); reintroduce;

    function GetDefValue(): Boolean; reintroduce;
    procedure SetDefValue(const AbValue: Boolean); reintroduce;

  public
    // public methods
    procedure Default(); override;
    procedure Cancel(); override;
    procedure Update(); override;
    function IsChanged(): Boolean; override;

    // properties
    property Value: Boolean read GetValue write SetValue;
    property DefValue: Boolean read GetDefValue write SetDefValue;

  end; // TBooleanOption


implementation

uses
  // system units
  SysUtils,
  // project units
  uOptionsFolder;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TOptionLink

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TOptionLink.Create(const AOption: TOption);
begin
  inherited Create();
  FSender := AOption;
  AOption.RegisterChanges(Self);
end; // TOptionLink.Create


destructor TOptionLink.Destroy();
begin
  ASSERT(Assigned(FSender));

  FSender.UnregisterChanges(Self);

  inherited Destroy();
end; // TOptionLink.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TOptionLink.Change();
begin
  if Assigned(OnChange) then begin
    OnChange(FSender);
  end;
end; // TOptionLink.Change


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TOption

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TOption.Create(const AstrName: String);
begin
  inherited Create();

  FstrName := AstrName;

  FbStoraged := TRUE;
  FbDefaulted := TRUE;

  FlstObservers := TObjectList.Create(FALSE);

end; // TOption.Create


destructor TOption.Destroy();
begin
  ASSERT(Assigned(FlstObservers));

  while FlstObservers.Count > 0 do begin
    UnregisterChanges(TOptionLink(FlstObservers.Last()));
  end;

  _FireChanged();

  FreeAndNil(FlstObservers);

  inherited Destroy();

end; // TOption.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TOption.Default();
begin
  _FireChanged();
end; // TOption.Default


procedure TOption.Cancel();
begin
  _FireChanged();
end; // TOption.Cancel


procedure TOption.Update();
begin
  _FireChanged();
end; // TOption.Update


//////////////////////////////////////////////////////////////////////////////
// observer subject realization

procedure TOption.RegisterChanges(Value: TOptionLink);
begin
  ASSERT(Assigned(Value));
  ASSERT(Assigned(FlstObservers));

  if Assigned(FlstObservers) then begin
    FlstObservers.Add(Value);
  end;

end; // TOption.RegisterChanges


procedure TOption.UnregisterChanges(Value: TOptionLink);
begin
  ASSERT(Assigned(Value));
  ASSERT(Assigned(FlstObservers));

  FlstObservers.Remove(Value);

end; // TOption.UnregisterChanges


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// property methods

procedure TOption.SetValue();
begin
  _FireChanged();
end; // TOption.SetValue


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// fire methods

procedure TOption._FireChanged();
var
  i: Integer;
begin
  ASSERT(Assigned(FlstObservers));

  for i := 0 to FlstObservers.Count - 1 do begin
    TOptionLink(FlstObservers[i]).Change();
  end;

end; // TOption._FireChanged


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TIntegerOption

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TIntegerOption.Default();
begin
  if Defaulted then begin
    FnValue := FnDefValue;
    inherited Default();
  end;
end; // TIntegerOption.Default


procedure TIntegerOption.Cancel();
begin
  FnValue := FnOldValue;
  inherited Cancel();
end; // TIntegerOption.Cancel


procedure TIntegerOption.Update();
begin
  FnOldValue := FnValue;
  inherited Update();
end; // TIntegerOption.Update


function TIntegerOption.IsChanged(): Boolean;
begin
  if Storaged then begin
    Result := (FnOldValue <> FnValue);
  end else begin
    Result := FALSE;
  end;
end; // TIntegerOption.IsChanged


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// property methods

function TIntegerOption.GetValue(): Integer;
begin
  Result := FnValue;
end; // TIntegerOption.GetValue


procedure TIntegerOption.SetValue(const AnValue: Integer);
begin
  if FnValue <> AnValue then begin
    FnValue := AnValue;
    inherited SetValue();
  end;
end; // TIntegerOption.SetValue


function TIntegerOption.GetDefValue(): Integer;
begin
  Result := FnDefValue;
end; // TIntegerOption.GetDefValue


procedure TIntegerOption.SetDefValue(const AnValue: Integer);
begin
  FnDefValue := AnValue;
end; // TIntegerOption.SetDefValue


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TStringOption

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TStringOption.Default();
begin
  if Defaulted then begin
    FstrValue := FstrDefValue;
    inherited Default();
  end;
end; // TStringOption.Default


procedure TStringOption.Cancel();
begin
  FstrValue := FstrOldValue;
  inherited Cancel();
end; // TStringOption.Cancel


procedure TStringOption.Update();
begin
  FstrOldValue := FstrValue;
  inherited Update();
end; // TStringOption.Update


function TStringOption.IsChanged(): Boolean;
begin
  if Storaged then begin
    Result := (FstrOldValue <> FstrValue);
  end else begin
    Result := FALSE;
  end;
end; // TStringOption.IsChanged


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// property methods

function TStringOption.GetValue(): String;
begin
  Result := FstrValue;
end; // TStringOption.GetValue


procedure TStringOption.SetValue(const AstrValue: String);
begin
  if FstrValue <> AstrValue then begin
    FstrValue := AstrValue;
    inherited SetValue();
  end;
end; // TStringOption.SetValue


function TStringOption.GetDefValue(): String;
begin
  Result := FstrDefValue;
end; // TStringOption.GetDefValue


procedure TStringOption.SetDefValue(const AstrValue: String);
begin
  FstrDefValue := AstrValue;
end; // TStringOption.SetDefValue


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TBooleanOption

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TBooleanOption.Default();
begin
  if Defaulted then begin
    FbValue := FbDefValue;
    inherited Default();
  end;
end; // TBooleanOption.Default


procedure TBooleanOption.Cancel();
begin
  FbValue := FbOldValue;
  inherited Cancel();
end; // TBooleanOption.Cancel


procedure TBooleanOption.Update();
begin
  FbOldValue := FbValue;
  inherited Update();
end; // TBooleanOption.Update


function TBooleanOption.IsChanged(): Boolean;
begin
  if Storaged then begin
    Result := (FbOldValue <> FbValue);
  end else begin
    Result := FALSE;
  end;
end; // TBooleanOption.IsChanged


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// property methods

function TBooleanOption.GetValue(): Boolean;
begin
  Result := FbValue;
end; // TBooleanOption.GetValue


procedure TBooleanOption.SetValue(const AbValue: Boolean);
begin
  if FbValue <> AbValue then begin
    FbValue := AbValue;
    inherited SetValue();
  end;
end; // TBooleanOption.SetValue


function TBooleanOption.GetDefValue(): Boolean;
begin
  Result := FbDefValue;
end; // TBooleanOption.GetDefValue


procedure TBooleanOption.SetDefValue(const AbValue: Boolean);
begin
  FbDefValue := AbValue;
end; // TBooleanOption.SetDefValue


end.
