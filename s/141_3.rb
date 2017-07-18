def f(input)
  log = HilightLog.new(input)
  log.run
  log.hilight_count.to_s
end

class HilightLog
  attr_accessor :l, :n, :logs, :hilights, :hilight_count

  def initialize(input)
    lines = input.split("\n")
    @l, @n = lines[0].split(' ').map(&:to_i)
    @logs = lines[1..@n].map { |l| l.split(' ').map(&:to_i) }
    @hilights = []
    @hilight_count = 0
  end

  def run
    require 'pp'
    @logs.each do |s, e|
#      puts "==log: #{s}, #{e}=="
#      pp @hilights
      hilight(s, e)
#      pp @hilights
#      puts "=============================\n"
    end
  end

  def unhilight(s, e)
    current_range = s..e
    ret = false
    target_index = @hilights.map { |r| r.begin }.bsearch_index { |b| b > current_range.begin } || @hilights.size
    prev_index = target_index - 1
    if (covered_range = @hilights[prev_index]) && covered_range.cover?(current_range.begin) && covered_range.cover?(current_range.end)
      covered_range_id = prev_index
      covered_range = @hilights[covered_range_id]
      @hilights.delete_at(covered_range_id)
      if current_range.begin == covered_range.begin
        unless covered_range.end == current_range.end
          @hilights.insert(covered_range_id, (current_range.end + 1)..covered_range.end)
        end
      else
        @hilights.insert(covered_range_id, covered_range.begin..(current_range.begin - 1))
        unless covered_range.end == current_range.end
          @hilights.insert(covered_range_id + 1, (current_range.end + 1)..covered_range.end)
        end
      end
      ret = true
    end
    ret
  end

  def hilight(s, e)
    return if unhilight(s, e)
    current_range = s..e
    # 空なら単に追加
    if @hilights.empty?
      @hilights << current_range
      return
    end

    next_index = @hilights.map { |r| r.begin }.bsearch_index { |b| b >= current_range.begin } || @hilights.size
    next_range = @hilights[next_index]
    prev_index = next_index - 1
    prev_range = @hilights[prev_index] if prev_index >= 0
    if next_range
      # 次の要素の前に挿入
      if current_range.end + 1 < next_range.begin
        @hilights.insert(next_index, current_range)
      else
        @hilights.delete_at(next_index)
        # 次の要素の左側に連結
        begin_index =
          if current_range.end + 1 >= next_range.begin
            current_range.begin
          else
            next_range.begin
          end
        end_index = [current_range.end, next_range.end].max
        new_range = begin_index..end_index
        @hilights.insert(next_index, new_range)

        merge_candidate_index = next_index + 1
        while merge_candidate = @hilights[merge_candidate_index]
          # 後ろで除去するものがあれば処理
          if merge_candidate.end <= new_range.end
            @hilights.delete_at(merge_candidate_index)
            next
          end
          # 後ろで連結するものがあれば処理
          if merge_candidate.begin <= new_range.end + 1
            @hilights.delete_at(merge_candidate_index)
            new_range = new_range.begin..merge_candidate.end
            @hilights.insert(next_index, new_range)
          end
          break
        end

        # 一つ前と連結する必要があれば連結
        if prev_range
          if new_range.begin <= prev_range.end + 1
            @hilights.delete_at(prev_index)
            @hilights.delete_at(prev_index)
            begin_index = prev_range.begin
            end_index = new_range.end
            @hilights.insert(prev_index, begin_index..end_index)
          end
        end
      end
    else
      # 前の要素の後に挿入
      if prev_range.end + 1 < current_range.begin
        @hilights << current_range
      # 前の要素の後に連結
      else
        @hilights.delete_at(prev_index)
        @hilights.insert(prev_index, prev_range.begin..current_range.end)
      end
    end
  end

  def hilight_count
    @hilights.map { |r| r.size }.inject(:+) || 0
  end
end

if $PROGRAM_NAME == __FILE__
  input = STDIN.readlines.join('')
  puts f(input)
end
