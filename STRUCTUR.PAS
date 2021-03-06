Unit Structures;

Interface

Uses
  StrList;

Type

  DartDirections = (ddUp, ddLeft, ddRight, ddDown); {���ࠢ����� ��५��}

  VisProcType = procedure (CurStr : Byte); {���. ���. �⮡�. ࠡ��� �����⬮�}

procedure ElementOneLink(x1, y1 : Integer; NeedDart, NeedData : Byte);
procedure ElementTwoLink(x1, y1 : Integer;  LeftDart, RightDart, NeedData : Byte);
procedure Dart(x1, y1, x2, y2 : Integer; DartDirection : DartDirections; Selected : Byte);
procedure PaintFullListOne(x, y : Integer);
procedure PaintFullListTwo(x, y : Integer);
function  FillList(var L : TList; FileName : String) : Boolean;
procedure Info(WindowTitle, FileName : String);
procedure CodeSelect(StLst : TList; SelStr, Frst, Lst : Word);
procedure CodeScroll(FileName : String; Proc : VisProcType);
procedure InitStack;
procedure InitOneLink;
procedure InitTwoLink;
procedure InitQueue;

procedure VisualAddBeginOneLink(CurStr : Byte); far;
procedure VisualAddMiddleOneLink(CurStr : Byte); far;
procedure VisualAddEndOneLink(CurStr : Byte); far;
procedure VisualDelBeginOneLink(CurStr : Byte); far;
procedure VisualDelMiddleOneLink(CurStr : Byte); far;
procedure VisualDelEndOneLink(CurStr : Byte); far;

procedure VisualAddBeginTwoLink(CurStr : Byte); far;
procedure VisualAddMiddleTwoLink(CurStr : Byte); far;
procedure VisualAddEndTwoLink(CurStr : Byte); far;
procedure VisualDelBeginTwoLink(CurStr : Byte); far;
procedure VisualDelMiddleTwoLink(CurStr : Byte); far;
procedure VisualDelEndTwoLink(CurStr : Byte); far;

procedure VisualAddInQueue(CurStr : Byte); far;
procedure VisualDelFromQueue(CurStr : Byte); far;

procedure VisualPushInStack(CurStr : Byte); far;
procedure VisualPopFromStack(CurStr : Byte); far;

Implementation

Uses Graph, GraphMode, Crt;

{------------------����᪠� ���樠������ �⥪�---------------------}
procedure InitStack;
Begin
  OutTextXY(122, 1, 'Top');
  Dart(135, 15, 135, 30, ddDown, 1);
  OutTextXY(390, 35, 'Nil');
  SavePicture;
End;
{-----------------------------�����------------------------------------}

{------------����᪠� ���樠������ �����吝��� ᯨ᪠-------------}
procedure InitOneLink;
Begin
  OutTextXY(120, 1, 'Head');
  Dart(135, 15, 135, 30, ddDown, 1);
  Dart(345, 15, 345, 30, ddDown, 1);
  OutTextXY(330, 1, 'Last');
  OutTextXY(390, 35, 'Nil');
  SavePicture;
End;
{-----------------------------�����------------------------------------}

{------------����᪠� ���樠������ ����吝��� ᯨ᪠--------------}
procedure InitTwoLink;
Begin
  OutTextXY(110, 1, 'Head');
  Dart(125, 15, 125, 30, ddDown, 1);
  OutTextXY(65, 25, 'Nil');
  OutTextXY(380, 45, 'Nil');
  Dart(335, 15, 335, 30, ddDown, 1);
  OutTextXY(320, 1, 'Last');
  SavePicture;
End;
{-----------------------------�����------------------------------------}

{------------------����᪠� ���樠������ ��।�-------------------}
procedure InitQueue;
Begin
  OutTextXY(60, 1, 'First');
  Dart(75, 15, 75, 30, ddDown, 1);
  OutTextXY(330, 35, 'Nil');
  Dart(285, 15, 285, 30, ddDown, 1);
  OutTextXY(270, 1, 'Last');
  SavePicture;
End;
{-----------------------------�����------------------------------------}

