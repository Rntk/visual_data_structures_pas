procedure DelFromBegin(var Head : PList);
var
  Temp : PList; {�ᯮ����⥫쭠� ��६�����}
Begin
  Temp := Head; {��࠭���� ��뫪� �� 㤠�塞� �������}
  Head := Head^.Next; {��������� 㪠��⥫� �� ������}
  Dispose(Temp); {㭨�⮦���� �������}
End;