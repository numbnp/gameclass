//////////////////////////////////////////////////////////////////////////////
//
// Описание протокола
//
//////////////////////////////////////////////////////////////////////////////

unit uProtocol;

interface

const
  // версия протокола
  PROTOCOL_V01 = 'v01';
  // текущая информация по деньгам и времени
  STR_CMD_INFO            = 'info';
  // полный расклад по финансам после заверешния работы
  STR_CMD_INFO_FULL       = 'infofull';
  // заблокировать
  STR_CMD_BLOCKED         = 'blocked';
  // пинг клиента
  STR_CMD_PING            = 'ping';
  // убить задачу
  STR_CMD_KILLTASK        = 'killtask';
  // установка времени
  STR_CMD_SETTIME         = 'settime';
  // перегрузиться !!!ИЗВРАТ: параметр True-restart, False-logoff
  STR_CMD_RESTART         = 'restart';
  // выключить комп
  STR_CMD_SHUTDOWN        = 'shutdown';
  // получить список оборудования
  STR_CMD_GETHARDWARE     = 'gethardware';
  // получить список запущенных задач
  STR_CMD_GETTASKSLIST    = 'gettaskslist';
  // деинсталлировать клиента
  STR_CMD_UNINSTALL       = 'uninstall';
  // включить/выключить режим шелла
  STR_CMD_SHELLMODE       = 'shellmode';
  // завершить работу клиента
  STR_CMD_CLOSECLIENT     = 'closeclient';
  // получить подробную инфу
  STR_CMD_GETEXTENDEDINFO = 'getextendedinfo';
  // принять сообщение на клиента
  // кто/кому/сообщение
