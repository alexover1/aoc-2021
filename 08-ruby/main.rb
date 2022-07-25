$lines = File.readlines("./input.txt")

def part_one
    result = 0

    $lines.each do |line|
        head, tail = line.split(" | ")
        tail.split.each do |word|
            if word.length == 7 || word.length == 4 || word.length == 3 || word.length == 2 then            
                result += 1
            end
        end
    end

    printf "Part One: %d\n", result
end

part_one