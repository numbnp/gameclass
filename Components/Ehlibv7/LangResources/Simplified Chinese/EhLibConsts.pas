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
  SClearSelectedCellsEh = '清除选择的单元？';
  SInvalidTextFormatEh = '错误的文本格式';
  SInvalidVCLDBIFFormatEh = '错误的 VCLDBIF 格式';
  SErrorDuringInsertValueEh = '插入值过程中出错：';
  SIgnoreErrorEh = '忽略错误？';
  STabularInformationEh = '表格信息';
  SPageOfPagesEh = '第 %d 页共 %d 页';
  SPreviewEh =  '预览';
  SFieldNameNotFoundEh = '字段名 ''%s'' 没有找到';
  SFindDialogStringNotFoundMessageEh = '字符串 "%s" 没有找到。';
  SVisibleColumnsEh = '错误的列';
  SCutEh = '剪贴';
  SCopyEh = '复制';
  SPasteEh = '粘贴';
  SDeleteEh = '删除';
  SSelectAllEh = '全选';

  SSTFilterListItem_Empties = '(空)';
  SSTFilterListItem_NotEmpties = '(非空)';
  SSTFilterListItem_All = '(全部)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(取消过滤)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByDescend = '(升序)';
  SSTFilterListItem_SortingByAscend = '(降序)';
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

