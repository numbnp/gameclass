//////////////////////////////////////////////////////////////////////////////
//
// TIconList - класс, содержащий список иконок и
// набор методов работы с этим списком.
//
// Данный модуль является переработкой модуля IcoList.pas из библиотеки
// RxLib версии 2.75.
//
//////////////////////////////////////////////////////////////////////////////


unit uIconList;

interface

uses
  // system units
  Messages,
  Windows,
  SysUtils,
  Classes,
  Graphics;

type

  //
  // TIconList class
  //

  TIconList = class(TPersistent)
  private
    // fields
    FList: TList;
    FnUpdateCount: Integer;
    FOnChange: TNotifyEvent;

    // events handlers
    procedure _IconChanged(ASender: TObject);

    // private helper methods
    procedure _SetUpdateState(const AbUpdating: Boolean);
    function _AddIcon(const AIcon: TIcon): Integer;
    procedure _ReadData(AStream: TStream);
    procedure _WriteData(AStream: TStream);

  protected
    // protected methods
    procedure Changed(); virtual;
    procedure DefineProperties(Filer: TFiler); override;

    // properties methods
    function GetCount(): Integer; virtual;
    function GetIcon(const AnIndex: Integer): TIcon; virtual;
    procedure SetIcon(const AnIndex: Integer; const AIcon: TIcon); virtual;

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // public methods
    function Add(const AIcon: TIcon): Integer; virtual;
    function AddResource(const AhInstance: THandle;
        const ApcResId: PChar): Integer; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate();
    procedure EndUpdate();
    procedure Clear(); virtual;
    procedure Delete(const AnIndex: Integer); virtual;
    procedure Exchange(const AnIndex1: Integer;
        const AnIndex2: Integer); virtual;
    function IndexOf(const AIcon: TIcon): Integer; virtual;
    procedure Insert(const AnIndex: Integer; const AIcon: TIcon); virtual;
    procedure InsertResource(const AnIndex: Integer;
        const AhInstance: THandle; const ApcResId: PChar); virtual;
    procedure LoadResource(const AhInstance: THandle;
        const ResIds: array of PChar);
    procedure LoadFromStream(const AStream: TStream); virtual;
    procedure Move(const AnCurIndex: Integer;
        const AnNewIndex: Integer); virtual;
    procedure SaveToStream(const AStream: TStream); virtual;

    // properties
    property Count: Integer read GetCount;
    property Icons[const Index: Integer]: TIcon
        read GetIcon write SetIcon; default;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  end; // TIconList


implementation

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TIconList.Create();
begin
  inherited Create();
  FList := TList.Create();
end; // TIconList.Create


destructor TIconList.Destroy;
begin
  FOnChange := nil;
  Clear();
  FreeAndNil(FList);
  inherited Destroy();
end; // TIconList.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TIconList.BeginUpdate();
begin
  if FnUpdateCount = 0 then begin
    _SetUpdateState(TRUE);
  end;
  Inc(FnUpdateCount);
end; // TIconList.BeginUpdate


procedure TIconList.EndUpdate();
begin
  Dec(FnUpdateCount);
  if FnUpdateCount = 0 then begin
    _SetUpdateState(FALSE);
  end;
end; // TIconList.EndUpdate


function TIconList.Add(const AIcon: TIcon): Integer;
var
  Icon: TIcon;
begin
  Icon := TIcon.Create();
  try
    Icon.Assign(AIcon);
    Result := _AddIcon(Icon);
  except
    FreeAndNil(Icon);
    raise;
  end;
end; // TIconList.Add


function TIconList.AddResource(const AhInstance: THandle;
    const ApcResId: PChar): Integer;
var
  Icon: TIcon;
begin
  Icon := TIcon.Create();
  try
    Icon.Handle := LoadIcon(AhInstance, ApcResId);
    Result := _AddIcon(Icon);
  except
    FreeAndNil(Icon);
    raise;
  end;
end; // TIconList.AddResource


procedure TIconList.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if not Assigned(Source) then begin
    Clear();
  end else if Source is TIconList then begin
    BeginUpdate();
    try
      Clear();
      for i := 0 to TIconList(Source).Count - 1 do begin
        Add(TIconList(Source)[i]);
      end;
    finally
      EndUpdate();
    end;
  end else if Source is TIcon then begin
    BeginUpdate();
    try
      Clear();
      Add(TIcon(Source));
    finally
      EndUpdate();
    end;
  end else begin
    inherited Assign(Source);
  end;
end; // TIconList.Assign


procedure TIconList.Clear();
var
  i: Integer;
begin
  BeginUpdate;
  try
    for i := FList.Count - 1 downto 0 do begin
      Delete(i);
    end;
  finally
    EndUpdate();
  end;
end; // TIconList.Clear


procedure TIconList.Delete(const AnIndex: Integer);
var
  Icon: TIcon;
begin
  Icon := Icons[AnIndex];
  if Icon <> nil then begin
    Icon.OnChange := nil;
    FreeAndNil(Icon);
  end;
  FList.Delete(AnIndex);
  Changed();
end; // TIconList.Delete


procedure TIconList.Exchange(
    const AnIndex1: Integer; const AnIndex2: Integer);
begin
  FList.Exchange(AnIndex1, AnIndex2);
  Changed();
end; // TIconList.Exchange


function TIconList.IndexOf(const AIcon: TIcon): Integer;
begin
  Result := FList.IndexOf(AIcon);
end; // TIconList.IndexOf


procedure TIconList.InsertResource(const AnIndex: Integer;
  const AhInstance: THandle; const ApcResId: PChar);
var
  Icon: TIcon;
