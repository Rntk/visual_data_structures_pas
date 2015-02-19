procedure AddInBegin(var Head : PList; Data : DataType);
var
  Temp : PList; {вспомогательная переменная}
Begin
  New(Temp); {выделение памяти под новый элемент}
  Temp^.Data := Data; {заполнение поля данных}
  Temp^.Next := Head; {установка связи}
  Head := Temp; {изменения указателя на голову}
End;
