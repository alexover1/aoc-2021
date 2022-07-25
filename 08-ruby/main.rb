$lines = File.readlines("./input.txt")

def part_one
    result = 0
    $lines.each do |line|
        input, output = line.split(" | ")
        output.split.each do |word|
            if word.length == 7 || word.length == 4 || word.length == 3 || word.length == 2 then            
                result += 1
            end
        end
    end
    printf "Part One: %d\n", result
end

#  0
# 1 2
#  3
# 4 5
#  6

SEGS_SIZE = 7
DIGITS_CNT = 10

DIGIT_MASKS = [
    # 6543210
    0b1110111, # 0
    0b0100100, # 1
    0b1011101, # 2
    0b1101101, # 3
    0b0101110, # 4
    0b1101011, # 5
    0b1111011, # 6
    0b0100101, # 7
    0b1111111, # 8
    0b1101111, # 9
]

$all_segs = File.readlines("./segs.txt")
SEGS_CNT = 5040

def decode(segs, wire)
    mask = 0
    for i in 0..wire.length-1
        for j in 0..SEGS_SIZE-1
            if segs[j] == wire[i] then
                mask |= (1<<j)
            end
        end
    end
    DIGIT_MASKS.each_with_index do |dmask, i|
        if dmask == mask then return i end
    end
    return -1
end

def verify_segs(segs, wires)
    for i in 0..DIGITS_CNT-1
        if decode(segs, wires[i]) < 0 then
            return false
        end
    end
    return true
end

def part_two
    result = 0

    $lines.each do |line|
        inputs, outputs = line.split " | "
        inputs = inputs.split
        outputs = outputs.split

        i = 0
        while i < SEGS_CNT
            if verify_segs($all_segs[i], inputs) then
                break
            end
            i += 1
        end

        if i >= SEGS_CNT then raise "UNREACHABLE" end

        value = 0
        outputs.each do |word|
            value = value * 10 + decode($all_segs[i], word)
        end
        result += value
    end

    printf "Part Two: %d\n", result
end

part_one
part_two