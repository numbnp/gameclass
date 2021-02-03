// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VirtualTrees.HeaderPopup.pas' rev: 34.00 (Windows)

#ifndef Virtualtrees_HeaderpopupHPP
#define Virtualtrees_HeaderpopupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Menus.hpp>
#include <VirtualTrees.hpp>

//-- user supplied -----------------------------------------------------------

namespace Virtualtrees
{
namespace Headerpopup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVTHeaderPopupMenu;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TVTHeaderPopupOption : unsigned char { poOriginalOrder, poAllowHideAll, poResizeToFitItem };

typedef System::Set<TVTHeaderPopupOption, TVTHeaderPopupOption::poOriginalOrder, TVTHeaderPopupOption::poResizeToFitItem> TVTHeaderPopupOptions;

typedef void __fastcall (__closure *TColumnChangeEvent)(Virtualtrees::TBaseVirtualTree* const Sender, const Virtualtrees::TColumnIndex Column, bool Visible);

class PASCALIMPLEMENTATION TVTHeaderPopupMenu : public Vcl::Menus::TPopupMenu
{
	typedef Vcl::Menus::TPopupMenu inherited;
	
private:
	TVTHeaderPopupOptions FOptions;
	Virtualtrees::TVTHeaderAddPopupItemEvent FOnHeaderAddPopupItem;
	TColumnChangeEvent FOnColumnChange;
	void __fastcall ResizeColumnToFit(System::TObject* Sender);
	void __fastcall ResizeToFit(System::TObject* Sender);
	
protected:
	virtual void __fastcall DoAddHeaderPopupItem(const Virtualtrees::TColumnIndex Column, /* out */ Virtualtrees::TAddPopupItemType &Cmd);
	virtual void __fastcall DoColumnChange(Virtualtrees::TColumnIndex Column, bool Visible);
	void __fastcall OnMenuItemClick(System::TObject* Sender);
	
public:
	__fastcall virtual TVTHeaderPopupMenu(System::Classes::TComponent* AOwner);
	virtual void __fastcall Popup(int x, int y);
	
__published:
	__property TVTHeaderPopupOptions Options = {read=FOptions, write=FOptions, default=4};
	__property Virtualtrees::TVTHeaderAddPopupItemEvent OnAddHeaderPopupItem = {read=FOnHeaderAddPopupItem, write=FOnHeaderAddPopupItem};
	__property TColumnChangeEvent OnColumnChange = {read=FOnColumnChange, write=FOnColumnChange};
public:
	/* TPopupMenu.Destroy */ inline __fastcall virtual ~TVTHeaderPopupMenu() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Headerpopup */
}	/* namespace Virtualtrees */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VIRTUALTREES_HEADERPOPUP)
using namespace Virtualtrees::Headerpopup;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VIRTUALTREES)
using namespace Virtualtrees;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Virtualtrees_HeaderpopupHPP
