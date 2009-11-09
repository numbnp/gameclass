unit uOptionsStorage;

interface

uses
  Windows,
  uOption;

type

  //
  // TOptionsStorage
  //

  TOptionsStorage = class(TObject)
  public
    // public methods
    procedure LoadOption(const AstrFolderName: String;
        var AOption: TOption); virtual; abstract;
    procedure SaveOption(const AstrFolderName: String;
        const AOption: TOption); virtual; abstract;

  end; // TOptionsStorage



implementation
end.
