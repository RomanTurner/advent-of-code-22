require "minitest/autorun"

class DayTwo  < Minitest::Test
    def get_data_sum(opponent, player)
        File.readlines("day-2-test.txt", chomp: true).map(&:split).sum{|opp_move, ply_move| opponent[opp_move][player[ply_move]]}
    end
    def test_problem_one
        player = {
            "X" => :r,
            "Y" => :p,
            "Z" => :s
        }
        opponent = {
            "A" => {r: 4, p: 8, s: 3},
            "B" => {r: 1, p: 5, s: 9},
            "C" => {r: 7, p: 2, s: 6}
        }
        assert_equal(15, get_data_sum(opponent, player))
    end
    def test_problem_two
        player = {
            "X" => :l,
            "Y" => :d,
            "Z" => :w
        }
        opponent = {
           "A" => {l: 3, d: 4, w: 8},
           "B" => {l: 1, d: 5, w: 9},
           "C" => {l: 2, d: 6, w: 7}
        }
        assert_equal(12, get_data_sum(opponent, player))
    end
  end