{------------------------�뢮� ⥮ਨ----------------------------------}
procedure Info(WindowTitle, FileName : String);
var
  F : Text;
  StList : TList;
  x, y, StringCount : Integer;
  i : Integer;
Begin
  x := 2; y := 2;
  Assign(F, FileName);
  if not FillList(StList, FileName) then Exit; {�᫨ 䠩� ���������, � ��室}
  StringCount := 0;
  ControlKey('ENTER - ��室');
  SetWindow(0, 0, MaxX, MaxY - 30, WindowTitle);
  for i := 1 to StList.GetCount do
    begin
      OutTextXY(x, y, StList.GetData(i));
      Inc(y, TextHeight('H') + 5);
      if (i mod 27 = 0) then {�᫨ ��諨 �� "����" ��࠭�, �}
        begin
          repeat
            ControlKey('ESC - ��室   ENTER - �த������');
            case ReadKey of {����� ��� ��.}
              Esc   : begin {��室}
                        StList.Destroy;
                        ClearDevice;
                        InitWindow;
                        Exit;
                      end;
              Enter : begin {�த������ �뢮� � "��砫�" ��࠭�}
                        x := 2;
                        y := 5;
                        ControlKey('ENTER - ��室');
                        SetWindow(0, 0, MaxX, MaxY - 30, WindowTitle);
                        MoveTo(x, y); {��३� � "��砫�" ��࠭�}
                        Break;
                      end;
            end;
          until False;
        end;
    end;
  readln;
  StList.Destroy;
  ClearDevice;
  InitWindow;
End;
{--------------------------�����---------------------------------------}

{-------------------------��५��--------------------------------------}
procedure Dart(x1, y1, x2, y2 : Integer; DartDirection : DartDirections; Selected : Byte);
const
  dWidth = 8;
  dHeight = 3;
Begin
  if Selected = 2 then SetColor(ColorTheme.Select);
  Line(x1, y1, x2, y2);
  case DartDirection of
    ddLeft :  begin{ <- ����� }
                Line(x1, y1, x1 + dWidth, y1 + dHeight);
                Line(x1, y1, x1 + dWidth, y1 - dHeight);
              end;
    ddRight : begin{ -> ��ࠢ�}
                Line(x2, y2, x2 - dWidth, y2 + dHeight);
                Line(x2, y2, x2 - dWidth, y2 - dHeight);
              end;
    ddUp    : begin {/\ �����}
                Line(x1, y1, x1 - dHeight, y1 + dWidth);
                Line(x1, y1, x1 + dHeight, y1 + dWidth);
              end;
    ddDown  : begin {\/ ����}
                Line(x2, y2, x2 + dHeight, y2 - dWidth);
                Line(x2, y2, x2 - dHeight, y2 - dWidth);
              end;
  end;
  SetColor(ColorTheme.Text);
End;
{--------------------------�����---------------------------------------}

{---------------���� ������� �����吝��� ᯨ᪠---------------------}
procedure ElementOneLink(x1, y1 : Integer; NeedDart, NeedData : Byte);
const
  ElementSize = 50;
var
  x2, y2 : Integer;
Begin
  x2 := x1 + ElementSize; {����祭�� ���न���}
  y2 := y1 + ElementSize; {��ன �窨}
  Rectangle(x1, y1, x2, y2);
  Line(x1, y2 - 10, x2, y2 - 10);
  with DefaultFont do
    begin
      SetTextStyle(Font, Direction, 4);
      OutTextXY(x1 + 8, y2 - 10, 'NEXT');
      SetTextStyle(Font, Direction, CharSize);
    end;
  if NeedDart > 0 then  {0 - ��� ��५��, 1 - � ��५���, 2 - � �뤥������ ��५���}
    begin
      if NeedDart = 2 then SetColor(ColorTheme.Select);
        Line(x2, y2 - 5, x2 + 10, y2 - 5);
        Line(x2 + 10, y2 - 5, x2 + 10, y1 + 20);
        Dart(x2 + 10, y1 + 20, x2 + 20, y1 + 20, ddRight, NeedDart);
        SetColor(ColorTheme.Text);
    end;
  if NeedData > 0 then {0 - ��� Data, 1 - � Data, 2 - ��������� Data}
    begin
      if NeedData = 2 then SetColor(ColorTheme.Select);
      OutTextXY(x1 + 7, y1 + 10, 'Data');
      SetColor(ColorTheme.Text);
    end;
