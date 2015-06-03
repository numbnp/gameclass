//////////////////////////////////////////////////////////////////////////////
//
// Компонент - наследник стандартного ListBox. Позволяет менять порядок
// элементов простым перетягиванием мышью (Drag & Drop в действии).
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KListBox;

interface

uses
  SysUtils,
  Classes,
  Controls,
  StdCtrls;

type

  //
  // TY2KListBox
  //

  TY2KListBox = class(TListBox)
  private
    // fields
    FbIsDragItems: boolean;

  protected
    // overrided methods
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;

    // overrides methods
    procedure DragDrop(Source: TObject; X, Y: Integer); override;

  published
    // разрешение перетягивания элементов списка
    property IsDragItems: boolean read FbIsDragItems write FbIsDragItems;

  end; // TY2KListBox


implementation


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DragMode := dmAutomatic;
  IsDragItems := TRUE;
end; // TY2KListBox.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// overrided methods

procedure TY2KListBox.DragDrop(Source: TObject; X, Y: Integer);
begin
  if IsDragItems and (Self = Source) then
    Self.Items.Move(ItemIndex,ItemAtPos(Point(x,y),True));
  inherited DragDrop(Source, X, Y);
end; // TY2KListBox.DragDrop

procedure TY2KListBox.DragOver(Source: TObject; X, Y: Integer;
    State: TDragState; var Accept: Boolean);
begin
  inherited DragOver(Source, X, Y, State, Accept);
  if IsDragItems then
    Accept := Accept or (Self = Source);
end; // TY2KListBox.DragOver


end. ////////////////////////// end of file //////////////////////////////////
