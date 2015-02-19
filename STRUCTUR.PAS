Unit Structures;

Interface

Uses
  StrList;

Type

  DartDirections = (ddUp, ddLeft, ddRight, ddDown); {направления стрелки}

  VisProcType = procedure (CurStr : Byte); {проц. граф. отобр. работы алгоритмов}

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

{------------------графическая инициализация стека---------------------}
procedure InitStack;
Begin
  OutTextXY(122, 1, 'Top');
  Dart(135, 15, 135, 30, ddDown, 1);
  OutTextXY(390, 35, 'Nil');
  SavePicture;
End;
{-----------------------------конец------------------------------------}

{------------графическая инициализация односвязного списка-------------}
procedure InitOneLink;
Begin
  OutTextXY(120, 1, 'Head');
  Dart(135, 15, 135, 30, ddDown, 1);
  Dart(345, 15, 345, 30, ddDown, 1);
  OutTextXY(330, 1, 'Last');
  OutTextXY(390, 35, 'Nil');
  SavePicture;
End;
{-----------------------------конец------------------------------------}

{------------графическая инициализация двусвязного списка--------------}
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
{-----------------------------конец------------------------------------}

{------------------графическая инициализация очереди-------------------}
procedure InitQueue;
Begin
  OutTextXY(60, 1, 'First');
  Dart(75, 15, 75, 30, ddDown, 1);
  OutTextXY(330, 35, 'Nil');
  Dart(285, 15, 285, 30, ddDown, 1);
  OutTextXY(270, 1, 'Last');
  SavePicture;
End;
{-----------------------------конец------------------------------------}

{------------------------вывод теории----------------------------------}
procedure Info(WindowTitle, FileName : String);
var
  F : Text;
  StList : TList;
  x, y, StringCount : Integer;
  i : Integer;
Begin
  x := 2; y := 2;
  Assign(F, FileName);
  if not FillList(StList, FileName) then Exit; {если файл отсутствует, то выход}
  StringCount := 0;
  ControlKey('ENTER - Выход');
  SetWindow(0, 0, MaxX, MaxY - 30, WindowTitle);
  for i := 1 to StList.GetCount do
    begin
      OutTextXY(x, y, StList.GetData(i));
      Inc(y, TextHeight('H') + 5);
      if (i mod 27 = 0) then {если дошли до "конца" экрана, то}
        begin
          repeat
            ControlKey('ESC - Выход   ENTER - Продолжить');
            case ReadKey of {считать код кл.}
              Esc   : begin {выход}
                        StList.Destroy;
                        ClearDevice;
                        InitWindow;
                        Exit;
                      end;
              Enter : begin {продолжить вывод с "начала" экрана}
                        x := 2;
                        y := 5;
                        ControlKey('ENTER - Выход');
                        SetWindow(0, 0, MaxX, MaxY - 30, WindowTitle);
                        MoveTo(x, y); {перейти в "начало" экрана}
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
{--------------------------конец---------------------------------------}

{-------------------------стрелка--------------------------------------}
procedure Dart(x1, y1, x2, y2 : Integer; DartDirection : DartDirections; Selected : Byte);
const
  dWidth = 8;
  dHeight = 3;
Begin
  if Selected = 2 then SetColor(ColorTheme.Select);
  Line(x1, y1, x2, y2);
  case DartDirection of
    ddLeft :  begin{ <- влево }
                Line(x1, y1, x1 + dWidth, y1 + dHeight);
                Line(x1, y1, x1 + dWidth, y1 - dHeight);
              end;
    ddRight : begin{ -> вправо}
                Line(x2, y2, x2 - dWidth, y2 + dHeight);
                Line(x2, y2, x2 - dWidth, y2 - dHeight);
              end;
    ddUp    : begin {/\ вверх}
                Line(x1, y1, x1 - dHeight, y1 + dWidth);
                Line(x1, y1, x1 + dHeight, y1 + dWidth);
              end;
    ddDown  : begin {\/ вниз}
                Line(x2, y2, x2 + dHeight, y2 - dWidth);
                Line(x2, y2, x2 - dHeight, y2 - dWidth);
              end;
  end;
  SetColor(ColorTheme.Text);