End;
{--------------------------�����---------------------------------------}

{---------------���� ������� ����吝��� ᯨ᪠----------------------}
procedure ElementTwoLink(x1, y1 : Integer;  LeftDart, RightDart, NeedData : Byte);
const
  ElementSize = 50;
var
  x2, y2 : Integer;
Begin
  x2 := x1 + ElementSize; {����祭�� ���न���}
  y2 := y1 + ElementSize; {��ன �窨}
  Rectangle(x1, y1, x2, y2);
  Line(x1, y2 - 10, x2, y2 - 10);
  Line(x1, y1 + 10, x2, y1 + 10);
  with DefaultFont do
    begin
      SettextStyle(Font, Direction, 4);
      OutTextXY(x1 + 8, y2 - 10, 'NEXT');
      OutTextXY(x1 + 8, y1, 'PREV');
      SetTextStyle(Font, Direction, CharSize);
    end;
  if RightDart > 0 then {0 - ��� ��. ��५��, 1 - � ��. ��५���, 2 - � ��. �뤥������ ��५���}
    begin
      if RightDart = 2 then SetColor(ColorTheme.Select);
      Line(x2, y2 - 5, x2 + 10, y2 - 5); {-}
      Line(x2 + 10, y2 - 5, x2 + 10, y1 + 34); {|}
      Dart(x2 + 10, y1 + 34, x2 + 20, y1 + 34, ddRight, RightDart); {->}
      SetColor(ColorTheme.Text);
    end;
  if LeftDart > 0 then {0 - ��� ���. ��५��, 1 - � ���. ��५���, 2 - � ���. �뤥������ ��५���}
    begin
      if LeftDart = 2 then SetColor(ColorTheme.Select);
      Line(x1 - 10, y1 + 5, x1, y1 + 5); {-}
      Line(x1 - 10, y1 + 5, x1 - 10, y1 + 16); {|}
      Dart(x1 - 20, y1 + 16, x1 - 10, y1 + 16, ddLeft, LeftDart); {<-}
      SetColor(ColorTheme.Text);
    end;
  if NeedData > 0 then {0 - ��� Data, 1 - � Data, 2 - ��������� Data}
    begin
      if NeedData = 2 then SetColor(ColorTheme.Select);
      OutTextXY(x1 + 7, y1 + 15, 'Data');
      SetColor(ColorTheme.Text);
    end;
End;
{--------------------------�����---------------------------------------}

{---------------------1-�吝� ᯨ᮪---------------------------------}
procedure PaintFullListOne(x, y : Integer);
var
  i : Byte;
Begin
  for i := 1 to 4 do
    begin
      ElementOneLink(x, y, 1, 1);
      Inc(x, 70);
    end;
End;
{--------------------------�����---------------------------------------}

{---------------------2-�吝� ᯨ᮪---------------------------------}
procedure PaintFullListTwo(x, y : Integer);
var
  i : Byte;
Begin
  for i := 1 to 4 do
    begin
      ElementTwoLink(x, y, 1, 1, 1);
      Inc(x, 70);
    end;
End;
{--------------------------�����---------------------------------------}

{-------------------���������� ᯨ᪠----------------------------------}
function FillList(var L : TList; FileName : String) : Boolean;
var
  F : Text;
  Error : Integer;
  Strk : String;
