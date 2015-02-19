procedure DelFromEnd(var Last : PList);
Begin
  Last := Last^.Prev; {изменения указателя на последний элемент}
  Dispose(Last^.Next); {уничтожение элемента}
  Last^.Next := nil; {инициализация ссылки}
End;