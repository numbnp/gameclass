//////////////////////////////////////////////////////////////////////////////
//
// TRemoteCommand
// Базовый класс команды, поступающей от управляющего сервера.
//
// Карамани Юрий - 05.2005
//
//////////////////////////////////////////////////////////////////////////////

unit uRemoteCommand;

interface

type

  //
  // TRemoteCommand
  //

  TRemoteCommand = class(TObject)
  public
    // public methods
    procedure Execute(); virtual; abstract;

  end; // TRemoteCommand


implementation


end. ////////////////////////// end of file //////////////////////////////////
