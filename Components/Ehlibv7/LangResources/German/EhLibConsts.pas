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
  SClearSelectedCellsEh = 'Selektierte Zellen löschen?';
  SInvalidTextFormatEh = 'Falsches Textformat';
  SInvalidVCLDBIFFormatEh = 'Falsches VCLDBIF-Format';
  SErrorDuringInsertValueEh = 'Fehler beim Werte einsetzen:';
  SIgnoreErrorEh = 'Fehler ignorien?';
  STabularInformationEh = 'Tabulatorinformation';
  SPageOfPagesEh = 'Seite %d von %d';
  SPreviewEh =  'Vorschau';
  SFieldNameNotFoundEh = 'Feldname ''%s'' nicht gefunden';
  SFindDialogStringNotFoundMessageEh = 'Text "%s" nicht gefunden.';
  SVisibleColumnsEh = 'Sichtbare Spalten';
  SCutEh = 'Ausschneiden';
  SCopyEh = 'Kopieren';
  SPasteEh = 'Einfügen';
  SDeleteEh = 'Löschen';
  SSelectAllEh = 'Alles markieren';

  SSTFilterListItem_Empties = '(Leer)';
  SSTFilterListItem_NotEmpties = '(Nicht leer)';
  SSTFilterListItem_All = '(Alle)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(Filter entfernen)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByAscend = '(Absteigend sortieren)';
  SSTFilterListItem_SortingByDescend = '(Aufsteigend sortieren)';
  SSTFilterListItem_ApplyFilter = '(Filter anwenden)';
  SSTFilterListItem_CustomFilter = '(Benutzerdefiniert...)';

  SSimpFilter_equals              = 'ist gleich';
  SSimpFilter_does_not_equal      = 'ist ungleich';
  SSimpFilter_is_greate_than      = 'ist größer als';
  SSimpFilter_is_greate_than_or_equall_to = 'ist größer oder gleich als';
  SSimpFilter_is_less_than        = 'ist kleiner als';
  SSimpFilter_is_less_than_or_equall_to = 'ist kleiner oder gleich als';
  SSimpFilter_begins_with         = 'Fängt an mit';
  SSimpFilter_does_not_begin_with = 'Fängt nicht an mit';
  SSimpFilter_ends_with           = 'Endet mit';
  SSimpFilter_does_not_end_with   = 'Endet nicht mit';
  SSimpFilter_contains            = 'enthält';
  SSimpFilter_does_not_contain    = 'enthält nicht';
  SSimpFilter_like                = 'ist wie';
  SSimpFilter_not_like            = 'ist nicht wie';
  SSimpFilter_in_list             = 'in der Liste';
  SSimpFilter_not_in_list         = 'nicht in der Liste';
  SSimpFilter_is_blank            = 'ist leer';
  SSimpFilter_is_not_blank        = 'ist nicht leer';

  SGroupingPanelText = 'Ziehen sie eine Spalte hierher um nach dieser Spalte zu gruppieren';

  SNoDataEh = '<Keine Daten vorhanden>'; //'No data';

    // Error message
  SQuoteIsAbsentEh = 'Quote is absent: ';
  SLeftBracketExpectedEh = '''('' expected: ';
  SRightBracketExpectedEh = ''')'' expected: ';
  SErrorInExpressionEh = 'Error in expression: ';
  SUnexpectedExpressionBeforeNullEh = 'Unexpected expression before Null: ';
  SUnexpectedExpressionAfterOperatorEh = 'Unexpected expression after operator: ';
  SIncorrectExpressionEh = 'Incorrect expression: ';
  SUnexpectedANDorOREh = 'Unexpected AND or OR: ';

  SGridSelectionInfo_Sum = 'Summe';
  SGridSelectionInfo_Cnt = 'Anzahl';
  SGridSelectionInfo_Evg = 'Durchschnitt';
  SGridSelectionInfo_Min = 'Min';
  SGridSelectionInfo_Max = 'Max';

  SFirstRecordEh = 'Erster Datensatz';
  SPriorRecordEh = 'Voriger Datensatz';
  SNextRecordEh = 'Nächster Datensatz';
  SLastRecordEh = 'Letzter Datensatz';
  SInsertRecordEh = 'Datensatz einfügen';
  SDeleteRecordEh = 'Datensatz löschen';
  SEditRecordEh = 'Datensatz bearbeiten';
  SPostEditEh = 'Datensatz speichern';
  SCancelEditEh = 'Bearbeiten abbrechen';
  SConfirmCaptionEh = 'Aktion';
  SRefreshRecordEh = 'Daten aktualisieren';

  SDeleteMultipleRecordsQuestionEh = '%d ausgewählte Datensätze löschen?';
  SDeleteAllRecordsQuestionEh = 'Alle Datensätze löschen?';

  SDuplicateVarNameEh = 'A Variable named ''%s'' already exists in the Collection';

  SSearchPanelEditorPromptText = 'Suche...';
  SUnsupportedFieldTypeEh = 'Unsupported field type (%s) in field %s';

  SSearchPanelApplyFilterEh = 'Nur Datensätze anzeigen die den Text enthalten';
  SSearchPanelCancelFilterEh = 'Filter entfernen und Suchtext löschen';
  SSearchPanelFindNextEh = 'Suche nächsten';
  SSearchPanelFindPrevEh = 'Suche vorigen';
  SSearchPanelOptionsEh = 'Suchoptionen anzeigen';

  SSortingByThisColumnIsNotPossibleEh = 'Sortierung für diese Spalte ist nicht möglich';
  SGroupingByThisColumnIsNotPossibleEh = 'Gruppierung nach dieser Spalte ist nicht möglich';

  SFindItemNameAllEh = '<All>';

implementation

end.

