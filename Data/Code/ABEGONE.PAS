procedure AddInBegin(var Head : PList; Data : DataType);
var
  Temp : PList; {�ᯮ����⥫쭠� ��६�����}
Begin
  New(Temp); {�뤥����� ����� ��� ���� �������}
  Temp^.Data := Data; {���������� ���� ������}
  Temp^.Next := Head; {��⠭���� �裡}
  Head := Temp; {��������� 㪠��⥫� �� ������}
End;
