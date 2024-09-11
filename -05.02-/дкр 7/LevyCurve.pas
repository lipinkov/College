unit LevyCurve;

interface

uses GraphABC;

procedure DrawLevy(x, y, l, a: real; depth: integer);

implementation

procedure DrawLevy(x, y, l, a: real; depth: integer);
var
  x1, y1: real;
begin
  if depth = 0 then
  begin
    x1 := x + l * cos(a);
    y1 := y + l * sin(a);
    Line(Round(x), Round(y), Round(x1), Round(y1));
  end
  else
  begin
    l := l / sqrt(2);
    DrawLevy(x, y, l, a + Pi/4, depth - 1);
    x := x + l * cos(a + Pi/4);
    y := y + l * sin(a + Pi/4);
    DrawLevy(x, y, l, a - Pi/4, depth - 1);
  end;
end;

end.
