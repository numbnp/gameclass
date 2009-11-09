@echo off
if "%1"=="Logon" goto Logon
if "%1"=="Logoff" goto Logoff
if "%1"=="Service" goto Service
if "%1"=="CloseShift" goto CloseShift
if "%1"=="MoneyRemoved" goto MoneyRemoved
echo Пример пакетного файла для обработки событий при работе сервера GameClass 3
echo Параметры командной строки:
echo %%1 - Действие (Logon, Logoff, Service, CloseShift или MoneyRemoved)
echo %%2 - Время в формате dd.mm.yy-hh:mm:ss
echo %%3 - Имя пользователя
echo %%4 и далее - дополнительная информация
echo При Service:
echo %%4 - идентификатор услуги
echo %%5 - количество
echo %%6 - IP-адрес компьютера (none - если неизвестно)
echo %%7 - имя клиента (none - если неизвестно)
echo %%8 - вариант оплаты (Separate, Prepay, Postpay)
echo При CloseShift:
echo %%4 - всего заработано
echo %%5 - у оператора
echo %%6 - у менеджера
echo При MoneyRemoved:
echo %%4 - изымаемая сумма
exit

:Logon
echo %2 Пользователь %3 подключился к базе данных
pause
exit
:Logoff
echo %2 Пользователь %3 отключился от базы данных
pause
exit
:Service
echo %2 При операторе %3 оказана услуга и идентификатором %4 в количестве %5
echo   IP-адрес компьютера: %6 
echo   имя клиента: %7
if "%8"=="Separate" echo   вариант оплаты: отдельная оплата  
if "%8"=="Prepay" echo   вариант оплаты: вычесть из предоплаты за сеанс  
if "%8"=="Postpay" echo   вариант оплаты: включить в постопалату за сеанс
pause
exit
:CloseShift
echo %2 Оператор %3 завершил смену
echo   всего заработано: %4
echo   у оператора: %5
echo   у менеджера: %6
pause
exit
:MoneyRemoved
echo %2 Менеджер %3 забрал деньги из кассы: %4
pause
exit
