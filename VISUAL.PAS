Program VisualList;

Uses
  GraphMode, Structures;

Const
  ResetPoint = 255;{��� �।��饣� ���祭��}

Var
  Point : Byte;{��࠭�� �㭪� ����}

BEGIN
  repeat
    Point := MenuCursor(Menu, 6);
    case Point of
      1 : begin {1-�吝�}
            repeat
              SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
              PaintFullListOne(110, 30); {���ᮢ�� �ᥣ� ᯨ᪠}
              InitOneLink; {���. ���樠������}
              Point := MenuCursor(SubMenu, 4);
              case  Point of
                  1 : begin {��������}
                        repeat
                          SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
                          PaintFullListOne(110, 30);
                          InitOneLink;
                          Point := MenuCursor(MenuAdd, 4);
                          case Point of
                            1 : CodeScroll(PathCode + 'ABegOne.pas', VisualAddBeginOneLink); {� ��砫�}
                            2 : CodeScroll(PathCode + 'AMidOne.pas', VisualAddMiddleOneLink); {� �।���}
                            3 : CodeScroll(PathCode + 'AEndOne.pas', VisualAddEndOneLink); {� �����}
                          end;
                        until (Point = 0) or (Point = 4);
                        Point := ResetPoint;
                      end;
                  2 : begin {�������}
                        repeat
                          SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
                          PaintFullListOne(110, 30);
                          InitOneLink;
                          Point := MenuCursor(MenuRm, 4);
                          case Point of
                              1 : CodeScroll(PathCode + 'DBegOne.pas', VisualDelBeginOneLink); {�� ��砫�}
                              2 : CodeScroll(PathCode + 'DMidOne.pas', VisualDelMiddleOneLink); {�� �।���}
                              3 : CodeScroll(PathCode + 'DEndOne.pas', VisualDelEndOneLink); {�� ����}
                          end;
                        until (Point = 0) or (Point = 4);
                        Point := ResetPoint;
                      end;
                  3 : Info('�����吝� ᯨ᮪', PathTheory + 'OneLink.txt'); {�����}
                end;
            until (Point = 0) or (Point = 4);
            Point := ResetPoint;
            SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
          end;
      2 : begin {2-�吝�}
            repeat
              SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
              PaintFullListTwo(100, 30);
              InitTwoLink;
              Point := MenuCursor(SubMenu, 4);
              case  Point of
                1 : begin {��������}
                      repeat
                        SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
                        PaintFullListTwo(100, 30);
                        InitTwoLink;
                        Point := MenuCursor(MenuAdd, 4);
                        case Point of
                          1 : CodeScroll(PathCode + 'ABegTwo.pas', VisualAddBeginTwoLink); {� ��砫�}
                          2 : CodeScroll(PathCode + 'AMidTwo.pas', VisualAddMiddleTwoLink); {� �।���}
                          3 : CodeScroll(PathCode + 'AEndTwo.pas', VisualAddEndTwoLink); {� �����}
                        end;
                      until (Point = 0) or (Point = 4);
                      Point := ResetPoint;
                    end;
                2 : begin {�������}
                      repeat
                        SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
                        PaintFullListTwo(100, 30);
                        InitTwoLink;
                        Point := MenuCursor(MenuRm, 4);
                        case  Point of
                          1 : CodeScroll(PathCode + 'DBegTwo.pas', VisualDelBeginTwoLink); {�� ��砫�}
                          2 : CodeScroll(PathCode + 'DMidTwo.pas', VisualDelMiddleTwoLink); {�� �।���}
                          3 : CodeScroll(PathCode + 'DEndTwo.pas', VisualDelEndTwoLink); {�� ����}
                        end;
                      until (Point = 0) or (Point = 4);
                      Point := ResetPoint;
                    end;
                3 : Info('����吝� ᯨ᮪', PathTheory + 'TwoLink.txt'); {�����}
              end;
            until (Point = 0) or (Point = 4);
            Point := ResetPoint;
            SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
          end;
      3 : begin {��।�}
            repeat
              SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
              PaintFullListOne(50, 30);
              InitQueue;
              Point := MenuCursor(SubMenu, 4);
              case  Point of
                1 : CodeScroll(PathCode + 'QueueAdd.pas', VisualAddInQueue); {��������}
                2 : CodeScroll(PathCode + 'QueueDel.pas', VisualDelFromQueue); {�������}
                3 : Info('��।�', PathTheory + 'Queue.txt'); {�����}
              end;
            until (Point = 0) or (Point = 4);
            Point := ResetPoint;
            SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
          end;
      4 : begin {�⥪}
            repeat
              SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
              PaintFullListOne(110, 30);
              InitStack;
              Point := MenuCursor(SubMenu, 4);
              case Point of
                1 : CodeScroll(PathCode + 'Push.pas', VisualPushInStack); {��������}
                2 : CodeScroll(PathCode + 'Pop.pas', VisualPopFromStack); {�������}
                3 : Info('�⥪', PathTheory + 'Stack.txt'); {�����}
              end;
            until (Point = 0) or (Point = 4);
            Point := ResetPoint;
            SetWindow(165, 0, MaxX, 200, '���㠫쭮� �⮡ࠦ����');
          end;
      5 : begin {� �ணࠬ��}
            ControlKey('ESC - ��室   ANY KEY - �뢥�� ��');
            AboutProgram;
            InitWindow;
          end;
    end;
  until (Point = 0) or (Point = 6);
  FreeMem(Picture, Size); {�᢮�������� �����, �뤥������ ��� �࠭. �����}
END.