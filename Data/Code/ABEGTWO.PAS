procedure AddInBegin(var Head : PList; Data : DataType);
Begin
  New(Head^.Prev); {�뤥����� ����� ��� ���� ������� � ��⠭���� �裡}
  Head^.Prev^.Next := Head; {��⠭���� �裡}
  Head := Head^.Prev; {��������� 㪠��⥫� �� ������}
  Head^.Prev := nil; {���樠������ ��뫪�}
  Head^.Data := Data; {���������� ���� ������}
End;