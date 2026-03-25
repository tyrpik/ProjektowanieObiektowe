program zad_3_0;

type
  TTable50 = array[1..50] of integer;

var
numbers : TTable50;

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

begin
    randomize;
    Generate50RandomNumbers(numbers);
    writeln('Click enter to exit.');
    readln;
end.