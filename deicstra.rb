class SingleConfiguration

  def initialize(raw_configuration)
    parse_configuration(raw_configuration)
    print_configuration
  end

  def parse_configuration(raw_configuration)
    @configuration = raw_configuration.split "\n"
    @adjacency_matrix, @city_names, @tasks = [], [], []
    @cities_number = @configuration.shift.to_i
    @cities_number.times do |current_city|
      @city_names << @configuration.shift
      connections_number = @configuration.shift.to_i
      parse_single_point current_city, connections_number, @configuration.shift(connections_number)
    end
    @tasks_number = @configuration.shift.to_i
    @tasks_number.times do |t|
      @tasks[t] = @configuration.shift.split ' '
    end
  end

  def parse_single_point current_city, connections_number, points
    @adjacency_matrix[current_city] = Array.new(@cities_number, -1)
    points.each do |current_point|
      distination_city, distance = current_point.split(' ').map{|v| v.to_i}
      @adjacency_matrix[current_city][distination_city-1] = distance
    end
  end

  def city_by_number(city_name)
    @city_names.index(city_name)
  end

  def process
    @tasks.map do |task|
      count_deikstra city_by_number(task[0]), city_by_number(task[1])
    end
  end

  def pretty_print arr
    arr.each do |a|
      p a
    end
  end

  def print_configuration
    puts "We have #{@cities_number} cities. They are:"
    p @city_names
    puts "We have #{@tasks_number} tasks here:"
    pretty_print @tasks
    puts "The @adjacency_matrix is:"
    pretty_print @adjacency_matrix
    puts '='*80
    puts
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
    puts
    @configurations = @raw_configurations.map{|c| SingleConfiguration.new c }
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
