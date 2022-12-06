require 'minitest/autorun'
require 'pry'

#--- Day 5: Supply Stacks ---
class DayFive
    attr_accessor :stack_file_name, :data_file_name, :stack, :byte_array, :file_name, :moves, :reverse

    def initialize(stack_file_name, data_file_name)
        @stack_file_name, @data_file_name = stack_file_name, data_file_name
        set_up_stack
    end

    def set_up_stack
        byte_array = File.readlines(@stack_file_name, chomp: true).map(&:bytes)
        byte_matrix, byte_headers = byte_array.slice(0, byte_array.size - 1), byte_array.last
        headers = byte_headers.map.with_index{|value, index| [value, index] unless[32, 91, 93].include?(value)}.compact!
        @stack = headers.inject({}) do |memo, (byte_key, line_location)|
              memo[Integer(byte_key.chr)] = []
              memo
        end

        byte_matrix.each do |line|
            headers.each do |(hash_key, line_location)|
                value = line[line_location]
                unless value.nil? || value == 32
                    @stack[Integer(hash_key.chr)] << value.chr
                end
             end
        end
    end

    def problem_one
        @reverse = true
        process_problem
    end

    def problem_two
        @reverse = false
        process_problem
    end

    def process_problem
        @moves = File.readlines(@data_file_name, chomp: true).map{|line| line.scan(/\d+/).map(&:to_i)}
        process_moves
        collect_message
    end

    def collect_message
        @stack.keys.map {|key| @stack[key][0]}.join('')
    end

    def process_moves
        @moves.each do |move|
            amount, start, finish = *move
            if @stack[start].nil?
                next
            else
                temp = @stack[start].shift(amount)
                temp.reverse! if @reverse
                @stack[finish].prepend(*temp)
            end
        end
    end
end


class TestDayFive < MiniTest::Test
    #todo: you can read it from a single file
    #todo: a, b = x.slice(0, x.find_index([])), x.slice(x.find_index([]) + 1, x.size)

    def test_set_up_stack
        test_stack = {
            1 => %w(N Z),
            2 => %w(D C M),
            3 => %w(P)
        }
        d5 = DayFive.new('test-stack.txt', 'day-5-test.txt')
        assert_equal(d5.stack, test_stack)
    end

    def test_problem_one
        d5 = DayFive.new('test-stack.txt', 'day-5-test.txt')
        assert_equal(d5.problem_one, "CMZ")
    end

    def test_problem_one_data
        d5 = DayFive.new('stack.txt', 'day-5-data.txt')
        assert_equal(d5.problem_one, "MQSHJMWNH")
    end

    def test_problem_two_data
        d5 = DayFive.new('stack.txt', 'day-5-data.txt')
        assert_equal(d5.problem_two, "LLWJRBHVZ")
    end

end
