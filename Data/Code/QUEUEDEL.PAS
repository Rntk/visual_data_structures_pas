function DelFromQueue(var First : PQueue) : DataType;
var
  Temp : PQueue;
Begin
  Temp := First; {сохранение указателя на первый эелемент очереди}
  First := First^.Next; {первым становится следующий элемент}
  DelFromQueue := Temp^.Data; {сохранение данных}
  Dispose(Temp); {уничтожение элемента}
End;