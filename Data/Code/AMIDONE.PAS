procedure AddInMiddle(var Prev : PList; Data : DataType);
var
  Temp : PList; {вспомогательная переменная}
Begin
  New(Temp); {выделение памяти под новый элемент}
  Temp^.Data := Data; {заполнение поля данных}
  Temp^.Next := Prev^.Next; {установка связи}
  Prev^.Next := Temp; {установка связи}
End;