procedure AddInMiddle(var Prev : PList; Data : DataType);
var
  Temp : PList; {�ᯮ����⥫쭠� ��६�����}
Begin
  New(Temp); {�뤥����� ����� ��� ���� �������}
  Temp^.Data := Data; {���������� ���� ������}
  Temp^.Next := Prev^.Next; {��⠭���� �裡}
  Prev^.Next := Temp; {��⠭���� �裡}
End;