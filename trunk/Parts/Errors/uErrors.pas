unit uErrors;

interface

uses
  Classes;
  
resourcestring
  //Общие ошибки 0-100
  ERR_CAPTION = 'Ошибка';
  ERR_UNKNOWN = 'Неизвестная ошибка';
  ERR_CRITICAL = 'Критическая ошибка';
  //SQL ошибки 100-200
  ERR_SQLSERVER_NOT_EXIST = 'Ошибка подключения к SQL-серверу.' + #13#10
      + 'Cервер не существует/не был установлен/инсталляция GameClass3 '
      + 'была проведена неверно.';
  ERR_SQLSERVER_PASSWORD_INCORRECT = 'Введен неверный пароль.';
  //Логические ошибки 200-300
  ERR_EXEFILE_CORRUPT = 'Нарушена целостность файла GCServer.exe';
  ERR_SOCKET = 'Невозможно открыть сервер для UDP-порта 3775! '
      + 'Возможно, Gameclass уже запущен под оператором,'#13#10
      + 'какое-либо другое приложение заняло этот порт '
      + 'или настройки файервола запрещают его открыть.';
const
  //Общие ошибки 0-100
  ERRNUM_DEFAULT = 0;
  //SQL ошибки 100-200
  ERRNUM_SQLSERVER_NOT_EXIST = 100;
  ERRNUM_SQLSERVER_PASSWORD_INCORRECT = 101;

type
  TErrorEvent = procedure(const Sender: TObject;
      const AnErrorNumber: Integer; const AlstError: TStringList) of object;

implementation

end.
