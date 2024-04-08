program zd4;

type
  NodePtr=^Node;
  Node=record
    Num: integer;
    Next: NodePtr;
  end;

var Head, Current: NodePtr;
  i, MaxValue, MinValue: integer;

procedure AddToList(var Head: NodePtr; Num: Integer); // Добавление в конец узла с числами в конец
var NewNode, TempPtr: NodePtr;
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

procedure Find(Head: NodePtr; var MaxValue, MinValue: integer);
var TempPtr: NodePtr;
begin
  TempPtr:=Head;
  MaxValue:=TempPtr^.Num;
  MinValue:=TempPtr^.Num;

  while TempPtr<>nil do
  begin
    if TempPtr^.Num>MaxValue then
      MaxValue:=TempPtr^.Num;
    if TempPtr^.Num<MinValue then
      MinValue:=TempPtr^.Num;
    TempPtr:=TempPtr^.Next;
  end;
end;

begin
  Head:=nil;
  for i := 1 to 10 do
    AddToList(Head, i);
  Find(Head, MaxValue, MinValue);
  Writeln('Максимальный элемент в списке: ', MaxValue);
  Writeln('Минимальный элемент в списке: ', MinValue);
end.
