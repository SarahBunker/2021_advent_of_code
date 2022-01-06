require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require_relative 'bingo'

class SquareTest < Minitest::Test
  def setup
    @square = Square.new("24")
  end
  
  def test_setup
    assert(square)
    assert_equal(false, square.marked?)
  end
  
  def test_match
    assert_equal(true, square == "24")
    assert_equal(false, square == '3')
  end
  
  def test_num
    assert_equal("24", square.number)
  end
  
  def test_mark
    square.mark
    assert(square.marked?)
  end
  
  def test_unmarked?
    assert(square.unmarked?)
    square.mark
    assert_equal(false, square.unmarked?)
  end
  
  private
  attr_reader :square
end

class BingoCardTest < Minitest::Test
  attr_reader :card, :card3
  def setup
    @card = BingoCard.new(["22", "13", "17", "11", "0", "8", "2", "23", "4", "24", "21", "9", "14", "16", "7", "6", "10", "3", "18", "5", "1", "12", "20", "15", "19"])
    @card3 = BingoCard.new(["14", "21", "17", "24", "4", "10", "16", "15", "9", "19", "18", "8", "23", "26", "20", "22", "11", "13", "6", "5", "2", "0", "12", "3", "7"])
  end
  
  def test_setup_card
    assert_equal("11", card.places[4].number)
  end
  
  def test_unmarked_squares
    hash = card.places
    assert_equal(hash, card.unmarked_squares)
  end
  
  def test_mark_card
    card.mark("7")
    assert_equal("7", card.current_num)
    hash = card.places
    hash.delete(15)
    assert_equal(hash, card.unmarked_squares)
  end
  
  def test_win?
    assert_equal(false, card.win?)
    card.mark("22")
    card.mark("13")
    card.mark("17")
    card.mark("11")
    card.mark("0")
    assert(card.win?)
  end
  
  def test_score
    numbers = ["7", "4", "9", "5", "11", "17", "23", "2", "0", "14", "21", "24"]
    numbers.each {|number| card3.mark(number)}
    assert_equal(true, card3.win?)
    assert_equal("24", card3.current_num)
    assert_equal("24", card.current_num)
    assert_equal(4512, card3.score)
  end
end

class BingoGameTest < Minitest::Test
  attr_accessor :game, :card1, :card2, :card3
  def setup
    @game = BingoGame.new("day4.txt")
    @card1 = BingoCard.new(["22", "13", "17", "11", "0", "8", "2", "23", "4", "24", "21", "9", "14", "16", "7", "6", "10", "3", "18", "5", "1", "12", "20", "15", "19"])
    @card2 = BingoCard.new(["3", "15", "0", "2", "22", "9", "18", "13", "17", "5", "19", "8", "7", "25", "23", "20", "11", "10", "24", "4", "14", "21", "16", "12", "6"])
    @card3 = BingoCard.new([["14", "21", "17", "24", "4", "10", "16", "15", "9", "19", "18", "8", "23", "26", "20", "22", "11", "13", "6", "5", "2", "0", "12", "3", "7"]])
  end
  
  def test_setup_game
    assert_equal([card1,card2,card3], game.boards)
  end
  
  def test_winning_board
    game.call_numbers
    assert_equal(4512, game.winning_board.score)
    game.score_winning_board
  end
  
  def test_boards_won?
    assert_equal(false, game.boards_won?)
    game.call_numbers(["7", "4", "9", "5", "11", "17", "23", "2", "0", "14", "21", "24"])
    assert_equal(false, game.boards_won?)
    game.call_numbers(["10", "16", "13"])
    # assert_equal(true, game.boards_won?)
  end
end