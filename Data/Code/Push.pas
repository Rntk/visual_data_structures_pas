procedure PushInStack(var Top : PStack; Data : DataType);
var
  Temp : PStack; {вспомогательная переменная}
Begin
  New(Temp); {выделение памяти под новый элемент}
  Temp^.Data := Data; {заполнение поля данных}
  Temp^.Next := Top; {установка связи}
  Top := Temp; {изменения указателя на вершину}
End;