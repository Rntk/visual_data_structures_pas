function PopFromStack(var Top : PStack) : DataType;
var
  Temp : PStack;
Begin
  Temp := Top; {��࠭���� 㪠��⥫� �� ���設� �⥪�}
  Top := Top^.Next; {���設�� �⥪� �⠭������ ᫥���騩 �������}
  PopFromStack := Temp^.Data; {��࠭���� ������}
  Dispose(Temp); {㭨�⮦���� �������}
End;