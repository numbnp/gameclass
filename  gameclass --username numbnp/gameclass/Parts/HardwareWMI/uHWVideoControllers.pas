//////////////////////////////////////////////////////////////////////////////
//
// TVideoController - класс, содержащий информацию об установленном
// на компьютере видеоадаптере.
//
//////////////////////////////////////////////////////////////////////////////

unit uHWVideoControllers;

interface

type

  //
  // TVideoController
  //

  TVideoController = class(TObject)
  private
    // fields
    FstrRAMCapacity: String;
    FstrName: String;
    FstrVideoProcessor: String;

  public
    // constructor / destructor
    constructor Create();

    // public methods
    function AsString(): String;
    procedure Clear();

    // properties
    property RAMCapacity: String read FstrRAMCapacity write FstrRAMCapacity;
    property Name: String read FstrName write FstrName;
    property VideoProcessor: String
        read FstrVideoProcessor write FstrVideoProcessor;

  end; // TVideoController


implementation

uses
  // project units
  uY2KString,
  uHWConst;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

constructor TVideoController.Create();
begin
  FstrRAMCapacity := '0';
  FstrName := '';
  FstrVideoProcessor := '';
end; // TVideoController.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TVideoController.Clear();
begin
  RAMCapacity := '0';
  Name := '';
  VideoProcessor := '';
end; // TVideoController.Clear


function TVideoController.AsString(): String;
var
  strParameters: String;
begin
  strParameters :=
      TAG_VIDEO_RAMCAPACITY + '=' + DoubleQuotedStr(RAMCapacity)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_VIDEO_NAME + '=' + DoubleQuotedStr(Name)
      + DIVIDER_FOR_HW_AS_STRING
      + TAG_VIDEO_VIDEO_PROCESSOR + '=' + DoubleQuotedStr(VideoProcessor);

  Result := TagStr(VIDEO_TAG, strParameters);

end; // TVideoController.AsString


end.
