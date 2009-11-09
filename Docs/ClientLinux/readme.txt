    Руководство по установке Linux клиента GameClass -- gccllin

1. В системе должны быть установлены русские шрифты CP1251 семества cronyx для 
   разрешения 96 DPI. Для Debian можно использовать пакет 
   xfonts-cronyx-cp1251-100dpi_2.3.8-6_all.deb, доступный по ссылке:
   http://www.gameclass.ru/download/xfonts-cronyx-cp1251-100dpi_2.3.8-6_all.deb

2. Установите разрешение экрана 96 DPI (см. приложение 1)

3. Добавить при отсутствии и установить по-умолчанию локаль ru_RU.CP1251. 
   В Debian это делается командой:
           dpkg-reconfigure locales

3. Создайте пользователя, для которого будет запускаться клиент.

4. Распакуйте архив с помощью команды "tar xzf gccllin.tar.gz".

5. Запустите install.sh. Задайте директорию для установки клиента и имя 
   пользователя, для которого будет запускаться клиент. 

6. После перезагрузки клиент GameClass будет автоматически запускаться при
   старте сессии X-Window

Скрипт изменяет /etc/rc.local для автоматического запуска клиента при старте 
системы. Проверьте корректность внесенных изменений.






-----------------------------------------------------------------
Приложение 1. Установка разрешение экрана 96 DPI.

   Вы можете узнать разрешение экрана командой: 
           xdpyinfo | grep resol

   Вы можете узнать размеры экрана командой: 
           xdpyinfo | grep dimen

   Window использует по умолчанию 96 DPI, Linux - 75 или 81. Изза этого шрифты
   в Linux выглядят мельче по сравнению с теми же самыми шрифтами в Windows при
   одинаковом размере экрана и шрифтов. 

   В зависимости от ситуации необходимо сделать следующие шаги, чтобы
   заставить Linux работать при 96 DPI.

   а) Если X-Window автоматически стартует через KDM или GDM, необходимо 
   отредактировать xorg.conf или XF86Config. Необходимо скорректировать
   переменную DisplaySize в сооттветствии с установленым разрешением экрана.
   
   Для разрешения 1280x1024:

           #   **********************************************************************
           # Monitor section
           #   **********************************************************************
           # Any number of monitor sections may be present
           Section "Monitor"
           Identifier "My Monitor"
           # HorizSync is in kHz unless units are specified.
           # HorizSync may be a comma separated list of discrete values, or a
           # comma separated list of ranges of values.
           # NOTE: THE VALUES HERE ARE EXAMPLES ONLY. REFER TO YOUR MONITOR'S
           # USER MANUAL FOR THE CORRECT NUMBERS.
           HorizSync 31 - 86
           # HorizSync 30-64 # multisync
           # HorizSync 31.5, 35.2 # multiple fixed sync frequencies
           # HorizSync 15-25, 30-50 # multiple ranges of sync frequencies
           # VertRefresh is in Hz unless units are specified.
           # VertRefresh may be a comma separated list of discrete values, or a
           # comma separated list of ranges of values.
           # NOTE: THE VALUES HERE ARE EXAMPLES ONLY. REFER TO YOUR MONITOR'S
           # USER MANUAL FOR THE CORRECT NUMBERS.
           VertRefresh 50-180
           Option "dpms"
           DisplaySize 337.5 270.0  #<--- именить или добавить эту строку
           EndSection
 
 
   Опция DisplaySize 337.5 270.0 заставляет X-Window загрузиться с
   разрешением 96x96 dpi при размере экрана 1280x1024. Значения переменной
   устанавливаются так:

           DisplaySize X Y

   где

           X = ширина_экрана_в_пикселях * 25.4 / желаемый_dpi
           Y = высота_экрана_в_пикселях * 25.4 / желаемый_dpi


   б) Если Linux сначала загружается в консоль (runlevel 3), а для старта 
   X-Window и используется startx, нужно отредактироавать скрипт 
   /usr/X11/bin/startx. В зависимости от дистрибутива, это может быть 
   символьная ссылка.

           userclientrc=$HOME/.xinitrc
           userserverrc=$HOME/.xserverrc
           sysclientrc=/usr/X11R6/lib/X11/xinit/xinitrc
           sysserverrc=/usr/X11R6/lib/X11/xinit/xserverrc
           defaultclient=/usr/X11R6/bin/xterm
           defaultserver=/usr/X11R6/bin/X
           defaultclientargs=""
           defaultserverargs="-dpi 96" #<--- изменить или добавить эту строку
           clientargs=""
           serverargs=""


   Необходимо добавить "-dpi 96" к строке defaultserverargs=

   c) Если используется Gnome, то выполнения одного из передыдущих шагов 
   недостаточно. В настройках Gnome/Desktop Prefs/Fonts/Details нужно
   изменить опцию DPI вверху страницы на 96. Если Gnome не используется, 
   но применяется демон gnome-setting для переноса оформления из
   Gnome в KDE, или используется приложения из Gnome, такие, как
   evolution, необходимо выполнить это действие.


------------------------------------------------------------------------------
-
делаем: locale -a | grep ru

если там есть 'ru_RU.CP1251', то все готово

делаем: localedef -c -i ru_RU -f CP1251 ru_RU.CP1251
если команда пишет ошибку 
cannot read character map directory 
`/usr/share/i18n/charmaps': No such file or directory
то поставьте пакеты glibc-i18ndata-2.2.4-77 icu-i18ndata-1.7-92 
(или других версий)

идем в /usr/lib/locale

если там появился каталог 'ru_RU.cp1251', копируем в 'ru_RU.CP1251' (регистронезависимость)

делаем 'locale -a | grep ru' и убеждаемся, что 'ru_RU.CP1251' появил
