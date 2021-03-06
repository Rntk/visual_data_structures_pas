unit GraphMode;

interface

uses Crt, Graph, StrList;

type

  StringArr = array [1..6] of String[20];

  ColorType = record
                Text : Byte;
                Back : Byte;
                Border1, Border2 : Byte;
                Select : Byte;
              end;

const

  Menu    : StringArr = ('�����吝� ᯨ᮪', '����吝� ᯨ᮪', '��।�', '�⥪', '� �ணࠬ��','��室');
  SubMenu : StringArr = ('���������� �������', '�������� �������', '�����', '�����', '', '');
  MenuAdd : StringArr = ('� ��砫�', '� �।���', '� �����','�����', '', '');
  MenuRm  : StringArr = ('�� ��砫�', '�� �।���', '�� ����','�����', '' , '');

  Otstup     = 21;  {����ﭨ� ����� �㭪⠬� ����}

  KodUpravl  = #0;  {}
  Up         = #72; {}
  Down       = #80; {}{���� ��.}
  Esc        = #27; {}
  Enter      = #13; {}
  F7         = #65; {}

  PathTheory = 'Data\Theory\'; {���� � 䠩��� ⥮ਨ}
  PathCode   = 'Data\Code\';   {���� � 䠩��� � ��室�묨 ������}

var
  Driver, Mode, Font, MaxY, MaxX : Integer;
  DefaultFont : TextSettingsType;
  ColorTheme : ColorType;
  Picture : Pointer;
  Size : Word;

procedure InitGraphMode;
procedure SetWindow(x, y, x1, y1 : Integer;  Title : String);
function  MenuCursor(M : StringArr; Cnt : Byte) : Byte;
procedure MainMenu(M : StringArr; Count : Byte; PosY : Integer);
Procedure PrintText(LeftPos, TopPos : Integer; Text : String; Speed : Word);
procedure SavePicture;
procedure PaintPicture;
procedure ControlKey(Keys : String);
procedure AboutProgram;
procedure InitWindow;


implementation

{----------------------����� ⥪��-----------------------------------}
Procedure PrintText(LeftPos, TopPos : Integer; Text : String; Speed : Word);
var
  i : Byte;
  S : String;
Begin
  S := '';
  Speed := Speed * 10000;
  for i := 1 to Length(Text) do
    begin
      if KeyPressed then
        begin
          MoveTo(LeftPos, TopPos);
          OutText(Text);
          Exit;
        end;
      MoveTo(LeftPos, TopPos);
      S := Concat(S, Text[i]);
      OutText(S);
      Delay(Speed);
    end;
End;
{--------------------------�����---------------------------------------}

{----------------------� �ணࠬ��-----------------------------------}
procedure AboutProgram;
Begin
  repeat
    SetWindow(0, 0, MaxX, MaxY - 30, '� �ணࠬ��');
    SetTextStyle(2, 0, 5);
    PrintText(150, 1, '��������⢮ ��ࠧ������ � ��㪨', 1);
    PrintText(200, 20, '���㡫��� ������⠭', 1);
    PrintText(110, 40, '��࠭᪨� �㬠���୮ - �孨�᪨� �������', 1);
    PrintText(195, 60, '����� ���� �㭠������', 1);
    SetTextStyle(2, 0, 9);
    PrintText(150, 120, '���ᮢ�� �஥��', 1);
    SetTextStyle(2, 0, 5);
    PrintText(240, 150, '�� �।����:', 1);
    PrintText(120, 170, '<< �᭮�� �����⬨��樨 � �ணࠬ��஢���� >>', 1);
    PrintText(250, 190, '�� ⥬�:', 1);
    PrintText(150, 210, '<< ���㠫����� �����⬮� ࠡ��� �', 1);
    PrintText(170, 230, '�������᪨�� ������ࠬ� ������', 1);
    PrintText(200, 250, '(ᯨ᪨, �⥪, ��।�) >>', 1);
    PrintText(340, 270, '�㪮����⥫�:', 1);
    PrintText(350, 290, '������� �.�.', 1);
    PrintText(340, 310, '�믮����: ��. ��. ��� - 9-05', 1);
    PrintText(350, 330, '������� �.�.', 1);
    if KeyPressed then
      if ReadKey = Esc then Break
        else
          begin
            Delay(65535);
            Delay(65535);
            Delay(65535);
            Delay(65535);
            Delay(65535);
          end;
    Delay(65535);
    Delay(65535);
    Delay(65535);
  until False;
  ClearDevice;
End;
{--------------------------�����---------------------------------------}

{--------------------------���ᮢ�� ����-----------------------------}
procedure SetWindow(x,y,x1,y1:Integer; Title:String);
var
  PosX,PosY:Integer;
Begin
  PosX := x1 - x;
  PosY := y1 - y;
  SetViewPort(x, y, x1, y1, False);
  with ColorTheme do
    begin
      SetColor(DarkGray);
      SetFillStyle(1, Back);
      Bar(1, 1, PosX - 1, PosY - 1);
      SetColor(Border1);
      Rectangle(1, 1, PosX - 1, PosY - 1);
      Line(3, 20, PosX - 2, 20);
      SetColor(Border2);
      Rectangle(2, 2, PosX - 2, PosY - 2);
      Line(3, 21, PosX - 2, 21);
      SetColor(Text);
    end;
  OutTextXY(5, 7, Title); {�뢮� ��������� ����}
  SetViewPort(x + 5, y + 25, x1 - 5, y1 - 5 , True);
