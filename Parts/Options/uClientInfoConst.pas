//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит константы для класса TClientInfo.
//
//////////////////////////////////////////////////////////////////////////////

unit uClientInfoConst;

interface

const
  // значения по умолчанию для опций
  DEF_BLOCKED = TRUE;
//  DEF_CLIENT_STATE = ClientState_Blocked;
  DEF_LOGIN = 'Гость';
  DEF_BALANCE = 0;
  DEF_SPENT = 0;
  DEF_BALANCE_LIMIT = 0;
  DEF_BALANCE_HISTORY = '';
  DEF_INFO = 'Отсутствует подключение к серверу GameClass 3';
  DEF_INFO_FULL = 'Отсутствует подключение к серверу GameClass 3';
  DEF_SUM = 0;
  DEF_START = 0;
  DEF_STOP = 0;
  DEF_TARIF_NAME = '';
  DEF_PACKET_TARIF = FALSE;
  DEF_TRAFIIC_SEPARATE_PAYMENT = FALSE;
  DEF_SEC_CODE = 0;
  DEF_UNBLOCKED_BY_PASSWORD = FALSE;
  DEF_INTERNET = FALSE;
  DEF_INTERNET_AVAILABLE = 0;
  DEF_INTERNET_USED = 0;
  DEF_RUNPAD_HIDED_TABS = '';
  DEF_DISCONNECTED = False;
  DEF_AFTER_STOP_ACTION_NEEDED = FALSE;

  INFO_GENERAL_FOLDER = 'ClientInfo';

type

  // перечисление состояний авторизации
  TClientState = (
      ClientState_Blocked,          // заблокировани
      ClientState_Authentication,   // можно логиниться
      ClientState_Order,            // залогинен, заказ сессии
      ClientState_Session,          // залогинен, сессия
      ClientState_Agreement,        // залогинен, заказ принят, соглашение
      ClientState_OperatorSession,   // сессия, поставленная оператором
      ClientState_OperatorAgreement, // соглашение сессии оператора
      ClientState_OperatorAgreementAccepted, // соглашение принято
                                            // (шлет только клиент сервису)
      ClientState_AgreementAccepted,// соглашение аккаунта принято
                                    // (шлет только клиент сервису)
      ClientState_NotInitialized          // еще не инициализирован

  );


implementation
end.


