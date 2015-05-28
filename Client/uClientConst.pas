unit uClientConst;

interface
{$IFDEF MSWINDOWS}
uses Messages;
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
const
{$IFDEF MSWINDOWS}
  

  WM_USER_ACTIVATE_INFO = WM_USER+10;
  WM_USER_UNBLOCK_PASSWORD = WM_USER+11;
  WM_USER_THREADSAFE_UPDATE = WM_USER+20;
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
  FIRST_DATE = 36526.0;// 01.01.2000
  DATE_FORMAT = 'dd mmm yy hh:mm:ss';

  MSG_ENTER_PASSWORD: String = 'Введите пароль разблокирования';
  MSG_UNBLOCKED: String = 'Компьютер разблокирован!';
  MSG_UNBLOCK_PASSWORD_NEEDED: String =
      'Нужно ввести пароль разблокирования!';
  MSG_UNBLOCK_BY_PASSWORD_DISABLED: String =
      'Разблокирование по паролю отключено!';


implementation

end.