Begin
  Assign(F, FileName);
  {$I-}
  Reset(F);
  {$I+}
  if IOResult <> 0 {�᫨ 䠩� ���������, �}
    then
      begin
        FillList := False;
        ColorTheme.Border1 := Red;                                 {}
        ColorTheme.Border2 := Red;                                 {}
        SetWindow(150, 200, 450, 350, '�訡��');                   {}{�뢮� ���� � ᮮ�饭���}
        OutTextXY(10, 10, '���� '+ FileName + ' �� ������!!!');    {}
        OutTextXY(10, 30, '���� ��������� ��� ��२�������!!!'); {}
        OutTextXY(10, 50, '������ ENTER ��� �த�������...');     {}
        readln;
        ColorTheme.Border1 := LightBlue;
        ColorTheme.Border2 := Cyan;
        ClearDevice;
      end
    else {����}
      begin
        L.Create;
        while not EOF(F) do    {}
          begin                {}{���뢠��� ��� ��ப}
            Readln(F, Strk);   {}{�� 䠩�� � ᯨ᮪}
            L.AddString(Strk); {}
          end;
        Close(F);
      end;
End;
{--------------------------�����---------------------------------------}

{---------------------�뢮� � �뤥����� ����--------------------------}
procedure CodeSelect(StLst : TList; SelStr, Frst, Lst : Word);
var
  i, TxtWidth : Word;
  y : Integer;
Begin
  y := 10;
  TxtWidth := TextWidth('H') + 5; {�����뢠��� ����� ⥪��}
  ControlKey('F7 - ������騩 ������   ESC - ��室');
  SetWindow(0, 205, MaxX, MaxY - 30, '��室�� ���');
  for i := Frst to Lst do
    begin
      if (i <> SelStr) {�᫨ ⥪��� ��ப� �� �뤥����, �}
        then
          begin
            SetColor(ColorTheme.Text);          {}{�뢥�� �� 梥⮬}
            OutTextXY(10, y, StLst.GetData(i)); {}{���筮�� ⥪��}
          end
        else {����}
          begin
            SetColor(ColorTheme.Select);       {}{�뢥�� �� � ᬥ饭��� �}
            OutTextXY(5, y, StLst.GetData(i)); {}{梥⮬ �뤥�����}
          end;
      Inc(y, TxtWidth); {"��६�饭��" �� ��ப� ����}
    end;
End;
{--------------------------�����---------------------------------------}

{----------------�ப��⪠ � �뤥����� ����----------------------------}
procedure CodeScroll(FileName : String; Proc : VisProcType);
var
  StList : TList;
  i : Byte;
  CurrentStr, F, L : Word;
  Key : Char;
Begin
  if FillList(StList, FileName) then
    begin
      for i := 1 to 5 do                                     {}{��宦����� ��ࢮ�}
        if StList.GetData(i) = 'Begin' then CurrentStr := i; {}{��ப� ����}
      F := 1; {������ ��ࢮ� ��ப�}
      L := 10; {������ ��᫥���� ��ப�}
      if StList.GetCount <= L then L := StList.GetCount; {���४�஢�� ����樨 ��᫥���� ��ப�}
      while CurrentStr <> StList.GetCount do
        begin
          Inc(CurrentStr); {ᬥ饭�� �뤥�����}
          if CurrentStr > L then
            begin
              Inc(F); {}{ᤢ�� ����}
              Inc(L); {}
            end;
          CodeSelect(StList, CurrentStr, F, L);
          PaintPicture;
          Proc(CurrentStr);
          SavePicture;
          repeat
            Key := ReadKey;
            if Key = KodUpravl then Key := ReadKey;
            case Key of
              F7 : begin
                     if StList.GetCount = CurrentStr then
                       begin
                         F := 1;
                         L := 10;
                         if StList.GetCount <= L then L := StList.GetCount;
                       end;
                     Break;
                   end;
              Esc : begin
                      InitWindow;
                      Exit;
                    end;
            end;
          until False;
        end;
    end;
  InitWindow;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� ���������� � ��砫� �����吝��� ᯨ᪠-----------}
