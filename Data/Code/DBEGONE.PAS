procedure DelFromBegin(var Head : PList);
var
  Temp : PList; {вспомогательная переменная}
Begin
  Temp := Head; {сохранение ссылки на удаляемый элемент}
  Head := Head^.Next; {изменение указателя на голову}
  Dispose(Temp); {уничтожение элемента}
End;