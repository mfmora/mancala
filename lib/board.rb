require 'byebug'
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14){Array.new}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_index do |index|
      @cups[index] = Array.new(4){:stone} unless index == 6 || index == 13
    end
  end

  def valid_move?(start_pos)
    start_pos -= 1

    unless in_bounds?(start_pos)
      raise "Invalid starting cup"
    end
    p start_pos
  end

  def in_bounds?(position)
    position >= 0 && position < @cups.length - 1 && position != 6
  end

  def opponent_cup(from_pos)
    from_pos < 6 ? 13 : 6
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos].dup
    @cups[start_pos] = []
    opponent = opponent_cup(start_pos)

    next_pos = circular_position(start_pos + 1)
    stones.each do |stone|
      if next_pos == opponent
        next_pos = circular_position(next_pos + 1)
      end
      @cups[next_pos] << stone
      next_pos = circular_position(next_pos + 1)
    end

    render
    last_pos = circular_position(next_pos - 1)
    next_turn(last_pos)
  end

  def circular_position(position)
    position % 14
  end

  def next_turn(ending_cup_idx)
    return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13
    return :switch if @cups[ending_cup_idx].count == 1
    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
  end
end
