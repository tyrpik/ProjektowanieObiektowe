program zad_3_5;

type
  TTable50 = array[1..50] of integer;

var
    i: integer;
    numbers: TTable50;
    
procedure Generate50RandomNumbers(var tab: TTable50);
var
    i: integer;
begin
    for i := 1 to 50 do
    begin
        tab[i] := random(101);
        write(tab[i], ' ');
    end;
    writeln
end;

procedure BubbleSort(var tab: TTable50);
var
    i, j, temp: integer;
begin
   for i := 1 to 50 do
    for j := 1 to 49 do
        if tab[j] > tab[j + 1] then
            begin
                temp := tab[j];
                tab[j] := tab[j + 1];
                tab[j + 1] := temp;
            end;
end;

begin
    randomize;
    Generate50RandomNumbers(numbers);
    BubbleSort(numbers);
    writeln('Table after sort:');
    for i := 1 to 50 do
        write(numbers[i], ' ');
    writeln;
    writeln('Click enter to exit.');
    readln;
end.