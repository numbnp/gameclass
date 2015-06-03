unit IEDocHostUIHandler;

interface

uses
  Windows, Messages, Forms, ActiveX, ComObj, ieConst, SHDocVw;

type
  TDocHostUIHandler = class(TComObject, IDocHostUIHandler)
    FWebBrowser: TWebBrowser;
  protected
    function IDocHostUIHandler.ShowContextMenu = IDocHostUIHandler_ShowContextMenu;
    function IDocHostUIHandler.GetHostInfo = IDocHostUIHandler_GetHostInfo;
    function IDocHostUIHandler.ShowUI = IDocHostUIHandler_ShowUI;
    function IDocHostUIHandler.HideUI = IDocHostUIHandler_HideUI;
    function IDocHostUIHandler.UpdateUI = IDocHostUIHandler_UpdateUI;
    function IDocHostUIHandler.EnableModeLess = IDocHostUIHandler_EnableModeless;
    function IDocHostUIHandler.OnDocWindowActivate = IDocHostUIHandler_OnDocWindowActivate;
    function IDocHostUIHandler.OnFrameWindowActivate = IDocHostUIHandler_OnFrameWindowActivate;
    function IDocHostUIHandler.ResizeBorder = IDocHostUIHandler_ResizeBorder;
    function IDocHostUIHandler.TranslateAccelerator = IDocHostUIHandler_TranslateAccelerator;
    function IDocHostUIHandler.GetOptionKeyPath = IDocHostUIHandler_GetOptionKeyPath;
    function IDocHostUIHandler.GetDropTarget = IDocHostUIHandler_GetDropTarget;
    function IDocHostUIHandler.GetExternal = IDocHostUIHandler_GetExternal;
    function IDocHostUIHandler.TranslateURL = IDocHostUIHandler_TranslateUrl;
    function IDocHostUIHandler.FilterDataObject = IDocHostUIHandler_FilterDataObject;

    function IDocHostUIHandler_ShowContextMenu( const dwID: DWORD; const ppt: PPOINT; const pcmdtReserved: IUnknown; const pdispReserved: IDispatch ): HRESULT; stdcall;
    function IDocHostUIHandler_GetHostInfo( var pInfo: TDOCHOSTUIINFO ): HRESULT; stdcall;
    function IDocHostUIHandler_ShowUI( const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject; const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame; const pDoc: IOleInPlaceUIWindow ): HRESULT; stdcall;
    function IDocHostUIHandler_HideUI: HRESULT; stdcall;
    function IDocHostUIHandler_UpdateUI: HRESULT; stdcall;
    function IDocHostUIHandler_EnableModeless( const fEnable: BOOL ): HRESULT; stdcall;
    function IDocHostUIHandler_OnDocWindowActivate( const fActivate: BOOL ): HRESULT; stdcall;
    function IDocHostUIHandler_OnFrameWindowActivate( const fActivate: BOOL ): HRESULT; stdcall;
    function IDocHostUIHandler_ResizeBorder( const prcBorder: PRECT; const pUIWindow: IOleInPlaceUIWindow; const fRameWindow: BOOL ): HRESULT; stdcall;
    function IDocHostUIHandler_TranslateAccelerator( const lpMsg: PMSG; const pguidCmdGroup: PGUID; const nCmdID: DWORD ): HRESULT; stdcall;
    function IDocHostUIHandler_GetOptionKeyPath( var pchKey: POLESTR; const dw: DWORD ): HRESULT; stdcall;
    function IDocHostUIHandler_GetDropTarget( const pDropTarget: IDropTarget; out ppDropTarget: IDropTarget ): HRESULT; stdcall;
    function IDocHostUIHandler_GetExternal( out ppDispatch: IDispatch ): HRESULT; stdcall;
    function IDocHostUIHandler_TranslateUrl( const dwTranslate: DWORD; const pchURLIn: POLESTR; var ppchURLOut: POLESTR ): HRESULT; stdcall;
    function IDocHostUIHandler_FilterDataObject( const pDO: IDataObject; out ppDORet: IDataObject ): HRESULT; stdcall;
  end;

const
  Class_DocHostUIHandler: TGUID = '{3F2BBC05-40DF-11D2-9455-00104BC936FF}';

implementation

uses ComServ;

function TDocHostUIHandler.IDocHostUIHandler_EnableModeless(const fEnable: BOOL): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_FilterDataObject(const pDO: IDataObject;
  out ppDORet: IDataObject): HRESULT;
begin
  ppDORet := nil;
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_GetDropTarget(const pDropTarget: IDropTarget;
  out ppDropTarget: IDropTarget): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_GetExternal(out ppDispatch: IDispatch): HRESULT;
begin
  ppDispatch := nil;
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_GetOptionKeyPath(var pchKey: POLESTR;
  const dw: DWORD): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_HideUI: HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_OnDocWindowActivate(const fActivate: BOOL): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_OnFrameWindowActivate(
  const fActivate: BOOL): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_ResizeBorder(const prcBorder: PRECT;
  const pUIWindow: IOleInPlaceUIWindow; const fRameWindow: BOOL): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_ShowContextMenu(const dwID: DWORD;
  const ppt: PPOINT; const pcmdtReserved: IUnknown;
  const pdispReserved: IDispatch): HRESULT;
begin
  if Assigned( FWebBrowser ) and Assigned( FWebBrowser.PopupMenu ) then
  begin
    FWebBrowser.PopupMenu.Popup( ppt^.x, ppt^.y );
    Result := S_OK;
  end
  else begin
    Result := S_OK;
  end;
end;

function TDocHostUIHandler.IDocHostUIHandler_ShowUI(const dwID: DWORD;
  const pActiveObject: IOleInPlaceActiveObject;
  const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
  const pDoc: IOleInPlaceUIWindow): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_TranslateAccelerator(const lpMsg: PMSG;
  const pguidCmdGroup: PGUID; const nCmdID: DWORD): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_TranslateUrl(const dwTranslate: DWORD;
  const pchURLIn: POLESTR; var ppchURLOut: POLESTR): HRESULT;
begin
  Result := S_FALSE;
end;

function TDocHostUIHandler.IDocHostUIHandler_UpdateUI: HRESULT;
begin
  Result := S_FALSE;
end;


initialization
  TComObjectFactory.Create(ComServer, TDocHostUIHandler, Class_DocHostUIHandler,
    'DocHostUIHandler', 'Implements DocHostUIHandler', ciMultiInstance);
end.
