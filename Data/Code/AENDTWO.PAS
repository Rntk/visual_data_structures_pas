procedure AddInEnd(var Last : PList; Data : DataType);
Begin
  New(Last^.Next); {выделение памяти под новый элемент и установка связи}
  Last^.Next^.Prev := Last; {установка связи}
  Last := Last^.Next; {изменение указателя на последний элемент}
  Last^.Data := Data; {заполнение поля данных}
  Last^.Next := nil; {инициализация ссылки}
End;