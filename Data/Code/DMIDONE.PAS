procedure DelFromMiddle(var Prev : PList);
var
  Temp : PList; {вспомогательная переменная}
Begin
  Temp := Prev^.Next; {сохранение ссылки на удаляемый элемент}
  Prev^.Next := Temp^.Next; {изменение ссылки на следующий элемент}
  Dispose(Temp); {уничтожение элемента}
End;