procedure AddInBegin(var Head : PList; Data : DataType);
Begin
  New(Head^.Prev); {выделение памяти под новый элемент и установка связи}
  Head^.Prev^.Next := Head; {установка связи}
  Head := Head^.Prev; {изменения указателя на голову}
  Head^.Prev := nil; {инициализация ссылки}
  Head^.Data := Data; {заполнение поля данных}
End;