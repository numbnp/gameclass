'%1 - Действие (ServiceStart, ServiceStop, ClientStart, ClientStop, Blocking, Unblocking, 
'     EnableIntenet, DisableIntenet, AfterStopAction, Disconnect, NMinutLeft, StateChanged, 
'     или TarifChanged)
'%2 - момент события в формате dd.mm.yy-hh:mm:ss
'%3 - дополнительнывй параметр (KillTask, Logoff, Restart или Shutdown при AfterStopAction; 
'     количество минут при NMinutLeft; название тарифа при TarifChanged)

Dim oArgs
Set oArgs = Wscript.Arguments

If oArgs.Count < 2 Then
  WScript.Quit 
End If

Dim strAction, strMoment, strExtraParameter, strInfo
strActon =  oArgs(0)
strMoment = oArgs(1)
strExtraParameter = ""
If oArgs.Count = 3 Then
  strExtraParameter = oArgs(2)
End If


If strActon="ServiceStart" Then
  WScript.Echo strMoment & "  Запущен сервис клиента GameClass"
End If
If strActon="ServiceStop" Then
  WScript.Echo strMoment & "  Остановлен сервис клиента GameClass"
End If
If strActon="ClientStart" Then
  WScript.Echo strMoment & "  Запущена визуальная часть клиента GameClass"
End If
If strActon="ClientStop" Then
  WScript.Echo strMoment & "  Остановлена визуальная часть клиента GameClass"
End If
If strActon="Blocking" Then
  WScript.Echo strMoment & "  Компьютер заблокирован"
End If
If strActon="Unblocking" Then
  WScript.Echo strMoment & "  Компьютер разблокирован"
End If
If strActon="EnableIntenet" Then
  WScript.Echo strMoment & "  Доступ в интернет разблокирован"
End If
If strActon="DisableIntenet" Then
  WScript.Echo strMoment & "  Доступ в интернет заблокирован"
End If
If strActon="AfterStopAction" Then
  If strExtraParameter="KillTask" Then
    strInfo = "Снятие задач"
  End If
  If strExtraParameter="Logoff" Then
    strInfo = "Завершение сеанса"
  End If
  If strExtraParameter="Restart" Then
    strInfo = "Перезагрузка"
  End If
  If strExtraParameter="Shutdown" Then
    strInfo = "Выключение компьютера"
  End If
  WScript.Echo strMoment & "  Действие после завершения сеанса: " & strInfo
End If
If strActon="Disconnect" Then
  WScript.Echo strMoment & "  Разрыв связи между клиентом и сервером GameClass"
End If
If strActon="NMinutLeft" Then
  WScript.Echo strMoment & "  До завершения сеанса осталось " & strExtraParameter & " минут" 
End If
If strActon="StateChanged" Then
  WScript.Echo strMoment & "  Изменилось состояние клиента GameClass"
End If
If strActon="TarifChanged" Then
  WScript.Echo strMoment & "  Текущий тариф изменен на " & strExtraParameter
End If

'Set wshshell = WScript.CreateObject("WScript.Shell")

'wshshell.Popup "Error with creating ActiveX object!",0,"",0