procedure VisualAddBeginOneLink(CurStr : Byte);
Begin
  case CurStr of
    7 : begin
          ElementOneLink(40, 30, 0, 0);
          Dart(10, 55, 40, 55, ddRight, 2);
          OutTextXY(5, 35, 'Temp');
        end;
    8 : begin
          Dart(10, 55, 40, 55, ddRight, 1);
          ElementOneLink(40, 30, 0, 2);
        end;
    9 : ElementOneLink(40, 30, 2, 1);
    10 : begin
           ElementOneLink(40, 30, 1, 1);
           Bar(100, 1, 160, 29);
           Dart(65, 15, 65, 30, ddDown, 2);
           OutTextXY(50, 1, 'Head');
         end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� ���������� � �।��� �����吝��� ᯨ᪠---------}
procedure VisualAddMiddleOneLink(CurStr : Byte);
Begin
  case CurStr of
    6 : begin
          Dart(205, 15, 205, 30, ddDown, 1);
          OutTextXY(190, 1, 'Prev');
        end;
    7 : begin
          Dart(205, 15, 205, 30, ddDown, 1);
          ElementOneLink(180, 95, 0, 0);
          Dart(150, 120, 180, 120, ddRight, 2);
          OutTextXY(130, 105, 'Temp');
        end;
    8 : begin
          Dart(150, 120, 180, 120, ddRight, 1);
          ElementOneLink(180, 95, 0, 2);
        end;
    9 : begin
          ElementOneLink(180, 95, 0, 1);
          ElementOneLink(180, 30, 2, 1);
          Line(230, 75, 240, 75);
          SetColor(ColorTheme.Select);
          Line(230, 140, 240, 140);
          Line(240, 140, 240, 75);
        end;
    10 : begin
           SetColor(ColorTheme.Text);
           ElementOneLink(180, 30, 1, 1);
           Line(230, 140, 240, 140);
           Line(240, 140, 240, 75);
           Bar(231, 60, 239, 80);
           Dart(205, 80, 205, 95, ddDown, 2);
         end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� ���������� � ����� �����吝��� ᯨ᪠------------}
