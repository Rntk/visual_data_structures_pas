procedure PushInStack(var Top : PStack; Data : DataType);
var
  Temp : PStack; {�ᯮ����⥫쭠� ��६�����}
Begin
  New(Temp); {�뤥����� ����� ��� ���� �����}
  Temp^.Data := Data; {���������� ���� ������}
  Temp^.Next := Top; {��⠭���� �裡}
  Top := Temp; {��������� 㪠��⥫� �� ���設�}
End;