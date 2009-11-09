unit uVCLTools;

interface

uses
  Controls,
  Windows,
  Graphics,
  Grids;


  procedure StringGridAutoResizeColums(AControl: TStringGrid);
  function GetTextWidth(const AstrText : String;
      const  AWinControl: TWinControl; const AFont: TFont): Integer;


implementation

function GetTextWidth(const AstrText : String;
    const  AWinControl: TWinControl; const AFont: TFont): Integer;
var
  hwndWindow: HWND;
  hwndObject: HWND;
  dcWindow: HDC;
  rectText: TRect;

begin
  rectText.Left := 0;
  rectText.Top := 0;
  rectText.Bottom := 0;
  rectText.Right := 0;

  hwndWindow := AWinControl.Handle;
  dcWindow := GetWindowDC(hwndWindow);
  hwndObject := SelectObject(dcWindow, AFont.Handle);
  DrawText(dcWindow ,PChar(AstrText),Length(AstrText),rectText,DT_CALCRECT);
  SelectObject(dcWindow, hwndObject);
  Result := rectText.Right - rectText.Left;
end;

procedure StringGridAutoResizeColums(AControl: TStringGrid);
var
  i,j,l,m :Integer;
begin
  for i:=0 to AControl.ColCount - 1 do begin
    m := 0;
    for j := 0 to AControl.RowCount - 1 do begin
      l := GetTextWidth(AControl.Cells[i,j], AControl, AControl.Font);
      if l > m then
        m := l;
    end;
    AControl.ColWidths[i] := m + 5;
  end;

end;

end.
