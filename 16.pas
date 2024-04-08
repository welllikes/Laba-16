program zd1;

type
  Stack=^StackNode;
  StackNode=record
    Data: integer;
    Next: Stack;
  end;

var InputFile, OutputFile: Text;
  NumberStack: Stack;
  Number: integer;

function Push(S: Stack; Data: integer): Stack;
var TempPtr: Stack;
begin
  New(TempPtr);
  TempPtr^.Data:=Data;
  TempPtr^.Next:=S;
  Push:=TempPtr;
end;

function Pop(var S: Stack): integer;
var TempPtr: Stack;
begin
  TempPtr:=S;
  Pop:=TempPtr^.Data;
  S:=TempPtr^.Next;
  Dispose(TempPtr);
end;

begin
  Assign(InputFile, 'input.txt');
  Reset(InputFile);

  Assign(OutputFile, 'output.txt');
  Rewrite(OutputFile);

  NumberStack:=nil;
  
  while not EOF(InputFile) do
  begin
    Readln(InputFile, Number);
    NumberStack:=Push(NumberStack, Number);
  end;

  while NumberStack<>nil do
  begin
    Number:=Pop(NumberStack);
    Writeln(OutputFile, Number);
  end;

  Close(InputFile);
  Close(OutputFile);
end.
