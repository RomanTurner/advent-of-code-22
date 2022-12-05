require 'minitest/autorun'

#--- Day 3: Rucksack Reorganization ---
class DayThree
    attr_accessor :triage_points, :sum, :file_name
    def initialize(file_name)
        @triage_points = ((97..122).to_a + ((97-32)..(122-32)).to_a).map(&:chr).each_with_object(Hash.new(0)).with_index{|(v, hash), i| hash[v] = i + 1}
        @sum = 0
        @file_name = file_name
    end

    def problem_one
        File.readlines(@file_name, chomp: true).each_with_index do |line, index|
             first, second = line.slice!(0, line.size/2).split(''), line.split('')
             dup = first & second
             dup.each {|d| @sum += @triage_points[d]}
        end
        @sum
    end

    def problem_two
        elf_groups = []
        File.readlines(@file_name, chomp:true).each_slice(3){|group| elf_groups << group }
        elf_groups.each do |group|
          first, second, third = group
          badge = first.split(//) & second.split(//) & third.split(//)
          @sum += @triage_points[badge[0]]
        end
        @sum
    end
end

class DayThreeTest < MiniTest::Test
    def test_problem_one
        d3 = DayThree.new('day-3-test.txt')
        assert_equal(157, d3.problem_one)
    end

    def test_problem_two
        d3 = DayThree.new('day-3-test.txt')
        assert_equal(d3.problem_two, 70)
    end
end
