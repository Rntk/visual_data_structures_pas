procedure AddInQueue(var Last : PQueue; Data : DataType);
Begin
  New(Last^.Next); {выделение памяти под новый элемент и установка связи}
  Last := Last^.Next; {сохранение ссылки на последний элемент}
  Last^.Next := nil;  {инициализация ссылки}
  Last^.Data := Data; {заполнение поля данных}
End;