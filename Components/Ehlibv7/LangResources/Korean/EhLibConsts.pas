{*******************************************************}
{                                                       }
{                       EhLib v5.6                      }
{                     EhLib v6.0.01                     }
{                   Resource of strings                 }
{                                                       }
{      Copyright (c) 2001-2012 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

unit EhLibConsts;

interface

resourcestring
  SClearSelectedCellsEh = '선택된 셀을 지우시겠습니까?';
  SInvalidTextFormatEh = '잘못된 문자열 형식입니다!';
  SInvalidVCLDBIFFormatEh = '잘못된 VCLDBIF 형식입니다!';
  SErrorDuringInsertValueEh = '자료 추가 도중 오류 발생: ';
  SIgnoreErrorEh = '오류를 무시하시겠습니까?';
  STabularInformationEh = '표 정보';
  SPageOfPagesEh = '%d / %d 페이지';
  SPreviewEh = '미리보기';
  SFieldNameNotFoundEh = '필드명 "%s"을(를) 찾을 수 없습니다!';
  SFindDialogStringNotFoundMessageEh = '문자열 "%s"을(를) 찾을 수 없습니다!'; 
  SVisibleColumnsEh = '표시 항목';
  SCutEh = '잘라내기';
  SCopyEh = '복사';
  SPasteEh = '붙여넣기';
  SDeleteEh = '삭제';
  SSelectAllEh = '모두 선택';

  SSTFilterListItem_Empties = '(공백)';
  SSTFilterListItem_NotEmpties = '(공백 아님)';
  SSTFilterListItem_All = '(모두)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(필터제거)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByAscend = '(오름차순정렬)';
  SSTFilterListItem_SortingByDescend = '(내림차순정렬)';
  SSTFilterListItem_ApplyFilter = '(필터적용)';
  SSTFilterListItem_CustomFilter = '(사용자설정)';

  SSimpFilter_equals              = '같음(=)';
  SSimpFilter_does_not_equal      = '같지 않음(<>)';
  SSimpFilter_is_greate_than      = '큼(>)';
  SSimpFilter_is_greate_than_or_equall_to = '크거나 같음(>=)';
  SSimpFilter_is_less_than        = '작음(<)';
  SSimpFilter_is_less_than_or_equall_to = '작거나 같음(<=)';
  SSimpFilter_begins_with         = '시작 값';
  SSimpFilter_does_not_begin_with = '제외할 시작 값';
  SSimpFilter_ends_with           = '종료 값';
  SSimpFilter_does_not_end_with   = '제외할 종료 값';
  SSimpFilter_contains            = '포함하는 값';
  SSimpFilter_does_not_contain    = '포함하지 않는 값';
  SSimpFilter_like                = '유사함';
  SSimpFilter_not_like            = '유사하지 않음';
  SSimpFilter_in_list             = '범위 설정';
  SSimpFilter_not_in_list         = '범위 밖 설정';
  SSimpFilter_is_blank            = '공백';
  SSimpFilter_is_not_blank        = '공백 아님';

  SGroupingPanelText = '여기에 제목을 끌어다 놓으면 해당 항목으로 그룹화됩니다!';

  SNoDataEh = '<자료 없음>';

  // Error message
  SQuoteIsAbsentEh = '인용부호 결여: ';
  SLeftBracketExpectedEh = '''('' 필요: ';
  SRightBracketExpectedEh = ''')'' 필요: ';
  SErrorInExpressionEh = '수식오류: ';
  SUnexpectedExpressionBeforeNullEh = 'NULL 앞 예상치 못한 수식: ';
  SUnexpectedExpressionAfterOperatorEh = '연산자 뒤 예상치 못한 수식: ';
  SIncorrectExpressionEh = '잘못된 수식: ';
  SUnexpectedANDorOREh = '잘못된 AND 또는 OR: ';

  SGridSelectionInfo_Sum = '합계';
  SGridSelectionInfo_Cnt = '건수';
  SGridSelectionInfo_Evg = '평균';
  SGridSelectionInfo_Min = '최소값';
  SGridSelectionInfo_Max = '최대값';

  SFirstRecordEh = '첫번째 레코드';
  SPriorRecordEh = '이전 레코드';
  SNextRecordEh = '다음 레코드';
  SLastRecordEh = '마지막 레코드';
  SInsertRecordEh = '레코드 추가';
  SDeleteRecordEh = '레코드 삭제';
  SEditRecordEh = '레코드 수정';
  SPostEditEh = '변경된 내용 저장';
  SCancelEditEh = '수정 취소';
  SConfirmCaptionEh = '확인';
  SRefreshRecordEh = '새로 고침';

  SDeleteMultipleRecordsQuestionEh = '선택된 %d 개의 레코드를 삭제하시겠습니까?';
  SDeleteAllRecordsQuestionEh = '모든 레코드를 삭제하시겠습니까?';

  SDuplicateVarNameEh = '변수명 "%s"가(이) 해당 컬렉션에 이미 존재합니다.';

  SSearchPanelEditorPromptText = '검색...';
  SUnsupportedFieldTypeEh = '지원하지 않는 필드 형식(%s)이 필드 "%s"에 있습니다!';

  SSearchPanelApplyFilterEh = '문장이 검색된 레코드 보기';
  SSearchPanelCancelFilterEh = '필터 삭제 및 검색된 문장 삭제';
  SSearchPanelFindNextEh = '다음 찾기';
  SSearchPanelFindPrevEh = '이전 찾기';
  SSearchPanelOptionsEh = '검색 옵션 보기';

  SSortingByThisColumnIsNotPossibleEh = '정렬할 수 없는 컬럼입니다.';
  SGroupingByThisColumnIsNotPossibleEh = '그룹화할 수 없는 컬럼입니다.';

  SFindItemNameAllEh = '<All>';

implementation

end.