End;
{--------------------------�����---------------------------------------}

{-------------------------�뢮� ����-----------------------------------}
procedure MainMenu(M : StringArr; Count : Byte; PosY : Integer);
var
  i : Byte;
  Coord, Punkt : Integer;
Begin
  Coord := 10;
  SetWindow(0, 0, 160, 200, '����');
  Punkt := PosY mod 10;
  for i := 1 to Count do
    begin
      if Punkt <> i then OutTextXY(5, Coord, M[i])
        else
          begin
            SetColor(ColorTheme.Select);
            OutTextXY(1, PosY - 10, M[i]);
            SetColor(ColorTheme.Text);
          end;
      Inc(Coord, Otstup);
    end;
End;
{--------------------------�����---------------------------------------}

{----------------------�����------------------------------------------}
function MenuCursor(M : StringArr; Cnt : Byte) : Byte;
var
  x, y, First, Last: Integer;
  Key : Char;
Begin
  First := Otstup;
  Last := Cnt * Otstup;
  x := First;
  y := First;
  repeat
    MoveTo(x, y);
    MainMenu(M, Cnt, y);
    repeat
      Key := ReadKey;
      if Key = KodUpravl then Key := ReadKey;
    until Key in [Enter, Esc, Up, Down];
    case Key of
      Up    : begin
                if y=First
                  then y:=Last
                  else Dec(y,Otstup);
              end;
      Down  : begin
                if y=Last
                  then y:=First
                  else Inc(y,Otstup);
              end;
      Enter : begin
                MenuCursor:=y mod 10;
              end;
      Esc   : begin
                MenuCursor:=0;
              end;
    end;
  until (Key = Esc) or (Key = Enter);
End;
{--------------------------�����---------------------------------------}

{-------------�뢮� ���ଠ樨 � ������� �ࠢ�����-------------------}
procedure ControlKey(Keys : String);
var
  i : Byte;
  Center : Integer;
Begin
  SetViewPort(0, MaxY - 25, MaxX, MaxY, False);
  SetColor(ColorTheme.Back);
  Bar(0, 0, MaxX, 30);
  SetColor(ColorTheme.Border1);
  Rectangle(0, 0, MaxX, 25);
  SetColor(ColorTheme.Border2);
  Rectangle(1, 1, MaxX, 24);
  for i := 1 to Length(Keys) do
    begin
      if Keys[i] in ['A'..'Z', 'a'..'z', '7'] {�᫨ ᨬ��� �室�� � ������⢮}
        then SetColor(ColorTheme.Select) {� ��⠭����� 梥� �뤥����� }
        else SetColor(ColorTheme.Text);  {���� ��⠭����� 梥� ���筮�� ⥪��}
      OutTextXY(5 + (i * 8), 5, Keys[i]);
    end;
End;
{--------------------------�����---------------------------------------}

{---------------���樠������ ������� ���� �ணࠬ��-------------------}
procedure InitWindow;
Begin
  SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
  SetWindow(0, 205, MaxX, MaxY - 30, '��室�� ���');
  ControlKey('UP - �����     DOWN - ����     ESC - ��室\�����     ENTER - �롮�');
  SetWindow(0, 0, 160, 200, '����');
End;
{--------------------------�����---------------------------------------}

{----------����祭�� ��ꥪ⮢ � �ࠩ��஬ � ���⮬--------------------}
Procedure MonDriver;external;
{$L Driver.obj}

Procedure LittFont;external;
{$L Litt.obj}
{--------------------------�����---------------------------------------}

{----------------���樠������ ����᪮�� ०���---------------------}
procedure InitGraphMode;
var
  Error : Integer;
Begin
  RegisterBGIDriver(@MonDriver);
  InitGraph(Driver,Mode,'');
  Error:=GraphResult;
  if Error<>0 then {�᫨ �訡��, �}
    begin
      writeln(GraphErrorMsg(Error)); {}{�뢮� ᮮ�饭�� �� �訡��}
      writeln('PRESS ENTER...');     {}
      readln;
      Exit;
    end;
  Font := RegisterBGIFont(@LittFont);
  with ColorTheme Do {���樠������ 梥⮢�� �奬�}
    Begin
      Text := Black;
      Border1 := LightBlue;
      Border2 := Cyan;
      Select := Red;
      Back := LightGray;
    End;
  with DefaultFont do {���樠������ � ��⠭���� ����}
    begin
      Font := 2;
      Direction := 0;
      CharSize := 5;
      SetTextStyle(Font, Direction, CharSize);
    end;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  Size := ImageSize(0, 0, 465, 190);
  GetMem(Picture, Size);
  InitWindow;
End;
{--------------------------�����---------------------------------------}

{---------------------��࠭���� ����ࠦ����---------------------------}
procedure SavePicture;
Begin
  GetImage(0, 0, 465, 190, Picture^);
End;
{--------------------------�����---------------------------------------}

{---------------------�뢮� ����ࠦ����--------------------------------}
procedure PaintPicture;
Begin
  SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
  PutImage(0, 0, Picture^, NormalPut);
End;
{--------------------------�����---------------------------------------}

BEGIN
  InitGraphMode;
END.