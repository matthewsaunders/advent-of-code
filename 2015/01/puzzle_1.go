package main

import (
	"bufio"
	"fmt"
	"os"
)

// const fileName string = "puzzle_1_sample_input.txt"
const fileName string = "puzzle_1_input.txt"

func readInput() string {
	file, err := os.Open(fileName)
	if err != nil {
		panic(err)
	}

	defer func() {
		if err := file.Close(); err != nil {
			panic(err)
		}
	}()

	var input string
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()

		// skip empty lines
		if input == "\n" {
			continue
		}

		input = line
	}

	return input
}

func main() {
	input := readInput()

	floor := 0

	fmt.Println(input)

	for _, letter := range input {
		if letter == '(' {
			floor++
		} else {
			floor--
		}
	}

	fmt.Printf("Floor: %d\n", floor)
}
