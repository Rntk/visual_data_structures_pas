procedure DelFromBegin(var Head : PList);
Begin
  Head := Head^.Next; {��������� 㪠��⥫� �� ������}
  Dispose(Head^.Prev); {㭨�⮦���� �������}
  Head^.Prev := nil; {���樠������ ��뫪�}
End;