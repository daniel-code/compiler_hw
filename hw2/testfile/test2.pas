program test;
var
  a: array [1 .. 5] of integer;
  b, c, d: integer;
begin
  b := 1;
  c := 3;
  a[2] :=c;
  for b := 1 TO b*2+1 do
  BEGIN
    if (a[b] >= 2) then
      WRITE(b);
    for d:= 1 To (1+2)*3 do
      WRITE(c);
  END;
end.