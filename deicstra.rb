
# This class represents single configuration
# - cities
# - distances
# - minimal paths to find
# and calculation algorithm
class SingleConfiguration 

  def initialize(raw_configuration) 
    parse_configuration(raw_configuration)
  end

  # This method receives raw data with configuration and
  # transforms it into calculateable arrays: 
  # adjacency_matrix is two dimantionals array of distances between every two cities
  # # 1 2 3 4
  # [-1, 1, 3, -1 ], # 1
  # [ 1, -1, 1, 4 ], # 2
  # [ 3, 1, -1, 1 ], # 3
  # [-1, 4, 1, -1 ] # 4
  # ]
  # city_names is array of city names 
  # ['gdansk', 'bydgoszcz', 'torun', 'warszawa']
  # tasks is two dimantional array of cities to find minimal path
  # [["gdansk","warszawa"], ["bydgoszcz","warszawa"]]
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

  def count_deikstra start_point, end_point
    watched_cities = Array.new(@cities_number, false)
    distances = Array.new(@cities_number, 10000)
    distances[start_point]= 0
    (0..@cities_number-1).each do |i| #убрать И 
      current_city = distances.index (distances.min)
      (0..@cities_number-1).each do |j|
        if (@adjacency_matrix[current_city][j] != -1) && !watched_cities[j] && (@adjacency_matrix[current_city][j] + distances[current_city] < distances[j])
          puts "!!!"
          distances[j] = @adjacency_matrix[current_city][j] + distances[current_city] 
        end
        p " At #{i} and #{j} distances are: #{distances}"

      end
      watched_cities[current_city] = true
    end
    p '*'*8
    p "From '#{@city_names[start_point]}' to '#{@city_names[end_point]}' you can arrive in #{ distances[end_point]} miles"
    distances[end_point]
  end

end

class Container

  def initialize user_input
    @raw_user_input = user_input
    @user_input = user_input.split("\n")
    @tests_number = @user_input.shift.to_i

    @raw_configurations = @user_input.join("\n").split("\n\n")

    @configurations = @raw_configurations.map{|c| SingleConfiguration.new c }
  end

  def count_distances
    @configurations.map do |c|
      p c.process
      puts
    end
  end

end

sho_to_tut = <<-eos
1
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