{*******************************************************}
{                                                       }
{                       EhLib v6.0                      }
{                     EhLib v6.0.01                     }
{                   Resource of strings                 }
{                                                       }
{      Copyright (c) 2001-2012 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

unit EhLibConsts;

interface

resourcestring
  SClearSelectedCellsEh = 'Limpar células selecionadas?';
  SInvalidTextFormatEh = 'Formato de texto inválido';
  SInvalidVCLDBIFFormatEh = 'Formato VCLDBIF invalido';
  SErrorDuringInsertValueEh = 'Erro durante a inserção do valor:';
  SIgnoreErrorEh = 'Ignorar erro?';
  STabularInformationEh = 'Informação Tabular';
  SPageOfPagesEh = 'Pag. %d de %d';
  SPreviewEh =  'Visualizar Impressão';
  SFieldNameNotFoundEh = 'Campo com nome ''%s'' não encontrado';
  SFindDialogStringNotFoundMessageEh = 'O texto "%s" não foi encontrada.';
  SVisibleColumnsEh = 'Colunas visíveis';
  SCutEh = 'Recortar';
  SCopyEh = 'Copiar';
  SPasteEh = 'Colar';
  SDeleteEh = 'Excluir';
  SSelectAllEh = 'Selecionar Tudo';

  SSTFilterListItem_Empties = '(Vazio)';
  SSTFilterListItem_NotEmpties = '(Não Vazio)';
  SSTFilterListItem_All = '(Todos)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(Limpar filtro)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByAscend = '(Ordem ascendente)';
  SSTFilterListItem_SortingByDescend = '(Ordem descendente)';
  SSTFilterListItem_ApplyFilter = '(Aplicar filtro)';
  SSTFilterListItem_CustomFilter = '(Customizado)';

  SSimpFilter_equals              = 'igual';
  SSimpFilter_does_not_equal      = 'diferente';
  SSimpFilter_is_greate_than      = 'maior';
  SSimpFilter_is_greate_than_or_equall_to = 'maior ou igual';
  SSimpFilter_is_less_than        = 'menor';
  SSimpFilter_is_less_than_or_equall_to = 'menor ou igual';
  SSimpFilter_begins_with         = 'iniciando com';
  SSimpFilter_does_not_begin_with = 'não iniciando com';
  SSimpFilter_ends_with           = 'terminando com';
  SSimpFilter_does_not_end_with   = 'não terminando com';
  SSimpFilter_contains            = 'contém';
  SSimpFilter_does_not_contain    = 'não contém';
  SSimpFilter_like                = 'semelhante';
  SSimpFilter_not_like            = 'não semelhante';
  SSimpFilter_in_list             = 'na lista';
  SSimpFilter_not_in_list         = 'fora da lista';
  SSimpFilter_is_blank            = 'vazio';
  SSimpFilter_is_not_blank        = 'não vazio';

  SGroupingPanelText = 'Arraste um cabeçalho da coluna aqui para agrupar por essa coluna';

  SNoDataEh = '<Sem Registros>'; //'No data';

    // Error message
  SQuoteIsAbsentEh = 'Citação é ausente: ';
  SLeftBracketExpectedEh = '''('' esperado: ';
  SRightBracketExpectedEh = ''')'' esperado: ';
  SErrorInExpressionEh = 'Erro na expressão: ';
  SUnexpectedExpressionBeforeNullEh = 'Inesperado expressão antes de Null: ';
  SUnexpectedExpressionAfterOperatorEh = 'Inesperado expressão após operador: ';
  SIncorrectExpressionEh = 'Expressão Incorreta: ';
  SUnexpectedANDorOREh = 'Inesperado E ou OU: ';

  SGridSelectionInfo_Sum = 'Sum';
  SGridSelectionInfo_Cnt = 'Count';
  SGridSelectionInfo_Evg = 'Average';
  SGridSelectionInfo_Min = 'Min';
  SGridSelectionInfo_Max = 'Max';

  SFirstRecordEh = 'Primeiro';
  SPriorRecordEh = 'Anterior';
  SNextRecordEh = 'Próximo';
  SLastRecordEh = 'Último';
  SInsertRecordEh = 'Inserir';
  SDeleteRecordEh = 'Remover';
  SEditRecordEh = 'Editar';
  SPostEditEh = 'Gravar';
  SCancelEditEh = 'Cancelar';
  SConfirmCaptionEh = 'Confirmação';
  SRefreshRecordEh = 'Atualizar';

  SDeleteMultipleRecordsQuestionEh = 'Remover %d registro(s) selecionado(s)?';
  SDeleteAllRecordsQuestionEh = 'Remover todos os registros?';

  SDuplicateVarNameEh = 'A variável ''%s'' já existe na Coleção';

  SSearchPanelEditorPromptText = 'Busca...';
  SUnsupportedFieldTypeEh = 'O tipo (%s) não é suportado no campo %s';

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

