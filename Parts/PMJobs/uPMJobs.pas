unit uPMJobs;

interface

uses
  uAutoUpdate,
  uPMJobsDataSet,
  uPMJobsRecord,
  uGCSidelines;

type
  TPMJobs = class(TPMJobsDataSet)
  private
    FPMJobsRecord: TPMJobsRecord;
  public
    constructor Create(AAutoUpdate: TAutoUpdate);
    destructor Destroy; override;

    procedure OnAfterInsertEvent (const Sender: TObject;
        const Id: Integer);

    property Current: TPMJobsRecord
        read FPMJobsRecord write FPMJobsRecord;
  end;

var
  GPMJobs: TPMJobs;


implementation

uses
  SysUtils,
  gccomputers,
  gccommon,
  gcconst,
  uRegistry,
  uNetTools,
  Math,
  uVirtualTime,
  ADODB,
  uGCDataSet,
  uDebugLog;

constructor TPMJobs.Create(AAutoUpdate: TAutoUpdate);
begin
  inherited Create(Nil, AAutoUpdate.Connection);
  AAutoUpdate.Add(Self,'PMJobs',4);
  FPMJobsRecord := TPMJobsRecord.Create(Self);
  OnAfterInsert := OnAfterInsertEvent;
end;

destructor TPMJobs.Destroy;
begin
  FreeAndNil(FPMJobsRecord);
  inherited Destroy;
end;

procedure  TPMJobs.OnAfterInsertEvent (const Sender: TObject;
    const Id: Integer);
var
  ClientIP: string;
  ClientComp: integer;
  i: integer;
  PrintedOk: boolean;
begin
  if (isManager) or not dsConnected
      or not GRegistry.Modules.Printer.Active
      or (Id <= GRegistry.Modules.Printer.LastProcessedId) then exit;

  GPMJobs.LocateById(Id);
  with GPMJobs.Current do begin
    Debug.Trace5('PrinterScan ClientIP:' + IPAddress
        + 'PrinterName:'+ PrinterName
        + ' PPages:' + IntToStr(PagesCount)
        + ' PrinterScanId:' + IntToStr(Id));
    ClientIP := IPAddress;
    // вычислим IP, с которого распечатали
    if (ClientIP<>'') then
      ClientIP := GetIPByName(ClientIP);
    // найдем номер компа, с которого велась распечатка
    ClientComp := -1;
    Debug.Trace5('PrinterScan ClientIP:'+ClientIP);
    for i:=0 to CompsCount-1 do
      if (Comps[i].ipaddr = ClientIP) then
        ClientComp := i;
    // если комп не из клиентских, то ClientComp = -1
    // теперь все готово, цена страницы, кол-во страниц, и даже IP юзера
    // есть два варианта, 1-ый (печатали с клиентского компа) и комп занят
        Debug.Trace5('PrinterScan ClientComp:' + IntToStr(ClientComp)
        + ' PageCost' + FloatToStr(Cost));
    PrintedOk := false;
    if (ClientComp <> -1) then
      if (Comps[ClientComp].busy)
        and (Comps[ClientComp].session.TimeStart <= Moment) then begin
        // обновляем данные сессии
        Comps[ClientComp].session.UpdatePrinted(PagesCount * Cost);
        Debug.Trace5('PrinterScan PPages' + IntToStr(PagesCount));
        PrintedOk := true;
        Console.AddEvent(EVENT_ICON_PRINTER,LEVEL_2,
            DateTimeToSql(GetVirtualTime) + ' >' + 'Printing from computer №'
            + Comps[ClientComp].GetStrNumber + ', '
            + IntToStr(PagesCount)+' page(s)');
      end;

    // 2-ой печатали с операторского компа
    if (Not PrintedOk) and GRegistry.Options.OperatorPrinterControl
        and (ClientIP = GRegistry.Options.OperatorIP) then begin
        // обновляем данные сессии
        Sideline.ToSell(0, PagesCount, stcSeparate, -1, -1, True, Cost);
        PrintedOk := true;
    end;

    // 3-ий печатали не с клиентского компа или с компа, который свободен
    if (Not PrintedOk) then begin
      Console.AddEvent(EVENT_ICON_PRINTER,LEVEL_0,
          DateTimeToSql(GetVirtualTime) + ' >' + 'Printing from IP '+ ClientIP
          + ', ' + IntToStr(PagesCount) + ' page(s)');
    end;
  end;
  // сохраним новый порог PrinterScanId
  GRegistry.Modules.Printer.LastProcessedId := Id;
end;

end.


