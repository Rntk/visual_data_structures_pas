procedure AddInEnd(var Last : PList; Data : DataType);
Begin
  New(Last^.Next); {�뤥����� ����� ��� ���� ������� � ��⠭���� �裡}
  Last^.Next^.Prev := Last; {��⠭���� �裡}
  Last := Last^.Next; {��������� 㪠��⥫� �� ��᫥���� �������}
  Last^.Data := Data; {���������� ���� ������}
  Last^.Next := nil; {���樠������ ��뫪�}
End;