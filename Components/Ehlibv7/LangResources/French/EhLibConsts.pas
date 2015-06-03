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
  SClearSelectedCellsEh = 'Effacer les cellules sélectionnées ?';
  SInvalidTextFormatEh = 'Mauvais format de texte';
  SInvalidVCLDBIFFormatEh = 'Format VCLDBIF Invalide';
  SErrorDuringInsertValueEh = 'Erreur pendant l''insertion de la valeur :';
  SIgnoreErrorEh = 'Ignorer l''erreur?';
  STabularInformationEh = 'Information de tabulation';
  SPageOfPagesEh = 'Page %d sur %d';
  SPreviewEh =  'Aperçu';
  SFieldNameNotFoundEh = 'Nom de champ ''%s'' non trouvé';
  SFindDialogStringNotFoundMessageEh = 'Chaîne "%s" non trouvée.';
  SVisibleColumnsEh = 'Colonnes visibles';
  SCutEh = 'Couper';
  SCopyEh = 'Copier';
  SPasteEh = 'Coller';
  SDeleteEh = 'Supprimer';
  SSelectAllEh = 'Tout sélectionner';

  SSTFilterListItem_Empties = '(Vide)';
  SSTFilterListItem_NotEmpties = '(Non vide)';
  SSTFilterListItem_All = '(Tous)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(Suppr. filtre)';
  SSTFilterListItem_ClearFilterInColumn = '(Effacer le filtre de la colonne)';
  SSTFilterListItem_SortingByAscend = '(Tri ascendant)';
  SSTFilterListItem_SortingByDescend = '(Tri descendant)';
  SSTFilterListItem_ApplyFilter = '(Appliquer le filtre)';
  SSTFilterListItem_CustomFilter = '(Personnalisé...)';

  SSimpFilter_equals              = 'égal';
  SSimpFilter_does_not_equal      = 'pas égal';
  SSimpFilter_is_greate_than      = 'supérieur à';
  SSimpFilter_is_greate_than_or_equall_to = 'supérieur ou égal à';
  SSimpFilter_is_less_than        = 'inférieur à';
  SSimpFilter_is_less_than_or_equall_to = 'inférieur ou égal à';
  SSimpFilter_begins_with         = 'commence par';
  SSimpFilter_does_not_begin_with = 'ne commence pas par';
  SSimpFilter_ends_with           = 'fini par';
  SSimpFilter_does_not_end_with   = 'ne fini pas par';
  SSimpFilter_contains            = 'contient';
  SSimpFilter_does_not_contain    = 'ne contient pas';
  SSimpFilter_like                = 'comme';
  SSimpFilter_not_like            = 'pas comme';
  SSimpFilter_in_list             = 'dans la liste';
  SSimpFilter_not_in_list         = 'pas dans la liste';
  SSimpFilter_is_blank            = 'est blanc';
  SSimpFilter_is_not_blank        = 'n''est pas blanc';

  SGroupingPanelText = 'Glisser l''entête de colonne ici pour grouper par cette colonne';

  SNoDataEh = '<Pas d''enregistrements>'; //'No data';
     // Error message
  SQuoteIsAbsentEh = 'Quote manquante: ';
  SLeftBracketExpectedEh = '''('' attendu: ';
  SRightBracketExpectedEh = ''')'' attendu: ';
  SErrorInExpressionEh = 'Erreur dans l''expression: ';
  SUnexpectedExpressionBeforeNullEh = 'Expression inattendue après le Null: ';
  SUnexpectedExpressionAfterOperatorEh = 'Expression inattendue après l''operateur: ';
  SIncorrectExpressionEh = 'Expression incorrecte: ';
  SUnexpectedANDorOREh = 'AND ou OR inattendu: ';

  SGridSelectionInfo_Sum = 'Somme';
  SGridSelectionInfo_Cnt = 'Nombre';
  SGridSelectionInfo_Evg = 'Moyenne';
  SGridSelectionInfo_Min = 'Min';
  SGridSelectionInfo_Max = 'Max';

  SFirstRecordEh = 'Premier enregistrement';
  SPriorRecordEh = 'Enregistrement précédent';
  SNextRecordEh = 'Enregistrement suivant';
  SLastRecordEh = 'Dernier enregistrement';
  SInsertRecordEh = 'Insérer un enregistrement';
  SDeleteRecordEh = 'Effacer l''enregistrement';
  SEditRecordEh = 'Modifier l''enregistrement';
  SPostEditEh = 'Valider les modifications';
  SCancelEditEh = 'Annuler les modifications';
  SConfirmCaptionEh = 'Confirmer';
  SRefreshRecordEh = 'Rafraîchir les données';

  SDeleteMultipleRecordsQuestionEh = 'Effacer les %d enregistrements sélectionnés?';
  SDeleteAllRecordsQuestionEh = 'Effacer tous les enregistrements?';

  SDuplicateVarNameEh = 'Une Variable nommée ''%s'' existe déjà dans la Collection';

  SSearchPanelEditorPromptText = 'Recherche...';
  SUnsupportedFieldTypeEh = 'Type de champs non supporté (%s) dans le champ %s';

  SSearchPanelApplyFilterEh = 'Montre les enregistrement où le texte a été trouvé';
  SSearchPanelCancelFilterEh = 'Annule le filtre et efface la texte recherché';
  SSearchPanelFindNextEh = 'Cherche suivant';
  SSearchPanelFindPrevEh = 'cherche précédent';
  SSearchPanelOptionsEh = 'Montre les options de recherche';

  SSortingByThisColumnIsNotPossibleEh = 'Le tri par cette colonne n''est pas possible';
  SGroupingByThisColumnIsNotPossibleEh = 'Le groupement par cette colonne n''est pas possible';

  SFindItemNameAllEh = '<Tous>';

implementation

end.

