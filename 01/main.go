// Day 01, Sonar Sweep

package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func contains[T comparable](s []T, e T) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

const InputPath = "./input.txt"
const InputSize = 2000
const WindowSize = 3

func Readln(r *bufio.Reader) (string, error) {
	var (
		is_prefix bool  = true
		err       error = nil
		line, ln  []byte
	)
	for is_prefix && err == nil {
		line, is_prefix, err = r.ReadLine()
		ln = append(ln, line...)
	}
	return string(ln), err
}

func ReadInput(path string) *bufio.Reader {
	f, err := os.Open(path)
	if err != nil {
		panic(err)
	}
	return bufio.NewReader(f)
}

func ParseInt(s string) int {
	data, err := strconv.Atoi(s)
	if err != nil {
		panic(err)
	}
	return data
}

func PartOne() {
	r := ReadInput(InputPath)
	result := 0
	prev := -1

	for s, e := Readln(r); e == nil; s, e = Readln(r) {
		data := ParseInt(s)

		if prev != -1 && data > prev {
			result++
		}

		prev = data
	}

	fmt.Println("Part One:", result)
}

func SumSlice(s []int) int {
	result := 0
	for _, elem := range s {
		result += elem
	}
	return result
}

func PartTwo() {
	r := ReadInput(InputPath)
	result := 0

	var values [InputSize]int
	values_size := 0

	start := 0
	end := WindowSize
	prev := -1

	for s, e := Readln(r); e == nil; s, e = Readln(r) {
		values[values_size] = ParseInt(s)
		values_size++

		if values_size >= WindowSize {
			sum := SumSlice(values[start:end])

			if prev != -1 && sum > prev {
				result++
			}

			prev = sum
			start++
			end++
		}
	}

	fmt.Println("Part Two:", result)
}

func main() {
	PartOne()
	PartTwo()
}