begin
  Icon := TIcon.Create();
  try
    Icon.Handle := LoadIcon(AhInstance, ApcResId);
    FList.Insert(AnIndex, Icon);
    Icon.OnChange := _IconChanged;
  except
    FreeAndNil(Icon);
    raise;
  end;
  Changed();
end; // TIconList.InsertResource


procedure TIconList.Insert(const AnIndex: Integer; const AIcon: TIcon);
var
  Icon: TIcon;
begin
  Icon := TIcon.Create;
  try
    Icon.Assign(AIcon);
    FList.Insert(AnIndex, Icon);
    Icon.OnChange := _IconChanged;
  except
    FreeAndNil(Icon);
    raise;
  end;
  Changed();
end; // TIconList.Insert


procedure TIconList.LoadResource(const AhInstance: THandle;
    const ResIds: array of PChar);
var
  i: Integer;
begin
  BeginUpdate();
  try
    for i := Low(ResIds) to High(ResIds) do begin
      AddResource(AhInstance, ResIds[i]);
    end;
  finally
    EndUpdate();
  end;
end; // TIconList.LoadResource


procedure TIconList.Move(const AnCurIndex: Integer;
    const AnNewIndex: Integer);
begin
  FList.Move(AnCurIndex, AnNewIndex);
  Changed();
end; // TIconList.Move


procedure TIconList.LoadFromStream(const AStream: TStream);
begin
  _ReadData(AStream);
end; // TIconList.LoadFromStream


procedure TIconList.SaveToStream(const AStream: TStream);
begin
  _WriteData(AStream);
end; // TIconList.SaveToStream


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TIconList.Changed();
begin
  if (FnUpdateCount = 0) and Assigned(FOnChange) then begin
    FOnChange(Self);
  end;
end; // TIconList.Changed


procedure TIconList.DefineProperties(Filer: TFiler);
var
  bHasData: Boolean;
  i: Integer;
  Ancestor: TIconList;
begin
  Ancestor := TIconList(Filer.Ancestor);
  if (Ancestor <> nil) and (Ancestor.Count = Count)
      and (Count > 0) then begin

    bHasData := FALSE;
    for i := 0 to Count - 1 do begin
      bHasData := Icons[i] <> Ancestor.Icons[i];
      if bHasData then begin
        Break;
      end;
    end
  end else begin
    bHasData := Count > 0;
  end;

  Filer.DefineBinaryProperty('Icons', _ReadData, _WriteData, bHasData);

end; // TIconList.DefineProperties


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TIconList.GetCount(): Integer;
begin
  Result := FList.Count;
end; // TIconList.GetCount


function TIconList.GetIcon(const AnIndex: Integer): TIcon;
begin
  Result := TObject(FList[AnIndex]) as TIcon;
end; // TIconList.GetIcon


procedure TIconList.SetIcon(const AnIndex: Integer; const AIcon: TIcon);
begin
  BeginUpdate();
  try
    if AnIndex = Count then begin
      Add(nil);
    end;
    if Icons[AnIndex] = nil then begin
      FList[AnIndex] := TIcon.Create();
    end;
    Icons[AnIndex].OnChange := _IconChanged;
    Icons[AnIndex].Assign(AIcon);
  finally
    EndUpdate();
  end;
end; // TIconList.SetIcon


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TIconList._IconChanged(ASender: TObject);
begin
  Changed();
end; // TIconList._IconChanged


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

function TIconList._AddIcon(const AIcon: TIcon): Integer;
begin
  Result := FList.Add(AIcon);
  if Assigned(AIcon) then begin
    AIcon.OnChange := _IconChanged;
  end;
  Changed();
end; // TIconList._AddIcon


procedure TIconList._ReadData(AStream: TStream);
var
  nLen: Longint;
  nCnt: Longint;
  i: Integer;
  Icon: TIcon;
  Mem: TMemoryStream;
begin
  BeginUpdate();
  try
    Clear();
    Mem := TMemoryStream.Create();
    try
      AStream.Read(nCnt, SizeOf(Longint));
      for I := 0 to nCnt - 1 do begin
        AStream.Read(nLen, SizeOf(Longint));
        if nLen > 0 then begin
          Icon := TIcon.Create();
          try
            Mem.SetSize(nLen);
            AStream.Read(Mem.Memory^, nLen);
            Mem.Position := 0;
            Icon.LoadFromStream(Mem);
            _AddIcon(Icon);
          except
            FreeAndNil(Icon);
            raise;
          end;
        end
        else begin
          _AddIcon(nil);
        end;
      end;
    finally
      FreeAndNil(Mem);
    end;
  finally
    EndUpdate();
  end;
end; // TIconList._ReadData


procedure TIconList._WriteData(AStream: TStream);
var
  i: Integer;
  nLen: Longint;
  Mem: TMemoryStream;
begin
  Mem := TMemoryStream.Create();
  try
    nLen := FList.Count;
    AStream.Write(nLen, SizeOf(Longint));
    for i := 0 to FList.Count - 1 do begin
      Mem.Clear();
      if (Icons[i] <> nil) and not Icons[i].Empty then begin
        Icons[i].SaveToStream(Mem);
        nLen := Mem.Size;
      end else begin
        nLen := 0;
      end;
      AStream.Write(nLen, SizeOf(Longint));
      if nLen > 0 then begin
        AStream.Write(Mem.Memory^, Mem.Size);
      end;
    end;
  finally
    FreeAndNil(Mem);
  end;
end; // TIconList._WriteData


procedure TIconList._SetUpdateState(const AbUpdating: Boolean);
begin
  if not AbUpdating then begin
    Changed();
  end;
end; // TIconList._SetUpdateState


end.


