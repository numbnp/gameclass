unit TrafInsp2TLB;

interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;

type
  APIListType = TOleEnum;
const
  itIPInterface = 1;	// Сетевые интерфейсы
  itUserGroup = 2;	//Группы клиентов
  itUser = 3;		//Клиенты
  itUserFilter = 4;	//Фильтры
  itFw = 5;		//Фильтры внешнего сетевого экрана
  itExtCont = 6;		//Внешние контролируемые счетчики
  itExtInfo = 7;		//Внешние информационные счетчики
  itContentGroup = 8;	//Описания типов данных
  itCacheRule = 9;	//Правила кэширования
  itReserved = 10;
  itSMTPServRule = 11;	//Правила SMTP сервера
  itWWWServConfig = 12;	//Разделы WWW сервера
  itWWWServRedirect = 13;//Правила редиректа SMTP сервера
  itNSUserPol = 14;	//Сетевая статистика по нарушению политик доступа
  itAdminList = 15;	//Пользователи (администрирование)
  itAdminGroup = 16;	//Группы пользователей (администрирование)
  itIPNetDesc = 21;	//IP сети
  itURLDesc = 22;	//URL списки
  itProxyRoute = 23;	//Правила прокси - каскада
  itPlugins = 24;	//Плагины
  itModules = 25;	//Модули расширения
  itProblems = 26;	//Предупреждения
  itIntNetRule = 27;	//Правила сетей
  itTariffDesc = 28;	//Тарифы
  itMaintenance = 29;	//Обслуживание
  itAccGroup = 30;	//Групповые счета
  itExtAllCounter = 31;	//Сводный список внешних счетчиков
  itScriptDef = 32;	//Скрипты
  itScriptQueue = 32;	//Текущая очередь выполняемых скриптов
  itDeviceDef = 33;	//Описания устройств (список оборудования)
  itMappingRule = 34;	//Правила перенаправления TCP соединений
  itAdvAttr = 35;	//Описания атрибутов


type
  ConfigAttrLevelType = TOleEnum;
const
  conf_AttrLevelNormal = 0;   //Конфигурационные атрибуты
  conf_AttrLevelForSave = 1;  //Атрибуты конфигурации в варианте для сохранения настроек, могут отличаться от данных по умолчанию conf_AttrLevelNormal
  conf_AttrLevelCaption = 2;  //Минимальный набор атрибутов - только GUID и DisplayName
  conf_AttrLevelRootOnly = 3; //Только корневые атрибуты, если в списке корневые атрибуты не предусмотрены, то будет выведен пустой список (см. описание списков в перечислении APIListType)
  conf_AttrLevelWORoot = 4;   //Только элементы списка без корневых атрибутов
  conf_AttrLevelDetail = 5;   //Все атрибуты (конфигурационные и состояния)
  conf_AttrLevelPreview = 6;  //Сокращенный набор атрибутов, поддерживается в некоторых списках
  conf_AttrLevelState = 7;    //Атрибуты состояния (также выводятся некоторые атрибуты конфигурации)


implementation

end.
