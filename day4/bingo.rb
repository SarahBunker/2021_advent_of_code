# require "pry"
# file = File.open("day4.txt")
# report = file.read
# readings = report.split(/\n\n/)

# numbers = readings[0]
# boards = readings[1..-1]
# p numbers.split(',')
# p boards[0].split(/[\s]+/)
# board2 = boards[1].split(/[\s]+/)
# board2.delete('')
# p board2
# p boards[2].split(/[\s]+/)

class Square
  attr_reader :number
  def initialize(number)
    @number = number
    @marked = false
  end
  
  def marked?
    marked
  end
  
  def unmarked?
    !marked
  end
  
  def mark
    self.marked = true
  end
  
  def ==(num)
    number == num
  end
  
  private
  attr_accessor :marked
end

class BingoCard
  attr_reader :places
  
  @@current_num = nil
  
  def initialize(array)
    @places = init_places(array)
  end
  
  def init_places(array)
    result = {}
    array.each_with_index {|num,index| result[index + 1] = Square.new(num)}
    result
  end
  
  def unmarked_squares
    places.select {|place, square| square.unmarked? }
  end
  
  def mark(num)
    @@current_num = num
    unmarked_squares.each{|place, square| square.mark if square == num}
  end
  
  def current_num
    @@current_num
  end
  
  WINNING_LINES = [(1..5).to_a, (6..10).to_a, (11..15).to_a, (16..20).to_a, (21..25).to_a, [1, 6, 11, 16, 21], [2, 7, 12, 17, 22], [3, 8, 13, 18, 23], [4, 9, 14, 19, 24], [5, 10, 15, 20, 25]]
  
  def win?
    WINNING_LINES.each do |line|
      # p line if places.values_at(*line).all?(&:marked?)
      return true if places.values_at(*line).all?(&:marked?)
    end
    false
  end
  
  def score
    sum_unmarked = unmarked_squares.values.map(&:number).map(&:to_i).sum
    sum_unmarked * current_num.to_i
  end
  
  def ==(other)
    places == other.places
  end
end

class BingoGame
  attr_accessor :boards, :numbers, :board_array, :winning_board, :array_boards_finished
  def initialize(text_file)
    file = File.open(text_file)
    report = file.read
    readings = report.split(/\n\n/)
    
    @numbers = readings[0].split(',')
    boards = readings[1..-1]
    @board_array = []
    boards.each do |array|
      new_array = array.split(/[\s]+/)
      new_array.delete('')
      board_array << new_array
    end
    @boards = set_up_boards (board_array)
    @winning_board = nil
    @array_boards_finished = []
  end
  
  def set_up_boards(array_boards)
    boards = []
    array_boards.each{|array| boards << BingoCard.new(array)}
    boards
  end
  
  def call_numbers(array = self.numbers)
    array.each do |num|
      boards.each do |board|
        board.mark(num) unless board.win?
        if board.win?
          self.winning_board = board unless winning_board
          array_boards_finished << board unless array_boards_finished.include?(board)
          # binding.pry
        end
      end
    break if boards_won?
    end
  end
  
  def score_winning_board
    puts "The winning board scored #{winning_board.score}"
  end
  
  def boards_won?
    boards.all?(&:win?)
  end
end

game = BingoGame.new("bingo.txt")
game.call_numbers
# game.call_numbers(["7", "4", "9", "5", "11", "17", "23", "2", "0", "14", "21", "24"])
# # game.score_winning_board
puts game.boards_won?
# game.call_numbers(["10", "16", "13"])
# puts game.boards_won?
# game.call_numbers
# game.boards.each_with_index{|board, index| puts "board #{index + 1} won: #{board.win?}"}
# p game.boards[1].places.values_at(3)[0].marked?
# p game.boards[1].places.values_at(8)[0].marked?
# p game.boards[1].places.values_at(13)[0].marked?
# p game.boards[1].places.values_at(18)[0].marked?
# p game.boards[1].places.values_at(23)[0].marked?
p game.array_boards_finished[0].score
p game.array_boards_finished[-1].score