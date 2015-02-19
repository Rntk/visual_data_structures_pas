unit StrList;

interface

type
  Element=^TElement;
  TElement=record
    Data : String;
    Next, Prev : Element;
    Index : Word;
  end;

  TList=object
    private
      Head,Last:Element;
      Count,First:Word;
    public
      Current : Element;
    Constructor Create;
    procedure SetIndex(One : Word);
    procedure AddString(NewData : String);
    function DelElement(Index:Word) : Boolean;
    function IndexSearch(Index : Word) : Element;
    function GetData(Index : Word) : String;
    function SetData(NewData : String; Index : Word) : Boolean;
    function GetCount : Word;
    function TruncateList(Index : Word) : Boolean;
    Destructor Destroy;
  end;

implementation

{---------------инициализация------------------------}
Constructor TList.Create;
Begin
  New(Head);
  Head^.Next:=nil;
  Head^.Prev:=nil;
  Head^.Data:='';
  Head^.Index:=1;
  Current:=Head;
  Last:=Current;
  Count:=1;
End;
{-----------------конец------------------------------}
{-------------добавление в список--------------------}
procedure TList.AddString(NewData:String);
Begin
  Current:=Last;
  New(Current^.Next);
  Current:=Current^.Next;
  Current^.Prev:=Last;
  Current^.Data:=NewData;
  Current^.Next:=nil;
  Current^.Index:=Current^.Prev^.Index+1;
  Last:=Current;
  Count:=Last^.Index;
End;
{-----------------конец------------------------------}
{------------удалени элемента------------------------}
function TList.DelElement(Index:Word):Boolean;
Begin
  DelElement:=True;
  if IndexSearch(Index)=nil
    then
      begin
        DelElement:=False;
        Exit;
      end;
  if Current=Head
    then
      begin
        Head:=Head^.Next;
        Dispose(Head^.Prev);
        Head^.Prev:=nil;
        Current:=Head;
        SetIndex(1);
        Exit;
      end;
  if Current=Last
    then
      begin
        Last:=Last^.Prev;
        Dispose(Last^.Next);
        Last^.Next:=nil;
        Current:=Last;
        SetIndex(1);
        Exit;
      end;
  Current^.Prev^.Next:=Current^.Next;
  Current^.Next^.Prev:=Current^.Prev;
  Dispose(Current);
  SetIndex(1);
  Current:=Head;
End;
{-----------------конец------------------------------}
{------------поиск по индексу------------------------}
function TList.IndexSearch(Index:Word):Element;
Begin
  if (Index>Last^.Index) or (Index<Head^.Index)
    then
      begin
        IndexSearch:=nil;
        Exit;
      end;
  if Index>Current^.Index
    then
      while Current^.Index<>Index do
        Current:=Current^.Next
    else
      if Index<Current^.Index
        then
          while Current^.Index<>Index do
            Current:=Current^.Prev;
  IndexSearch:=Current;
End;
{-----------------конец------------------------------}
{----------------индексация--------------------------}
procedure TList.SetIndex(One:Word);
Begin
  First:=One;
  Current:=Head^.Next;
  Head^.Index:=One;
  while Current^.Next<>nil do
    begin
      Current^.Index:=Current^.Prev^.Index+1;
      Current:=Current^.Next;
    end;
End;
{-----------------конец------------------------------}
{------------освобождение выделенной памяти----------}
Destructor TList.Destroy;
Begin
  Current:=Head^.Next;
  while Current<>Last do
    begin
      Dispose(Current^.Prev);
      Current:=Current^.Next;
    end;
  Dispose(Last);
End;
{-----------------конец------------------------------}
{------------получение дынных из элемента------------}
function TList.GetData(Index:Word) : String;
Begin
  Current:=IndexSearch(Index);
  if Current=nil
    then GetData:= ''
    else GetData:=Current^.Data;
End;
{-----------------конец------------------------------}
{------------занесение данных в элемент--------------}
function TList.SetData(NewData : String; Index:Word):Boolean;
Begin
  Current:=IndexSearch(Index);
  if Current=nil
    then SetData:=False
    else
      begin
        SetData:=True;
        Current^.Data:=NewData;
      end;
End;
{-----------------конец------------------------------}
{--------------количество элементов------------------}
function TList.GetCount:Word;
Begin
  GetCount:=Last^.Index;
End;
{-----------------конец------------------------------}
{------------отсечение части списка------------------}
function TList.TruncateList(Index:Word):Boolean;
Begin
  Current:=IndexSearch(Index);
  if Current=nil
    then TruncateList:=False
    else
      begin
        while Last^.Next<>Current do
          begin
            Last:=Last^.Prev;
            Dispose(Last^.Next);
          end;
        Current:=Last;
        Current^.Next:=nil;
      end;
End;
{-----------------конец------------------------------}
END.