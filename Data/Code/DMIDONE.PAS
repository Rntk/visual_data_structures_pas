procedure DelFromMiddle(var Prev : PList);
var
  Temp : PList; {�ᯮ����⥫쭠� ��६�����}
Begin
  Temp := Prev^.Next; {��࠭���� ��뫪� �� 㤠�塞� �������}
  Prev^.Next := Temp^.Next; {��������� ��뫪� �� ᫥���騩 �������}
  Dispose(Temp); {㭨�⮦���� �������}
End;