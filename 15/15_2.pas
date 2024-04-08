program zd2;

type
  NodePtr=^Node;
  Node=record
    Word: string;
    Count: integer;
    Next: NodePtr;
  end;

var F: Text;
  Head, Current: NodePtr;
  WordCount: integer;

function LowerCase(const S: string): string; // Проверка и замена верхнего регистра на нижний
var i: integer;
begin
  Result:=S;
  for i:=1 to Length(S) do
    if (S[i]>='A') and (S[i]<='Z') then
      Result[i]:=Chr(Ord(S[i])+32);
end;

function CreateNode(Word: string): NodePtr; // Создание нового узла и возвращение указателя на него
var NewNode: NodePtr;
begin
  New(NewNode);
  NewNode^.Word:=LowerCase(Word);
  NewNode^.Count:=1;
  NewNode^.Next:=nil;
  CreateNode:=NewNode;
end;

function MakePlace(Word: string): NodePtr; // Поиск места для вставки нового узла в алф.п.
var Prev, Current: NodePtr;
begin
  Prev:=nil;
  Current:=Head;
  while (Current<>nil) and (LowerCase(Current^.Word)<LowerCase(Word)) do
  begin
    Prev:=Current;
    Current:=Current^.Next;
  end;
  MakePlace:=Prev;
end;

procedure AddBefore(NewNode, Place: NodePtr); // Вставка нового узла перед указанным местом
begin
  if Place=nil then
  begin
    NewNode^.Next:=Head;
    Head:=NewNode;
  end
  else
  begin
    NewNode^.Next:=Place^.Next;
    Place^.Next:=NewNode;
  end;
end;

function WordExists(Place: NodePtr; Word: string): Boolean; // Проверка существует ли слово в списке начиная с указанного места
begin
  WordExists:=(Place <> nil) and (Place^.Next <> nil) and (LowerCase(Place^.Next^.Word) = LowerCase(Word));
end;

procedure InsertOrUpdateWord(Word: string); // Вставка нового слова и увеличение счетчика
var NewNode, Place: NodePtr;
begin
  Place:=MakePlace(Word);
  if not WordExists(Place, Word) then
  begin
    NewNode:=CreateNode(Word);
    AddBefore(NewNode, Place);
  end
  else
    Inc(Place^.Next^.Count);
end;

procedure ProcessLine(Line: string); // Обарботка и разбитие строки, и обновление списка 
var Word: string;
  i, WordStart: Integer;
begin
  Line:=Line+' ';
  WordStart:=1;
  for i:=1 to Length(Line) do
  begin
    if Line[i] in [' '] then
    begin
      if i>WordStart then
      begin
        Word:=Copy(Line, WordStart, i-WordStart);
        InsertOrUpdateWord(Word);
      end;
      WordStart:=i+1;
    end;
  end;
end;

var EntireLine: string; // Переменная хранит всю строку
begin
  Assign(F, 'text.txt');
  Reset(F);
  ReadLn(F, EntireLine);
  Close(F);
  
  Head:=nil;
  ProcessLine(EntireLine);

  Current:=Head;
  while Current <> nil do
  begin
    Writeln(Current^.Word, ': ', Current^.Count);
    Current:=Current^.Next;
  end;

  WordCount:=0;
  Current:=Head;
  while Current <> nil do
  begin
    Inc(WordCount);
    Current:=Current^.Next;
  end;

  Writeln('Всего слов: ', WordCount);
end.
