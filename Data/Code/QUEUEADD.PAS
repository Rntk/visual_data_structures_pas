procedure AddInQueue(var Last : PQueue; Data : DataType);
Begin
  New(Last^.Next); {�뤥����� ����� ��� ���� ������� � ��⠭���� �裡}
  Last := Last^.Next; {��࠭���� ��뫪� �� ��᫥���� �������}
  Last^.Next := nil;  {���樠������ ��뫪�}
  Last^.Data := Data; {���������� ���� ������}
End;