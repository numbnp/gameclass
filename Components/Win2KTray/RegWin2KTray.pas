//////////////////////////////////////////////////////////////////////////////
//
// Модуль регистрации компонент пакета Win2KTray.
//
//////////////////////////////////////////////////////////////////////////////

unit RegWin2KTray;

interface

uses
  // system units
  Classes,
  Dialogs,
  TypInfo,
  DesignIntf,
  DesignEditors;


procedure Register;

implementation

uses
  // project units
  uIconList,
  ufrmIconListEdit,
  uModernTrayIcon;


procedure Register();
begin
  RegisterComponents('Win2KTray', [TModernTrayIcon]);
  RegisterPropertyEditor(TypeInfo(TIconList), nil, '', TIconListProperty);
  RegisterPropertyEditor(TypeInfo(string), TModernTrayIcon, 'Hint',
    TStringProperty);

end; // Register


end.