End;
{--------------------------конец---------------------------------------}

{---------------рисует элемент односвязного списка---------------------}
procedure ElementOneLink(x1, y1 : Integer; NeedDart, NeedData : Byte);
const
  ElementSize = 50;
var
  x2, y2 : Integer;
Begin
  x2 := x1 + ElementSize; {получение координат}
  y2 := y1 + ElementSize; {второй точки}
  Rectangle(x1, y1, x2, y2);
  Line(x1, y2 - 10, x2, y2 - 10);
  with DefaultFont do
    begin
      SetTextStyle(Font, Direction, 4);
      OutTextXY(x1 + 8, y2 - 10, 'NEXT');
      SetTextStyle(Font, Direction, CharSize);
    end;
  if NeedDart > 0 then  {0 - без стрелки, 1 - со стрелкой, 2 - с выделенной стрелкой}
    begin
      if NeedDart = 2 then SetColor(ColorTheme.Select);
        Line(x2, y2 - 5, x2 + 10, y2 - 5);
        Line(x2 + 10, y2 - 5, x2 + 10, y1 + 20);
        Dart(x2 + 10, y1 + 20, x2 + 20, y1 + 20, ddRight, NeedDart);
        SetColor(ColorTheme.Text);
    end;
  if NeedData > 0 then {0 - без Data, 1 - с Data, 2 - веделенным Data}
    begin
      if NeedData = 2 then SetColor(ColorTheme.Select);
      OutTextXY(x1 + 7, y1 + 10, 'Data');
      SetColor(ColorTheme.Text);
    end;
End;
{--------------------------конец---------------------------------------}

{---------------рисует элемент двусвязного списка----------------------}
procedure ElementTwoLink(x1, y1 : Integer;  LeftDart, RightDart, NeedData : Byte);
const
  ElementSize = 50;
var
  x2, y2 : Integer;
Begin
  x2 := x1 + ElementSize; {получение координат}
  y2 := y1 + ElementSize; {второй точки}
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
  if RightDart > 0 then {0 - без пр. стрелки, 1 - со пр. стрелкой, 2 - с пр. выделенной стрелкой}
    begin
      if RightDart = 2 then SetColor(ColorTheme.Select);
      Line(x2, y2 - 5, x2 + 10, y2 - 5); {-}
      Line(x2 + 10, y2 - 5, x2 + 10, y1 + 34); {|}
      Dart(x2 + 10, y1 + 34, x2 + 20, y1 + 34, ddRight, RightDart); {->}
      SetColor(ColorTheme.Text);
    end;
  if LeftDart > 0 then {0 - без лев. стрелки, 1 - со лев. стрелкой, 2 - с лев. выделенной стрелкой}
    begin
      if LeftDart = 2 then SetColor(ColorTheme.Select);
      Line(x1 - 10, y1 + 5, x1, y1 + 5); {-}
      Line(x1 - 10, y1 + 5, x1 - 10, y1 + 16); {|}
      Dart(x1 - 20, y1 + 16, x1 - 10, y1 + 16, ddLeft, LeftDart); {<-}
      SetColor(ColorTheme.Text);
    end;
  if NeedData > 0 then {0 - без Data, 1 - с Data, 2 - веделенным Data}
    begin
      if NeedData = 2 then SetColor(ColorTheme.Select);
      OutTextXY(x1 + 7, y1 + 15, 'Data');
      SetColor(ColorTheme.Text);
    end;
End;
{--------------------------конец---------------------------------------}

{---------------------1-связный список---------------------------------}
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
{--------------------------конец---------------------------------------}

{---------------------2-связный список---------------------------------}
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
{--------------------------конец---------------------------------------}

{-------------------заполнение списка----------------------------------}
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
  if IOResult <> 0 {если файл отсутствует, то}
    then
      begin
        FillList := False;
        ColorTheme.Border1 := Red;                                 {}
        ColorTheme.Border2 := Red;                                 {}
        SetWindow(150, 200, 450, 350, 'Ошибка');                   {}{вывод окна с сообщением}
        OutTextXY(10, 10, 'Файл '+ FileName + ' не найден!!!');    {}
        OutTextXY(10, 30, 'Файл отсутствует или переименован!!!'); {}
        OutTextXY(10, 50, 'Нажмите ENTER для продолжения...');     {}
        readln;
        ColorTheme.Border1 := LightBlue;
        ColorTheme.Border2 := Cyan;
        ClearDevice;
      end
    else {иначе}
      begin
        L.Create;
        while not EOF(F) do    {}
          begin                {}{считывание всех строк}
            Readln(F, Strk);   {}{из файла в список}
            L.AddString(Strk); {}
          end;
        Close(F);
      end;
