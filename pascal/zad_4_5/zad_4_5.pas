program zad_4_5;

type
  TTableDynamic = array of integer;
    
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

procedure RunTests;
var
  testTab: TTableDynamic;
  i: integer;
  isSorted: boolean;
  isPrecise: boolean;

begin
  writeln('--- UNIT TESTS ---');

  {Test 1: Bad Range (L > U)}
  GenerateRandomNumbers(testTab, 2, 1, 3);
  if Length(testTab) = 0 then writeln('Test 1 (Bad Range -> Clear): PASS')
  else writeln('Test 1 (Bad Range): FAIL');

  {Test 2: Negative Size}
  GenerateRandomNumbers(testTab, 1, 2, -1);
  if Length(testTab) = 0 then writeln('Test 2 (Negative Size): PASS')
  else writeln('Test 2 (Negative Size): FAIL');

  {Test 3: Bubble Sort Logic}
  SetLength(testTab, 3);
  testTab[0] := 3;
  testTab[1] :=2;
  testTab[2] :=1;
  BubbleSort(testTab);
  isSorted := True;
  for i := 0 to 1 do
    if testTab[i] > testTab[i + 1] then 
    begin
        isSorted := False;
        break;
    end;
  if isSorted then writeln('Test 3 (Sort Logic): PASS')
  else writeln('Test 3 (Sort Logic): FAIL');

  {Test 4: Empty Array Stability - should not throw an error}
  SetLength(testTab, 0);
  BubbleSort(testTab);
  writeln('Test 4 (Empty Array Stability): PASS');

  {Test 5: Boundaries Precision (range 1..1) }
  GenerateRandomNumbers(testTab, 1, 1, 3);
  isPrecise := True;
  for i := Low(testTab) to High(testTab) do
    if testTab[i] <> 1 then 
    begin
        isPrecise := False;
        break;
    end;
  if (Length(testTab) = 3) and isPrecise then writeln('Test 5 (Boundaries Precision): PASS')
  else writeln('Test 5 (Boundaries Precision): FAIL');

  writeln('--- END OF TESTS ---');
  writeln;
end;

begin
    randomize;
    RunTests;
end.