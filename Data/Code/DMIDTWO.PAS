procedure DelFromMiddle(var DelEl : PList);
var
  Temp : PList; {�ᯮ����⥫쭠� ��६�����}
Begin
  Temp := DelEl; {��࠭���� ��뫪� �� 㤠�塞� �������}
  DelEl^.Prev^.Next := DelEl^.Next; {��⠭���� �裡}
  DelEl^.Next^.Prev := DelEl^.Prev; {��⠭���� �裡}
  Dispose(Temp); {㭨�⮦���� �������}
End;