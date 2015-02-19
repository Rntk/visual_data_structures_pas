procedure DelFromEnd(var Prev, Last : PList);
Begin
  Last := Prev; {изменение указателя на последний элемент}
  Dispose(Last^.Next); {уничтожение элемента}
  Last^.Next := nil; {инициализация ссылки}
End;