procedure DelFromBegin(var Head : PList);
Begin
  Head := Head^.Next; {изменения указателя на голову}
  Dispose(Head^.Prev); {уничтожение элемента}
  Head^.Prev := nil; {инициализация ссылки}
End;