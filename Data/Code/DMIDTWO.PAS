procedure DelFromMiddle(var DelEl : PList);
var
  Temp : PList; {вспомогательная переменная}
Begin
  Temp := DelEl; {сохранение ссылки на удаляемый элемент}
  DelEl^.Prev^.Next := DelEl^.Next; {установка связи}
  DelEl^.Next^.Prev := DelEl^.Prev; {установка связи}
  Dispose(Temp); {уничтожение элемента}
End;