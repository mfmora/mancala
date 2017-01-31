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
  end

  def in_bounds?(position)
    position >= 0 && position <= @cups.length - 1
  end

  def make_move(start_pos, current_player_name)
    debugger
    stones = @cups[start_pos]
    @cups[start_pos] = []
    next_pos = circular_position(start_pos + 1)
    stones.each do |stone|
      if next_pos == cup_from_position(start_pos)
        next_pos = circular_position(next_pos + 1)
      end
      @cups[next_pos] << stone
      next_pos = circular_position(next_pos + 1)
    end
    render
    next_turn(circular_position(next_pos))
  end

  def cup_from_position(position)
    position <= 6 ? 7 : 13
  end

  def circular_position(position)
    position % 14
  end

  def next_turn(ending_cup_idx)
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
