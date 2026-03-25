program zad_4_0;

type
  TTableDynamic = array of integer;

var
    numbers: TTableDynamic;
    i, lower_boundary, upper_boundary, size: integer;
    
procedure GenerateRandomNumbers(var tab: TTableDynamic; l_boundary, u_boundary, size: integer);
var
    i: integer;
begin
    if (l_boundary > u_boundary)  or (size < 1) then
    begin
        SetLength(tab, 0);
        exit;
    end;

    SetLength(tab, size);
    for i := Low(tab) to High(tab) do
    begin
        tab[i] := random(u_boundary - l_boundary + 1) + l_boundary;
        write(tab[i], ' ');
    end;
    writeln
end;

procedure BubbleSort(var tab: TTableDynamic);
var
    i, j, temp: integer;
begin
   for i := Low(tab) to High(tab) do
    for j := Low(tab) to High(tab) - 1 do
        if tab[j] > tab[j + 1] then
            begin
                temp := tab[j];
                tab[j] := tab[j + 1];
                tab[j + 1] := temp;
            end;
end;

begin
    randomize;
    lower_boundary := 100;
    upper_boundary := 200;
    size := 30;

    writeln('Drawing ', size, ' numbers in the range ', lower_boundary, '..', upper_boundary, ':');
    GenerateRandomNumbers(numbers, lower_boundary, upper_boundary, size);
    BubbleSort(numbers);
    writeln('Numbers after sort:');
    for i := Low(numbers) to High(numbers) do
        write(numbers[i], ' ');
    writeln;
    writeln('Click enter to exit.');
    readln;
end.