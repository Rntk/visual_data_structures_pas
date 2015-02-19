function PopFromStack(var Top : PStack) : DataType;
var
  Temp : PStack;
Begin
  Temp := Top; {сохранение указателя на вершину стека}
  Top := Top^.Next; {вершиной стека становится следующий элемент}
  PopFromStack := Temp^.Data; {сохранение данных}
  Dispose(Temp); {уничтожение элемента}
End;