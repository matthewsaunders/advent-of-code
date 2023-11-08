package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// const fileName string = "puzzle_1_sample_input.txt"

const fileName string = "puzzle_1_input.txt"

func readInput() []string {
	file, err := os.Open(fileName)
	if err != nil {
		panic(err)
	}

	defer func() {
		if err := file.Close(); err != nil {
			panic(err)
		}
	}()

	inputs := []string{}
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()

		if line == "\n" {
			continue
		}

		inputs = append(inputs, line)
	}

	return inputs
}

func main() {
	data := readInput()
	totalArea := 0

	for _, input := range data {
		dimensions := strings.Split(input, "x")
		l, _ := strconv.Atoi(dimensions[0])
		w, _ := strconv.Atoi(dimensions[1])
		h, _ := strconv.Atoi(dimensions[2])

		side1 := l * w
		side2 := l * h
		side3 := w * h
		min := side1

		if side2 < min {
			min = side2
		}

		if side3 < min {
			min = side3
		}

		area := 2*side1 + 2*side2 + 2*side3 + min
		totalArea += area
	}

	fmt.Printf("Total area: %v\n", totalArea)
}
