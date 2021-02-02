
This directory contains language-specific resource files.

There are two types of resources depending on the VCL version.
  For Delphi7-Delphi2005 in the folder "Res.Ansi".
  For Delphi2006 and higher in the folder "Res".
The files in the Res folder are stored in the Utf8 encoding.
The files in the Res.Ansi folder are stored in the Ansi encoding.

If you install library manually then copy files from "Res" (Or "Res.Ansi") folder 
into the <EhLib installed folder>\Lib folder.

If you use language resources as external resources you need to copy "Res" folder
into the folder of executable file.

Every file EhLibLangConsts.XXX.dfm contains a resource for one language.
Where XXX is "Language name abbreviation".
You can see a list of available Language name abbreviations here:
  https://www.microsoft.com/resources/msdn/goglobal/default.mspx

Inside the dfm file the "Language name abbreviation" is included in the name of class
like this

----- EhLibLangConsts.ENU.dfm  ----->
object TEhLibLanguageConsts_ENU
  Language = 'English'
....
----- EhLibLangConsts.ENU.dfm  -----<

first property with name "Language" must be assigned by the name of Language in English.

If you want to add a new Language you should get know "Language name abbreviation" from 
the the list described above.
Copy file EhLibLangConsts.ENU.dfm to a new file and modify the contents of the file.
For example for French the file will looks like this

----- EhLibLangConsts.FRA.dfm  ----->
object TEhLibLanguageConsts_FRA
  Language = 'French'

  ClearSelectedCells = 'Effacer les cellules sélectionnées?'
  InvalidTextFormat = 'Mauvais format de texte'
....
----- EhLibLangConsts.FRA.dfm  -----<

If you want to participate in EhLib supported languages,
please create language files for the next templates:

<EhLib archive folder>\LangResources\Res\EhLibLangConsts.XXX.dfm  (Utf8 encoding)
<EhLib archive folder>\LangResources\Res.Ansi\EhLibLangConsts.XXX.dfm  (Ansi encoding)

For EhLib Demos
<EhLib archive folder>\Demos\MainDemo\Res\AppLangConsts.XXX.dfm  (Utf8 encoding)
<EhLib archive folder>\Demos\MainDemo\Res.Ansi\AppLangConsts.XXX.dfm  (Ansi encoding)

Send files to support@ehlib.com so we could include new resource in the next builds. 
Include in the letter the next information:
  The Language name 
  'Supported by' info (your name)
  Contact info (your e-mail).

Here is information about current supported languages:
                  
Language    	   Directory Name     Supported by            Contact info

English     	   English            Dmitry V. Bolshakov     support@ehlib.com
Russian     	   Russian            Dmitry V. Bolshakov     support@ehlib.com
Spanish     	   Spanish            Alberto Garcia Alvarez  tim@telecable.es
German      	   German             Hartmut Festing         h.festing@edv-service-festing.de
French      	   French             Tanguy KERNOA           tanguy@menlog.com
Ukrainian   	   Ukrainian          Sergiy Sekela           Dr_Web@ukr.net
Japanese    	   Japanese           Tomio Suzuki            suzuki@sslabo.com, sslabo@mba.nifty.com, systemlabo.suzuki@nifty.com
Simplified Chinese Simplified Chinese <N/D>                   slq.mail@163.com
Polish        	   Polish             Bolek Umnicki           bolum@poczta.onet.pl
Bulgarian          Bulgarian          Georgi Panayotov        georgi@ada-soft.bg
Portuguese         Portuguese         Joaquim Nunes           japnunes@oninet.pt
Czech              Czech              Michal Mutl             michal.mutl@mitec.cz 	
Persian            Persian            Benyamin Rahimi         benyrahimi@gmail.com
Portugues Brasil   Portugues Brasil   Andre Luiz Torres Cravo andre@altc.com.br
Arabic             Arabic             Khalid Dawood           Khaliddawood@gmail.com