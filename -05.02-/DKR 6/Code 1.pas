program Dkr6;

const
  MaxSize = 3;

type
  TItem = record
    Data: integer;
    Next: integer;
  end;
  
  TCircularList = record
    Items: array[1..MaxSize] of TItem;
    Head: integer;
    Size: integer;
  end;

var
  List: TCircularList;
  Choice: integer;

procedure InitializeList(var L: TCircularList);
begin
  L.Head := 0;
  L.Size := 0;
end;

procedure AddItem(var L: TCircularList; Data: integer);
var
  i, newIndex: integer;
begin
  if L.Size < MaxSize then
  begin
    Inc(L.Size);
    newIndex := L.Size; 
  end
  else
  begin
 
    writeln('Переполнение. Самый старый элемент будет удален.');
    newIndex := L.Head;
    L.Head := L.Items[L.Head].Next; 
  end;

  L.Items[newIndex].Data := Data;
    
  if L.Size = 1 then 
  begin
    L.Head := newIndex;
    L.Items[newIndex].Next := newIndex; 
  end
  else
  begin
    i := L.Head;
    while L.Items[i].Next <> L.Head do
      i := L.Items[i].Next;
    L.Items[i].Next := newIndex;
    L.Items[newIndex].Next := L.Head; 
  end;
end;

procedure DeleteItem(var L: TCircularList; Data: integer);
var
  i, prev: integer;
  found: boolean;
begin
  if L.Head <> 0 then
  begin
    i := L.Head;
    prev := 0;
    found := False;
    repeat
      if L.Items[i].Data = Data then
      begin
        found := True;
        break;
      end;
      prev := i;
      i := L.Items[i].Next;
    until i = L.Head;

    if found then
    begin
      if prev = 0 then 
      begin
        if L.Items[i].Next = i then 
        begin
          InitializeList(L);
          exit;
        end
        else
        begin
          L.Head := L.Items[i].Next;
        end;
      end;

      if prev <> 0 then
        L.Items[prev].Next := L.Items[i].Next;
      Dec(L.Size); // Уменьшаем размер списка после удаления
      writeln('Элемент удален.');
    end
    else
      writeln('Элемент не найден.');
  end
  else
    writeln('Список пуст.');
end;

procedure ShowList(L: TCircularList);
var
  i: integer;
begin
  if L.Head <> 0 then
  begin
    i := L.Head;
    repeat
      write(L.Items[i].Data, ' ');
      i := L.Items[i].Next;
    until (i = L.Head); 
    writeln;
  end
  else
    writeln('Список пуст.');
end;

begin
  InitializeList(List);
  repeat
    writeln('1. Добавить элемент');
    writeln('2. Показать список');
    writeln('3. Удалить элемент');
    writeln('4. Выход');
    readln(Choice);
    case Choice of
      1: begin
           writeln('Введите значение:');
           readln(Choice);
           AddItem(List, Choice);
         end;
      2: ShowList(List);
      3: begin
           writeln('Введите значение для удаления:');
           readln(Choice);
           DeleteItem(List, Choice);
         end;
      4: break;
    else
      writeln('Неверный выбор. Попробуйте снова.');
    end;
  until Choice = 4;
end.
