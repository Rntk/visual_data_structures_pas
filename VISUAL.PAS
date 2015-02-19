Program VisualList;

Uses
  GraphMode, Structures;

Const
  ResetPoint = 255;{сброс предыдущего значения}

Var
  Point : Byte;{выбранный пункт меню}

BEGIN
  repeat
    Point := MenuCursor(Menu, 6);
    case Point of
      1 : begin {1-связный}
            repeat
              SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
              PaintFullListOne(110, 30); {прорисовка всего списка}
              InitOneLink; {граф. инициализация}
              Point := MenuCursor(SubMenu, 4);
              case  Point of
                  1 : begin {Добавить}
                        repeat
                          SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
                          PaintFullListOne(110, 30);
                          InitOneLink;
                          Point := MenuCursor(MenuAdd, 4);
                          case Point of
                            1 : CodeScroll(PathCode + 'ABegOne.pas', VisualAddBeginOneLink); {В начало}
                            2 : CodeScroll(PathCode + 'AMidOne.pas', VisualAddMiddleOneLink); {В середину}
                            3 : CodeScroll(PathCode + 'AEndOne.pas', VisualAddEndOneLink); {В конец}
                          end;
                        until (Point = 0) or (Point = 4);
                        Point := ResetPoint;
                      end;
                  2 : begin {Удалить}
                        repeat
                          SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
                          PaintFullListOne(110, 30);
                          InitOneLink;
                          Point := MenuCursor(MenuRm, 4);
                          case Point of
                              1 : CodeScroll(PathCode + 'DBegOne.pas', VisualDelBeginOneLink); {Из начала}
                              2 : CodeScroll(PathCode + 'DMidOne.pas', VisualDelMiddleOneLink); {Из середины}
                              3 : CodeScroll(PathCode + 'DEndOne.pas', VisualDelEndOneLink); {Из конца}
                          end;
                        until (Point = 0) or (Point = 4);
                        Point := ResetPoint;
                      end;
                  3 : Info('Односвязный список', PathTheory + 'OneLink.txt'); {Теория}
                end;
            until (Point = 0) or (Point = 4);
            Point := ResetPoint;
            SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
          end;
      2 : begin {2-связный}
            repeat
              SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
              PaintFullListTwo(100, 30);
              InitTwoLink;
              Point := MenuCursor(SubMenu, 4);
              case  Point of
                1 : begin {Добавить}
                      repeat
                        SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
                        PaintFullListTwo(100, 30);
                        InitTwoLink;
                        Point := MenuCursor(MenuAdd, 4);
                        case Point of
                          1 : CodeScroll(PathCode + 'ABegTwo.pas', VisualAddBeginTwoLink); {В начало}
                          2 : CodeScroll(PathCode + 'AMidTwo.pas', VisualAddMiddleTwoLink); {В середину}
                          3 : CodeScroll(PathCode + 'AEndTwo.pas', VisualAddEndTwoLink); {В конец}
                        end;
                      until (Point = 0) or (Point = 4);
                      Point := ResetPoint;
                    end;
                2 : begin {Удалить}
                      repeat
                        SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
                        PaintFullListTwo(100, 30);
                        InitTwoLink;
                        Point := MenuCursor(MenuRm, 4);
                        case  Point of
                          1 : CodeScroll(PathCode + 'DBegTwo.pas', VisualDelBeginTwoLink); {Из начала}
                          2 : CodeScroll(PathCode + 'DMidTwo.pas', VisualDelMiddleTwoLink); {Из середины}
                          3 : CodeScroll(PathCode + 'DEndTwo.pas', VisualDelEndTwoLink); {Из конца}
                        end;
                      until (Point = 0) or (Point = 4);
                      Point := ResetPoint;
                    end;
                3 : Info('Двусвязный список', PathTheory + 'TwoLink.txt'); {Теория}
              end;
            until (Point = 0) or (Point = 4);
            Point := ResetPoint;
            SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
          end;
      3 : begin {Очередь}
            repeat
              SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
              PaintFullListOne(50, 30);
              InitQueue;
              Point := MenuCursor(SubMenu, 4);
              case  Point of
                1 : CodeScroll(PathCode + 'QueueAdd.pas', VisualAddInQueue); {Добавить}
                2 : CodeScroll(PathCode + 'QueueDel.pas', VisualDelFromQueue); {Удалить}
                3 : Info('Очередь', PathTheory + 'Queue.txt'); {Теория}
              end;
            until (Point = 0) or (Point = 4);
            Point := ResetPoint;
            SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
          end;
      4 : begin {Стек}
            repeat
              SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
              PaintFullListOne(110, 30);
              InitStack;
              Point := MenuCursor(SubMenu, 4);
              case Point of
                1 : CodeScroll(PathCode + 'Push.pas', VisualPushInStack); {Добавить}
                2 : CodeScroll(PathCode + 'Pop.pas', VisualPopFromStack); {Удалить}
                3 : Info('Стек', PathTheory + 'Stack.txt'); {Теория}
              end;
            until (Point = 0) or (Point = 4);
            Point := ResetPoint;
            SetWindow(165, 0, MaxX, 200, 'Визуальное отображение');
          end;
      5 : begin {О программе}
            ControlKey('ESC - Выход   ANY KEY - Вывести все');
            AboutProgram;
            InitWindow;
          end;
    end;
  until (Point = 0) or (Point = 6);
  FreeMem(Picture, Size); {освобождение памяти, выделенной для хран. изобр}
END.