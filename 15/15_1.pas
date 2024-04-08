Program zad1;
var n: integer;
  I_ptr, pI: ^integer;
begin
  n:=2;
  pI:=@n;
  I_ptr:=pI;
  writeln('Значение, находящееся по адресу I_ptr = ', I_ptr^);
end.