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
  SClearSelectedCellsEh = 'Изчистване на избраните клетки?';
  SInvalidTextFormatEh = 'Невалиден формат на текста';
  SInvalidVCLDBIFFormatEh = 'Невалиден VCLDBIF формат';
  SErrorDuringInsertValueEh = 'Грешка при вмъкване на стойност:';
  SIgnoreErrorEh = 'Игнориране на грешката?';  
  STabularInformationEh = 'Табулаторна информация';  // Not very good translation
  SPageOfPagesEh = 'Страница %d от %d';
  SPreviewEh =  'Преглед';
  SFieldNameNotFoundEh = 'Файлът с име ''%s'' не е открит';
  SFindDialogStringNotFoundMessageEh = 'Символния низ "%s" не е открит.';
  SVisibleColumnsEh = 'Visible columns';
  SCutEh = 'Cut';
  SCopyEh = 'Copy';
  SPasteEh = 'Paste';
  SDeleteEh = 'Delete';
  SSelectAllEh = 'Select All';

  SSTFilterListItem_Empties = '(Празно)';
  SSTFilterListItem_NotEmpties = '(Не е празно)';
  SSTFilterListItem_All = '(Всичко)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(Изчисти филтъра)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByAscend = '(Възходящ ред)';
  SSTFilterListItem_SortingByDescend = '(Низходящ ред)';
  SSTFilterListItem_ApplyFilter = '(Apply filter)';
  SSTFilterListItem_CustomFilter = '(Custom...)';

  SSimpFilter_equals              = 'equals';
  SSimpFilter_does_not_equal      = 'does not equal';
  SSimpFilter_is_greate_than      = 'is greate than';
  SSimpFilter_is_greate_than_or_equall_to = 'is greate than or equall to';
  SSimpFilter_is_less_than        = 'is less than';
  SSimpFilter_is_less_than_or_equall_to = 'is less than or equall to';
  SSimpFilter_begins_with         = 'begins with';
  SSimpFilter_does_not_begin_with = 'does not begin with';
  SSimpFilter_ends_with           = 'ends with';
  SSimpFilter_does_not_end_with   = 'does not end with';
  SSimpFilter_contains            = 'contains';
  SSimpFilter_does_not_contain    = 'does not contain';
  SSimpFilter_like                = 'like';
  SSimpFilter_not_like            = 'not like';
  SSimpFilter_in_list             = 'in list';
  SSimpFilter_not_in_list         = 'not in list';
  SSimpFilter_is_blank            = 'is blank';
  SSimpFilter_is_not_blank        = 'is not blank';

  SGroupingPanelText = 'Drag a column header here to group by that column';

  SNoDataEh = '<No Records>'; //'No data';

    // Error message
  SQuoteIsAbsentEh = 'Quote is absent: ';
  SLeftBracketExpectedEh = '''('' expected: ';
  SRightBracketExpectedEh = ''')'' expected: ';
  SErrorInExpressionEh = 'Error in expression: ';
  SUnexpectedExpressionBeforeNullEh = 'Unexpected expression before Null: ';
  SUnexpectedExpressionAfterOperatorEh = 'Unexpected expression after operator: ';
  SIncorrectExpressionEh = 'Incorrect expression: ';
  SUnexpectedANDorOREh = 'Unexpected AND or OR: ';

  SGridSelectionInfo_Sum = 'Sum';
  SGridSelectionInfo_Cnt = 'Count';
  SGridSelectionInfo_Evg = 'Average';
  SGridSelectionInfo_Min = 'Min';
  SGridSelectionInfo_Max = 'Max';

  SFirstRecordEh = 'First record';
  SPriorRecordEh = 'Prior record';
  SNextRecordEh = 'Next record';
  SLastRecordEh = 'Last record';
  SInsertRecordEh = 'Insert record';
  SDeleteRecordEh = 'Delete record';
  SEditRecordEh = 'Edit record';
  SPostEditEh = 'Post edit';
  SCancelEditEh = 'Cancel edit';
  SConfirmCaptionEh = 'Confirm';
  SRefreshRecordEh = 'Refresh data';

  SDeleteMultipleRecordsQuestionEh = 'Delete %d selected records?';
  SDeleteAllRecordsQuestionEh = 'Delete All records?';

  SDuplicateVarNameEh = 'A Variable named ''%s'' already exists in the Collection';

  SSearchPanelEditorPromptText = 'Search...';
  SUnsupportedFieldTypeEh = 'Unsupported field type (%s) in field %s';

  SSearchPanelApplyFilterEh = 'Show records where the text is found';
  SSearchPanelCancelFilterEh = 'Cancel filter and clear the search text';
  SSearchPanelFindNextEh = 'Find next';
  SSearchPanelFindPrevEh = 'Find prev';
  SSearchPanelOptionsEh = 'Show find options';

  SSortingByThisColumnIsNotPossibleEh = 'Sorting by this column is not possible';
  SGroupingByThisColumnIsNotPossibleEh = 'Grouping by this column is not possible';

  SFindItemNameAllEh = '<All>';

implementation

end.

