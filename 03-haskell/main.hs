import Data.Char (digitToInt)
import Data.List
import Data.Function

input_path = "./input.txt"

mostCommon :: Ord a => [a] -> a
mostCommon = head . maximumBy (compare `on` length) . group . sort

leastCommon :: Ord a => [a] -> a
leastCommon = head . head . sortBy (compare `on` length) . group . sort

zipAllWith :: ([a] -> b) -> [[a]] -> [b]
zipAllWith _ [] = []
zipAllWith f xss = map f . transpose $ xss

zipAll = zipAllWith id

toDec :: String -> Int
toDec = foldl' (\acc x -> acc * 2 + digitToInt x) 0

-- Part One
reverseS :: String -> String
reverseS = map reverseC
	where 
		reverseC '0' = '1'
		reverseC '1' = '0'

solvePartOne :: [String] -> Int
solvePartOne input = x * y
	where 
		bits = map mostCommon . zipAll $ input
		x = toDec $ bits
		y = toDec . reverseS $ bits

partOne :: IO ()
partOne = do
	content <- readFile input_path
	print . solvePartOne . lines $ content

-- Part Two
chInPos :: Char -> Int -> String -> Bool
chInPos ch pos s = (s !! pos) == ch

oxygenRating :: Int -> [String] -> Int
oxygenRating pos [input] = toDec input
oxygenRating pos input = oxygenRating (pos+1) newInput
	where
		col = (zipAll input) !! pos
		filterChPos = chInPos (mostCommon col) pos
		newInput = filter filterChPos $ input

c02Rating :: Int -> [String] -> Int
c02Rating pos [input] = toDec input
c02Rating pos input = c02Rating (pos+1) newInput
	where
		col = (zipAll input) !! pos
		filterChPos = chInPos (leastCommon col) pos
		newInput = filter filterChPos $ input

solvePartTwo :: [String] -> Int
solvePartTwo input = o * c
	where
		o = oxygenRating 0 input
		c = c02Rating 0 input

partTwo :: IO ()
partTwo = do
	content <- readFile input_path
	print . solvePartTwo . lines $ content

main :: IO ()
main = do
	partOne
	partTwo
