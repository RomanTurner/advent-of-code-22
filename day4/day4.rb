require 'minitest/autorun'

class DayFour
    attr_accessor :file_name, :sum

    def initialize(file_name)
        @file_name = file_name
        @sum = 0
    end

    def problem_one
        File.readlines(@file_name, chomp: true).each do |line|
            first, second = file_line_to_range_tuple(line)
            @sum += 1 if first.cover?(second) || second.cover?(first)
        end
        @sum
    end

    def problem_two
        File.readlines(@file_name, chomp: true).each do |line|
            @sum += 1 if overlap?(*file_line_to_range_tuple(line))
        end
        @sum
    end

    def overlap?(a, b)
        b.begin <= a.end && a.begin <= b.end
    end

    def file_line_to_range_tuple(line)
        a, b = line.split(',')
        [change_custom_str_to_range(a), change_custom_str_to_range(b)]
    end

    def change_custom_str_to_range(str)
        Range.new(*str.split('-').map(&:to_i))
    end

end

class TestDayFour < MiniTest::Test
    def test_change_custom_str_to_range
        assert_equal(Range.new(*'2-4'.split('-').map(&:to_i)), 2..4)
        assert_equal(Range.new(*'888-1234'.split('-').map(&:to_i)), 888..1234)
    end

    def test_does_overlap
        d4 = DayFour.new('day-4-test.txt')
        assert(d4.overlap?((1..3), (2..5)))
    end

    def test_does_not_overlap
        d4 = DayFour.new('day-4-test.txt')
        refute(d4.overlap?((1..3), (6..9)))
    end

    def test_problem_one_test
        d4 = DayFour.new('day-4-test.txt')
        assert_equal(d4.problem_one, 2)
    end

    def test_problem_one_data
        d4 = DayFour.new('day-4-data.txt')
        assert_equal(d4.problem_one, 538)
    end

    def test_problem_two_test
        d4 = DayFour.new('day-4-test.txt')
        assert_equal(d4.problem_two, 4)
    end

    def test_problem_two_data
        d4 = DayFour.new('day-4-data.txt')
        assert_equal(d4.problem_two, 792)
    end
end
