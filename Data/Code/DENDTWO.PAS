procedure DelFromEnd(var Last : PList);
Begin
  Last := Last^.Prev; {��������� 㪠��⥫� �� ��᫥���� �������}
  Dispose(Last^.Next); {㭨�⮦���� �������}
  Last^.Next := nil; {���樠������ ��뫪�}
End;