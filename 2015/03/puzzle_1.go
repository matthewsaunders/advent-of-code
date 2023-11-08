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

		if input == "\n" {
			continue
		}

		input = line
	}

	return input
}

func main() {
	input := readInput()

	x := 0
	y := 0
	houses := make(map[string]int)
	key := fmt.Sprintf("%v,%v", x, y)
	houses[key] += 1

	for _, direction := range input {
		switch direction {
		case '^':
			y += 1
		case '>':
			x += 1
		case 'v':
			y -= 1
		case '<':
			x -= 1
		}

		key := fmt.Sprintf("%v,%v", x, y)
		houses[key] += 1
	}

	keys := []string{}

	for key, _ := range houses {
		keys = append(keys, key)
	}

	fmt.Printf("Total houses: %v\n", len(keys))
}