//  STR_CMD_RECEIVEMESSAGE     = 'receivemessage';

  STR_CMD_SETVOLUME = 'setvolume';

  // команды авторизации
  // нельзя аутентифицироваться
  // параметром True - заблокировано, False - сессия оператора
  STR_CMD_AUTH_GOSTATE_0          = 'auth_gostate0';
  // запрос на включение аутентификации
  STR_CMD_AUTH_QUERYSTATE_1       = 'auth_querystate1';
  // перейти в состояние авторизации,
  // параметром может передаться номер доп. кода
  STR_CMD_AUTH_GOSTATE_1          = 'auth_gostate1';
  // запрос авторизации (передается пароль, имя, доп.код)
  STR_CMD_AUTH_QUERYSTATE_2       = 'auth_querystate2';
  // неверный пароль/имя/код и т.д. параметром идет описание ошибки
  STR_CMD_AUTH_FAILEDLOGGING_2    = 'auth_failedpass2';
  // авторизация успешна, перейти в состояние заказа
  // (в нем можно находиться 60 сек),
  // параметром передается логин/баланс/предел_доверия
  STR_CMD_AUTH_GOSTATE_2          = 'auth_gostate2';
  // запрос тарифов
  STR_CMD_AUTH_QUERYTARIFS_2      = 'auth_querytarifs2';
  // обратно передаются тарифы
  STR_CMD_AUTH_RETTARIFS_2        = 'auth_rettarifs2';
  // запрос о стоимости
  // Параметры: название-тарифа/деньги/время
  // деньги или время должно быть пустым - ответ пересчет
  STR_CMD_AUTH_QUERYCOSTTIME_2    = 'auth_querycosttime2';
  // возврат стоимости для указанного тарифа
  // Параметры: название-тарифа/деньги
  STR_CMD_AUTH_RETCOSTTIME_2      = 'auth_retcosttime2';
  // запрос на начало заказа
  // Параметры: стоимость/начало/конец/пакетный тариф
  STR_CMD_AUTH_QUERYSTATE_3       = 'auth_querystate3';
  // авторизация пройдена и сделан заказ
  // Параметры:  имя_тарифа/старт/стоп/баланс/отдельн_оплата_трафика/первыйстейт
  STR_CMD_AUTH_GOSTATE_3          = 'auth_gostate3';
  // запрос о стоимости трафика для текущей сессии
  // Параметры: деньги/трафик в КБ
  // деньги или время должно быть пустым - ответ пересчет
  STR_CMD_AUTH_QUERYCOSTTRAFFIC_3    = 'auth_querycosttraffic3';
  // возврат стоимости трафика для текущей сессии
  // Параметры: стоимость/трафик в КБ
  STR_CMD_AUTH_RETCOSTTRAFFIC_3      = 'auth_retcosttraffic3';
  // Доплатить за трафик
  // Параметры: деньги
  STR_CMD_AUTH_ADDTRAFFIC_3    = 'auth_addtraffic3';
  // запрос на остановку текущего сеанса, переход в режим 2
  STR_CMD_AUTH_QUERYSTOP_3        = 'auth_querystop3';
  // подтверждение остановки заказа
  STR_CMD_AUTH_STOPSTATE_3        = 'auth_stopstate3';
  // запрос на включение аутентификации
  STR_CMD_AUTH_QUERYLOGOFF        = 'auth_querylogoff';
  // передача истории балланса
  STR_CMD_AUTH_SENDBALANCEHISTORY = 'auth_sendbalancehistory';
  // запрос на смену пароля
  STR_CMD_AUTH_QUERYCHANGEPASS    = 'auth_querychangepass';
  // пароль изменен
  STR_CMD_AUTH_PASSCHANGED        = 'auth_passchanged';

  STR_CMD_SESSIONINFO = 'sessioninfo';   // команда не используется

  // Запускаем процесс на клиенте (запускается службой)
  STR_CMD_EXECUTE_COMMAND_SRV = 'execute_cmd_srv';

  // звуковые команды
  STR_CMD_PLAY_SOUND = 'play_sound';

  // звуковые команды
  STR_CMD_SHOW_WARNING_TEXT = 'show_warning_text';

  STR_CMD_RET_PROCESSLIST = 'inet_ret_process_list';

  WAVFILE_5MINSLEFT_RU        = 'gccl_5minsleft_ru.wav';
  WAVFILE_MAXPOSTPAY_RU       = 'gccl_maxpostpay_ru.wav';
  WAVFILE_STOP_PREPAY_RU      = 'gccl_stopprepay_ru.wav';
  WAVFILE_MOVETOOTHERCOMP_RU  = 'gccl_movetoothercomp_ru.wav';
  WAVFILE_YOUAREPENALIZED_RU  = 'gccl_youarepenalized_ru.wav';
  WAVFILE_FORMINUTE_BEGIN     = 'gccl_for';
  WAVFILE_FORMINUTE_END_RU    = 'minuts_ru.wav';

  WAVFILE_5MINSLEFT_ENG       = 'gccl_5minsleft_eng.wav';
  WAVFILE_MAXPOSTPAY_ENG      = 'gccl_maxpostpay_eng.wav';
  WAVFILE_STOP_PREPAY_ENG     = 'gccl_stopprepay_eng.wav';
  WAVFILE_MOVETOOTHERCOMP_ENG = 'gccl_movetoothercomp_eng.wav';
  WAVFILE_YOUAREPENALIZED_ENG = 'gccl_youarepenalized_eng.wav';
  WAVFILE_FORMINUTE_END_ENG   = 'minuts_eng.wav';
  STR_CMD_GUESTSESSION = 'guestsession';   // запуск гостевой сессии
  // Доплатить за время
  // Параметры: деньги
  STR_CMD_AUTH_ADDTIME_3    = 'auth_addtime3';
  // запрос о стоимости
  // Параметры: деньги/время
  // деньги или время должно быть пустым - ответ пересчет
  STR_CMD_AUTH_QUERYCOSTTIME_3    = 'auth_querycosttime3';
  // возврат стоимости для указанного тарифа
  // Параметры: деньги/время
  STR_CMD_AUTH_RETCOSTTIME_3      = 'auth_retcosttime3';

  // команды передачи инфы о клиенте
  // передать параметр/значение
  STR_CMD_CLIENT_INFO_SET                 = 'client_info_set';
  // запросить параметр или 'all' - все параметры
  STR_CMD_CLIENT_INFO_GET                 = 'client_info_get';

  // команды для изменения настроек клиента
  // передать параметр/значение
  STR_CMD_OPTION_SET                = 'option_set';
  // запросить параметр или 'all' - все параметры
  STR_CMD_OPTION_GET                = 'option_get';

  // команды, которые клиент GameClass отсылает серверу
  STR_CMD_RET_GETEXTENDEDINFO   = 'RetGetextendedinfo';
  STR_CMD_RET_PINGANSWER        = 'pinganswer';
  STR_CMD_RET_RESTARTING        = 'restarting';
  STR_CMD_RET_TASKSLIST         = 'RetTasksList';
  STR_CMD_RET_GETHARDWARE       = 'RetGetHardware';
  STR_CMD_RET_INFO              = 'RetInfo';
  // послать сообщение с клиента на сервер
  // кто/кому/сообщение
  STR_CMD_SENDMESSAGE     = 'sendmessage';


  // компанды для Linux-сервера
  STR_CMD_INETBLOCK   = 'inet_block=';
  STR_CMD_INETUNBLOCK = 'inet_unblock=';
  // это новые компанды для Linux-сервера
  //inet_set_speed_for_ip=ip/speed (Установить скорость трафика для IP (на будущее))
  STR_CMD_INETSETSPEEDFORIP = 'inet_set_speed_for_ip=';
  //inet_get_traffic_value (запрос информации по трафику для всех IP)
  STR_CMD_GETTRAFFICVALUE = 'inet_get_traffic_value';
  //inet_get_traffic_value_answer (ответ по трафику для всех IP)
  STR_CMD_GETTRAFFICVALUEANSWER = 'inet_get_traffic_value_answer';
  STR_CMD_INETSETGROUP = 'inet_set_group=';
  STR_CMD_INETSETLIMIT = 'inet_set_limit';

  // = - это лажа
  // компанды для Linux-сервера
  STR_CMD_INET_BLOCK   = 'inet_block';
  STR_CMD_INET_UNBLOCK = 'inet_unblock';
  // это новые компанды для Linux-сервера
  //inet_set_speed_for_ip=ip/speed (Установить скорость трафика для IP (на будущее))
  STR_CMD_INET_SETSPEEDFORIP = 'inet_set_speed_for_ip';
  //inet_get_traffic_value (запрос информации по трафику для всех IP)
  STR_CMD_INET_GETTRAFFICVALUE = 'inet_get_traffic_value';
  //inet_get_traffic_value_answer (ответ по трафику для всех IP)
  STR_CMD_INET_GETTRAFFICVALUEANSWER = 'inet_get_traffic_value_answer';
  STR_CMD_INET_SETGROUP = 'inet_set_group';
  STR_CMD_INET_SETLIMIT = 'inet_set_limit';

implementation

end.
