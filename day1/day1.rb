memo = {}
deer = 1
File.readlines('day-1-data.txt').each do |line|
    line.strip!
    if line.empty?
        deer += 1
        next
    end
    memo[deer].nil? ? memo[deer] = Integer(line) : memo[deer] += Integer(line)
end
memo.sort_by(&:last).last(3).map{|k, v| v}.sum
memo.max_by{|k,v| v}
