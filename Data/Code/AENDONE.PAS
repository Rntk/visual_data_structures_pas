procedure AddInEnd(var Last : PList; Data : DataType);
Begin
  New(Last^.Next); {�뤥����� ����� ��� ���� ������� � ��⠭���� �裡}
  Last := Last^.Next; {��࠭���� ��뫪� �� ��᫥���� �������}
  Last^.Next := nil;  {���樠������ ��뫪�}
  Last^.Data := Data; {���������� ���� ������}
End;