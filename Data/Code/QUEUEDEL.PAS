function DelFromQueue(var First : PQueue) : DataType;
var
  Temp : PQueue;
Begin
  Temp := First; {��࠭���� 㪠��⥫� �� ���� �������� ��।�}
  First := First^.Next; {���� �⠭������ ᫥���騩 �������}
  DelFromQueue := Temp^.Data; {��࠭���� ������}
  Dispose(Temp); {㭨�⮦���� �������}
End;