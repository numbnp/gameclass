{*******************************************************}
{                                                       }
{                       EhLib v5.6                      }
{                       EhLib v6.0                      }
{                   Resource of strings                 }
{                                                       }
{      Copyright (c) 2001-2012 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

unit EhLibConsts;

interface

resourcestring
  SClearSelectedCellsEh = 'Очистить выделенные ячейки?';
  SInvalidTextFormatEh = 'Неверный формат текста';
  SInvalidVCLDBIFFormatEh = 'Неверный формат VCLDBIF';
  SErrorDuringInsertValueEh = 'Ошибка при вставке значения:';
  SIgnoreErrorEh = 'Игнорировать ошибку?';
  STabularInformationEh = 'Табличная информация';
  SPageOfPagesEh = 'Страница %d из %d';
  SPreviewEh =  'Предварительный просмотр';
  SFieldNameNotFoundEh = 'Имя поля ''%s'' не найдено';
  SFindDialogStringNotFoundMessageEh = 'Строка "%s" не найдена.';
  SVisibleColumnsEh = 'Видимые столбцы';
  SCutEh = 'Вырезать';
  SCopyEh = 'Копировать';
  SPasteEh = 'Вставить';
  SDeleteEh = 'Удалить';
  SSelectAllEh = 'Выбрать все';

  SSTFilterListItem_Empties = '(Пустые)';
  SSTFilterListItem_NotEmpties = '(Не пустые)';
  SSTFilterListItem_All = '(Все)';
  SSTFilterListItem_SelectAll = '(Выбрать все элементы)';
  SSTFilterListItem_ClearFilter = '(Очистить фильтр)';
  SSTFilterListItem_ClearFilterInColumn = '(Очистить фильтр в столбце)';
  SSTFilterListItem_SortingByDescend = '(Сортировка по убыванию)';
  SSTFilterListItem_SortingByAscend = '(Сортировка по возрастанию)';
  SSTFilterListItem_ApplyFilter = '(Применить фильтр)';
  SSTFilterListItem_CustomFilter = '(Условие...)';

  SSimpFilter_equals              = 'равно';
  SSimpFilter_does_not_equal      = 'не равно';
  SSimpFilter_is_greate_than      = 'больше';
  SSimpFilter_is_greate_than_or_equall_to = 'больше или равно';
  SSimpFilter_is_less_than        = 'меньше';
  SSimpFilter_is_less_than_or_equall_to = 'меньше или равно';
  SSimpFilter_begins_with         = 'начинается с';
  SSimpFilter_does_not_begin_with = 'не начинается с';
  SSimpFilter_ends_with           = 'заканчивается на';
  SSimpFilter_does_not_end_with   = 'не заканчивается на';
  SSimpFilter_contains            = 'содержит';
  SSimpFilter_does_not_contain    = 'не содержит';
  SSimpFilter_like                = 'подобно';
  SSimpFilter_not_like            = 'не подобно';
  SSimpFilter_in_list             = 'в списке';
  SSimpFilter_not_in_list         = 'не в списке';
  SSimpFilter_is_blank            = 'пустые';
  SSimpFilter_is_not_blank        = 'не пустые';

  SGroupingPanelText = 'Перетащите сюда заголовок, чтобы сгруппировать по столбцу';

  SNoDataEh = 'Нет данных'; //'No data';

    // Error message
  SQuoteIsAbsentEh = 'Отсутствует кавычка: ';
  SLeftBracketExpectedEh = '''('' пропущена: ';
  SRightBracketExpectedEh = ''')'' пропущена: ';
  SErrorInExpressionEh = 'Ошибка в выражении: ';
  SUnexpectedExpressionBeforeNullEh = 'Пропущено выражение перед Null: ';
  SUnexpectedExpressionAfterOperatorEh = 'Пропущено выражение после оператора: ';
  SIncorrectExpressionEh = 'Неверное выражение: ';
  SUnexpectedANDorOREh = 'Пропущен AND или OR: ';

  SGridSelectionInfo_Sum = 'Sum';
  SGridSelectionInfo_Cnt = 'Count';
  SGridSelectionInfo_Evg = 'Average';
  SGridSelectionInfo_Min = 'Min';
  SGridSelectionInfo_Max = 'Max';

  SFirstRecordEh = 'Первая запись';
  SPriorRecordEh = 'Предыдущая запись';
  SNextRecordEh = 'Следующая запись';
  SLastRecordEh = 'Последняя запись';
  SInsertRecordEh = 'Вставить запись';
  SDeleteRecordEh = 'Удалить запись';
  SEditRecordEh = 'Редактировать запись';
  SPostEditEh = 'Подтвердить редактирование';
  SCancelEditEh = 'Отменить редактирование';
  SConfirmCaptionEh = 'Подтвердить';
  SRefreshRecordEh = 'Обновить данные';

  SDeleteMultipleRecordsQuestionEh = 'Удалить %d выбранных записей?';
  SDeleteAllRecordsQuestionEh = 'Удалить все записи?';

  SDuplicateVarNameEh = 'Переменная с именем ''%s'' уже присутствует в Коллекции';

  SSearchPanelEditorPromptText = 'Поиск...';
  SUnsupportedFieldTypeEh = 'Неподдерживаемый тип (%s) для поля %s';

  SSearchPanelApplyFilterEh = 'Показать все записи, которые содержат текст';
  SSearchPanelCancelFilterEh = 'Отменить фильтр и очистить строку поиска';
  SSearchPanelFindNextEh = 'Искать следующее совпадение';
  SSearchPanelFindPrevEh = 'Искать предыдущее совпадение';
  SSearchPanelOptionsEh = 'Показать опции поиска';

  SSortingByThisColumnIsNotPossibleEh = 'Сортировка по этому полю невозможна';
  SGroupingByThisColumnIsNotPossibleEh = 'Группировка по этому полю невозможна';

  SFindItemNameAllEh = '<Все>';

implementation

end.

