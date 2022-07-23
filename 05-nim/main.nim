import std/strutils
import std/math

const file = "input.txt"
const size = 1000

type Point = object
  x: int
  y: int

var board: array[size, array[size, int]]

proc make_point(s: seq[string]): Point =
  let x = parseInt(s[0])
  let y = parseInt(s[1])
  return Point(x: x, y: y)

proc show_board() =
  for row in board:
    for col in row:
      if col == 0:
        stdout.write ". "
      else:
        stdout.write col
        stdout.write " "
    stdout.write "\n"
    stdout.flushFile()

proc sign(x: int): int =
  if x == 0: return x
  elif x < 0: return -1
  else: return 1

proc draw_line(x0: var int, y0: var int, x1: var int, y1: var int) =
  var x = 0
  var y = 0
  var n = max(abs(x1-x0)+1, abs(y1-y0)+1)

  for i in 0..< n:
    x = x0+sign(x1-x0)*i;
    y = y0+sign(y1-y0)*i;
    board[y][x].inc()

proc solve(diagonals: bool): int =
  for line in lines(file):
    var pairs = line.split(" -> ")
    var p1 = make_point(pairs[0].split(","))
    var p2 = make_point(pairs[1].split(","))

    if p1.x == p2.x or p1.y == p2.y:
      draw_line(p1.x, p1.y, p2.x, p2.y)
    elif diagonals:
      draw_line(p1.x, p1.y, p2.x, p2.y)

  var res = 0
  for row in board:
    for col in row:
      if col > 1:
        res.inc()
  return res

# echo "Part One: ", solve(false)
echo "Part Two: ", solve(true)
