FILE = "./input.txt"

# Part One
with open(FILE, "r") as f:
    xs = [int(x) for x in f.read().split(",")]
    sums = []
    for i in range(max(xs)):
        sums.append(sum([abs(x - i) for x in xs]))
    print("Part One:", min(sums))

# Part Two
with open(FILE, "r") as f:
    xs = [int(x) for x in f.read().split(",")]
    sums = []
    for i in range(max(xs)):
        sums.append(sum([sum(range(abs(x - i)+1)) for x in xs]))
    print("Part Two:", min(sums))