procedure VisualAddEndOneLink(CurStr : Byte);
Begin
  case CurStr of
    5 : begin
          Bar(390, 30, 410, 49);
          ElementOneLink(320, 30, 2, 1);
          ElementOneLink(390, 30, 0, 0);
        end;
    6 : begin
          ElementOneLink(320, 30, 1, 1);
          Bar(320, 1, 360, 29);
          Dart(415, 15, 415, 30, ddDown, 2);
          OutTextXY(400, 1, 'Last');
        end;
    7 : begin
          Dart(415, 15, 415, 30, ddDown, 1);
          ElementOneLink(390, 30, 2, 0);
          OutTextXY(445, 35, 'Nil');
        end;
    8 : begin
          ElementOneLink(390, 30, 1, 0);
          ElementOneLink(390, 30, 1, 2);
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� 㤠����� �� ��砫� �����吝��� ᯨ᪠------------}
procedure VisualDelBeginOneLink(CurStr : Byte);
Begin
  case CurStr of
    7 : begin
          Dart(70, 50, 110, 50, ddRight, 2);
          OutTextXY(60, 35, 'Temp');
        end;
    8 : begin
          Dart(70, 50, 110, 50, ddRight, 1);
          Bar(120, 1, 160, 29);
          Dart(205, 15, 205, 30, ddDown, 2);
          OutTextXY(190, 1, 'Head');
        end;
    9 : begin
          Dart(205, 15, 205, 30, ddDown, 1);
          Bar(50, 30, 179, 80);
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� 㤠����� �� �।��� �����吝��� ᯨ᪠----------}
procedure VisualDelMiddleOneLink(CurStr : Byte);
Begin
  case CurStr of
    6 : begin
          Dart(90, 50, 110, 50, ddRight, 1);
          OutTextXY(75, 30, 'Prev');
        end;
    7 : begin
          Dart(90, 50, 110, 50, ddRight, 1);
          Dart(205, 15, 205, 30, ddDown, 2);
          OutTextXY(190, 2, 'Temp');
        end;
    8 : begin
          Dart(205, 15, 205, 30, ddDown, 1);
          Bar(171, 30, 179, 60);
          SetColor(ColorTheme.Select);
          Line(160, 75, 170, 75);
          Line(170, 75, 170, 1);
          Line(170, 1, 240, 1);
          Line(240, 1, 240, 50);
          Dart(240, 50, 250, 50, ddRight, 2);
        end;
    9 : begin
          SetColor(ColorTheme.Text);
          Line(170, 55, 170, 1);
          Line(170, 1, 240, 1);
          Line(240, 1, 240, 50);
          Bar(170, 1, 240, 80);
          Dart(170, 50, 250, 50, ddRight, 2);
          SetColor(ColorTheme.Select);
          Line(170, 50, 170, 75)
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� 㤠����� �� ���� �����吝��� ᯨ᪠-------------}
procedure VisualDelEndOneLink(CurStr : Byte);
Begin
  case CurStr of
    4 : begin
          Dart(275, 80, 275, 95, ddUp, 1);
          OutTextXY(260, 95, 'Prev');
        end;
    5 : begin
          Dart(275, 80, 275, 95, ddUp, 1);
          Bar(320, 1, 370, 29);
          Dart(275, 15, 275, 30, ddDown, 2);
          OutTextXY(260, 1, 'Last');
        end;
    6 : begin
          Dart(275, 15, 275, 30, ddDown, 1);
          Bar(301, 30, 410, 80);
        end;
    7 : begin
          ElementOneLink(250, 30, 2, 1);
          OutTextXY(320, 35, 'Nil');
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� ���������� � ��砫� ����吝��� ᯨ᪠------------}
procedure VisualAddBeginTwoLink(CurStr : Byte);
Begin
  case CurStr of
    5 : begin
          ElementTwoLink(100, 30, 2, 1, 1);
          Bar(60, 20, 80, 50);
          ElementTwoLink(30, 30, 0, 0, 0);
        end;
    6 : begin
          ElementTwoLink(100, 30, 1, 1, 1);
          ElementTwoLink(30, 30, 0, 2, 0);
        end;
    7 : begin
          ElementTwoLink(30, 30, 0, 1, 0);
          Bar(100, 1, 140, 29);
          Dart(55, 15, 55, 30, ddDown, 2);
          OutTextXY(40, 1, 'Head');
        end;
    8 : begin
          Dart(55, 15, 55, 30, ddDown, 1);
          ElementTwoLink(30, 30, 2, 1, 0);
          OutTextXY(1, 32, 'Nil');
        end;
    9 : begin
          ElementTwoLink(30, 30, 1, 1, 0);
          ElementTwoLink(30, 30, 0, 0, 2);
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� ���������� � �।��� ����吝��� ᯨ᪠----------}
procedure VisualAddMiddleTwoLink(CurStr : Byte);
Begin
  case CurStr of
    6 : begin
          Dart(195, 15, 195, 30, ddDown, 1);
          OutTextXY(180, 1, 'Prev');
        end;
    7 : begin
          ElementTwoLink(170, 95, 0, 0, 0);
          Dart(150, 120, 170, 120, ddRight, 2);
          OutTextXY(120, 105, 'Temp');
        end;
    8 : begin
          Dart(150, 120, 170, 120, ddRight, 1);
          ElementTwoLink(170, 95, 0, 0, 2);
        end;
    9 : begin
          ElementTwoLink(170, 30, 0, 2, 1);
          ElementTwoLink(170, 95, 0, 0, 1);
          Line(220, 75, 230, 75);
          SetColor(ColorTheme.Select);
          Line(220, 140, 230, 140);
          Line(230, 140, 230, 75);
        end;
    10 : begin
           ElementTwoLink(170, 30, 0, 1, 1);
           ElementTwoLink(100, 30, 0, 2, 1);
           SetColor(ColorTheme.Text);
           Line(150, 75, 160, 75);
           Line(220, 140, 230, 140);
           Line(230, 140, 230, 75);
           SetColor(ColorTheme.Select);
           Line(160, 100, 170, 100);
           Line(160, 100, 160, 75);
         end;
    11 : begin
           ElementTwoLink(100, 30, 0, 1, 1);
           SetColor(ColorTheme.Text);
           Line(160, 100, 170, 100);
           Line(160, 100, 160, 75);
           Bar(221, 60, 229, 80);
           Dart(195, 80, 195, 95, ddDown, 2);
         end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� ���������� � ����� ����吝��� ᯨ᪠-------------}
