FILE = "./input.txt"


def part_one(xs):
    sums = []
    for i in range(max(xs)):
        sums.append(sum([abs(x - i) for x in xs]))
    print("Part One:", min(sums))


def part_two(xs):
    sums = []
    for i in range(max(xs)):
        sums.append(sum([sum(range(abs(x - i)+1)) for x in xs]))
    print("Part Two:", min(sums))


with open(FILE, "r") as f:
    xs = [int(x) for x in f.read().split(",")]
    part_one(xs)
    part_two(xs)
