def f(input)
  time_macine = TimeMacine.new(input)
  time_macine.run
  time_macine.minimum_cost_route
end

class TimeMacine
  attr_reader :n, :cf, :cb, :default_safeties, :complete_routes

  def initialize(input)
    lines = input.split("\n")
    @n = lines[0].to_i
    @cf, @cb = lines[1].split(' ').map(&:to_i)
    @default_safeties = lines[2].split('').map { |s| s == 's' ? true : false }
    @complete_routes = []
  end

  def travel(visited, visit_candidates, safeties)
    visit_candidates.each do |vc|
      current_era = Era.new(visited, safeties)
      current_era.to(vc)
      travel(current_era.visited, current_era.not_visited, current_era.safeties)
      # 全部回っている
      if (1...@n).all? { |v| current_era.visited.include?(v) }
        # 現在が安全
        if current_era.safeties.last
          @complete_routes << current_era.visited.push(@n)
        # 現在が危険なので、他に安全な場所のうち、コストが低い方を回る(と、現在が安全になる)
        elsif (vc = current_era.lowcost_visit_candidate(@cb, @cf))
          @complete_routes << current_era.visited.push(vc).push(@n)
        end
      end
    end
  end

  def run
    self.travel([@n], self.visit_candidates, @default_safeties)
  end

  def visit_candidates
    @default_safeties[0...-1].map.with_index(1) do |safe, index|
      index if safe
    end.compact
  end

  def minimum_cost_route
    @complete_routes.sort_by do |route|
      cost(route)
    end.first.join(' ')
  end

  def cost(route)
    route.each_cons(2).inject(0) do |sum, (i, j)|
      sum + (i < j ? @cf : @cb)
    end
  end
end

class Era
  attr_reader :visited, :safeties

  def initialize(visited, safeties)
    @visited = Marshal.load(Marshal.dump(visited))
    @safeties = Marshal.load(Marshal.dump(safeties))
  end

  def not_visited
    @safeties[0...-1].map.with_index(1) do |safe, index|
      index if safe
    end.compact - @visited
  end

  # i >= 1
  def to(i)
    @visited << i
    (i...@safeties.size).each do |j|
      @safeties[j] = !@safeties[j]
    end
  end

  def lowcost_visit_candidate(cb, cf)
    vc = @safeties[0...-1].map.with_index(1) do |safe, index|
      index if safe
    end.compact - [@visited.last]
    vc.sort_by { |v| v < @visited.last ? cb : cf }.first
  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts f(input)
end