procedure VisualAddEndTwoLink(CurStr : Byte);
Begin
  case CurStr of
    5 : begin
          ElementTwoLink(310, 30, 0, 2, 0);
          Bar(380, 30, 440, 60);
          ElementTwoLink(380, 30, 0, 0, 0);
        end;
    6: begin
         ElementTwoLink(310, 30, 0, 1, 0);
         ElementTwoLink(380, 30, 2, 0, 0);
       end;
    7 : begin
          ElementTwoLink(380, 30, 1, 0, 0);
          Bar(280, 1, 350, 29);
          Dart(405, 15, 405, 30, ddDown, 2);
          OutTextXY(390, 1, 'Last');
        end;
    8 : begin
          Dart(405, 15, 405, 30, ddDown, 1);
          ElementTwoLink(380, 30, 0, 0, 2);
        end;
    9 : begin
          ElementTwoLink(380, 30, 1, 2, 1);
          OutTextXY(445, 45, 'Nil');
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� 㤠����� �� ��砫� ����吝��� ᯨ᪠-------------}
procedure VisualDelBeginTwoLink(CurStr : Byte);
Begin
  case CurStr of
    5 : begin
          Bar(100, 1, 140, 29);
          Dart(195, 15, 195, 30, ddDown, 2);
          OutTextXY(180, 1, 'Head');
        end;
    6 : begin
          Dart(195, 15, 195, 30, ddDown, 1);
          Bar(50, 25, 169, 80);
        end;
    7 : begin
          ElementTwoLink(170, 30, 2, 1, 1);
          OutTextXY(130, 30, 'Nil');
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{-------���㠫����� 㤠����� �� �।��� ����吝��� ᯨ᪠-----------}
procedure VisualDelMiddleTwoLink(CurStr : Byte);
Begin
  case CurStr of
    6 : begin
          Dart(195, 15, 195, 30, ddDown, 1);
          OutTextXY(180, 2, 'DelEl');
        end;
    7 : begin
          Dart(195, 15, 195, 30, ddDown, 1);
          Dart(195, 80, 195, 95, ddUp, 2);
          OutTextXY(180, 95, 'Temp');
        end;
    8 : begin
          Dart(195, 80, 195, 95, ddUp, 1);
          Bar(160, 50, 169, 75);
          ElementTwoLink(170, 30, 1, 2, 1);
          Line(220, 75, 230, 75);
          SetColor(ColorTheme.Select);
          Line(150, 75, 160, 75);
          Line(160, 75, 160, 110);
          Line(160, 110, 230, 110);
          Line(230, 110, 230, 70);
        end;
    9 : begin
          SetColor(ColorTheme.Text);
          ElementTwoLink(170, 30, 1, 1, 1);
          Line(150, 75, 160, 75);
          Line(160, 75, 160, 110);
          Line(160, 110, 230, 110);
          Line(230, 110, 230, 70);
          Bar(221, 30, 230, 49);
          ElementTwoLink(170, 30, 2, 1, 1);
          Line(160, 35, 170, 35);
          SetColor(ColorTheme.Select);
          Line(230, 35, 240, 35);
          Line(230, 1, 230, 35);
          Line(160, 1, 230, 1);
          Line(160, 1, 160, 35);
        end;
    10 : begin
           ElementTwoLink(170, 30, 1, 1, 1);
           SetColor(ColorTheme.Text);
           Line(230, 1, 230, 35);
           Line(160, 1, 230, 1);
           Line(160, 1, 160, 35);
           Bar(160, 1, 230, 110);
           Bar(151, 40, 160, 50);
           Bar(230, 50, 239, 70);
           SetColor(ColorTheme.Select);
           Line(230, 35, 230, 45);
           Line(160, 75, 160, 65);
           Line(150, 75, 160, 75);
           Dart(150, 45, 230, 45, ddLeft, 2);
           Dart(160, 65, 240, 65, ddRight, 2);
         end;
  end;
