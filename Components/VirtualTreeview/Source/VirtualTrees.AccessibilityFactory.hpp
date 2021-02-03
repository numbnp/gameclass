// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VirtualTrees.AccessibilityFactory.pas' rev: 34.00 (Windows)

#ifndef Virtualtrees_AccessibilityfactoryHPP
#define Virtualtrees_AccessibilityfactoryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.oleacc.hpp>
#include <VirtualTrees.hpp>

//-- user supplied -----------------------------------------------------------

namespace Virtualtrees
{
namespace Accessibilityfactory
{
//-- forward type declarations -----------------------------------------------
__interface DELPHIINTERFACE IVTAccessibleProvider;
typedef System::DelphiInterface<IVTAccessibleProvider> _di_IVTAccessibleProvider;
class DELPHICLASS TVTAccessibilityFactory;
//-- type declarations -------------------------------------------------------
__interface IVTAccessibleProvider  : public System::IInterface 
{
	virtual _di_IAccessible __fastcall CreateIAccessible(Virtualtrees::TBaseVirtualTree* ATree) = 0 ;
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION TVTAccessibilityFactory : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	static bool FAccessibilityAvailable;
	static TVTAccessibilityFactory* FVTAccessibleFactory;
	System::Classes::TInterfaceList* FAccessibleProviders;
	
private:
	__classmethod void __fastcall FreeFactory();
	
public:
	__fastcall TVTAccessibilityFactory();
	__fastcall virtual ~TVTAccessibilityFactory();
	_di_IAccessible __fastcall CreateIAccessible(Virtualtrees::TBaseVirtualTree* ATree);
	static TVTAccessibilityFactory* __fastcall GetAccessibilityFactory();
	void __fastcall RegisterAccessibleProvider(const _di_IVTAccessibleProvider AProvider);
	void __fastcall UnRegisterAccessibleProvider(const _di_IVTAccessibleProvider AProvider);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Accessibilityfactory */
}	/* namespace Virtualtrees */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VIRTUALTREES_ACCESSIBILITYFACTORY)
using namespace Virtualtrees::Accessibilityfactory;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VIRTUALTREES)
using namespace Virtualtrees;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Virtualtrees_AccessibilityfactoryHPP
