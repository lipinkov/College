program P;

uses GraphABC, LevyCurve;

var
  Dep: integer = 10; 
  Sca: real = 200.0; 
  OffX, OffY: integer; 

procedure Redraw;
begin
  ClearWindow;
  DrawLevy(WindowWidth div 2 + OffX - Sca / 2, WindowHeight / 2 + OffY, Sca, 0, Dep);
end;

procedure KeyDownHandler(Key: integer);
begin
  case Key of
    VK_Up: begin Dep := Dep + 1; Redraw; end;
    VK_Down: if Dep > 0 then begin Dep := Dep - 1; Redraw; end;
    VK_Left: begin Sca := Sca * 0.9; Redraw; end;
    VK_Right: begin Sca := Sca * 1.1; Redraw; end;
    VK_W: begin OffY := OffY - 10; Redraw; end;
    VK_S: begin OffY := OffY + 10; Redraw; end;
    VK_A: begin OffX := OffX - 10; Redraw; end;
    VK_D: begin OffX := OffX + 10; Redraw; end;
  end;
end;

begin
  SetWindowSize(800, 600);
  OffX := 0;
  OffY := 0;
  
  OnKeyDown := KeyDownHandler;
  
  Redraw;
end.
