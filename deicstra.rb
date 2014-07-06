class SingleConfiguration

  def initialize(raw_configuration)
    @adjacency_matrix = [
      # 1   2   3   4   
      [-1,  1,  3, -1 ], # 1
      [ 1, -1,  1,  4 ], # 2
      [ 3,  1, -1,  1 ], # 3
      [-1,  4,  1, -1 ]  # 4
    ]
    @city_names = ['gdansk', 'bydgoszcz', 'torun', 'warszawa']
    @tasks_number = 2
    @tasks = [['gdansk', 'warszawa'], ['bydgoszcz', 'warszawa']]
    parse_configuration(raw_configuration)
  end

  # procedure TTestContainer.load(inputSource:TStrings);
  # var
  #  s:string;
  #  i: Integer;
  #  test,city: Integer;
  #  p:integer;
  #  pair:TIntPair;
  # begin
  #  try
  #   input.Assign(inputSource);
  #   curLine:=0;
  #   testsNumber:=readInt();
  #   for test:=1 to testsNumber do
  #    begin
  #     tests[test]:=TTest.Create(readInt()); //reading cities number and creating new test(test)
  #     for city:=1 to tests[test].N do
  #      begin
  #       tests[test].cities[city]:=readStr(); //reading city name
  #       p:=readInt(); // the number of neighbours of city
  #       for i:=1 to p do
  #        begin
  #         // reading transportation cost
  #         pair:=readIntPair();
  #         tests[test].d[pair.first][pair.second]:=readInt();
  #         tests[test].d[pair.second][pair.first]:=tests[test].d[pair.first][pair.second];
  #        end;
  #      end;

  #      tests[test].r:=readInt();
  #      setLength(tests[test].distancesToFind,testsNumber+1);
  #      for i:=1 to testsNumber do
  #       tests[test].distancesToFind[i]:=readCitiesPair(TStringArray(tests[test].cities));
                
  #      readStr(); //skip empty line dividing the tests
  #    end;

  #  except
  #    on E : Exception do
  #    begin
  #      ShowMessage('Error: '+E.Message);
  #    end;
  #  end;
  # end;
  def parse_configuration(raw_configuration)
    puts "Current configuration: "
    puts raw_configuration
    puts '='*80

  end

  def city_number(city_name)
    @city_names.index(city_name)
  end

  def process
    @tasks.map do |task|
      count_deikstra city_number(task[0]), city_number(task[1])
    end
  end

  # procedure TForm1.Button1Click(Sender: TObject);
  # var
  #   a:array[1..20,1..20] of longint;//матрица смежности (-1 нет ребра)
  #   b:array[1..20]of boolean;//список просмотренных вершин
  #   d:array[1..20] of longint;//расстояния
  #   q, i, j, m, v: integer;
  # begin
  #  //Ввод данных
  #   q := StrToIntDef(Edit1.Text, 1); //начальная вершина
  #   if (q < 1) or (q > n) then q := 1;

  #   for i := 1 to n do
  #     for j := 1 to n do
  #       a[j, i] := StrToIntDef(grid.Cells[i - 1, j - 1], -1);

  #   //Расчет
  #   fillchar(b,sizeof(b),0);
  #   fillchar(d,sizeof(d), 10000); //бесконечность
  #   d[q] := 0;//расстояние до начальной вершины
  #   for i:=1 to n do
  #   begin
  #     m:=1000;
  #     for j:=1 to n do
  #     if ( (d[j] <= m) and (not b[j]) ) then
  #     begin
  #       m:=d[j];
  #       v:=j;
  #     end;
  #     b[v] := true;
  #     for j:=1 to n do
  #      if ((a[v,j]<>-1)and(not b[j])and (d[v]+a[v,j]<d[j])) then
  #        d[j]:=d[v]+a[v,j];
  #   end;

  #   //Вывод результата
  #   ListBox1.Clear;
  #   for i := 1 to n do
  #     ListBox1.Items.Append(IntToStr(q) + ' -> ' + IntToStr(i) + ': ' + IntToStr(d[i]));

  # end;

  def count_deikstra start_point, end_point
    
    count_city = @city_names.length
    watched_cities = []
    distances = Array.new(count_city, 10000)
   distances[start_point]= 0
    (1..count_city).each do |i|
    end
   distances[end_point]
  end

end

class Container

  def initialize user_input
    @raw_user_input = user_input
    @user_input = user_input.split("\n")
    @tests_number = @user_input.shift.to_i

    @raw_configurations = @user_input.join("\n").split("\n\n")
    
    puts "We are going to read #{@tests_number} ranges."
    @configurations = []
    @tests_number.times do |current_city_number|
      @configurations << SingleConfiguration.new(@raw_configurations[current_city_number])
    end

  end

  def count_distances
    @configurations.map do |c|
      puts c.process
      puts ""
    end
  end

end

sho_to_tut = <<-eos
2
4
gdansk
2
2 1
3 3
bydgoszcz
3
1 1
3 1
4 4
torun
3
1 3
2 1
4 1
warszawa
2
2 4
3 1
2
gdansk warszawa
bydgoszcz warszawa

4
gdansk
2
2 1
3 3
bydgoszcz
3
1 1
3 1
4 4
torun
3
1 3
2 1
4 1
warszawa
2
2 4
3 1
2
gdansk warszawa
bydgoszcz warszawa
eos

c = Container.new(sho_to_tut)

c.count_distances  #=> 
                    # 
                    # 2
                    # 3
                    # 
                    # 2
                    # 3
