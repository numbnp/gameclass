{*******************************************************}
{                                                       }
{                       EhLib v6.1                      }
{                     EhLib v6.1.03                     }
{                   Resource of strings                 }
{                                                       }
{      Copyright (c) 2001-2013 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{*******************************************************}
{                                                       }
{                       EhLib v5.3                      }
{                   Resource of strings                 }
{                                                       }
{      Copyright (c) 2001-2009 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

unit EhLibConsts;

interface

resourcestring
  SClearSelectedCellsEh = 'Seçili hücreleri temizle?';
  SInvalidTextFormatEh = 'Yanlýþ metin biçimi';
  SInvalidVCLDBIFFormatEh = 'Yanlýþ VCLDBIF biçimi';
  SErrorDuringInsertValueEh = 'Deðer eklenirken hata oluþtu:';
  SIgnoreErrorEh = 'Hata yoksayýlsýn mý?';
  STabularInformationEh = 'Tab bilgisi';
  SPageOfPagesEh = 'Sayfa %d of %d';
  SPreviewEh =  'Önizleme';
  SFieldNameNotFoundEh = 'Alan ''%s'' bulunamadý';
  SFindDialogStringNotFoundMessageEh = '"%s" metni bulunamadý.';

  SSTFilterListItem_Empties = '(Boþ)';
  SSTFilterListItem_NotEmpties = '(Dolu)';
  SSTFilterListItem_All = '(Tümü)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(Filtreyi sýfýrla)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByDescend = '(Küçükten büyüðe)';
  SSTFilterListItem_SortingByAscend = '(Büyükten küçüðe)';
  SSTFilterListItem_ApplyFilter = '(Filtreyi Uygula)';
  SSTFilterListItem_CustomFilter = '(Özel...)';

  SVisibleColumnsEh = 'Sütun Görüntüleme Ayarlarý';
  SCutEh = 'Kes';
  SCopyEh = 'Kopyala';
  SPasteEh = 'Yapýþtýr';
  SDeleteEh = 'Sil';
  SSelectAllEh = 'Tümünü Seç';

  SSimpFilter_equals              = 'eþittir';
  SSimpFilter_does_not_equal      = 'eþit deðil';
  SSimpFilter_is_greate_than      = 'büyüktür';
  SSimpFilter_is_greate_than_or_equall_to = 'büyük veya eþit';
  SSimpFilter_is_less_than        = 'küçüktür';
  SSimpFilter_is_less_than_or_equall_to = 'küçük veya eþit';
  SSimpFilter_begins_with         = 'ile baþlar';
  SSimpFilter_does_not_begin_with = 'ile baþlamaz';
  SSimpFilter_ends_with           = 'ile bitenler';
  SSimpFilter_does_not_end_with   = 'ile bitmeyenler';
  SSimpFilter_contains            = 'içerir';
  SSimpFilter_does_not_contain    = 'içermeyenler';
  SSimpFilter_like                = 'gibi';
  SSimpFilter_not_like            = 'gibi deðil';
  SSimpFilter_in_list             = 'liste içindekiler';
  SSimpFilter_not_in_list         = 'listede olmayanlar';
  SSimpFilter_is_blank            = 'boþ olanlar';
  SSimpFilter_is_not_blank        = 'boþ olmayanlar';

    // Error message
  SQuoteIsAbsentEh = 'Tek týrnak yok sayýldý: ';
  SLeftBracketExpectedEh = '''('' gerekli: ';
  SRightBracketExpectedEh = ''')'' gerekli: ';
  SErrorInExpressionEh = 'Ýfade de hata var:  ';
  SUnexpectedExpressionBeforeNullEh = ' Null'' den önce gereksz ifade : ';
  SUnexpectedExpressionAfterOperatorEh = 'Ýþlemciden sonra gereksiz ifade var: ';
  SIncorrectExpressionEh = 'Hatalý ifade : ';
  SUnexpectedANDorOREh = 'Gereksiz AND veya OR: ';

  SGridSelectionInfo_Sum = 'Sum';
  SGridSelectionInfo_Cnt = 'Count';
  SGridSelectionInfo_Evg = 'Average';
  SGridSelectionInfo_Min = 'Min';
  SGridSelectionInfo_Max = 'Max';

  SFirstRecordEh = 'Ýlk Kayýt';
  SPriorRecordEh = 'Önceki Kayýt';
  SNextRecordEh = 'Sonraki Kayýt';
  SLastRecordEh = 'Son Kayýt';
  SInsertRecordEh = 'Kayýt Ekle';
  SDeleteRecordEh = 'Kayýt Sil';
  SEditRecordEh = 'Kaydý Düzenle';
  SPostEditEh = 'Deðiþikliði Kaydet';
  SCancelEditEh = 'Deðiþikliði Ýptal Et';
  SConfirmCaptionEh = 'Onay';
  SRefreshRecordEh = 'Veriyi Tazele';


  SGroupingPanelText = 'Gruplamak için bir sütun baþlýðýný bu alana sürükleyiniz';
  SNoDataEh = '<No Records>'; //'No data';

  SDeleteMultipleRecordsQuestionEh = 'Seçilen %d kayýt silinsin mi ?';
  SDeleteAllRecordsQuestionEh = 'Tüm kayýtlat silinsin mi ?';

  SDuplicateVarNameEh = 'Koleksiyonda ''%s'' adlý bir deðiþken zaten var';

  SSearchPanelEditorPromptText = 'Ara...';
  SUnsupportedFieldTypeEh = ' %s alanýnda desteklenmeyen (%s) alan tipi bulundu';

  SSearchPanelApplyFilterEh = 'Metnin geçtiði kayýtlarý göster';
  SSearchPanelCancelFilterEh = 'Süzgeci iptal et ve aranan metni temizle';
  SSearchPanelFindNextEh = 'Sonrakini Bul';
  SSearchPanelFindPrevEh = 'Öncekini Bul';
  SSearchPanelOptionsEh = 'Arama seçeneklerini göster';

  SSortingByThisColumnIsNotPossibleEh = 'Bu sütuna göre sýralama yapýlamýyor';
  SGroupingByThisColumnIsNotPossibleEh = 'Bu sütuna göre gruplama yapýlamýyor';

  SFindItemNameAllEh = '<All>';

implementation

end.