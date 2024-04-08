program zd3;

type
  NodePtr=^Node;
  Node=record
    Num: integer;
    Next: NodePtr;
  end;

var Head, Current: NodePtr;
  i: integer;

procedure AddToList(var Head: NodePtr; Num: integer);
var NewNode: NodePtr;
  TempPtr: NodePtr;
begin
  New(NewNode);
  NewNode^.Num:=Num;
  NewNode^.Next:=nil;

  if Head=nil then
    Head:=NewNode
  else
  begin
    TempPtr:=Head;
    while TempPtr^.Next<>nil do
      TempPtr:=TempPtr^.Next;
    TempPtr^.Next:=NewNode;
  end;
end;

procedure DisplayList(Head: NodePtr); // Вывод элементов на экран
var TempPtr: NodePtr;
begin
  TempPtr:=Head;
  while TempPtr<>nil do
  begin
    Write(TempPtr^.Num, ' ');
    TempPtr:=TempPtr^.Next;
  end;
  Writeln;
end;

procedure DisplayEvenElements(Head: NodePtr); // Вывод четных
var TempPtr: NodePtr;
begin
  TempPtr:=Head;
  while TempPtr<>nil do
  begin
    if TempPtr^.Num mod 2=0 then
      Write(TempPtr^.Num, ' ');
    TempPtr:=TempPtr^.Next;
  end;
  Writeln;
end;

begin
  Head:=nil;
  for i := 1 to 10 do
    AddToList(Head, i);
  Writeln('Список:');
  DisplayList(Head);
  Writeln('Четные элементы списка:');
  DisplayEvenElements(Head);
end.
