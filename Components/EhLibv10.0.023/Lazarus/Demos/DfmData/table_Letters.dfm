object MemTableData: TMemTableDataEh
  object DataStruct: TMTDataStructEh
    object post_id: TMTNumericDataFieldEh
      FieldName = 'post_id'
      NumericDataType = fdtIntegerEh
      AutoIncrement = False
      DisplayLabel = 'post_id'
      DisplayWidth = 10
      currency = False
      Precision = 15
    end
    object topic_id: TMTNumericDataFieldEh
      FieldName = 'topic_id'
      NumericDataType = fdtIntegerEh
      AutoIncrement = False
      DisplayLabel = 'topic_id'
      DisplayWidth = 10
      currency = False
      Precision = 15
    end
    object post_subject: TMTStringDataFieldEh
      FieldName = 'post_subject'
      StringDataType = fdtStringEh
      DisplayLabel = 'post_subject'
      DisplayWidth = 255
      Size = 255
      Transliterate = True
    end
    object post_text: TMTBlobDataFieldEh
      FieldName = 'post_text'
      DisplayLabel = 'post_text'
      DisplayWidth = 10
      BlobType = ftMemo
      Transliterate = True
    end
    object topic_title: TMTStringDataFieldEh
      FieldName = 'topic_title'
      StringDataType = fdtStringEh
      DisplayLabel = 'topic_title'
      DisplayWidth = 255
      Size = 255
      Transliterate = True
    end
    object poster_id: TMTNumericDataFieldEh
      FieldName = 'poster_id'
      NumericDataType = fdtIntegerEh
      AutoIncrement = False
      DisplayLabel = 'poster_id'
      DisplayWidth = 10
      currency = False
      Precision = 15
    end
    object username: TMTStringDataFieldEh
      FieldName = 'username'
      StringDataType = fdtStringEh
      DisplayLabel = 'username'
      DisplayWidth = 255
      Size = 255
      Transliterate = True
    end
    object post_time_d: TMTDateTimeDataFieldEh
      FieldName = 'post_time_d'
      DateTimeDataType = fdtDateTimeEh
      DisplayLabel = 'post_time_d'
      DisplayWidth = 18
    end
    object post_attachment: TMTNumericDataFieldEh
      FieldName = 'post_attachment'
      NumericDataType = fdtIntegerEh
      AutoIncrement = False
      DisplayLabel = 'post_attachment'
      DisplayWidth = 10
      currency = False
      Precision = 15
    end
    object post_read: TMTNumericDataFieldEh
      FieldName = 'post_read'
      NumericDataType = fdtIntegerEh
      AutoIncrement = False
      DisplayLabel = 'post_read'
      DisplayWidth = 10
      currency = False
      Precision = 15
    end
    object post_Mark: TMTNumericDataFieldEh
      FieldName = 'post_Mark'
      NumericDataType = fdtIntegerEh
      AutoIncrement = False
      DisplayLabel = 'post_Mark'
      DisplayWidth = 10
      currency = False
      Precision = 15
    end
    object Importance: TMTNumericDataFieldEh
      FieldName = 'Importance'
      NumericDataType = fdtIntegerEh
      AutoIncrement = False
      DisplayLabel = 'Importance'
      DisplayWidth = 10
      currency = False
      Precision = 15
    end
  end
  object RecordsList: TRecordsListEh
    Data = (
      (
        1
        1
        'Welcome to the forum!'
        
          'This is an example post in the forum. '#13#10'It seems that everything' +
          ' works fine. '#13#10'Good luck!'
        'Welcome to the forum!'
        2
        'Administrator'
        40899.9715740741d
        0
        0
        0
        0)
      (
        251
        133
        'Re: cells[col, row]'
        
          'Hello '#13#10#13#10'You can use next universal code to get field value as ' +
          'string from any DataSet descended from TDataSet:'#13#10#13#10'Col := 0;'#13#10'R' +
          'ow := 0;'#13#10#13#10'DataSet.DisableControls;'#13#10'try'#13#10'DataSet.RecNo := Row ' +
          '+ 1;'#13#10'ResultStr := DBGridEh1.Columns[Col].Field.AsString;'#13#10'final' +
          'ly'#13#10'DataSet.EnableControls;'#13#10'end;'#13#10#13#10'Disadvantage of this method' +
          ' is that DataSet.EnableControls force DBGrid (or any other conro' +
          'l conneced to this DataSet) to be redrawn.'#13#10#13#10'Some DataSets prov' +
          'ide an interface for direct access to the internal array of reco' +
          'rds.'#13#10'For example, for TMemTableEh you can use next code:'#13#10#13#10'Res' +
          'ultStr := VarToStr(MemTableEh1.RecordsView[Row].Value['#13#10'DBGridEh' +
          '1.Columns[Col].Field.FieldNo-1, dvvValueEh]);'#13#10#13#10'Best regards'#13#10'A' +
          'dmin'#13#10
        'cells[col, row]'
        2
        'Administrator'
        41056.9355208333d
        0
        1
        0
        0)
      (
        250
        132
        'Re: Filter Problem with list on another table'
        
          'Hello Dmitry I don'#39't know if you have see the problem, so I send' +
          ' a screenShot ... If you don'#39't answer after this, I can'#39't do any' +
          'thing else to show you, that use STFilter.ListField = '#39'ID'#39' is no' +
          't correct... You can'#39't say that show ID instead the listValue to' +
          ' the end users works as it must. Best regards Rico'
        'Filter Problem with list on another table'
        85
        'Rico'
        41052.4778125d
        1
        1
        0
        1)
      (
        2
        2
        'Welcome to the forum!'
        
          'We welcome everyone at a new forum of the EhLib library. The boa' +
          'rd includes the following forums: News: Read-only Forum. This fo' +
          'rum will be posted news about the EhLib library and EhLib.Com si' +
          'te. EhLib main forum: Main Forum of the EhLib Library. Write all' +
          ' your technical questions of the library in this forum. EhLib no' +
          'ntechnical: Questions that are not related to technical aspects.' +
          ' Best regards EhLib Team'
        'Welcome to the forum!'
        2
        'Administrator'
        40904.9667592593d
        0
        1
        0
        0)
      (
        246
        129
        'Re: Whole group selection when DataGrouping'
        
          'Hello msotirca Unfortunately this version of the library doesn'#39't' +
          ' support such feature. But it is a good idea for realization in ' +
          'future versions. Best regards Admin'
        'Whole group selection when DataGrouping'
        2
        'Administrator'
        41043.9469212963d
        0
        0
        1
        0)
      (
        247
        133
        'cells[col, row]'
        
          'how can i get the text from specific cell (not selected and not ' +
          'focused ) like function cells[col, row] in TDbAdvgrid from TMS c' +
          'omponents thinks'
        'cells[col, row]'
        170
        'bestwail'
        41050.6927083333d
        0
        1
        1
        0)
      (
        248
        132
        'Re: Filter Problem with list on another table'
        
          'Hello Dmitry, In the same project, try to use custom filter with' +
          ' first column set like this : STFilter.KeyField = '#39'ID'#39' STFilter.' +
          'ListField = '#39'ID'#39' The displayed values are [b:3jsyw7va]the Column' +
          '.KeyList and not the column.pickList[/b:3jsyw7va] in the custom ' +
          'filter window (1,2,3) , but values are correct in the filter (li' +
          'b1,lib2,lib3) I hope you are agree this time to say that this se' +
          'tting is not OK If I set STFilter like this STFilter.KeyField = ' +
          #39#39' STFilter.ListField = '#39'ID'#39' Values are the column.pickList as i' +
          't must and the filter is ok If I set STFilter like this STFilter' +
          '.KeyField = '#39'ID'#39' STFilter.ListField = '#39'LIB'#39' Values are the colum' +
          'n.pickList, but the filter doesn'#39't work (exception) How is the c' +
          'orrect setting ? Best regards Rico'
        'Filter Problem with list on another table'
        85
        'Rico'
        41051.1475462963d
        0
        1
        1
        0)
      (
        99
        38
        'Re: Bug in MEMTABLE with TreeView'
        
          'Hello We fixed the error and uploaded EhLib 5.6 Build 5.6.212 Yo' +
          'u can check it. Now if you expand or collapse nodes when dataset' +
          ' is in editing mode the grid will post data before changing node' +
          's state. Best regards Administrator'
        'Bug in MEMTABLE with TreeView'
        2
        'Administrator'
        40962.9963194444d
        0
        0
        0
        0)
      (
        100
        92
        'Upgrades'
        
          'What is your upgrade policy? If I purchase a license now for ver' +
          'sion 5.6, do I get free upgrades for anything in the 5.x series,' +
          ' or for anything for 12 months, or what? Thanks, Rob.'
        'Upgrades'
        149
        'arkangles'
        40965.446712963d
        0
        1
        0
        0)
      (
        101
        93
        'Multi select Combobox'
        
          'I'#39'm looking for a Combobox or LookupCombobox with multi-selectio' +
          'n capability, iue to drop down the list of options and be able t' +
          'o select more than one of them. Do any EhLib components allow th' +
          'at? Thanks, Rob.'
        'Multi select Combobox'
        149
        'arkangles'
        40965.44875d
        0
        1
        0
        0)
      (
        102
        92
        'Re: Upgrades'
        
          'Hello By registering EhLib 5.X (includion 5.6) you will get all ' +
          'versions of 5.X Free. There are no any time restrictions. Best r' +
          'egards Administrator'
        'Upgrades'
        2
        'Administrator'
        40965.5746759259d
        0
        1
        1
        0)
      (
        103
        94
        'I'#39'm happy to see the new forum for EHDBGRID.'
        
          '<!-- s:P --><img src="{SMILIES_PATH}/icon_razz.gif" alt=":P" tit' +
          'le="'#1044#1088#1072#1079#1085#1080#1090#1089#1103'" /><!-- s:P --> I'#39'm happy to see the new forum for' +
          ' EHDBGRID. This grid is one of the best tools for Delphi ! Congr' +
          'atulations for all you big work and long life to your products. ' +
          'Remy'
        'I'#39'm happy to see the new forum for EHDBGRID.'
        150
        'WALLOON'
        40965.5995601852d
        0
        1
        0
        0)
      (
        104
        93
        'Re: Multi select Combobox'
        
          'Hello Rob. Unfortunately, this version of library doesn'#39't have s' +
          'uch capability, but we added it to the list of features that we ' +
          'are going to realize at the one of the next versions. Best regar' +
          'ds Administrator'
        'Multi select Combobox'
        2
        'Administrator'
        40965.8639699074d
        0
        1
        0
        1)
      (
        105
        38
        'Re: Bug in MEMTABLE with TreeView'
        'Hello, Test with 5.6.215 and it works !! Thank you'
        'Bug in MEMTABLE with TreeView'
        85
        'Rico'
        40967.7839699074d
        0
        1
        0
        1)
      (
        106
        95
        'Color of STFilter'
        
          'Hello, With the version 5.6.215 of EHLib the STFilter and the gr' +
          'ill cells have the same color. In code I see that you have chang' +
          'e the function SetColor(LightenColor(FixedColor, 8)) by SetColor' +
          '(ApproximateColor(clWindow, FixedColor, 8)) to set the filter co' +
          'lor. On my application, the filter is blank and the filter too i' +
          'n this version. You can see difference if you see the demo proje' +
          'ct in ehlib4.2 by example. Thank You Rico'
        'Color of STFilter'
        85
        'Rico'
        40967.8390509259d
        0
        1
        0
        1)
      (
        107
        96
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        
          'I have a button which Closes MemtableEh connected to a Datasetdr' +
          'iver connected to a Query and when I re-open the MemTableEh the ' +
          'Recordcount is Zero. The Query is definitely open. Do I need to ' +
          'call a method to get the memtableeh to reload the data? Thanks. ' +
          'Rod'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        118
        'rundlegd'
        40970.8471643518d
        0
        1
        0
        1)
      (
        108
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          'Hello, Try this : close the query and repoen it. Have you try me' +
          'mtable.refresh ? Rico'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        85
        'Rico'
        40970.8893402778d
        0
        1
        0
        0)
      (
        109
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          '[quote=&quot;Rico&quot;:66j93ql5]Hello, Try this : close the que' +
          'ry and repoen it. Have you try memtable.refresh ? Rico[/quote:66' +
          'j93ql5] Thanks for the suggestions Rico. That is what I initiall' +
          'y tried and it did not work. The content of the MemTableEh is no' +
          't reloaded. that is why I tried to close and reopen the MemTable' +
          'Eh.'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        118
        'rundlegd'
        40970.9081134259d
        0
        1
        0
        0)
      (
        110
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          'And like is ? : memtable.close; query.close; query.open; memtabl' +
          'e.open'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        85
        'Rico'
        40970.9224189815d
        0
        1
        0
        0)
      (
        111
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          '[quote=&quot;Rico&quot;:3irg2slc]And like is ? : memtable.close;' +
          ' query.close; query.open; memtable.open[/quote:3irg2slc] Yes, I ' +
          'have tried that as well. Do not know if it matters that the MemT' +
          'ableEh is connected to a DataSetDriverEh.'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        118
        'rundlegd'
        40970.9401967593d
        0
        1
        0
        0)
      (
        112
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          '[quote=&quot;rundlegd&quot;:3lpp7hxs] Do not know if it matters ' +
          'that the MemTableEh is connected to a DataSetDriverEh.[/quote:3l' +
          'pp7hxs] I don'#39't find other thing to refresh a memtable. Properti' +
          'es of DataSetDriverEh are used to apply updates on database. If ' +
          'a other way exists to refresh memtable, ask Dmitry <!-- s;) --><' +
          'img src="{SMILIES_PATH}/icon_e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080 +
          #1074#1072#1077#1090'" /><!-- s;) -->'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        85
        'Rico'
        40970.9553703704d
        0
        1
        0
        0)
      (
        113
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          '[quote=&quot;Rico&quot;:2m2j3lqo][quote=&quot;rundlegd&quot;:2m2' +
          'j3lqo] Do not know if it matters that the MemTableEh is connecte' +
          'd to a DataSetDriverEh.[/quote:2m2j3lqo] I don'#39't find other thin' +
          'g to refresh a memtable. Properties of DataSetDriverEh are used ' +
          'to apply updates on database. If a other way exists to refresh m' +
          'emtable, ask Dmitry <!-- s;) --><img src="{SMILIES_PATH}/icon_e_' +
          'wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) -->[/quote:2m2' +
          'j3lqo] Rico, Does Dmitry regularly check the forum? Rod'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        118
        'rundlegd'
        40970.9881365741d
        0
        1
        0
        0)
      (
        114
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          'Hello Rod. MemtableEh.Close MemtableEh.Open must work without an' +
          'y additional code. If it isn'#39't then it is a bug. First of all, t' +
          'ry to download and test last build of Ehlib. It is EhLib 5.6 Bui' +
          'ld 5.6.216 now. One of early build of EhLib 5.6 had a similar bu' +
          'g. Best regards Administrator'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        2
        'Administrator'
        40971.0234143519d
        0
        1
        0
        0)
      (
        115
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          '[quote=&quot;Administrator&quot;:3rwott3z]Hello Rod. MemtableEh.' +
          'Close MemtableEh.Open must work without any additional code. If ' +
          'it isn'#39't then it is a bug. First of all, try to download and tes' +
          't last build of Ehlib. It is EhLib 5.6 Build 5.6.216 now. One of' +
          ' early build of EhLib 5.6 had a similar bug. Best regards Admini' +
          'strator[/quote:3rwott3z] I will try the current version i am usi' +
          'ng 5.6.209 currently'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        118
        'rundlegd'
        40971.0427199074d
        0
        1
        0
        0)
      (
        116
        96
        'Re: After Closing MemtableEh, and Re-Opening Recordcount is'
        
          '[quote=&quot;rundlegd&quot;:1x5w6zue][quote=&quot;Administrator&' +
          'quot;:1x5w6zue]Hello Rod. MemtableEh.Close MemtableEh.Open must ' +
          'work without any additional code. If it isn'#39't then it is a bug. ' +
          'First of all, try to download and test last build of Ehlib. It i' +
          's EhLib 5.6 Build 5.6.216 now. One of early build of EhLib 5.6 h' +
          'ad a similar bug. Best regards Administrator[/quote:1x5w6zue] I ' +
          'will try the current version i am using 5.6.209 currently[/quote' +
          ':1x5w6zue] The current version of EhLib solved the problem. Than' +
          'ks everyone for you help. Rod'
        'After Closing MemtableEh, and Re-Opening Recordcount is Zero'
        118
        'rundlegd'
        40971.0832523148d
        0
        1
        0
        1)
      (
        117
        97
        'Bug in DbgridEh in OnDrawColumnCell event and HideDuplicates'
        
          'Hi Ehlib Team. I'#39'm english short and ehlib 5.6.216 is tested. DB' +
          'GRIDEH In OnDrawColumnCell event and HideDuplicates properties s' +
          'et TRUE. HideDuplicates properties column field is not work. Ste' +
          'p 1. bug test source procedure TForm1.DBGridEh1DrawColumnCell(Se' +
          'nder: TObject; const Rect: TRect; DataCol: Integer; Column: TCol' +
          'umnEh; State: TGridDrawState); begin If DBGridEh1.DataSource.Dat' +
          'aSet.fieldbyname('#39'NAME'#39').asstring = '#39'BBB'#39' then Begin DBGridEh1.c' +
          'anvas.Brush.Color:=$00FAFFDF; DBGridEh1.canvas.Font.Style:=[fsBo' +
          'ld]; DBGridEh1.canvas.Font.Color:=ClBlack; End; DBGridEh1.Defaul' +
          'tDrawColumnCell(Rect, DataCol, Column, State); end; Setp 2. &quo' +
          't;NAME&quot; Column field is HideDuplicates properties set TRUE.' +
          ' Setp 3. program run and &quot;NAME&quot; column field be displa' +
          'yed all of the duplicate values??. Now DBGRIDEH.pas is bug fixed' +
          ' on OnDefaultDrawColumnCell event. procedure TCustomDBGridEh.Def' +
          'aultDrawColumnCell(const Rect: TRect; DataCol: Integer; Column: ' +
          'TColumnEh; State: TGridDrawState); var Value: string; ARect, ARe' +
          'ct1: TRect; XFrameOffs, YFrameOffs, KeyIndex: Integer; RowHeight' +
          ': Integer; /////////////////////////////////////////////////////' +
          '////////////////////////////// //new add var RowString:string; /' +
          '////////////////////////////////////////////////////////////////' +
          '////////////////// /////////////////////////////////////////////' +
          '////////////////////////////////////// // new add function funct' +
          'ion CheckColumnDuplicateValues(Column: TColumnEh; var s: String)' +
          ': Boolean; var OldActive: Integer; begin Result := False; { TODO' +
          ' : Add support of IMemTableEh } OldActive := FDataLink.ActiveRec' +
          'ord; if OldActive &gt; 0 then begin FDataLink.ActiveRecord := Ol' +
          'dActive-1; try Column.FillColCellParams(VarColCellParamsEh); wit' +
          'h VarColCellParamsEh do begin FCol := Column.Index + IndicatorOf' +
          'fset; FRow := FDataLink.ActiveRecord + TopDataOffset; GetCellPar' +
          'ams(Column, FFont, FBackground, FState); Column.GetColCellParams' +
          '(False, VarColCellParamsEh); end; if s = VarColCellParamsEh.FTex' +
          't then Result := True; finally FDataLink.ActiveRecord := OldActi' +
          've; end; end; end; /////////////////////////////////////////////' +
          '////////////////////////////////////// begin ARect := Rect; if (' +
          'dghFooter3D in OptionsEh) then begin XFrameOffs := 1; InflateRec' +
          't(ARect, -1, -1); end else XFrameOffs := 2; YFrameOffs := XFrame' +
          'Offs; if Flat then Dec(YFrameOffs); ////////////////////////////' +
          '/////////////////////////////////////////////////////// // sourc' +
          'e is modified and CheckColumnDuplicateValues function added // V' +
          'alue := Column.DisplayText; RowString:= Column.DisplayText; if C' +
          'olumn.HideDuplicates and CheckColumnDuplicateValues(Column, RowS' +
          'tring) then Value := '#39#39' else Value := Column.DisplayText; //////' +
          '////////////////////////////////////////////////////////////////' +
          '/////////////'
        'Bug in DbgridEh in OnDrawColumnCell event and HideDuplicates'
        148
        'loveyang'
        40971.4223958333d
        1
        1
        0
        0)
      (
        119
        99
        'Numeric format and numpad'
        
          'Hello, The French numeric format is '#39'# ##0.00'#39', the decimalpoint' +
          ' is a comma To input numeric values in dbGridEh all is ok, becau' +
          'se the point of the numpad is replace by a comma Is is possible ' +
          'to do the same thing in the incremental search and in the STFilt' +
          'er ? In incremental seach, it would be better to remove the spac' +
          'e too, because it'#39's not usefull to seach 1 236,45 if you must ty' +
          'pe space after 1 by example (my users don'#39't do that and I must r' +
          'emove space in the displayFormat) Thank You Best Regards Rico'
        'Numeric format and numpad'
        85
        'Rico'
        40971.9242592593d
        0
        1
        0
        1)
      (
        120
        95
        'Re: Color of STFilter'
        
          'A screenShot to show you the problem In backGroung ehLib5.6 In F' +
          'oreGround ehLib4.2 I want just to know how to set color of the S' +
          'tFilter or if is it always possible with ehLib5.6. Thank You Ric' +
          'o [attachment=0:27ysp5g3]<!-- ia0 -->filterColor.jpg<!-- ia0 -->' +
          '[/attachment:27ysp5g3]'
        'Color of STFilter'
        85
        'Rico'
        40975.5060416667d
        1
        1
        0
        0)
      (
        121
        95
        'Re: Color of STFilter'
        
          'Hello Rico I see that the higher grid looks more stylish. Even i' +
          'f the filter row have the same color with the data row You can e' +
          'asy undersatand where is the Filter row by Edit Buttons that is ' +
          'shown in translucent style. How much important to you that the F' +
          'ilter row have a different color from a color of Data rows? Best' +
          ' regards Administrator.'
        'Color of STFilter'
        2
        'Administrator'
        40977.0191203704d
        0
        1
        0
        0)
      (
        122
        95
        'Re: Color of STFilter'
        
          'Hello Dmitry, [quote=&quot;Administrator&quot;:1a4mg9uy] How muc' +
          'h important to you that the Filter row have a different color fr' +
          'om a color of Data rows? [/quote:1a4mg9uy] In this example you a' +
          're right, because the edit buttons are visibles. But, I can send' +
          ' you an other screenShot where there is no edit button and impos' +
          'sible to see difference between dataRow and the filter ! You hav' +
          'e always edit buttons when dbGrid is connected to a memTableEh, ' +
          'but if you connect the grid to a clientDataset you can'#39't see tha' +
          't the first line is a filter. I hope you can do anything, draw t' +
          'he black border at least ... Best regards Rico'
        'Color of STFilter'
        85
        'Rico'
        40977.1650810185d
        0
        1
        0
        0)
      (
        123
        95
        'Re: Color of STFilter'
        
          'Hello, Dmitry, I understand now why I don'#39't see filters on some ' +
          'screens ! In fact, filters have always edit Buttons, DbgridEh do' +
          ' that even with a TClientDataSet (sorry). But filter looks like ' +
          'this when the dataSet is not open (and I don'#39't see it with my fi' +
          'rst test <!-- s;) --><img src="{SMILIES_PATH}/icon_e_wink.gif" a' +
          'lt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) --> ) : [attachment=0:sty' +
          'hjwec]<!-- ia0 -->filterColor2.jpg<!-- ia0 -->[/attachment:styhj' +
          'wec] Bests regards Rico'
        'Color of STFilter'
        85
        'Rico'
        40977.5065740741d
        1
        1
        0
        0)
      (
        124
        100
        'TreeList'
        
          #1044#1086#1073#1088#1099#1081' '#1076#1077#1085#1100' '#1044#1084#1080#1090#1088#1080#1081'! '#1055#1086#1076#1089#1082#1072#1078#1080#1090#1077', '#1087#1088#1086#1073#1091#1102' '#1042#1072#1096#1091' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1091' '#1080' '#1089#1090#1086#1083#1082#1085 +
          #1091#1083#1089#1103' '#1089' '#1074#1086#1087#1088#1086#1089#1072#1084#1080': 1. .MoveRecord( ?, ? - '#1079#1076#1077#1089#1100' '#1076#1072#1085#1085#1099#1077' '#1073#1088#1072#1090#1100' '#1086#1090#1082#1091 +
          #1076#1072'? '#1041#1077#1088#1091' .RecNo , '#1085#1086' '#1086#1085' '#1085#1072' 1 '#1073#1086#1083#1100#1096#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1074' tree, R' +
          'ec.ItemIndex - '#1074#1086#1086#1073#1097#1077' '#1076#1072#1083#1077#1082#1086' '#1086#1090' '#1082#1091#1088#1089#1086#1088#1072' '#1074' '#1075#1088#1080#1076#1077'... 2. '#1050#1072#1082' '#1086#1090#1082#1088#1099#1074 +
          #1072#1090#1100' Grid '#1074' '#1074#1080#1076#1077' Tree '#1080' '#1091#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1090#1100' '#1089#1088#1072#1079#1091' '#1076#1083#1103' '#1079#1072#1087#1080#1089#1077#1081' expanded ' +
          #1080#1083#1080' '#1085#1077#1090', '#1090#1086#1095#1085#1077#1077' '#1075#1076#1077' '#1084#1086#1078#1085#1086' '#1101#1090#1086' '#1087#1088#1086#1087#1080#1089#1072#1090#1100'? ('#1061#1086#1088#1086#1096#1086' '#1089#1076#1077#1083#1072#1083' '#1085#1072' After' +
          'Open, '#1087#1088#1086#1096#1077#1083' '#1087#1086' '#1074#1089#1077#1084' '#1079#1072#1087#1080#1089#1103#1084' '#1080' '#1087#1088#1086#1089#1090#1072#1074#1080#1083', '#1085#1086' '#1087#1088#1080' '#1086#1090#1082#1088#1099#1090#1080#1080' '#1076#1077#1088#1077#1074#1072 +
          ' '#1101#1090#1086' '#1089#1086#1073#1099#1090#1080#1077' '#1091#1078#1077' '#1085#1077' '#1088#1072#1073#1086#1090#1072#1077#1090', '#1072' '#1076#1077#1088#1077#1074#1086' '#1089#1086#1079#1076#1072#1077#1090#1089#1103' '#1074#1085#1091#1090#1088#1080' '#1087#1086#1090#1086#1084'...' +
          '. '#1057#1084#1091#1090#1085#1099#1077' '#1084#1099#1089#1083#1080', '#1085#1077' '#1089#1090#1072#1085#1076#1072#1088#1090#1085#1099#1081' '#1082#1086#1084#1087#1086#1085#1077#1085#1090', '#1085#1086' '#1086#1095#1077#1085#1100' '#1091#1076#1086#1073#1085#1099#1081' '#1087#1086#1083#1100 +
          #1079#1086#1074#1072#1090#1077#1083#1102'. '#1057#1087#1072#1089#1080#1073#1086'. P.S. '#1086#1090#1083#1080#1095#1085#1099#1081' grid.'
        'TreeList'
        151
        'Mark'
        40978.7022916667d
        0
        1
        0
        0)
      (
        125
        100
        'Re: TreeList'
        #1080' '#1090#1080#1096#1080#1085#1072'... '#1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082' '#1079#1076#1077#1089#1100' '#1087#1086#1103#1074#1083#1103#1077#1090#1089#1103'?'
        'TreeList'
        151
        'Mark'
        40979.9696759259d
        0
        1
        0
        0)
      (
        126
        100
        'Re: TreeList'
        
          'Hello Mark, I don'#39't know if I can help you, but I don'#39't speak ru' +
          'ssian <!-- s;) --><img src="{SMILIES_PATH}/icon_e_wink.gif" alt=' +
          '";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) --> You are on an English-sp' +
          'eaking forum here ! If you want help here, speak english please ' +
          'or post here [url:3l84986q]http&#58;//forum&#46;ehlib&#46;com/ru' +
          '[/url:3l84986q] Rico'
        'TreeList'
        85
        'Rico'
        40980.0951041667d
        0
        1
        0
        0)
      (
        127
        101
        'NULL values in TColumnEh.KeyList'
        
          'Hello! Is it possible to include to TColumnEh.KeyList NULL value' +
          '? For example, PickList = (YES, NO, Not assigned). Field, assign' +
          'ed to column, can store values 1, 0 or NULL (or nullable Boolean' +
          '). How to fill KeyList so that his values correspond to PickList' +
          '? If I set PickList = (YES, NO, Not assigned), KeyList = (1, 0),' +
          ' NotInKeyListIndex = 2 all works fine, but when user edit row in' +
          ' DbGridEh (select value '#39'Not assigned'#39' in DropDown list), error ' +
          'occur (when POST changes) . Excuse me, my english bad.'
        'NULL values in TColumnEh.KeyList'
        152
        'Alexandr'
        40980.8227777778d
        0
        1
        0
        0)
      (
        24
        23
        'Problems with DBGridEh'
        
          'Hello! I think about simple question: How collapse or expand all' +
          ' records in DBGridEh (this records have been grouped by Data Gro' +
          'uping later). Can You help me? Thank You very much. BR, Konstant' +
          'in'
        'Problems with DBGridEh'
        70
        'kast2k'
        40940.4170949074d
        0
        1
        0
        0)
      (
        25
        23
        'Re: Problems with DBGridEh'
        
          'Hello! There is no such procedure that could do it. But you can ' +
          'use next code to collapse or expand all records in Grouping mode' +
          '. [code:sh084jpp]//Expand All procedure TForm1&#46;Button1Click(' +
          'Sender&#58; TObject); var i&#58; Integer; begin for i &#58;= 0 t' +
          'o DBGridEh1&#46;DataGrouping&#46;GroupLevels&#46;Count-1 do begi' +
          'n DBGridEh1&#46;DataGrouping&#46;GroupLevels&#91;i&#93;&#46;Extr' +
          'actNodes; end; end; //Collapse All procedure TForm1&#46;Button2C' +
          'lick(Sender&#58; TObject); var i&#58; Integer; begin for i &#58;' +
          '= 0 to DBGridEh1&#46;DataGrouping&#46;GroupLevels&#46;Count-1 do' +
          ' begin DBGridEh1&#46;DataGrouping&#46;GroupLevels&#91;i&#93;&#46' +
          ';CollapseNodes; end; end; [/code:sh084jpp] Best regards Administ' +
          'rator'
        'Problems with DBGridEh'
        2
        'Administrator'
        40941.9626967593d
        0
        0
        0
        1)
      (
        26
        23
        'Re: Problems with DBGridEh'
        
          'Thanks a lot! I was trying to realise this for long time <!-- s:' +
          'D --><img src="{SMILIES_PATH}/icon_e_biggrin.gif" alt=":D" title' +
          '="'#1054#1095#1077#1085#1100' '#1076#1086#1074#1086#1083#1077#1085'" /><!-- s:D -->'
        'Problems with DBGridEh'
        70
        'kast2k'
        40942.5630555556d
        0
        1
        0
        1)
      (
        231
        128
        'Re: column.editing = false and allowedSelection'
        
          'Hello Dmitry, I don'#39't know why you don'#39't see the problem ... So,' +
          ' in this is this project if you set dgMultiSelect := True it don' +
          #39't works and if you set to False it works ! Best regards Rico [a' +
          'ttachment=0:34vkdlad]<!-- ia0 -->testCopyCell.zip<!-- ia0 -->[/a' +
          'ttachment:34vkdlad]'
        'column.editing = false and allowedSelection'
        85
        'Rico'
        41038.1967361111d
        1
        1
        0
        0)
      (
        232
        128
        'Re: column.editing = false and allowedSelection'
        
          'Helo Rico. In your project you removed [gstRectangle, gstColumns' +
          '] from AllowedSelections. In such conditions Grid selects row wh' +
          'en user clicks on Data Cell. So when you click cell and press ct' +
          'rl+c a Row is selected. Is it important for you that [gstRectang' +
          'le, gstColumns] is not in the AllowedSelections? Best regards Ad' +
          'min'
        'column.editing = false and allowedSelection'
        2
        'Administrator'
        41038.2230902778d
        0
        0
        1
        0)
      (
        233
        128
        'Re: column.editing = false and allowedSelection'
        
          'Hello Dmitry, I don'#39't need [gstRectangle, gstColumns] in the All' +
          'owedSelections, but [gstRecordBookmarks] yes ! In fact, it works' +
          ' only if I have AllowedSelections := [] Try with my project with' +
          ' [gstRecordBookmarks] to see the problem (and dgMultiSelect := T' +
          'rue) Best regards Rico'
        'column.editing = false and allowedSelection'
        85
        'Rico'
        41038.6317361111d
        0
        1
        0
        0)
      (
        234
        128
        'Re: column.editing = false and allowedSelection'
        
          'Helo Rico. What do you mean &quot;it works&quot;? I thought that' +
          ' you wanted that s user could click on a cell and pressing ctrl+' +
          'c get the current cell value into clipboard. (Not values of the ' +
          'whole row). To achieve this you can set AllowedSelections to one' +
          ' of the next values: AllowedSelections = [] AllowedSelections = ' +
          '[gstRectangle] AllowedSelections = [gstRecordBookmarks, gstRecta' +
          'ngle] AllowedSelections = [gstRecordBookmarks, gstRectangle, gst' +
          'All] AllowedSelections = [gstRecordBookmarks, gstRectangle, gstC' +
          'olumns, gstAll] Key moment here is that the gstRectangle value m' +
          'ust present with one gstRecordBookmarks. If gstRecordBookmarks v' +
          'alue present in the AllowedSelections without gstRectangle then ' +
          'grid will select whole row on mouse click. Best regards Admin'
        'column.editing = false and allowedSelection'
        2
        'Administrator'
        41038.9881944444d
        0
        0
        1
        0)
      (
        235
        128
        'Re: column.editing = false and allowedSelection'
        
          'Thank you Dmitry, it'#39's exactly what I want <!-- s:D --><img src=' +
          '"{SMILIES_PATH}/icon_e_biggrin.gif" alt=":D" title="'#1054#1095#1077#1085#1100' '#1076#1086#1074#1086#1083#1077 +
          #1085'" /><!-- s:D --> Best regards Rico'
        'column.editing = false and allowedSelection'
        85
        'Rico'
        41038.9963888889d
        0
        1
        0
        0)
      (
        236
        130
        'Filter Problem'
        
          'Dear Dmitry I have the following problem wirh STFilter: I have a' +
          ' TMemTableEh with a Field (let'#39's say A) which has some Values an' +
          'd a calculated Field (let'#39's say B) whose values are derived from' +
          ' the first Field A Values. The calculated Field B cannot be used' +
          ' in a Filter expression, So I use the Column.STFilter properties' +
          ' DataField, KeyField, ListField, ListSource connected to the tab' +
          'le which has the Values of the Field A and it works OK. But when' +
          ' I use the Custom Filter, the Filter Expression does not return ' +
          'the Values of the KeyField (as it should) but the Values of the ' +
          'ListField and the DBGrid shows nothing. Best Regards Nicholas'
        'Filter Problem'
        163
        'arnikos'
        41039.4663194444d
        0
        1
        0
        0)
      (
        237
        131
        'Searching in trees'
        
          'EhLib 4.2 Build 4.2.16 Searching in collapsed records doesn'#39't wo' +
          'rk even with option &quot;Search in all nodes&quot; (&quot;'#1042#1086' '#1074#1089 +
          #1077#1093' '#1074#1077#1090#1074#1103#1093'&quot; in russian). Actually, in function [code:82ugeny' +
          'r]function LocateDatasetTextEh(AGrid&#58; TCustomDBGridEh; const' +
          ' FieldName, Text&#58; String; AOptions&#58; TLocateTextOptionsEh' +
          '; Direction&#58; TLocateTextDirectionEh; Matching&#58; TLocateTe' +
          'xtMatchingEh; TreeFindRange&#58; TLocateTextTreeFindRangeEh)&#58' +
          '; Boolean;[/code:82ugenyr] parameter TreeFindRange is only decla' +
          'red but never used. How can I fix it?'
        'Searching in trees'
        168
        'Ice_Harley'
        41040.5053356482d
        0
        1
        0
        0)
      (
        172
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          #1044#1086#1073#1088#1099#1081' '#1076#1077#1085#1100'! '#1050' '#1089#1086#1078#1072#1083#1077#1085#1080#1103' '#1073#1077#1079' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1080#1089#1093#1086#1076#1085#1086#1075#1086' '#1082#1086#1076#1072' '#1072#1083#1075#1086#1088#1080#1090#1084' '#1074 +
          #1082#1083#1102#1095#1077#1085#1080#1103' '#1080#1085#1082#1088#1077#1084#1077#1085#1090#1085#1086#1075#1086' '#1087#1086#1080#1089#1082#1072' '#1082#1072#1082' '#1074' '#1074#1077#1088#1089#1080#1080' 4 '#1085#1077' '#1089#1076#1077#1083#1072#1090#1100'. '#1042' '#1089#1074#1086#1077' ' +
          #1074#1088#1077#1084#1103', '#1087#1086' '#1087#1088#1086#1089#1100#1073#1077' '#1090#1088#1091#1076#1103#1097#1080#1093#1089#1103', '#1084#1099' '#1089#1076#1077#1083#1072#1083#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1072#1083#1075#1086#1088#1080#1090#1084#1072' '#1095#1090#1086 +
          #1073' '#1086#1085' '#1088#1072#1073#1086#1090#1072#1083' '#1080#1084#1077#1085#1085#1086' '#1090#1072#1082', '#1082#1072#1082' '#1086#1085' '#1088#1072#1073#1086#1090#1072#1077#1090' '#1089#1077#1081#1095#1072#1089'. '#1042#1086#1079#1084#1086#1078#1085#1086', '#1076#1083#1103' '#1073 +
          #1086#1083#1077#1077' '#1075#1080#1073#1082#1086#1081' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1090#1086#1080#1090' '#1076#1086#1073#1072#1074#1080#1090#1100' '#1089#1074#1086#1081#1089#1090#1074#1072' IncSearch '#1080' Prefer' +
          'IncSearch '#1090#1080#1087#1072' Boolean '#1074' TColumnEh, '#1090#1072#1082' '#1095#1090#1086' '#1074#1099' '#1089#1084#1086#1078#1077#1090#1077' '#1085#1072#1089#1090#1088#1072#1080#1074#1072 +
          #1090#1100' '#1072#1083#1075#1086#1088#1080#1090#1084' '#1074#1082#1083#1102#1095#1077#1085#1080#1103' '#1087#1086#1080#1089#1082#1072' '#1080#1085#1076#1080#1074#1080#1076#1091#1072#1083#1100#1085#1086' '#1076#1083#1103' '#1082#1072#1078#1076#1086#1081' '#1082#1086#1083#1086#1085#1082#1080'. '#1055 +
          #1086#1076#1086#1081#1076#1077#1090' '#1083#1080' '#1074#1072#1084' '#1090#1072#1082#1086#1077' '#1088#1072#1089#1096#1080#1088#1077#1085#1080#1077'? Best regards Admin -- Unfortuna' +
          'tely, it is not possible to make algorithm of turning on of the ' +
          'increment searching works as it worked in version 4 without modi' +
          'fying the source code. At one time, at the request of working pe' +
          'ople, we made ??some changes in the algorithm so that it started' +
          ' to work exactly the way it works now. Perhaps, for a more flexi' +
          'ble customization it is needed to add IncSearch and PreferIncSea' +
          'rch properties (of Boolean type) to the TColumnEh class, so you ' +
          'could customize the seeking algorithm for the each column indivi' +
          'dually. Will it fit?'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        2
        'Administrator'
        40996.061875d
        0
        1
        1
        0)
      (
        173
        115
        'Re: Bug in editButton'
        
          'In fact we just need to know that ebsDropDownEh do the default a' +
          'ction and not the others buttons styles. If you consider that a ' +
          'button style must do actions it'#39's not a bug ...'
        'Bug in editButton'
        85
        'Rico'
        40996.1921875d
        0
        1
        0
        0)
      (
        174
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          #1044#1086#1073#1088#1099#1081' '#1076#1077#1085#1100'! '#1042' '#1087#1088#1080#1085#1094#1080#1087#1077' '#1103' '#1089#1085#1103#1083' '#1082#1086#1084#1084#1077#1085#1090' '#1080' '#1090#1072#1073#1083#1080#1094#1072' '#1088#1072#1073#1086#1090#1072#1077#1090' '#1090#1072#1082' '#1082#1072 +
          #1082' '#1084#1085#1077' '#1085#1091#1078#1085#1086'. '#1050#1086#1085#1077#1095#1085#1086' '#1077#1089#1083#1080' '#1073#1099' '#1042#1099' '#1089#1076#1077#1083#1072#1083#1080' '#1089#1074#1086#1081#1089#1090#1074#1086' '#1089#1090#1086#1083#1073#1094#1072' '#1090#1086' '#1073#1099#1083#1086 +
          ' '#1073#1099' '#1086#1095#1077#1085#1100' '#1093#1086#1088#1086#1096#1086' ('#1085#1086' '#1083#1080#1095#1085#1086' '#1103' '#1085#1077' '#1085#1072#1089#1090#1072#1080#1074#1072#1102' <!-- s:-) --><img src=' +
          '"{SMILIES_PATH}/icon_e_smile.gif" alt=":-)" title="'#1059#1083#1099#1073#1072#1077#1090#1089#1103'" />' +
          '<!-- s:-) --> ). '#1055#1099#1057#1099'. '#1057#1087#1072#1089#1080#1073#1086' '#1079#1072' '#1086#1090#1074#1077#1090#1099'.'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        157
        'Mironico'
        40996.5021875d
        0
        0
        0
        0)
      (
        175
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          'Hello Dmitry, If you add IncSearch and PreferIncSearch propertie' +
          's to the TColumnEh class, I wonder if it will be easy to underst' +
          'and what appends with options dghIncSearch and dghPreferIncSearc' +
          'h, because it makes many cases between optionsEh and colum'#39's pro' +
          'perties. I suppose the default values on column will be False ? ' +
          'Is it possible to add simply a class variable to DBGridEh like D' +
          'BGridEhInplaceSearchTextColor to have autoEnterSearchMode on rea' +
          'dOnly column when dghIncSearch is in optionsEh ? Best Regards Ri' +
          'co'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        85
        'Rico'
        40996.6137152778d
        0
        1
        0
        0)
      (
        176
        116
        'documentation or source code of the demo file for learning ?'
        'can i get it or any documentation for DBgridEh usage'
        'documentation or source code of the demo file for learning ?'
        64
        'ahmedltayib'
        40996.6328472222d
        0
        1
        0
        0)
      (
        177
        116
        'Re: documentation or source code of the demo file for learni'
        
          'You can find help files in directory ..\ehlib\HLP demo files in ' +
          '..\ehlib\demos'
        'documentation or source code of the demo file for learning ?'
        85
        'Rico'
        40996.6345601852d
        0
        1
        0
        0)
      (
        178
        117
        'Help : How to have rows readOnly and not readOnly in a grid'
        
          'Hello, In some case I need a grid where the rows can be readOnly' +
          ' and not ReadOnly. To do that I connect a event onColumnsGetCell' +
          'Params(Sender: TObject; EditMode: Boolean; Params: TColCellParam' +
          'sEh) on each column and set Params.ReadOnly := True or false. I ' +
          'wonder if you know a better way to do that ? Thank You Rico'
        'Help : How to have rows readOnly and not readOnly in a grid'
        85
        'Rico'
        40996.8856134259d
        0
        1
        0
        0)
      (
        179
        117
        'Re: Help : How to have rows readOnly and not readOnly in a g'
        'Use DataSet.OnAfterScroll event.'
        'Help : How to have rows readOnly and not readOnly in a grid'
        55
        'sinys'
        40996.9378472222d
        0
        0
        0
        1)
      (
        180
        117
        'Re: Help : How to have rows readOnly and not readOnly in a g'
        
          'Hello Rico. onColumnsGetCellParams is a very good way (May be th' +
          'e best). ReadOnly property was added to the Params parameter spe' +
          'cifically for this purpose.'
        'Help : How to have rows readOnly and not readOnly in a grid'
        2
        'Administrator'
        40996.9596527778d
        0
        1
        0
        0)
      (
        181
        117
        'Re: Help : How to have rows readOnly and not readOnly in a g'
        
          'Thank you Dmitry ! And I saw that you have add a the property Te' +
          'xtEditing that is very usefull to disable lookUp and editors (ve' +
          'ry good <!-- s:D --><img src="{SMILIES_PATH}/icon_e_biggrin.gif"' +
          ' alt=":D" title="'#1054#1095#1077#1085#1100' '#1076#1086#1074#1086#1083#1077#1085'" /><!-- s:D --> )'
        'Help : How to have rows readOnly and not readOnly in a grid'
        85
        'Rico'
        40996.9770949074d
        0
        1
        0
        0)
      (
        182
        114
        'Re: XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        
          #1044#1086#1073#1088#1099#1081' '#1076#1077#1085#1100'. '#1054#1095#1077#1085#1100' '#1087#1086#1093#1086#1078#1077' '#1085#1072' '#1087#1077#1088#1077#1089#1077#1095#1077#1085#1080#1077' '#1085#1077#1089#1082#1086#1083#1100#1082#1080#1093' '#1074#1077#1088#1089#1080#1081' '#1073#1080#1073#1083#1080 +
          #1086#1090#1077#1082#1080'. '#1055#1086#1087#1088#1086#1073#1091#1081#1090#1077' '#1091#1076#1072#1083#1080#1090#1100' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1091' '#1074#1088#1091#1095#1085#1091#1102' '#1080#1079' IDE '#1080' '#1074#1089#1077' '#1077#1077' '#1092#1072#1081 +
          #1083#1099'. '#1045#1089#1083#1080' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1081' '#1074#1077#1088#1089#1080#1080' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086' '#1085#1077' '#1073#1099#1083#1086', '#1090#1086' '#1087#1086#1087#1088#1086#1073#1091#1081#1090#1077' '#1089#1082 +
          #1072#1095#1072#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1089#1073#1086#1088#1082#1091'. '#1057#1077#1081#1095#1072#1089' '#1101#1090#1086' '#1089#1073#1086#1088#1082#1072' EhLib 5.6 Build 5.6.22' +
          '1.'
        'XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        2
        'Administrator'
        40997.072974537d
        0
        1
        0
        0)
      (
        183
        114
        'Re: XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        
          #1048#1089#1087#1086#1083#1100#1079#1091#1102' '#1089#1073#1086#1088#1082#1091' EhLib 5.6 Build 5.6.221, '#1087#1088#1080#1095#1077#1084' '#1089#1090#1072#1074#1083#1102' '#1082#1086#1084#1087#1086#1085#1077#1085 +
          #1090#1099' '#1085#1072' '#1095#1080#1089#1090#1091#1102' IDE. '#1044#1091#1084#1072#1102', '#1095#1090#1086' '#1087#1088#1086#1073#1083#1077#1084#1072' '#1088#1077#1096#1072#1077#1090#1089#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077#1084' DCU' +
          ' '#1092#1072#1081#1083#1086#1074' '#1087#1086#1076' XE Update 4 ('#1087#1086#1089#1082#1086#1083#1100#1082#1091' Embarcadero '#1087#1086#1089#1090#1086#1103#1085#1085#1086' '#1074#1085#1086#1089#1080#1090' ' +
          #1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1074' '#1089#1074#1086#1080' '#1092#1072#1081#1083#1099'). '#1058#1072#1082' '#1082#1072#1082' '#1074#1077#1088#1089#1080#1103' '#1090#1088#1080#1072#1083#1100#1085#1072#1103', '#1073#1077#1079' '#1080#1089#1093#1086#1076#1085#1080#1082#1086 +
          #1074' '#1085#1077' '#1080#1084#1077#1102' '#1090#1072#1082#1086#1081' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1080'.'
        'XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        159
        'Vladimir'
        40997.5863888889d
        0
        1
        0
        0)
      (
        184
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          'Hello Rico About IncSearch and PreferIncSearch properties to the' +
          ' TColumnEh: By default values in IncSearch and PreferIncSearch p' +
          'roperties of TColumnEh will have the same value as dghIncSearch ' +
          'and dghPreferIncSearch in OptionsEh but it will be possible to c' +
          'hange default values. About adding class variable to DBGridEh li' +
          'ke DBGridEhInplaceSearchTextColor to have autoEnterSearchMode on' +
          ' readOnly: I think that having IncSearch and PreferIncSearch in ' +
          'the TColumnEh will eliminate the need for additional properties ' +
          'and make it more flexible, because it will allow to disable/enab' +
          'le IncSearch for individual columns. Best regards Admin'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        2
        'Administrator'
        40997.5887152778d
        0
        1
        0
        0)
      (
        185
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          'Hello Dmitry, It will be certainly more flexible. Just one quest' +
          'ion : When we will update ehlib with this new feature, what appe' +
          'nds with a grid where the dghIncSearch = True and dghPreferIncSe' +
          'arch = False in OptionsEh ? By default values IncSearch = True a' +
          'nd PreferIncSearch = False in TColumnEh ? In this case, the colu' +
          'm will be in autoEnterSearchMode when values can'#39't be modified ?' +
          ' Best regards Rico'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        85
        'Rico'
        40997.6140162037d
        0
        1
        0
        0)
      (
        186
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          'Hello When you update ehlib with this new feature, and in you pr' +
          'oject you have the dghIncSearch = True and dghPreferIncSearch = ' +
          'False in OptionsEh then in TColumEh.IncSearch will be True and T' +
          'ColumEh.PreferIncSearch will be False After that you will set TC' +
          'olumEh.PreferIncSearch to True for any column you want (In your ' +
          'specific case you will change TColumEh.PreferIncSearch to True f' +
          'or ReadOnly columns).'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        2
        'Administrator'
        40997.6509722222d
        0
        1
        0
        0)
      (
        187
        118
        'can I merge cells?'
        
          'Hi, please help me... I need to merge three cells in a grid to p' +
          'lace a text as a title and keep below these other three separate' +
          ' cells similar to that chart? thanks regards'
        'can I merge cells?'
        160
        'sambizimo'
        40998.3615277778d
        1
        1
        0
        0)
      (
        188
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          'Hello Dmitry, I understand now how I will work. I need it ! IncS' +
          'earch and PreferIncSearch will be in the params in event onColum' +
          'nsGetCellParams ? Best regards Rico'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        85
        'Rico'
        40998.4522106481d
        0
        1
        0
        0)
      (
        189
        118
        'Re: can I merge cells?'
        
          'Hello, Set DBGridEh.UseMultiTitle := True And define the titles ' +
          'like this : Column[0].Title.Caption := '#39'Title|A'#39'; Column[1].Titl' +
          'e.Caption := '#39'Title|B'#39'; Column[2].Title.Caption := '#39'Title|C'#39'; Ri' +
          'co'
        'can I merge cells?'
        85
        'Rico'
        40998.5062731481d
        0
        1
        0
        0)
      (
        190
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          'Hello Rico. Do you really need IncSearch and PreferIncSearch in ' +
          'the Params of OnColumnsGetCellParams event? For what type of tas' +
          'ks and how are you going to use it in that event? Could you give' +
          ' an example? Best regards Admin'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        2
        'Administrator'
        40998.6308217593d
        0
        1
        0
        0)
      (
        191
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          'Hello Dmitry, In my input grid of invoices or orders, I use the ' +
          'product code column to add products. This product code can not b' +
          'e changed after entered. The product code column is read-only ex' +
          'cept in insert mode. In fact, with the new properties on columns' +
          ' I can have autoEnterSeachMode and so, I don'#39't need IncSearch an' +
          'd PreferIncSearch in the Params of OnColumnsGetCellParams event,' +
          ' because IncSeach is not active in inserting mode ! Sorry, you c' +
          'an forget my question <!-- s;) --><img src="{SMILIES_PATH}/icon_' +
          'e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) --> Best reg' +
          'ards Rico'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        85
        'Rico'
        40998.7006712963d
        0
        1
        0
        0)
      (
        97
        90
        'How to use ExportDBGridEhToOleExcel'
        
          'Hi! I want to know to use the procedure &quot;ExportDBGridEhToOl' +
          'eExcel&quot;'
        'How to use ExportDBGridEhToOleExcel'
        147
        'beroyak'
        40961.6000231481d
        0
        1
        0
        0)
      (
        98
        91
        'TDBGridEh Exportation'
        
          'The procedure ExportDBGridEhToOleExcel doesn'#39't export TDBGridEh ' +
          'with color and vertical shapes. How to do it?'
        'TDBGridEh Exportation'
        147
        'beroyak'
        40961.6390393519d
        0
        0
        0
        0)
      (
        15
        10
        'Re: test'
        'test message'
        'test'
        55
        'sinys'
        40936.8227662037d
        0
        1
        0
        0)
      (
        238
        132
        'Filter Problem with list on another table'
        
          'Hello, I'#39've a problem on filter in dbgrid when the filed is link' +
          'ed to another cds the problem is in dbgrideh Line 29244 Before P' +
          'arseExpression(Value); FExpression.Operand1 = '#39'Ok'#39' ( see my exam' +
          'ple below ) After FExpression.Operand1 = 1 but i think it try to' +
          ' do the same in SetLookupKeyValues(FExpression.Operand1); Line 2' +
          '9249 so after FExpression.Operand1 is null Example i have a tabl' +
          'e status (Tclientdataset ) ID ; LIB ----------- 1 ; Ok 2 ; NotOk' +
          ' in the list i'#39've the ref to the status so i see STFilter is lin' +
          'ked to the TClientdataset NUMBER ; STATUS N12 ; Ok N13 ; Ok N14 ' +
          '; NotOk Status filter on nul value when i try to filter on statu' +
          's OK Many thanks for any idea'
        'Filter Problem with list on another table'
        85
        'Rico'
        41040.5473032407d
        0
        1
        0
        0)
      (
        239
        132
        'Re: Filter Problem with list on another table'
        
          'Hello Dmitry, In this project you can see that you use the listf' +
          'ield to build the filter instead the keyfield in the STFilter Be' +
          'st regards Rico [attachment=0:e59zhytf]<!-- ia0 -->filter.zip<!-' +
          '- ia0 -->[/attachment:e59zhytf]'
        'Filter Problem with list on another table'
        85
        'Rico'
        41041.1871643519d
        1
        1
        0
        0)
      (
        240
        130
        'Re: Filter Problem'
        
          'Hello Nicholas I checked it and attached demo project where it (' +
          'Key Field) works as in the Droped down filter (where you select ' +
          'values using checkboxes) as in the Custom Filter (I selected Cus' +
          'tom.. for CalcCountry). In both cases Grid put KeyFeild and KeyV' +
          'alue to the filter expression. There in the Project: STFilter.Da' +
          'taField = '#39'Name'#39' STFilter.KeyField = '#39'Name'#39' STFilter.ListField =' +
          ' '#39'Capital'#39' STFilter.ListSource = LookupSource Set BreakPoint in ' +
          'the procedure TSQLDatasetFeaturesEh.ApplyFilter(Sender: TObject;' +
          ' DataSet: TDataSet; IsReopen: Boolean); to check what exression ' +
          'forms to assing to the Filter property. Best regards Admin'
        'Filter Problem'
        2
        'Administrator'
        41042.7667476852d
        0
        0
        0
        0)
      (
        241
        132
        'Re: Filter Problem with list on another table'
        
          'Hello Rico. In the project you have first colum with title '#39'Filt' +
          'er OK with listfield = ID'#39' where a filter works correctly, as it' +
          ' must. You set STFilter.KeyField = '#39'ID'#39' STFilter.ListField = '#39'ID' +
          #39' but Grid show values in the droped down list from the Column.P' +
          'ickList as it determines automatically that Column.PickList and ' +
          'Column.KeyList is not Empty and substitutes values from Column.P' +
          'ickList and you see '#39'lib1'#39',... instead of 1,2... So the first co' +
          'lum is customized correctly and works. Best regards Admin'
        'Filter Problem with list on another table'
        2
        'Administrator'
        41043.0556944444d
        0
        1
        0
        0)
      (
        242
        132
        'Re: Filter Problem with list on another table'
        
          'Hello Dmitry, Thank you for the answer. [quote:18cayln1]Grid sho' +
          'w values in the droped down list from the Column.PickList as it ' +
          'determines automatically that Column.PickList and Column.KeyList' +
          ' is not Empty and substitutes values from Column.PickList and yo' +
          'u see '#39'lib1'#39',... instead of 1,2...[/quote:18cayln1] Yes I saw th' +
          'is, but could you confirm that it doesn'#39't work like this in ehli' +
          'b 4.2 ? I have migrate my project to 5.6 from 4.2 and in 4.2 I a' +
          'm pretty sure that it doesn'#39't do that, I have STFilter.ListField' +
          ' = '#39'LIB'#39'. If you say me yes and that is like this now, no proble' +
          'm I do the changes ... PS : I don'#39't understand why you use listf' +
          'ield instead the idfield to build the filter, because to me, the' +
          ' listfield sould be only display in the droped down list and not' +
          'hing else <!-- s:?: --><img src="{SMILIES_PATH}/icon_question.gi' +
          'f" alt=":?:" title="'#1042#1086#1087#1088#1086#1089'" /><!-- s:?: --> Best regards Rico'
        'Filter Problem with list on another table'
        85
        'Rico'
        41043.1134837963d
        0
        1
        0
        0)
      (
        243
        130
        'Re: Filter Problem'
        
          'Dear Dmitry Here attached is a Demo Project showing the problem.' +
          ' There are 2 tables: customers and countries. The first table (c' +
          'ustomers) contains the names of the customers and in field Count' +
          'ries the codes of some countries (more than one) in the format X' +
          'X,XX,XX... where XX is the country code. The second table contai' +
          'ns the code and the country name. DBGridEh1 displays the list of' +
          ' the customers but the field CalcCountries is a calculated Field' +
          ' showing not the country codes but their FullName in Format coun' +
          'try1, country2, .... The Column CalcCountries of DBGridEh1 has t' +
          'he following properties: STFilter.ListSource=scountries STFilter' +
          '.ListField=Country STFilter.KeyField=Code STFilter.DataField=Cou' +
          'ntries When I use the filter of this column, the Filter list dis' +
          'plays the countries and checking the Value '#39'Greece'#39' the DBGridEh' +
          '1 displays only the customer '#39'Nicholas'#39' who has just 1 country (' +
          'Greece) and it works as it was expected, but when I use the cust' +
          'om Filter and the operator [b:32q9bvti]'#39'contains'#39'[/b:32q9bvti] a' +
          'nd select the Value '#39'Italy'#39' (or any other) the records are disap' +
          'peared instead of showing customers '#39'George'#39' and '#39'Alex'#39' where '#39'I' +
          'taly'#39' (code=02) is contained in their Field Countries. To run th' +
          'e application just create a BDE Alias '#39'EhLib'#39' of type '#39'Standard'#39 +
          ' pointing to the directory of the Application. Environment: Delp' +
          'hi5 Enterprise, upd1 Best Regards Nicholas'
        'Filter Problem'
        163
        'arnikos'
        41043.5108564815d
        1
        1
        0
        0)
      (
        244
        132
        'Re: Filter Problem with list on another table'
        
          'Hello Dmitry, In the same project I have set the STFilter like t' +
          'his and it works too !! STFilter.KeyField = '#39#39' STFilter.ListFiel' +
          'd = '#39'LIB'#39' It is correct to do that ? I suppose you build the fil' +
          'ter with the keylist in this case .. Why don'#39't build filter alwa' +
          'ys with keylist ? Thank you Best regards Rico'
        'Filter Problem with list on another table'
        85
        'Rico'
        41043.5979050926d
        0
        1
        0
        0)
      (
        245
        131
        'Re: Searching in trees'
        
          'Hello Ice_Harley We fixed it in version EhLib 5.6 Build 5.6.229 ' +
          'You can check it for example if download evaluation version form' +
          ' official site - <!-- m --><a class="postlink" href="http://www.' +
          'ehlib.com">http://www.ehlib.com</a><!-- m -->. Is it suitable fo' +
          'r you to upgrade your version to version 5? Best regards Admin'
        'Searching in trees'
        2
        'Administrator'
        41043.9440277778d
        0
        1
        0
        0)
      (
        156
        110
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          #1044#1086#1073#1088#1099#1081' '#1076#1077#1085#1100'! '#1048#1089#1087#1086#1083#1100#1079#1091#1102' '#1089#1090#1072#1088#1091#1102' '#1074#1077#1088#1089#1080#1102' 4.1 ('#1080' Firebird+FibPlus). '#1080 +
          ' '#1085#1077' '#1084#1086#1075#1091' '#1087#1077#1088#1077#1081#1090#1080' '#1085#1072' '#1073#1086#1083#1077#1077' '#1085#1086#1074#1091#1102' '#1080#1079'-'#1079#1072' '#1086#1076#1085#1086#1081' ('#1076#1083#1103' '#1084#1077#1085#1103') '#1085#1077#1087#1088#1080#1103#1090#1085#1086 +
          #1089#1090#1080'. '#1053#1077#1087#1088#1080#1103#1090#1085#1086#1089#1090#1100' '#1082#1072#1089#1072#1077#1090#1089#1103' '#1089#1074#1086#1081#1089#1090#1074': dghIncSearch '#1080' dghPreferIncS' +
          'earch (DBGridEh). '#1044#1086#1087#1091#1089#1090#1080#1084' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1090#1072#1073#1083#1080#1094#1072' '#1089' 2-'#1084#1103' '#1087#1086#1083#1103#1084#1080': T' +
          'OV_NAME, KOLVO. '#1055#1077#1088#1074#1086#1077' '#1087#1086#1083#1077' ReadOnly, '#1074#1090#1086#1088#1086#1077' - '#1085#1077#1090' ('#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103 +
          ' '#1076#1083#1103' '#1088#1091#1095#1085#1086#1075#1086' '#1074#1074#1086#1076#1072' '#1095#1080#1089#1077#1083'). '#1057#1077#1081#1095#1072#1089' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072' '#1087#1086' TOV_NAME '#1085#1091#1078#1085#1086' '#1087 +
          #1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1086' '#1078#1072#1090#1100' Ctrl+F '#1080' '#1090#1086#1075#1076#1072' '#1091#1078#1077' '#1085#1072#1073#1080#1088#1072#1090#1100' '#1085#1072' '#1082#1083#1072#1074#1080#1072#1090#1091#1088#1077' '#1089#1080#1084 +
          #1074#1086#1083#1099' (dghIncSearch=True '#1080' dghPreferIncSearch=False). '#1040' '#1077#1089#1083#1080' '#1077#1097#1077' ' +
          #1087#1086#1089#1090#1072#1074#1080#1090#1100' dghPreferIncSearch=True '#1090#1086' Ctrl+F '#1087#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1086' '#1078#1072#1090#1100' ' +
          #1085#1077' '#1085#1091#1078#1085#1086' '#1085#1086' '#1090#1086#1075#1076#1072' '#1074' '#1087#1086#1083#1077' KOLVO ('#1093#1086#1090#1100' '#1086#1085#1086' '#1080' '#1085#1077' ReadOnly) '#1090#1086#1078#1077' '#1089#1088#1072 +
          #1073#1072#1090#1099#1074#1072#1077#1090' '#1087#1086#1080#1089#1082' ('#1087#1088#1080#1093#1086#1076#1080#1090#1089#1103' '#1078#1072#1090#1100' Enter '#1072' '#1090#1086#1075#1076#1072' '#1091#1078#1077' '#1074#1074#1086#1076#1080#1090#1100' '#1095#1080#1089#1083#1086')' +
          '. '#1053#1077' '#1087#1086#1076#1089#1082#1072#1078#1077#1090' '#1083#1080' '#1082#1090#1086' '#1084#1086#1078#1085#1086' '#1083#1080' '#1082#1072#1082'-'#1090#1086' '#1089#1076#1077#1083#1072#1090#1100' '#1090#1072#1082' '#1082#1072#1082' '#1073#1099#1083#1086' '#1074' 4.1' +
          ': '#1095#1090#1086#1073#1099' '#1074' ReadOnly '#1089#1088#1072#1073#1072#1090#1099#1074#1072#1083' '#1087#1086#1080#1089#1082' '#1087#1088#1080' '#1087#1077#1088#1074#1086#1084' '#1085#1072#1078#1072#1090#1080#1080' '#1073#1077#1079' '#1087#1088#1077#1076#1074 +
          #1072#1088#1080#1090#1077#1083#1100#1085#1086#1075#1086' Ctrl+F '#1072' '#1074' ('#1053#1045')ReadOnly '#1087#1086#1080#1089#1082' '#1085#1077' '#1089#1088#1072#1073#1072#1090#1099#1074#1072' '#1074#1086#1086#1073#1097#1077'. '#1057 +
          #1087#1072#1089#1080#1073#1086' '#1073#1086#1083#1100#1096#1086#1077' '#1079#1072#1088#1072#1085#1077#1077'.'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        157
        'Mironico'
        40994.6170833333d
        0
        1
        0
        0)
      (
        157
        107
        'Re: Popup menu in title button to set columns visibles'
        
          'Hello Rico. Unfortunately it is not possbile now. But we are wor' +
          'king on it. More soon it will be solved at the next version of t' +
          'he library. Standart menus don'#39't support to keep menu opened aft' +
          'er clicking. Best regards Admin.'
        'Popup menu in title button to set columns visibles'
        2
        'Administrator'
        40994.6470833333d
        0
        1
        0
        0)
      (
        158
        90
        'Re: How to use ExportDBGridEhToOleExcel'
        
          'Hello Here is an example: ExportDBGridEhToOleExcel(DBGridEh1, []' +
          ', True); Here is declaration of ExportDBGridEhToOleExcel: [code:' +
          '1ubi0ysr]function ExportDBGridEhToOleExcel(DBGridEh&#58; TCustom' +
          'DBGridEh; Options&#58; TDBGridEhExportAsOLEXLSOptions; IsSaveAll' +
          '&#58; Boolean = True)&#58; Variant; type TDBGridEhExportAsOLEXLS' +
          'Option = (oxlsColoredEh, oxlsDataAsDisplayText, oxlsDataAsEditTe' +
          'xt); TDBGridEhExportAsOLEXLSOptions = set of TDBGridEhExportAsOL' +
          'EXLSOption;[/code:1ubi0ysr] function returns Instance of Excel.A' +
          'pplication created by CreateOleObject('#39'Excel.Application'#39') funct' +
          'ion. So you can perform addidtion action after creation data. Be' +
          'st regards Admin.'
        'How to use ExportDBGridEhToOleExcel'
        2
        'Administrator'
        40994.6549537037d
        0
        1
        0
        0)
      (
        161
        112
        'Re: Whay not realized WideMemo in MemTableEh'
        
          'Hello MemTableEh supports WideMemo fields. If you have a problem' +
          ' with this fields in the MemTableEh, please, write a demo projec' +
          't where the problem is obviously visible, and send to <!-- e -->' +
          '<a href="mailto:support@ehlib.com">support@ehlib.com</a><!-- e -' +
          '->. Best regards Admin'
        'Whay not realized WideMemo in MemTableEh'
        2
        'Administrator'
        40994.7395949074d
        0
        1
        0
        0)
      (
        160
        112
        'Whay not realized WideMemo in MemTableEh'
        'Whay not realized WideMemo in MemTableEh'
        'Whay not realized WideMemo in MemTableEh'
        158
        'Shagrat2'
        40994.7038773148d
        0
        1
        0
        0)
      (
        162
        112
        'Re: Whay not realized WideMemo in MemTableEh'
        
          '[code:16swzp5k] fFNumE &#58;= TWideMemoField&#46;Create(fTables)' +
          '; fFNumE&#46;FieldName &#58;= '#39'NumE'#39'; fFNumE&#46;DisplayLabel &#' +
          '58;= '#39'NumE'#39'; fFNumE&#46;DataSet &#58;= fTables; fTables&#46;Crea' +
          'teDataSet; [/code:16swzp5k] Return message: SUnknownFieldType'
        'Whay not realized WideMemo in MemTableEh'
        158
        'Shagrat2'
        40994.7632638889d
        0
        1
        0
        0)
      (
        163
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          #1042' '#1089#1086#1089#1077#1076#1085#1077#1081' '#1090#1077#1084#1077' '#1087#1080#1096#1091#1090' '#1087#1088#1086' '#1079#1072#1082#1086#1084#1077#1085#1090#1080#1088#1086#1074#1072#1085#1085#1091#1102' '#1089#1090#1088#1086#1095#1082#1091'. '#1056#1072#1089#1082#1086#1084#1077#1085#1090#1080#1088 +
          #1086#1074#1072#1083', '#1087#1077#1088#1077#1080#1085#1089#1090#1072#1083#1080#1083' - '#1079#1072#1088#1072#1073#1086#1090#1072#1083#1086' '#1090#1072#1082' '#1082#1072#1082' '#1084#1085#1077' '#1085#1091#1078#1085#1086'. '#1042#1086#1087#1088#1086#1089' '#1074' '#1090#1086#1084' ' +
          #1095#1077#1084' '#1101#1090#1086' '#1095#1088#1077#1074#1072#1090#1086'? '#1053#1077' '#1079#1088#1103' '#1078#1077' '#1079#1072#1082#1086#1084#1077#1085#1090#1080#1083#1080'.'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        157
        'Mironico'
        40994.7638657407d
        0
        1
        0
        0)
      (
        164
        113
        'XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        
          #1044#1086#1073#1088#1099#1081' '#1076#1077#1085#1100'! '#1057#1082#1072#1095#1072#1083' '#1090#1088#1080#1072#1083#1100#1085#1091#1102' '#1074#1077#1088#1089#1080#1102' '#1074#1072#1096#1077#1075#1086' '#1087#1088#1086#1076#1091#1082#1090#1072'. '#1053#1072#1095#1072#1083' '#1082#1086#1084#1087 +
          #1080#1083#1080#1088#1086#1074#1072#1090#1100' '#1080' '#1087#1086#1083#1091#1095#1080#1083' '#1086#1096#1080#1073#1082#1091': [DCC Fatal Error] EhLibConsts.pas(68' +
          '): F2051 Unit DBGridEh was compiled with a different version of ' +
          'EhLibConsts.SNoDataEh '#1048#1089#1087#1086#1083#1100#1079#1091#1102' XE2 Update 4 DCU-'#1092#1072#1081#1083#1099' '#1082#1086#1087#1080#1088#1086#1074#1072#1083 +
          ' '#1086#1090#1089#1102#1076#1072': RADStudioXE2\Win32\Release\ '#1055#1091#1090#1080' '#1090#1097#1072#1090#1077#1083#1100#1085#1086' '#1087#1088#1086#1074#1077#1088#1080#1083'. '#1042' ' +
          #1095#1077#1084' '#1084#1086#1078#1077#1090' '#1073#1099#1090#1100' '#1086#1096#1080#1073#1082#1072'? '#1057#1087#1072#1089#1080#1073#1086' '#1073#1086#1083#1100#1096#1086#1077' '#1079#1072#1088#1072#1085#1077#1077'.'
        'XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        159
        'Vladimir'
        40994.7743055556d
        0
        1
        0
        0)
      (
        165
        114
        'XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        
          #1044#1086#1073#1088#1099#1081' '#1076#1077#1085#1100'! '#1057#1082#1072#1095#1072#1083' '#1090#1088#1080#1072#1083#1100#1085#1091#1102' '#1074#1077#1088#1089#1080#1102' '#1074#1072#1096#1077#1075#1086' '#1087#1088#1086#1076#1091#1082#1090#1072'. '#1053#1072#1095#1072#1083' '#1082#1086#1084#1087 +
          #1080#1083#1080#1088#1086#1074#1072#1090#1100' '#1080' '#1087#1086#1083#1091#1095#1080#1083' '#1086#1096#1080#1073#1082#1091': [DCC Fatal Error] EhLibConsts.pas(68' +
          '): F2051 Unit DBGridEh was compiled with a different version of ' +
          'EhLibConsts.SNoDataEh '#1048#1089#1087#1086#1083#1100#1079#1091#1102' XE2 Update 4 DCU-'#1092#1072#1081#1083#1099' '#1082#1086#1087#1080#1088#1086#1074#1072#1083 +
          ' '#1086#1090#1089#1102#1076#1072': RADStudioXE2\Win32\Release\ '#1055#1091#1090#1080' '#1090#1097#1072#1090#1077#1083#1100#1085#1086' '#1087#1088#1086#1074#1077#1088#1080#1083'. '#1042' ' +
          #1095#1077#1084' '#1084#1086#1078#1077#1090' '#1073#1099#1090#1100' '#1086#1096#1080#1073#1082#1072'? '#1057#1087#1072#1089#1080#1073#1086' '#1073#1086#1083#1100#1096#1086#1077' '#1079#1072#1088#1072#1085#1077#1077'.'
        'XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        159
        'Vladimir'
        40994.7749652778d
        0
        1
        0
        0)
      (
        166
        115
        'Bug in editButton'
        
          'Hello Dmitry, I found a bug in editButton with specials conditio' +
          'ns Not easy to find this bug this time <!-- s;) --><img src="{SM' +
          'ILIES_PATH}/icon_e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!--' +
          ' s;) --> On a lookup field, if you set ButtonStyle to cbsNone on' +
          ' a column and a editButton to ebsDropDownEh, the button has 2 ac' +
          'tions ! it opens the lookupList + do action of the editButton. I' +
          'f you change ebsDropDownEh to ebsMinusEh in designMode (not in r' +
          'unTime) by example, it works ! [attachment=0:3r0pfjxp]<!-- ia0 -' +
          '->editButton.zip<!-- ia0 -->[/attachment:3r0pfjxp] Thank you Ric' +
          'o'
        'Bug in editButton'
        85
        'Rico'
        40994.8244097222d
        1
        1
        0
        0)
      (
        167
        107
        'Re: Popup menu in title button to set columns visibles'
        
          'Hello Dmitry, It'#39's a good news ! I see too that is not possible ' +
          'with a popupMenu ... I wonder if you will do a new popupMenu(eh)' +
          ' or if you create an internal menu in the grid ... I say that, b' +
          'ecause I have my own menu to manage DBGridEh and I have lots of ' +
          'options like : - Print DBGrid - Preview DBGrid - Export data (ex' +
          'cel ...) - Quick filter (on right click I apply a filter with th' +
          'e cell value) - Set Line Number - Hide/Show filter - Columns (vi' +
          'sible/color) .... It should be better a new object popupMenu for' +
          ' me of course <!-- s;) --><img src="{SMILIES_PATH}/icon_e_wink.g' +
          'if" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) --> Best regards Ric' +
          'o'
        'Popup menu in title button to set columns visibles'
        85
        'Rico'
        40994.9980902778d
        0
        1
        0
        0)
      (
        168
        110
        'Re: dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        
          'Hello Mironico, Sorry, but I don'#39't speak russian, so I used goog' +
          'le translator ... It seems that you speak about my post [url:y4h' +
          '4ssuu]http&#58;//forum&#46;ehlib&#46;com/en/viewtopic&#46;php?f=' +
          '5&amp;t=109[/url:y4h4ssuu] If yes, I have uncomment the line to ' +
          'have incSearch on readOnly columns in ehlib 4.2 and now in 5.6 a' +
          'nd all work fine <!-- s:) --><img src="{SMILIES_PATH}/icon_e_smi' +
          'le.gif" alt=":)" title="'#1059#1083#1099#1073#1072#1077#1090#1089#1103'" /><!-- s:) --> (since many ye' +
          'ars) Hope Dmitry gives me an answer about this Rico'
        'dghIncSearch '#1080' dghPreferIncSearch (DBGridEh). Need help'
        85
        'Rico'
        40995.1835532407d
        0
        1
        0
        0)
      (
        169
        115
        'Re: Bug in editButton'
        'It'#39's not a bug or a known bug ?'
        'Bug in editButton'
        85
        'Rico'
        40995.879212963d
        0
        1
        0
        0)
      (
        170
        115
        'Re: Bug in editButton'
        
          'Hello Rico. I think it is not a bug. If you write EditButtonsCli' +
          'ck event it does not always mean that the grid must suppress def' +
          'ault action. For example for some records may want to execute de' +
          'fault action of the Edit button. In your case simply write next ' +
          'additional event. [code:2ssfwtpz]procedure TForm1&#46;DBGridEh1C' +
          'olumns5EditButtons0Down(Sender&#58; TObject; TopButton&#58; Bool' +
          'ean; var AutoRepeat, Handled&#58; Boolean); begin // if Want to ' +
          'suppress default action then Handled &#58;= True; end; [/code:2s' +
          'sfwtpz] Best regards Admin'
        'Bug in editButton'
        2
        'Administrator'
        40996.0481712963d
        0
        1
        0
        0)
      (
        171
        115
        'Re: Bug in editButton'
        
          'Hello Dmitry, Why it does that only with ebsDropDownEh ? In my p' +
          'roject only the editButton should be active to me, the dropDown ' +
          'botton is not be displayed with the ButtonStyle to cbsNone no ? ' +
          'In ehlib4.2 it doesnt work like that (dropDown is not actived) I' +
          ' '#39'am sure there is something, may be index 0 of dropDown button ' +
          '? To solve that, I don'#39't need to add some code, just not choose ' +
          'ebsDropDownEh ... Best Regards Rico'
        'Bug in editButton'
        85
        'Rico'
        40996.0571412037d
        0
        1
        0
        0)
      (
        10
        10
        'test'
        'test test test'
        'test'
        55
        'sinys'
        40935.7456712963d
        0
        0
        1
        0)
      (
        192
        112
        'Re: Whay not realized WideMemo in MemTableEh'
        
          'Hello We fixed the error and uploaded EhLib 5.6 Build 5.6.222. Y' +
          'ou can download it now and check. Best regards Admin'
        'Whay not realized WideMemo in MemTableEh'
        2
        'Administrator'
        40999.6565162037d
        0
        1
        0
        0)
      (
        193
        114
        'Re: XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        
          'As I understand the topic there'#39's a problem with installing eval' +
          'uation version in the latest version of Delphi XE2 (update 4, he' +
          'lp update 4). I'#39've downloaded the latest version (5.6.223) and t' +
          'ried to install it. I got the message: [quote:1235q9zf]C:\Progra' +
          'm Files (x86)\Embarcadero\RAD Studio\9.0\Bin\dcc32.exe -$Y- -$L-' +
          ' -$D- -B -JPHNE -JL -NSData.Win;Bde;Vcl;Vcl.Imaging;Data;Winapi;' +
          'System;System.Win;Datasnap EhLib160.dpk Copyright (c) 1983,2011 ' +
          'Embarcadero Technologies, Inc. EhLibConsts.pas(66) EhLibConsts.p' +
          'as(67) Fatal: F2051 Unit DBGridEh was compiled with a different ' +
          'version of EhLibConsts.SNoDataEh[/quote:1235q9zf] I'#39'd like to as' +
          'k you for the version compiled with update 4. is It possible? Ki' +
          'ndest regards, Jacek'
        'XE2 Update 4 '#1080' '#1090#1088#1080#1072#1083
        161
        'JacekH'
        41001.8248263889d
        0
        1
        0
        0)
      (
        194
        119
        'Problem with installing valuation version in Delphi XE2'
        
          'There'#39's a problem with installing evaluation version in the late' +
          'st version of Delphi XE2 (update 4, help update 4). I'#39've downloa' +
          'ded the latest version (5.6.223) and tried to install it. I got ' +
          'the message: [quote:2shqlkuq]C:\Program Files (x86)\Embarcadero\' +
          'RAD Studio\9.0\Bin\dcc32.exe -$Y- -$L- -$D- -B -JPHNE -JL -NSDat' +
          'a.Win;Bde;Vcl;Vcl.Imaging;Data;Winapi;System;System.Win;Datasnap' +
          ' EhLib160.dpk Copyright (c) 1983,2011 Embarcadero Technologies, ' +
          'Inc. EhLibConsts.pas(66) EhLibConsts.pas(67) Fatal: F2051 Unit D' +
          'BGridEh was compiled with a different version of EhLibConsts.SNo' +
          'DataEh[/quote:2shqlkuq] Kindest regards, Jacek'
        'Problem with installing valuation version in Delphi XE2'
        161
        'JacekH'
        41001.8262152778d
        0
        1
        0
        0)
      (
        195
        119
        'Re: Problem with installing valuation version in Delphi XE2'
        
          'hello Jacek It is not a problem of Studio update 4 but EhLib. Th' +
          'ere was an old version of EhLibConsts that appeared into the com' +
          'piling paths in some cases. We fixed it and uploaded EhLib 5.6 B' +
          'uild 5.6.224. You can check it now. Best regards Admin.'
        'Problem with installing valuation version in Delphi XE2'
        2
        'Administrator'
        41001.9861111111d
        0
        1
        0
        0)
      (
        196
        119
        'Re: Problem with installing valuation version in Delphi XE2'
        
          'Hi, I'#39've installed without any problem. Thank you! Now I'#39'm testi' +
          'ng demos. I can say: wow <!-- s:) --><img src="{SMILIES_PATH}/ic' +
          'on_e_smile.gif" alt=":)" title="'#1059#1083#1099#1073#1072#1077#1090#1089#1103'" /><!-- s:) --> It loo' +
          'ks really great. The look: I can skin it with Delphi XE2 themes,' +
          ' also most of the controls can be skinned with AlphaSkins. Great' +
          ', because clients want more &quot;modern&quot; look than a stand' +
          'ard Delphi grid. Features: I'#39'm using DevExpres Quantum Grid also' +
          '. But sometimes its &quot;too heavy&quot;. Although it'#39's also ve' +
          'ry powerful. I like your grid with its the functionality of grou' +
          'ping and detail panel. Looking into help I can see it uses its o' +
          'wn memory dataset. Well, I'#39'm using AnyDAC and it'#39's TADQuery clas' +
          's is a kind of combinations select/insert/delete/update commands' +
          ' with in-memory dataset. If I could use it with EhLib grid it co' +
          'uld be easier to manipulate data without copying them from the q' +
          'uery to in-memory dataset and synchronizing changes, what can be' +
          ' especially complicated in cascade master-detail scenarios. Well' +
          ', more questions soon <!-- s;) --><img src="{SMILIES_PATH}/icon_' +
          'e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) --> Now I'#39'm ' +
          'very impressed with the EhLib Grid functionality. Regards, Jacek'
        'Problem with installing valuation version in Delphi XE2'
        161
        'JacekH'
        41002.0282291667d
        0
        1
        0
        0)
      (
        197
        119
        'Re: Problem with installing valuation version in Delphi XE2'
        
          'Hello Jacek Ehlib do have its own memory dataset, but dbgrideh c' +
          'an work with any type of datasets though such features as groupi' +
          'ng works only when dbgrideh is connected to TMemTablEh as the st' +
          'andart dataset methods don'#39't allow to realize similar things wit' +
          'hout tricks. Best regards Admin'
        'Problem with installing valuation version in Delphi XE2'
        2
        'Administrator'
        41002.1209259259d
        0
        1
        0
        0)
      (
        198
        99
        'Re: Numeric format and numpad'
        
          'Hello Dmitry, Could you say me if add this code to have my decim' +
          'alSeparator with numpab in incSeach is correct ? [code:39qb63gl]' +
          'procedure TCustomDBGridEh&#46;WMChar(var Message&#58; TWMChar); ' +
          'var CharMsg&#58; TMsg; DBC&#58; Boolean; begin if (columns&#91;s' +
          'electedindex&#93;&#46;FField is TNumericField) then if ((decimal' +
          'Separator &lt;&gt; '#39'&#46;'#39') and (message&#46;CharCode = 46)) the' +
          'n message&#46;CharCode &#58;= ord(decimalSeparator); &#46;&#46;&' +
          '#46;/&#46;&#46;&#46; [/code:39qb63gl] Thank you Best regards Ric' +
          'o'
        'Numeric format and numpad'
        85
        'Rico'
        41002.6220949074d
        0
        1
        0
        0)
      (
        199
        120
        'Bug event DropDownBoxGetCellParams'
        
          'Hello Dmitry, The code below raise AV (you can test it with the ' +
          'attached project) In fact, I have exception with lookupField som' +
          'etimes, but I don'#39't found how to reproduce this and the bug in D' +
          'ropDownBox is not my real problem, it'#39's just a test, but I hope ' +
          'that this is linked .. . [code:1fdgtbm6] procedure TForm1&#46;DB' +
          'GridEh1Columns5DropDownBoxGetCellParams(Sender&#58; TObject; Col' +
          'umn&#58; TColumnEh; AFont&#58; TFont; var Background&#58; TColor' +
          '; State&#58; TGridDrawState); begin MessageDlg('#39'test'#39', mtWarning' +
          ', &#91;mbOK&#93;, 0); end; [/code:1fdgtbm6] [attachment=0:1fdgtb' +
          'm6]<!-- ia0 -->dropDownBoxGetCellParam.zip<!-- ia0 -->[/attachme' +
          'nt:1fdgtbm6] PS : My real pb raise AV in midas.dll in function T' +
          'CustomClientDataSet.BookmarkValid(Bookmark: TBookmark): Boolean;' +
          ' after dataSet.EnableControls. Best regards Rico'
        'Bug event DropDownBoxGetCellParams'
        85
        'Rico'
        41003.5517824074d
        1
        1
        0
        0)
      (
        200
        120
        'Re: Bug event DropDownBoxGetCellParams'
        
          'Hello Rico Why do you want to call MessageDlg function inside th' +
          'e event that is intended only to change parameters of the drawin' +
          'g cell? This event (GetCellParams) is called from Paint procedur' +
          'e and doesn'#39't expect any interaption in time of drawing because ' +
          'inside Painting prcedore it capture drawing resources that must ' +
          'be released after finishing painting. Such functions as MessageD' +
          'lg inside drawing process interrapt painting process without giv' +
          'ing opportunity to release drawing resources correctly. Best reg' +
          'ards Admin.'
        'Bug event DropDownBoxGetCellParams'
        2
        'Administrator'
        41003.6638657407d
        0
        1
        0
        0)
      (
        201
        121
        'Try before buy ;) and questions'
        
          'Hi, I'#39've installed evaluation version. I'#39'm just a minute before ' +
          'buying the library. I do like it but have some questions/problem' +
          's: 1. Sorting - opposite direction than the picture shows and fi' +
          'lter says <!-- s:) --><img src="{SMILIES_PATH}/icon_e_smile.gif"' +
          ' alt=":)" title="'#1059#1083#1099#1073#1072#1077#1090#1089#1103'" /><!-- s:) --> 2. Row height sizing ' +
          'changes filter row height - can they be independent? I'#39'd like to' +
          ' change the height of rows without affecting a filter row height' +
          ' 3. Custom filter localization - is it possible? 4. Record selec' +
          'ting: checkbox in indicator column cannot be changed. Editing is' +
          ' allowed, I'#39've tried with row selecting on/off. The datasource i' +
          's connected to AnyDAC TADQuery. 5. How can I use dedicated in-pl' +
          'ace editors e.g. Richedit/Memo, my own db-aware component for sp' +
          'ecified columns? 6. In mutlititle mode: is it possible to collap' +
          'se/expand columns with the same main title name? E.g. Columns: A' +
          'ddress|Street, Address|City and to collapse it for Address only ' +
          'column, then expand to show both &quot;included&quot; columns? K' +
          'indest regards, Jacek'
        'Try before buy ;) and questions'
        161
        'JacekH'
        41003.7025d
        0
        1
        0
        0)
      (
        202
        120
        'Re: Bug event DropDownBoxGetCellParams'
        
          'Hello Dmitry, As I said, it'#39's just a test, I don'#39't need do to th' +
          'is of course <!-- s;) --><img src="{SMILIES_PATH}/icon_e_wink.gi' +
          'f" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) --> I search a bug wi' +
          'th lookupField and I think that I have found the real problem th' +
          'is time ! After many hours I have found how to reproduce it (rea' +
          'lly not easy) - Exception in midas.dll - The bug is caused by th' +
          'e bookmak when AllowedSelections is [gstRecordBookmarks,gstAll] ' +
          'and dgMultiSelect = True In this case the grid save an invalid b' +
          'ookMark = '#39#39' and crash after in function TCustomClientDataSet.Bo' +
          'okmarkValid(Bookmark: TBookmark) when you open a dropDownCombo a' +
          'nd you don'#39't select item in insert mode. You can reproduce with ' +
          'this project (D7): [attachment=0:377f96dd]<!-- ia0 -->bookmark.z' +
          'ip<!-- ia0 -->[/attachment:377f96dd] Best regards Rico'
        'Bug event DropDownBoxGetCellParams'
        85
        'Rico'
        41003.7531944444d
        1
        1
        0
        0)
      (
        203
        120
        'Re: Bug event DropDownBoxGetCellParams'
        
          'Hello Dmitry, My second project it'#39's really a bug in bookmark (o' +
          'ccurs very often in my application) Thank you Best regards Rico'
        'Bug event DropDownBoxGetCellParams'
        85
        'Rico'
        41004.0249652778d
        0
        1
        0
        0)
      (
        204
        120
        'Re: Bug event DropDownBoxGetCellParams'
        
          'Hello Rico This is a quick solution of your problem. [code:1fnlk' +
          'deg]procedure TForm1&#46;DataSource1StateChange(Sender&#58; TObj' +
          'ect); begin if ClientDataSet1&#46;State = dsInsert then DBGridEh' +
          '1&#46;Options &#58;= DBGridEh1&#46;Options - &#91;dgMultiSelect&' +
          '#93; else DBGridEh1&#46;Options &#58;= DBGridEh1&#46;Options + &' +
          '#91;dgMultiSelect&#93;; end; [/code:1fnlkdeg] What about fixing ' +
          'it inside Ehlib, we will think about it as it looks like a bug i' +
          'n the TClientDataSet. It returns Nil bookmark for the new recods' +
          ' but can'#39't treat Nil bookmarks in the BookmarkValid function. Be' +
          'st regards Admin'
        'Bug event DropDownBoxGetCellParams'
        2
        'Administrator'
        41004.0892708333d
        0
        1
        0
        0)
      (
        205
        120
        'Re: Bug event DropDownBoxGetCellParams'
        
          'Thank you Dmitry, I did your solution and it works I don'#39't know ' +
          'if it can help you, but in ehlib 4.2 you don'#39't have this bug. Th' +
          'is bug is also in DelphiX2 ? Best regards Rico'
        'Bug event DropDownBoxGetCellParams'
        85
        'Rico'
        41004.5186226852d
        0
        1
        0
        0)
      (
        206
        122
        'Help : How to display the EmptyDataInfo in TDBLookupCombobox'
        
          'Hello, I want to display a product list in a TDBLookupComboboxEh' +
          ' and have &lt;All&gt; as EmptyDataInfo by example. On TDBLookupC' +
          'omboboxEh the dataSource is null and I set ListSource with my da' +
          'taSet product. EmptyDataInfo.Text := '#39'&lt;All&gt;'#39'; My problems ' +
          ': - On open comboBox the first line is blank (it should be &lt;A' +
          'll&gt; no ?) - &lt;All&gt; is displayed only when TDBLookupCombo' +
          'boxEh hasn'#39't the focus - I don'#39't know Where specified value to e' +
          'mptyValue Thank you Best regards Rico'
        'Help : How to display the EmptyDataInfo in TDBLookupCombobox'
        85
        'Rico'
        41004.8088310185d
        0
        1
        0
        0)
      (
        207
        122
        'Re: Help : How to display the EmptyDataInfo in TDBLookupComb'
        
          '[quote=&quot;Rico&quot;:cv5zrw3u]- On open comboBox the first li' +
          'ne is blank (it should be &lt;All&gt; no ?) [/quote:cv5zrw3u] NO' +
          '. Property &quot;EmptyDataInfo&quot; not intended for replace em' +
          'ptyValue in lists. Only to indicate that the field is blank or i' +
          'ndicate for which this is a field where it isNull. [quote=&quot;' +
          'Rico&quot;:cv5zrw3u]&lt;All&gt; is displayed only when TDBLookup' +
          'ComboboxEh hasn'#39't the focus[/quote:cv5zrw3u] It'#39's ok, so conceiv' +
          'ed. But, if you want, we add property for save EmptyDataInfo.Tex' +
          't when component is focused, but this does'#39't mean what EmptyData' +
          'Info.Text will be located in ListSource or PickList. And if Empt' +
          'yDataInfo.Text = '#39'&lt;All&gt;'#39' and DBLookupComboboxEh1.KeyValue ' +
          '= Null you will see '#39'&lt;All&gt;'#39' on component, but DBLookupComb' +
          'oboxEh1.Text &lt;&gt; '#39'&lt;All&gt;'#39'.'
        'Help : How to display the EmptyDataInfo in TDBLookupCombobox'
        55
        'sinys'
        41004.8726273148d
        0
        1
        1
        0)
      (
        208
        122
        'Re: Help : How to display the EmptyDataInfo in TDBLookupComb'
        
          'Hello Rico Check properties of TDBLookupComboboxEh.DropDownBox.S' +
          'pecRow DropDownBox.SpecRow.CellsText = '#39'(All)'#39' DropDownBox.SpecR' +
          'ow.Visible = True'
        'Help : How to display the EmptyDataInfo in TDBLookupCombobox'
        2
        'Administrator'
        41004.9590625d
        0
        1
        0
        0)
      (
        209
        122
        'Re: Help : How to display the EmptyDataInfo in TDBLookupComb'
        'Thank you Dmitry &amp; sinys !'
        'Help : How to display the EmptyDataInfo in TDBLookupCombobox'
        85
        'Rico'
        41004.9667476852d
        0
        1
        0
        0)
      (
        210
        121
        'Re: Try before buy ;) and questions'
        
          'Hello Jacek I sent answers to private email and repeats them her' +
          'e. [quote:3awhgrqo]1. Sorting - opposite direction than the pict' +
          'ure shows and filter says [/quote:3awhgrqo] We will make this po' +
          'ssibility customizable at one of the next versions. I think you ' +
          'will add global property that will define what type of sorting (' +
          'ascending or descending) means every type of sorting marker. [qu' +
          'ote:3awhgrqo]2. Row height sizing changes filter row height - ca' +
          'n they be independent? I'#39'd like to change the height of rows wit' +
          'hout affecting a filter row height [/quote:3awhgrqo] Not in this' +
          ' version. But we added this wish as feature for the new versions' +
          '. [quote:3awhgrqo]3. Custom filter localization - is it possible' +
          '?[/quote:3awhgrqo] Yes. There are resources files into the EhLib' +
          '\LangResources\ directory for various Languages [quote:3awhgrqo]' +
          '4. Record selecting: checkbox in indicator column cannot be chan' +
          'ged. Editing is allowed, I'#39've tried with row selecting on/off. T' +
          'he datasource is connected to AnyDAC TADQuery. [/quote:3awhgrqo]' +
          ' Check if dgMultiSelect is in Options property and gstRecordBook' +
          'marks in AllowedSelections. [quote:3awhgrqo]5. How can I use ded' +
          'icated in-place editors e.g. Richedit/Memo, my own db-aware comp' +
          'onent for specified columns? [/quote:3awhgrqo] There is no speci' +
          'al facilities to do it. But I think there is a code to realize i' +
          't. [quote:3awhgrqo]6. In mutlititle mode: is it possible to coll' +
          'apse/expand columns with the same main title name? E.g. Columns:' +
          ' Address|Street, Address|City and to collapse it for Address onl' +
          'y column, then expand to show both &quot;included&quot; columns?' +
          ' [/quote:3awhgrqo] Unfortunately DBGridEh doesn'#39't support such a' +
          ' thing. Best regards Admin'
        'Try before buy ;) and questions'
        2
        'Administrator'
        41013.7081828704d
        0
        1
        0
        0)
      (
        211
        121
        'Re: Try before buy ;) and questions'
        
          'Thank you for the reply. I'#39'd like to apologize for no answer to ' +
          'your email. Since I'#39'm finishing a big project I had little time ' +
          'to do it <!-- s:( --><img src="{SMILIES_PATH}/icon_e_sad.gif" al' +
          't=":(" title="'#1043#1088#1091#1089#1090#1085#1099#1081'" /><!-- s:( --> Soon I'#39'm starting a new p' +
          'roject and plan to build it with your grid. It looks that it can' +
          ' do almost everything I need from a db grid. The only functional' +
          'ity I have to solve is using Memo and Rich Edit as in-place edit' +
          'ors. Other problems you answered I'#39've already tested - thank you' +
          ' once again. I have to say that I really like your idea with a d' +
          'etail panel. It allows me to use customized editors and actions ' +
          'beside detail-grid. This is what I haven'#39't found in other grids ' +
          'I use (TMS, DevEx, standard DB Grid). I like your grid can be pa' +
          'inted using new Delphi XE2 styles (again: it doesn'#39't work for De' +
          'vEx or TMS). Since I'#39'm using Trial version without sources I hav' +
          'e no idea about grouping in the grid without included in-memory ' +
          'dataset. I'#39'm building all my db applications with AnyDAC. AnyDAC' +
          ' supports cursor cloning and I think it can a be used for local ' +
          'grouping. Well, we'#39'll see soon... <!-- s;) --><img src="{SMILIES' +
          '_PATH}/icon_e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) ' +
          '--> Kindest regards, Jacek'
        'Try before buy ;) and questions'
        161
        'JacekH'
        41013.765d
        0
        1
        0
        0)
      (
        212
        123
        'BUG in sumList with Calculated fields in MemTable'
        
          'Hello Dmitry, The footers don'#39't work anymore with ehlib 5.6.220 ' +
          'with calculated fields in memTable Project belows to see the pro' +
          'blem The same project works with ehlib 4.2 PS : Could you do a c' +
          'hange log on each build in this forum ? (I know that I don'#39't use' +
          ' the last build, but I don'#39't know what you have fixed since 3 or' +
          ' 4 builds) Thank you [attachment=0:rubn6q3r]<!-- ia0 -->sumList.' +
          'zip<!-- ia0 -->[/attachment:rubn6q3r] Best regards Rico'
        'BUG in sumList with Calculated fields in MemTable'
        85
        'Rico'
        41015.7884606481d
        1
        0
        0
        0)
      (
        213
        123
        'Re: BUG in sumList with Calculated fields in MemTable'
        
          'Is it the same bug here ? [url:1da2ctp1]http&#58;//forum&#46;ehl' +
          'ib&#46;com/ru/viewtopic&#46;php?f=4&amp;t=143[/url:1da2ctp1] Sor' +
          'ry, But I don'#39't speak russian <!-- s:D --><img src="{SMILIES_PAT' +
          'H}/icon_e_biggrin.gif" alt=":D" title="'#1054#1095#1077#1085#1100' '#1076#1086#1074#1086#1083#1077#1085'" /><!-- s:D' +
          ' --> I have downloaded the last version and the the bug still ex' +
          'ists ! The last build on ehlib.com is EhLib 5,6 build 5.6.224, w' +
          'here can I find EhLib 5,6 build 5.6.227 ?'
        'BUG in sumList with Calculated fields in MemTable'
        85
        'Rico'
        41015.9905902778d
        0
        1
        0
        0)
      (
        214
        123
        'Re: BUG in sumList with Calculated fields in MemTable'
        
          'Hello Rico Just uploaded EhLib 5,6 build 5.6.227 for the other u' +
          'sers. You can download it now. Best regards Admin'
        'BUG in sumList with Calculated fields in MemTable'
        2
        'Administrator'
        41016.0638888889d
        0
        1
        0
        0)
      (
        215
        123
        'Re: BUG in sumList with Calculated fields in MemTable'
        
          'Sorry, but the version is still EhLib 5,6 build 5.6.224 on ehlib' +
          '.com'
        'BUG in sumList with Calculated fields in MemTable'
        85
        'Rico'
        41016.1329861111d
        0
        1
        0
        0)
      (
        216
        124
        'test'
        '[color=#0040FF:33e5602l]test[/color:33e5602l]'
        'test'
        163
        'arnikos'
        41022.0106597222d
        0
        1
        0
        0)
      (
        217
        125
        'Help : Probem in grid with message in event validate'
        
          'Hello Dmitry, My problem : In my project, when I add a product i' +
          'n the grid, I want to ask my customers if they want to cancel th' +
          'e operation when the product still exists in the grid. So, in th' +
          'e event clientDataSet.validate I put a MessageDlg to ask them. T' +
          'he problem is that all rows display the input value and I don'#39't ' +
          'see how to avoid this ...(cds.disableControls doesn'#39't work) Proj' +
          'ect belows to see the problem [attachment=0:3h6mzvkx]<!-- ia0 --' +
          '>enableCtrl.zip<!-- ia0 -->[/attachment:3h6mzvkx] Thank you Best' +
          ' regards Rico'
        'Help : Probem in grid with message in event validate'
        85
        'Rico'
        41025.8601157407d
        1
        1
        0
        0)
      (
        218
        125
        'Re: Help : Probem in grid with message in event validate'
        
          'Hello Rico it is not the problem of the GridEh, the problem occu' +
          'rs in a TDBGrid too. According to the Delphi help OnValidate wan' +
          'ts the exception to be raised if any error happens in the time o' +
          'f writing the field value. If you want to check data when user e' +
          'nters a value in the DBGridEh use TCOlumnEh.UpdateData event to ' +
          'check and show information. For example like this: [code:21zzp7f' +
          '7]procedure TForm1&#46;DBGridEh1Columns0UpdateData(Sender&#58; T' +
          'Object; var Text&#58; String; var Value&#58; Variant; var UseTex' +
          't, Handled&#58; Boolean); begin if MessageDlg('#39'Is text &quot;'#39'+T' +
          'ext+'#39'&quot; correct?'#39', mtWarning, &#91;mbYes, mbNo&#93;, 0) &lt;' +
          '&gt; mrYes then Abort; end; [/code:21zzp7f7] Best regards Admin'
        'Help : Probem in grid with message in event validate'
        2
        'Administrator'
        41025.9823611111d
        0
        1
        0
        0)
      (
        219
        126
        'STFilter does not filter ?!'
        
          'Hi, I'#39'm just getting stuck with the STFilter. It is not filterin' +
          'g the treeview like it does in the treeview demo. The grid shows' +
          ' the data in treeview mode in addition I can choose a filter at ' +
          'the top line. After applying the filter nothing happens with the' +
          ' data in the grid (it is not filtered). [attachment=0:27b08qdh]<' +
          '!-- ia0 -->STFilter.JPG<!-- ia0 -->[/attachment:27b08qdh] The Me' +
          'mtable is bound to an AdoDatadriver with an ordinary sql select ' +
          'statement inside (Select * from #btemp) (I don'#39't need to change ' +
          'the data in the grid) So what'#39's the clue ? brgds, Dimo'
        'STFilter does not filter ?!'
        164
        'Dimo73'
        41026.980625d
        1
        1
        0
        0)
      (
        220
        126
        'Re: STFilter does not filter ?!'
        
          'Hello Dimo Set DBGridEh.STFilter.Local=True and add EhLibMTE to ' +
          #39'uses'#39' clause of any unit of your project. Read more info about ' +
          'sorting and filtering data in the DataSet Using DBGridEh in the ' +
          '&quot;EhLib users guide.doc&quot;. Best regards Admin'
        'STFilter does not filter ?!'
        2
        'Administrator'
        41027.0692476852d
        0
        1
        0
        0)
      (
        80
        73
        'hello'
        'hello'
        'hello'
        128
        'endannabelt'
        40958.3627546296d
        0
        1
        0
        0)
      (
        221
        127
        'Print Preview'
        
          'Hi, I'#39'm just getting two errors while using Ehlib with Delphi 5 ' +
          'Enterprise in my own project and in your demo1: -&gt; Pressing &' +
          'quot;Preview&quot; in the demo1 gives the exception: [attachment' +
          '=1:5tj8f10s]<!-- ia1 -->PrintPreview.JPG<!-- ia1 -->[/attachment' +
          ':5tj8f10s] Means something like: error while reading from tbNext' +
          'Page.Hint: invalid property value -&gt; Pressing Printer Setup i' +
          'n &quot;Inplace preview&quot; throws the following exception: [c' +
          'ode:5tj8f10s]if PrintDBGridEh1&#46;PrinterSetupDialog then Print' +
          'DBGridEh1&#46;PrintTo(PreviewBox1&#46;Printer);[/code:5tj8f10s] ' +
          '[attachment=0:5tj8f10s]<!-- ia0 -->InPreviewPrinterSetup.JPG<!--' +
          ' ia0 -->[/attachment:5tj8f10s] Means something like: error while' +
          ' reading from rgFitingType.Items.Strings: invalid property value' +
          ' I have the same messages when I use it in my Delphi 5 project. ' +
          'Also I tried it in Delphi 2009 which worked [color=#FF0000:5tj8f' +
          '10s]without[/color:5tj8f10s] errors ?! brgds, Dimo'
        'Print Preview'
        164
        'Dimo73'
        41028.8208101852d
        1
        0
        0
        0)
      (
        222
        127
        'Re: Print Preview'
        
          'Hello Dimo Check if it because of German Language Resources. The' +
          'se are Dfm files that users send us to use it as a Language Reso' +
          'urces. Try to reinstall the Library and select &quot;English&quo' +
          't; in the &quot;Language resourses'#39' edit when EhLibInstaller.exe' +
          ' is executed. Best regards Admin.'
        'Print Preview'
        2
        'Administrator'
        41031.0964930556d
        0
        1
        0
        0)
      (
        223
        127
        'Re: Print Preview'
        
          'That worked ! Great <!-- s;-) --><img src="{SMILIES_PATH}/icon_e' +
          '_wink.gif" alt=";-)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;-) --> Many th' +
          'anks ! brgds, Dimo.'
        'Print Preview'
        164
        'Dimo73'
        41031.6503356481d
        0
        1
        0
        1)
      (
        224
        128
        'column.editing = false and allowedSelection'
        
          'Hello Dmitry, Why I can copy the cell text when column.editing =' +
          ' false ? If I copy the text with ctrl+c, the column title and al' +
          'l data record are copied... why don'#39't have the same selection as' +
          ' readOnly = True ? Best regards Rico'
        'column.editing = false and allowedSelection'
        85
        'Rico'
        41032.1491550926d
        0
        1
        0
        1)
      (
        225
        128
        'Re: column.editing = false and allowedSelection'
        
          'Hello Rico '#1057'ounterquestion, why column.editing = false must prev' +
          'ent copy operation? In your internet browser you can select this' +
          ' text (or any at all) and copy it, but you can'#39't edit this text.' +
          ' Best regards Admin'
        'column.editing = false and allowedSelection'
        2
        'Administrator'
        41035.1787152778d
        0
        1
        0
        1)
      (
        226
        128
        'Re: column.editing = false and allowedSelection'
        
          'Hello Dmitry, Sorry !!!! I just see, that I have do a mistake in' +
          ' my first question ... My question is in fact : Why I [b:27rnqyy' +
          'a][color=#FF0000:27rnqyya]can'#39't[/color:27rnqyya][/b:27rnqyya] co' +
          'py the cell text when column.editing = false ? When column.editi' +
          'ng = false, there is no popup menu on the cell to copy text and ' +
          'when I use ctrl+c, the copied datas are not correct ... Best reg' +
          'ards Rico'
        'column.editing = false and allowedSelection'
        85
        'Rico'
        41035.9026736111d
        0
        1
        0
        0)
      (
        227
        129
        'Whole group selection when DataGrouping'
        
          'Hi. I have the following situation: i am using a DBGridEh with d' +
          'ata grouping and for the IndicatorOptions property group i only ' +
          'use gioShowRowselCheckboxesEh. My problem is when i select (chec' +
          'k) a data group row the first child row (data row) of the group ' +
          'is selected (checked). When i check the group title row i want t' +
          'o check all the child rows of that group. I am developing an app' +
          ' with a grid on the left and another on the right. I want to sel' +
          'ect some rows from the left grid and drag them over the grid in ' +
          'the right. The data in the grid on the left is grouped by certai' +
          'n criterions. I can drag rows from the grid on the left to the o' +
          'ne on the right but I want to also drag a whole group at once. I' +
          's it possible?'
        'Whole group selection when DataGrouping'
        167
        'msotirca'
        41036.7301388889d
        0
        1
        0
        0)
      (
        228
        128
        'Re: column.editing = false and allowedSelection'
        
          'Hello Rico. I have checked it. I set geaCopyEh in EditActions, C' +
          'olumns[0].TextEditing = False and started simple application. I ' +
          'set focus to a grid, first column and pressed ctrl+c. I opened n' +
          'otepad and pressed ctrl+v. The only value of the copied cell was' +
          ' pasted, as expected. Best regards Admin.'
        'column.editing = false and allowedSelection'
        2
        'Administrator'
        41037.17125d
        0
        1
        0
        1)
      (
        229
        128
        'Re: column.editing = false and allowedSelection'
        
          'Hello Dmitry, I think to have found where is the problem Add dgM' +
          'ultiSelect in dbGrid options and retry your test <!-- s;) --><im' +
          'g src="{SMILIES_PATH}/icon_e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072 +
          #1077#1090'" /><!-- s;) --> Best regards Rico'
        'column.editing = false and allowedSelection'
        85
        'Rico'
        41037.2295949074d
        0
        1
        0
        1)
      (
        230
        128
        'Re: column.editing = false and allowedSelection'
        
          'Helo Rico Nothing changed. It still works as with dgMultiSelect ' +
          'as without dgMultiSelect. It would be better if you create demo ' +
          'porject and send it to the forum or to <!-- e --><a href="mailto' +
          ':support@ehlib.com">support@ehlib.com</a><!-- e --> Best regards' +
          ' Admin'
        'column.editing = false and allowedSelection'
        2
        'Administrator'
        41038.1144675926d
        0
        1
        0
        0)
      (
        55
        38
        'Re: Bug in MEMTABLE with TreeView'
        
          'Hello, Thank for your answer. Have you plan to fix this in the n' +
          'ext release ? Could you say me witch event I can use to do this ' +
          'check ? you plan to add events ? Best regards Rico'
        'Bug in MEMTABLE with TreeView'
        85
        'Rico'
        40953.544837963d
        0
        1
        0
        0)
      (
        56
        51
        'Problem with Treeview in DBGridEh'
        
          'Hello! The problem looks like: 1.There is a query from the datab' +
          'ase, for example, house number, street name and name of resident' +
          ' 2. Data is grouped by street name and house number. if the quer' +
          'y is executed when the application loads, the grouping is workin' +
          'g right, but if i expand and collapse all the nodes, part of the' +
          ' records as if disappearing, but are available. If i expand all ' +
          'the nodes to the bottom and use mouse scrolling then plus 1 or 4' +
          ' nodes are available. I click on dbgrideh &quot;+&quot; for the ' +
          'disclosure of the node and another node became visible. I hope y' +
          'ou understand me. Is it a bug of Memtable? Thank You.'
        'Problem with Treeview in DBGridEh'
        70
        'kast2k'
        40954.3665856481d
        0
        1
        0
        0)
      (
        57
        51
        'Re: Problem with Treeview in DBGridEh'
        'Hello, Have you set memtable.FetchAllOnOpen := True; ?'
        'Problem with Treeview in DBGridEh'
        85
        'Rico'
        40954.496875d
        0
        1
        0
        0)
      (
        58
        51
        'Re: Problem with Treeview in DBGridEh'
        
          'No. And that'#39's the problem! Thank You very much! <!-- s;) --><im' +
          'g src="{SMILIES_PATH}/icon_e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072 +
          #1077#1090'" /><!-- s;) --> Now it works normal <!-- s:) --><img src="{SM' +
          'ILIES_PATH}/icon_e_smile.gif" alt=":)" title="'#1059#1083#1099#1073#1072#1077#1090#1089#1103'" /><!-- ' +
          's:) -->'
        'Problem with Treeview in DBGridEh'
        70
        'kast2k'
        40954.5795949074d
        0
        1
        0
        0)
      (
        133
        104
        'Bug with Params.ReadOnly in event OngetCellParams'
        
          'Hello Dmitry, Test do with last build 5.6.219 The project change' +
          ' the value 1 by '#39'One'#39' in the event onGetCellParams and set Param' +
          's.ReadOnly := True when value = 1 The cells aren'#39't readOnly when' +
          ' value = 1 and for the others values the cells are readOnly afte' +
          'r input one character. PS : Have you something like mantis to se' +
          'e changes in source code and the comments ? I must compare each ' +
          'unit to see what'#39's new in the last build and it'#39's not usefull. B' +
          'est regards Rico [attachment=0:2ldxch7g]<!-- ia0 -->readOnlyCell' +
          'Param.zip<!-- ia0 -->[/attachment:2ldxch7g]'
        'Bug with Params.ReadOnly in event OngetCellParams'
        85
        'Rico'
        40983.5703356481d
        1
        1
        0
        0)
      (
        134
        103
        'Re: '#1055#1088#1080#1084#1077#1088' '#1087#1086' DataGrouping '#1074' RunTime'
        #1058#1086' '#1095#1090#1086' '#1085#1091#1078#1085#1086', '#1089#1087#1072#1089#1080#1073'...'
        #1055#1088#1080#1084#1077#1088' '#1087#1086' DataGrouping '#1074' RunTime'
        153
        'someuser'
        40983.8118287037d
        0
        1
        0
        0)
      (
        135
        104
        'Re: Bug with Params.ReadOnly in event OngetCellParams'
        
          'Hello Rico. Fixed it in the Build 5.6.220. I had a look on manti' +
          's. It looks usefull for developers team but IMHO not much of use' +
          'full for end-user of the sofware library. Best regards Admin'
        'Bug with Params.ReadOnly in event OngetCellParams'
        2
        'Administrator'
        40984.4657407407d
        0
        0
        0
        0)
      (
        136
        95
        'Re: Color of STFilter'
        
          'Done in the build 5.6.218 (OnGetSubtitleRowColor event in the TD' +
          'BGridEhStyle class)'
        'Color of STFilter'
        85
        'Rico'
        40984.5008449074d
        0
        1
        0
        0)
      (
        139
        101
        'Re: NULL values in TColumnEh.KeyList'
        
          'Hello Alexandr You forget to point the most important informatio' +
          'n. What type of error occurs? Try to use TColumnEh.UpdateData ev' +
          'ent as follows [code:boo0otsx]procedure TForm1&#46;DBGridEh1Colu' +
          'mns6UpdateData(Sender&#58; TObject; var Text&#58; String; var Va' +
          'lue&#58; Variant; var UseText, Handled&#58; Boolean); begin if T' +
          'ext = '#39#39' then begin Value &#58;= Null; UseText &#58;= False; end' +
          '; end; [/code:boo0otsx] Best regards Admin'
        'NULL values in TColumnEh.KeyList'
        2
        'Administrator'
        40985.0755324074d
        0
        1
        0
        0)
      (
        140
        105
        'Autosum field doesnt work properly ?'
        
          'Hello. I have an Grid on which footer having autosum field. The ' +
          'dataSource is MemTableEh object. when i copy data from IBQuery t' +
          'o this MemTableEh object with the function &quot;LoadFromDataSet' +
          '( ibQuery1, -1, lmCopy, false )&quot; the autosum stop working. ' +
          'Please help.'
        'Autosum field doesnt work properly ?'
        154
        'baihui'
        40986.0656944444d
        0
        1
        0
        0)
      (
        138
        99
        'Re: Numeric format and numpad'
        
          'Hello Dmitry, The incremental seach works with this piece of cod' +
          'e in procedure TCustomDBGridEh.WMChar(var Message: TWMChar); if ' +
          '((decimalSeparator = '#39','#39') and (message.CharCode = 46)) then begi' +
          'n if ((columns[selectedindex].FField.DataType=ftFloat)or (column' +
          's[selectedindex].FField.DataType=ftCurrency)or (columns[selected' +
          'index].FField.DataType=ftBCD)or (columns[selectedindex].FField.D' +
          'ataType=ftFMTBcd)) then message.CharCode := ord('#39','#39') else messag' +
          'e.CharCode := ord('#39'.'#39'); end; I don'#39't like add code in your libra' +
          'ry and I am sure you have better to propose <!-- s;) --><img src' +
          '="{SMILIES_PATH}/icon_e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /' +
          '><!-- s;) --> Thank you Best regards Rico'
        'Numeric format and numpad'
        85
        'Rico'
        40984.8508796296d
        0
        1
        0
        0)
      (
        53
        38
        'Re: Bug in MEMTABLE with TreeView'
        
          'Hello, You are right. All data are lost in a changing record. It' +
          ' is little hard to keep changing values in a changing record whe' +
          'n a tree node collapses or expandes, but we can check if there w' +
          'as any changes in the record and Post data on collapses or expan' +
          'des of a tree node. I think this behavior is more correct. Best ' +
          'regards Administrator'
        'Bug in MEMTABLE with TreeView'
        2
        'Administrator'
        40952.9478587963d
        0
        1
        0
        0)
      (
        60
        53
        'EhLib 5.6 is available for download.'
        
          'Dear Developers, We are glad to announce the new version (5.6) o' +
          'f EhLib software. In this version: * Fixed handling of the globa' +
          'l variable OldStyleFlatBorder. In previous versions, if OldStyle' +
          'FlatBorder = False (default value is False), then if TDBEditEh.F' +
          'lat = True then drawing boundaries of TDBEditEh in Flat style ne' +
          'ver worked. In this version, if OldStyleFlatBorder = False then ' +
          'drawing boundaries of TDBEditEh in Flat style will work when the' +
          ' Windwos is in the Classic style and drawing Flat border will no' +
          't work when the Windwos is in Themed environments and applicatio' +
          'n use Themes. + Added a Images property in the class TEditButton' +
          'Eh (TDBEditEh.EditButtons[i].Images) of a TEditButtonImagesE typ' +
          'e. TEditButtonImagesEh = class(TPersistent) published property N' +
          'ormalImages: TCustomImageList; property HotImages: TCustomImageL' +
          'ist; property PressedImages: TCustomImageList; property Disabled' +
          'Images: TCustomImageList; property NormalIndex: Integer; propert' +
          'y HotIndex: Integer; property PressedIndex: Integer; property Di' +
          'sabledIndex: Integer; end; Now it is allowed to draw Images from' +
          ' ImageList in EditButtons of Edit controls and columns of TDBGri' +
          'dEh. Images are drawn when TEditButtonEh.Style = ebsGlyphEh and ' +
          'TDBEditEh.EditButtons[i].Images.NormalImages is assigned. + Adde' +
          'd EmptyDataInfo property in DBGridEh. If this property is enable' +
          'd and DataSet is Active and it contains no data, then DBGridEh d' +
          'raws &lt;No data&gt; text in the center of the client area. You ' +
          'can specify the inscription for each DBGrid or set a global vari' +
          'able DBGridEhEmptyDataInfoText that is located in the module DBG' +
          'ridEh. + Added EmptyDataInfo property in the TDBEditEh, TDBNumbe' +
          'rEditEh, TDBComboBoxEh, TDBLookupComboBoxEh. Use TDBEditEh.Empty' +
          'DataInfo.Text property to display the text that will be displaye' +
          'd in the Edit control when it contains no data. + Added standart' +
          ' property Touch (supported in Delphi 2010 and higher) for DBGrid' +
          'Eh, TDBEditEh, TDBNumberEditEh, TDBComboBoxEh, TDBLookupComboBox' +
          'Eh, TDBDateTimeEditEh. + Added the ability in design-time to ope' +
          'n the Edit buttons collection editor (EditButtons) in TDBEditEh,' +
          ' TDBNumberEditEh, TDBComboBoxEh, TDBLookupComboBoxEh, TDBDateTim' +
          'eEditEh controls. A menu item to open the collection is in the c' +
          'ontext menu of the component that opens on the right mouse butto' +
          'n. + In TDBCheckBoxEh added the ability to set Empty value ('#39#39') ' +
          'for properties ValueChecked, ValueUnchecked. This allows you to ' +
          'set the state of CheckBox for Null value of DB field. + In DBGri' +
          'dEh added OnDataGroupGetRowParams event. The event is used to cu' +
          'stomize information for group records (when Grid works in data g' +
          'rouping mode - Grid.DataGrouping.Active = True). In the event yo' +
          'u can specify color, font, text and pictures for the group row. ' +
          '+ in the module DBGridEhImpExp added a global procedure - Export' +
          'DBGridEhToOleExcel. The procedure is designed to export data fro' +
          'm DBGridEh to MS Excel. The procedure uses OLE to export data wh' +
          'ich means the MS Excel must be installed on the computer to allo' +
          'w this procedure work. + At design-time a context menu of TDBGri' +
          'dEh component displays information about the version of the libr' +
          'ary. + Added global procedure - DrawProgressBarEh. The procedure' +
          ' allows you to draw a picture in the form of a progress bar (Pro' +
          'gressBar). It can be used to display progress bar in grid cells.' +
          ' See example of use in the DEMOS\DEMO1 project. Best regards: Dm' +
          'itry V. Bolshakov Home page: <!-- m --><a class="postlink" href=' +
          '"http://www.ehlib.com">http://www.ehlib.com</a><!-- m --> E-mail' +
          ': <!-- e --><a href="mailto:support@ehlib.com">support@ehlib.com' +
          '</a><!-- e -->'
        'EhLib 5.6 is available for download.'
        2
        'Administrator'
        40954.9778587963d
        0
        1
        0
        0)
      (
        132
        103
        'Re: '#1055#1088#1080#1084#1077#1088' '#1087#1086' DataGrouping '#1074' RunTime'
        
          '[code:281wq6b0] DBGridEh_Univ&#46;DataGrouping&#46;Active &#58;=' +
          ' False; DBGridEh_Univ&#46;DataGrouping&#46;GroupLevels&#46;Clear' +
          '; DBGridEh_Univ&#46;DataGrouping&#46;GroupLevels&#46;Add&#46;Col' +
          'umn &#58;= DBGridEh_Univ&#46;FindFieldColumn('#39'x1'#39'); DBGridEh_Uni' +
          'v&#46;DataGrouping&#46;GroupLevels&#46;Add&#46;Column &#58;= DBG' +
          'ridEh_Univ&#46;FindFieldColumn('#39'x2'#39'); DBGridEh_Univ&#46;DataGrou' +
          'ping&#46;GroupLevels&#46;Add&#46;Column &#58;= DBGridEh_Univ&#46' +
          ';FindFieldColumn('#39'x3'#39'); DBGridEh_Univ&#46;DataGrouping&#46;Activ' +
          'e &#58;= True;[/code:281wq6b0]'
        #1055#1088#1080#1084#1077#1088' '#1087#1086' DataGrouping '#1074' RunTime'
        55
        'sinys'
        40983.4953125d
        0
        1
        0
        0)
      (
        128
        102
        'Bug on getCellParam'
        
          'Hello Dmitry, Test do with last build 5.6.217 The project change' +
          ' the value 1 by '#39'One'#39' in the event onGetCellParam With ehlib 4.2' +
          ' it works, with 5.6 I don'#39't understand what appends ! Thank you ' +
          'to see this problem Best regards Rico [attachment=0:2gurgjwy]<!-' +
          '- ia0 -->getCellParam.zip<!-- ia0 -->[/attachment:2gurgjwy]'
        'Bug on getCellParam'
        85
        'Rico'
        40982.8928356481d
        1
        1
        0
        0)
      (
        129
        102
        'Re: Bug on getCellParam'
        
          'Hello Rico. It is a bug. We fixed it in the build 5.6.219. Best ' +
          'regards Administrator'
        'Bug on getCellParam'
        2
        'Administrator'
        40982.9830555556d
        0
        1
        0
        0)
      (
        130
        102
        'Re: Bug on getCellParam'
        
          'Thank you Dmitry, Have you include the colored filters in 5.6.21' +
          '9 ? Rico'
        'Bug on getCellParam'
        85
        'Rico'
        40982.9899884259d
        0
        1
        0
        0)
      (
        131
        103
        #1055#1088#1080#1084#1077#1088' '#1087#1086' DataGrouping '#1074' RunTime'
        
          #1047#1076#1088#1072#1074#1089#1090#1074#1091#1081#1090#1077'! '#1048#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1089#1083#1077#1076#1091#1102#1097#1072#1103' '#1089#1093#1077#1084#1072' '#1044#1072#1090#1072#1089#1077#1090' TMemTableEh -&' +
          'gt; '#1044#1072#1090#1072#1089#1086#1088#1089' TDataSource -&gt; '#1043#1088#1080#1076' TDBGridEh '#1042' RunTime, '#1074' '#1076#1072#1090#1072#1089 +
          #1077#1090#1077' '#1089#1086#1079#1076#1072#1077#1090#1089#1103' '#1089#1090#1088#1091#1082#1090#1091#1088#1072' '#1087#1086#1083#1077#1081' '#1080' '#1079#1072#1087#1086#1083#1085#1103#1077#1090#1089#1103' '#1076#1072#1085#1085#1099#1084#1080', '#1076#1072#1083#1077#1077' '#1087#1099#1090#1072#1102 +
          #1089#1100' '#1088#1077#1072#1083#1080#1079#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1091' '#1087#1086' '#1086#1076#1085#1086#1084#1091' '#1080#1079' '#1087#1086#1083#1077#1081' '#1080#1089#1087#1086#1083#1100#1079#1091#1102#1103' DataGro' +
          'uping... '#1055#1088#1086#1096#1091' '#1087#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1073#1086#1083#1100#1096#1086#1081' '#1087#1088#1080#1084#1077#1088' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' DataGrou' +
          'ping '#1074' RunTime '#1088#1077#1078#1080#1084#1077', '#1090'.'#1077'. '#1087#1088#1086#1075#1088#1072#1084#1085#1086' '#1089#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1091' '#1087#1086' '#1086#1076#1085 +
          #1086#1084#1091' '#1080#1079' '#1089#1090#1086#1083#1073#1094#1086#1074'... '#1047#1072#1088#1072#1085#1077#1077' '#1089#1087#1072#1089#1080#1073#1086
        #1055#1088#1080#1084#1077#1088' '#1087#1086' DataGrouping '#1074' RunTime'
        153
        'someuser'
        40983.285462963d
        0
        1
        0
        0)
      (
        41
        38
        'Bug in MEMTABLE with TreeView'
        
          'Hello, When collapse or expand a treeView, the data are lost if ' +
          'you don'#39't change record. To reproduce this, take TreeViewGrild i' +
          'n the demo project (project1.exe) (<!-- m --><a class="postlink"' +
          ' href="http://ehlib.com/ehlibdemo_rar.exe">http://ehlib.com/ehli' +
          'bdemo_rar.exe</a><!-- m -->) Change CHILD1 ID 4 by 5 (stay on th' +
          'e record) and then collapse ROOT2 by exemple and you can see tha' +
          't CHILD1 value is 4 Thank You'
        'Bug in MEMTABLE with TreeView'
        85
        'Rico'
        40949.6024189815d
        0
        1
        0
        1)
      (
        42
        39
        'Test'
        'Test'
        'Test'
        85
        'Rico'
        40949.7060185185d
        0
        1
        0
        1)
      (
        141
        106
        'cross tab - pivot grid'
        'is it possible to display data as in the attached file?'
        'cross tab - pivot grid'
        64
        'ahmedltayib'
        40986.8549652778d
        1
        1
        0
        0)
      (
        142
        107
        'Popup menu in title button to set columns visibles'
        
          'Hello, Is it possible to don'#39't close the global popup menu when ' +
          'a column is selected ? When you parameter the grid'#39's columns it'#39 +
          's not usefull to right click -&gt; select menu &quot;visible col' +
          'omn&quot; -&gt; select column for each column ! In some grids I ' +
          'have 30 columns and it'#39's very annoying. Thank you Rico'
        'Popup menu in title button to set columns visibles'
        85
        'Rico'
        40987.708587963d
        0
        1
        0
        0)
      (
        143
        108
        'Lookup fields not nullables'
        
          'Hello, Could you say me how to have a lookup field not nullable ' +
          'in a DBGridEh ? I want that my users choose values in lookup com' +
          'bo, but I don'#39't want they by able to clear the field by pressing' +
          ' Del or BackSpace keys (I have a null value in my DataBase after' +
          '). Why the TColumnEh..OnNotInList event is not execute on null v' +
          'alue ? I can use the event KeyDown on the dbGrid, but it'#39's not u' +
          'sefull ... @Dmitry : Have you plan something to have this featur' +
          'e ? (a property on colums like '#39'Nullable'#39' or '#39'DeleteKeyClear'#39') T' +
          'hank You Rico'
        'Lookup fields not nullables'
        85
        'Rico'
        40988.6002314815d
        0
        1
        0
        0)
      (
        144
        108
        'Re: Lookup fields not nullables'
        
          'May be use event OnChange or OnChangeKeyValue and check for exam' +
          'ple: [code:3ia4cop6]if dbLookupcomboBoxEh1&#46;KeyValue = Null t' +
          'hen dbLookupcomboBoxEh1&#46;KeyValue &#58;= 1; // you value by d' +
          'efault[/code:3ia4cop6]'
        'Lookup fields not nullables'
        55
        'sinys'
        40988.6897453704d
        0
        1
        0
        1)
      (
        145
        108
        'Re: Lookup fields not nullables'
        
          '[quote=&quot;sinys&quot;:vmmeygk8]May be use event OnChange or O' +
          'nChangeKeyValue and check for example: [code:vmmeygk8]if dbLooku' +
          'pcomboBoxEh1&#46;KeyValue = Null then dbLookupcomboBoxEh1&#46;Ke' +
          'yValue &#58;= 1; // you value by default[/code:vmmeygk8][/quote:' +
          'vmmeygk8] Hello sinys, I don'#39't need to do that in a dbLookupcomb' +
          'oBoxEh but in a lookupCombo in the DBGridEh <!-- s;) --><img src' +
          '="{SMILIES_PATH}/icon_e_wink.gif" alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /' +
          '><!-- s;) --> There isn'#39't such event in the column and the only ' +
          'one is TColumnEh.OnNotInList, but it doesn'#39't work for null value' +
          's With TColumnEh.UpdateData I could set a value, but I don'#39't hav' +
          'e the old value in this event ... Rico'
        'Lookup fields not nullables'
        85
        'Rico'
        40988.7073958333d
        0
        1
        0
        0)
      (
        146
        108
        'Re: Lookup fields not nullables'
        
          'Hello Rico. What about property - TField.Required. Can you use t' +
          'his property?'
        'Lookup fields not nullables'
        2
        'Administrator'
        40988.7672106481d
        0
        1
        0
        0)
      (
        147
        106
        'Re: cross tab - pivot grid'
        
          'Hello Unfortunately, EhLib doesn'#39't have components for combined ' +
          'cross analysis. You need to use other comonents for this. Best r' +
          'egards Admin.'
        'cross tab - pivot grid'
        2
        'Administrator'
        40988.7712615741d
        0
        1
        0
        0)
      (
        148
        108
        'Re: Lookup fields not nullables'
        
          '[quote=&quot;Administrator&quot;:34rv2d0q]Hello Rico. What about' +
          ' property - TField.Required. Can you use this property?[/quote:3' +
          '4rv2d0q] Hello Dmitry, I try it and I have the message &quot;Fie' +
          'ld [MYFIEILD] required ....&quot; when the data is posted While ' +
          'the data is not posted, there is no message, so you can input va' +
          'lues in others fields before have the message This message don'#39't' +
          ' speak to end users and they must press Escape to abort changes,' +
          ' but Escape abort all changes done on the record !!, so all chan' +
          'ges are lost ... Not very usefull this method as you can see ...' +
          ' (I think the message appears too late to be used in a grid) You' +
          ' don'#39't think that add a property to columns will be the best sol' +
          'ution ? (or modify TColumnEh.OnNotInList to do abort change when' +
          ' data is null) Best regards Rico'
        'Lookup fields not nullables'
        85
        'Rico'
        40988.8314583333d
        0
        1
        0
        0)
      (
        149
        108
        'Re: Lookup fields not nullables'
        
          'May be this variant: [code:2mmgpca3] procedure DataSet1BeforePos' +
          't(DataSet&#58; TDataSet); begin if DataSet1&#46;FieldByName('#39'Che' +
          'ckField'#39')&#46;IsNull then begin ShowMessage('#39'Error &#46;&#46;&#4' +
          '6;'#39'); Abort; end; end;[/code:2mmgpca3]'
        'Lookup fields not nullables'
        55
        'sinys'
        40988.9270023148d
        0
        1
        0
        1)
      (
        150
        108
        'Re: Lookup fields not nullables'
        
          'Thank you sinys, With this, you don'#39't have null value and you ha' +
          've a message, but it'#39's not better than set required on the field' +
          ' The user can input bad values and I think that the control shou' +
          'ld be in the column before the post data ... In the same idea, w' +
          'ant that user can input only the values of the comboBox on a loo' +
          'kupField is logical too Only Dmitry can say if it'#39's a good idea ' +
          'or not ... <!-- s;) --><img src="{SMILIES_PATH}/icon_e_wink.gif"' +
          ' alt=";)" title="'#1055#1086#1076#1084#1080#1075#1080#1074#1072#1077#1090'" /><!-- s;) --> Rico'
        'Lookup fields not nullables'
        85
        'Rico'
        40988.9868865741d
        0
        1
        0
        0)
      (
        151
        108
        'Re: Lookup fields not nullables'
        
          'Hello Rico. About TField.Required. Suppose the end user don'#39't ev' +
          'en enter the cell where you require to enter value. And he will ' +
          'try to post changes. How any property in the column could help y' +
          'ou to force to enter value if user even didn'#39't put input cursor ' +
          'to that cell? if you set TField.Required then When the dialog ab' +
          'out a field that must have a value is shown and you press Escape' +
          ' or Enter The DataSet is still in the Inserting mode, so all you' +
          'r values entered in over fields don'#39't lose yet. You can move cur' +
          'sor to the offered field, enter a value and post a record.'
        'Lookup fields not nullables'
        2
        'Administrator'
        40989.0432986111d
        0
        1
        0
        0)
      (
        152
        105
        'Re: Autosum field doesnt work properly ?'
        
          'Hello You must call DBGridEh.SumList.RecalcAll after the LoadFro' +
          'mDataSet. It is one of a disadvantages of SumList. It can track ' +
          'only Open Close actions in DataSet. As SumList is created for th' +
          'e TDataSet it doesn'#39't know about new functions in descendant cla' +
          'sses. Best regards Admin.'
        'Autosum field doesnt work properly ?'
        2
        'Administrator'
        40989.0467592593d
        0
        1
        0
        0)
      (
        153
        108
        'Re: Lookup fields not nullables'
        
          'Hello Dmitry, I see that you don'#39't understand what I need, so I'#39 +
          'll give you a real example of my application. First there are tw' +
          'o properties to add on TDBColumnGridEh, not one 1 - AllowNullVal' +
          'ue (True/False) With this propertie the field value can be null,' +
          ' but when a value is set, the user have only the choice to chang' +
          'e the value with the comboBox or input a new value. In this case' +
          ' VK_DELETE does nothing and an empty string is not valid 2 - All' +
          'owNewValue (True/False) With this property the field can be null' +
          ' too, but the user have only the choice to change the value with' +
          ' the comboBox In this case TDBColumnGridEh works like a classic ' +
          'comboBox [b:2ifkttwg]Example 1 : Input invoice lines [/b:2ifkttw' +
          'g] My record is like this : lineType, product code, product name' +
          ', quantity, price, V.A.T ... The field V.A.T (Value added tax) i' +
          's required for product line When the I add a product in the invo' +
          'ice the V.A.T have a value (this value is required in the table ' +
          'product) The user can change the V.A.T with a comboBox, but in n' +
          'ever case can set value to null (even if V.A.T equal 0, in this ' +
          'case V.A.T 0% must exists) and he can'#39't add a new TAX. In this i' +
          'nvoice, I can add differents type of lines as comments by exampl' +
          'e, and in this case the field V.A.T is null, I use only the prod' +
          'uct name and the type of line. With the event OnGetParams I set ' +
          'readOnly to True for such lines on V.A.T and all work fine... As' +
          ' you can see, I can'#39't set required = True on the field V.A.T Act' +
          'ually, the user can set Null in this field, but with the propert' +
          'y AllowNewValue = False and AllowNullValue = False, no error is ' +
          'possible [b:2ifkttwg]Example 2 : Add criteria on product[/b:2ifk' +
          'ttwg] In this case the user can choose criteria with the comboBo' +
          'x and can add a new element when it doesn'#39't exists in the list. ' +
          'When a add a new criteria, the field is null, so if the user don' +
          #39't choose a criteria, the record is not posted. But the user can' +
          ' select an other criteria, but in never case set a null value. A' +
          'ctually, the user can set Null in this field, but with the prope' +
          'rty AllowNullValue = False, no error is possible Hope you are ag' +
          'ree with me <!-- s:) --><img src="{SMILIES_PATH}/icon_e_smile.gi' +
          'f" alt=":)" title="'#1059#1083#1099#1073#1072#1077#1090#1089#1103'" /><!-- s:) --> Thank you Best rega' +
          'rds Rico'
        'Lookup fields not nullables'
        85
        'Rico'
        40989.2251041667d
        0
        1
        0
        0)
      (
        154
        90
        'Re: How to use ExportDBGridEhToOleExcel'
        
          '<!-- s:cry: --><img src="{SMILIES_PATH}/icon_cry.gif" alt=":cry:' +
          '" title="'#1055#1083#1072#1095#1077#1090' '#1080#1083#1080' '#1089#1080#1083#1100#1085#1086' '#1088#1072#1089#1089#1090#1088#1086#1077#1085'" /><!-- s:cry: -->'
        'How to use ExportDBGridEhToOleExcel'
        156
        'sunyesy'
        40990.5059375d
        0
        1
        0
        0)
      (
        155
        109
        'dghIncSearch in OptionsEh'
        
          'Hello Dmitry, Just a little question : Why have you comment the ' +
          'line 15510 in procedure TCustomDBGridEh.KeyPress ? line : ((dghI' +
          'ncSearch in OptionsEh) and not CanEditModifyColumn(SelectedIndex' +
          ')) or You have do that in version 4.2 (If I remember) and I neve' +
          'r understand why, because since this change, a readOnly grid doe' +
          'sn'#39't enter in search mode without press Ctrl+F. Why press Ctrl+F' +
          ' when dghIncSearch is set and the grid is readOnly ? I know I ca' +
          'n set dghPreferIncSearch to have automatic seach mode, it'#39's just' +
          ' a question ... PS : What do you think about my proposition of n' +
          'ew properties ? Best regards Rico'
        'dghIncSearch in OptionsEh'
        85
        'Rico'
        40990.6202777778d
        0
        1
        0
        0))
  end
end