End;
{--------------------------конец---------------------------------------}

{---------------------вывод и выделение кода--------------------------}
procedure CodeSelect(StLst : TList; SelStr, Frst, Lst : Word);
var
  i, TxtWidth : Word;
  y : Integer;
Begin
  y := 10;
  TxtWidth := TextWidth('H') + 5; {высчитывание высоты текста}
  ControlKey('F7 - Следующий оператор   ESC - Выход');
  SetWindow(0, 205, MaxX, MaxY - 30, 'Исходный код');
  for i := Frst to Lst do
    begin
      if (i <> SelStr) {если текущая строка не выделена, то}
        then
          begin
            SetColor(ColorTheme.Text);          {}{вывести ее цветом}
            OutTextXY(10, y, StLst.GetData(i)); {}{обычного текста}
          end
        else {иначе}
          begin
            SetColor(ColorTheme.Select);       {}{вывести ее со смещением и}
            OutTextXY(5, y, StLst.GetData(i)); {}{цветом выделения}
          end;
      Inc(y, TxtWidth); {"перемещение" на строку вниз}
    end;
End;
{--------------------------конец---------------------------------------}

{----------------прокрутка и выделение кода----------------------------}
procedure CodeScroll(FileName : String; Proc : VisProcType);
var
  StList : TList;
  i : Byte;
  CurrentStr, F, L : Word;
  Key : Char;
Begin
  if FillList(StList, FileName) then
    begin
      for i := 1 to 5 do                                     {}{нахождение первой}
        if StList.GetData(i) = 'Begin' then CurrentStr := i; {}{строки кода}
      F := 1; {индекс первой строки}
      L := 10; {индекс последней строки}
      if StList.GetCount <= L then L := StList.GetCount; {корректировка позиции последней строки}
      while CurrentStr <> StList.GetCount do
        begin
          Inc(CurrentStr); {смещение выделения}
          if CurrentStr > L then
            begin
              Inc(F); {}{сдвиг вниз}
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
{--------------------------конец---------------------------------------}

{-------визуализация добавления в начало односвязного списка-----------}
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
{--------------------------конец---------------------------------------}

{-------визуализация добавления в середину односвязного списка---------}
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
{--------------------------конец---------------------------------------}

{-------визуализация добавления в конец односвязного списка------------}
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
{--------------------------конец---------------------------------------}

{-------визуализация удаление из начала односвязного списка------------}
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
{--------------------------конец---------------------------------------}

{-------визуализация удаление из середины односвязного списка----------}
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
{--------------------------конец---------------------------------------}

{-------визуализация удаление из конца односвязного списка-------------}
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
{--------------------------конец---------------------------------------}

{-------визуализация добавления в начало двусвязного списка------------}
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
{--------------------------конец---------------------------------------}

{-------визуализация добавления в середину двусвязного списка----------}
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
{--------------------------конец---------------------------------------}

{-------визуализация добавления в конец двусвязного списка-------------}
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
{--------------------------конец---------------------------------------}

{-------визуализация удаление из начала двусвязного списка-------------}
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
{--------------------------конец---------------------------------------}

{-------визуализация удаление из середины двусвязного списка-----------}
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
{--------------------------конец---------------------------------------}

{----------визуализация удаление из конца двусвязного списка-----------}
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
{--------------------------конец---------------------------------------}

{----------------визуализация добавления в очередь---------------------}
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
{--------------------------конец---------------------------------------}

{----------------визуализация удаление из очереди----------------------}
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
{--------------------------конец---------------------------------------}

{----------------визуализация добавления в стек------------------------}
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
{--------------------------конец---------------------------------------}

{----------------визуализация удаления из стека------------------------}
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
{--------------------------конец---------------------------------------}

END.