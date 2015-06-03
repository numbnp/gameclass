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
  SClearSelectedCellsEh = 'آیا سلول های انتخاب شده خالی شوند؟';
  SInvalidTextFormatEh = 'فرمت نوشتاری نامعتبر';
  SInvalidVCLDBIFFormatEh = '  صحیح نیست  vclbif فرمت';
  SErrorDuringInsertValueEh = 'خطا در درج مقدار';
  SIgnoreErrorEh = 'آیا از خطا چشم پوشی شود؟';
  STabularInformationEh = 'اطلاعات صفحه ها';
  SPageOfPagesEh = 'صفحه %d از %d';
  SPreviewEh =  'پیش نمایش';
  SFieldNameNotFoundEh = ' ''%s'' فیلد پیدا نشد ';
  SFindDialogStringNotFoundMessageEh = ' "%s" رشته پیدا نشد "%s" ';
  SVisibleColumnsEh = ' ستون های مرئی ';
  SCutEh = 'برداشتن';
  SCopyEh = 'رونوشت';
  SPasteEh = 'چسباندن';
  SDeleteEh = 'حذف';
  SSelectAllEh = 'انتخاب همه';

  SSTFilterListItem_Empties = '(خالی)';
  SSTFilterListItem_NotEmpties = '(خالی نباشد)';
  SSTFilterListItem_All = '(همه)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(حدف فیلتر)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByAscend = '(مرتب سازی صعودی)';
  SSTFilterListItem_SortingByDescend = '(مرتب سازی نزولی)';
  SSTFilterListItem_ApplyFilter = '(اعمال فیلتر)';
  SSTFilterListItem_CustomFilter = '(Custom...)';

  SSimpFilter_equals              = 'برابر است با';
  SSimpFilter_does_not_equal      = 'مخالف است با';
  SSimpFilter_is_greate_than      = 'بزرگتر از';
  SSimpFilter_is_greate_than_or_equall_to = 'بزرگتر مساوی از';
  SSimpFilter_is_less_than        = 'کوچکتر از';
  SSimpFilter_is_less_than_or_equall_to = 'کوچکتر مساوی از';
  SSimpFilter_begins_with         = 'شروع با';
  SSimpFilter_does_not_begin_with = 'مخالف شروع با';
  SSimpFilter_ends_with           = 'پایان با';
  SSimpFilter_does_not_end_with   = 'مخالف پایان با';
  SSimpFilter_contains            = 'شامل';
  SSimpFilter_does_not_contain    = 'شامل نباشد';
  SSimpFilter_like                = 'شبیه';
  SSimpFilter_not_like            = 'مخالف شبیه';
  SSimpFilter_in_list             = 'در لیست';
  SSimpFilter_not_in_list         = 'در لیست نباشد';
  SSimpFilter_is_blank            = 'خالی';
  SSimpFilter_is_not_blank        = 'مخالف خالی';

  SGroupingPanelText = 'برای گروه بندی ستون ها را به این قسمت انتقال دهید';

  SNoDataEh = '<هیچ دیتایی موجود نیست>'; //'No data';

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

