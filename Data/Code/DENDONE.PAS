procedure DelFromEnd(var Prev, Last : PList);
Begin
  Last := Prev; {��������� 㪠��⥫� �� ��᫥���� �������}
  Dispose(Last^.Next); {㭨�⮦���� �������}
  Last^.Next := nil; {���樠������ ��뫪�}
End;