End;
{--------------------------�����---------------------------------------}

{----------���㠫����� 㤠����� �� ���� ����吝��� ᯨ᪠-----------}
procedure VisualDelEndTwoLink(CurStr : Byte);
Begin
  case CurStr of
    5 : begin
          Bar(260, 1, 350, 29);
          Dart(265, 15, 265, 30, ddDown, 2);
          OutTextXY(250, 1, 'Last');
        end;
    6 : begin
          Dart(265, 15, 265, 30, ddDown, 1);
          Bar(291, 30, 400, 80);
        end;
    7 : begin
          ElementTwoLink(240, 30, 1, 2, 1);
          OutTextXY(310, 45, 'Nil');
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{----------------���㠫����� ���������� � ��।�---------------------}
procedure VisualAddInQueue(CurStr : Byte);
Begin
  case CurStr of
    5 : begin
          ElementOneLink(260, 30, 2, 0);
          Bar(330, 30, 3400, 49);
          ElementOneLink(330, 30, 0, 0);
        end;
    6 : begin
          ElementOneLink(260, 30, 1, 0);
          Bar(250, 1, 320, 29);
          Dart(355, 15, 355, 30, ddDown, 2);
          OutTextXY(340, 1, 'Last');
        end;
    7 : begin
          Dart(355, 15, 355, 30, ddDown, 1);
          ElementOneLink(330, 30, 2, 0);
          OutTextXY(400, 35, 'Nil');
        end;
    8 : begin
          ElementOneLink(330, 30, 1, 0);
          ElementOneLink(330, 30, 1, 2);
        end;
  end;
End;
{--------------------------�����---------------------------------------}

{----------------���㠫����� 㤠����� �� ��।�----------------------}
procedure VisualDelFromQueue(CurStr : Byte);
Begin
  case CurStr of
    7 : begin
          Dart(20, 45, 50, 45, ddRight, 2);
          OutTextXY(10, 25, 'Temp');
        end;
    8 : begin
          Dart(20, 45, 50, 45, ddRight, 1);
          Bar(55, 1, 100, 29);
          OutTextXY(132, 1, 'First');
          Dart(145, 15, 145, 30, ddDown, 2);
        end;
    10 : begin
           Dart(145, 15, 145, 30, ddDown, 2);
           Bar(10, 1, 119, 80);
         end;
  end;
End;
{--------------------------�����---------------------------------------}

{----------------���㠫����� ���������� � �⥪------------------------}
procedure VisualPushInStack(CurStr : Byte);
Begin
  case CurStr of
    7 : begin
          ElementOneLink(40, 30, 0, 0);
          Dart(10, 45, 40, 45, ddRight, 2);
          OutTextXY(1, 25, 'Temp');
        end;
    8 : begin
          Dart(10, 45, 40, 45, ddRight, 1);
          ElementOneLink(40, 30, 0, 2);
        end;
    9 : ElementOneLink(40, 30, 2, 1);
    10 : begin
           ElementOneLink(40, 30, 1, 0);
           Bar(100, 1, 150, 29);
           Dart(65, 15, 65, 30, ddDown, 2);
           OutTextXY(52, 1, 'Top');
         end;
  end;
End;
{--------------------------�����---------------------------------------}

{----------------���㠫����� 㤠����� �� �⥪�------------------------}
procedure VisualPopFromStack(CurStr : Byte);
Begin
  case CurStr of
    7 : begin
          Dart(70, 50, 110, 50, ddRight, 2);
          OutTextXY(70, 35, 'Temp');
        end;
    8 : begin
          Dart(70, 50, 110, 50, ddRight, 1);
          Bar(100, 1, 150, 29);
          OutTextXY(192, 1, 'Top');
          Dart(205, 15, 205, 30, ddDown, 2);
        end;
    10 : begin
           Dart(205, 15, 205, 30, ddDown, 2);
           Bar(60, 30, 179, 80);
         end;
  end;
End;
{--------------------------�����---------------------------------------}

END.