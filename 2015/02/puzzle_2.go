package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
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
	totalLength := 0

	for _, input := range data {
		strDimensions := strings.Split(input, "x")
		l, _ := strconv.Atoi(strDimensions[0])
		w, _ := strconv.Atoi(strDimensions[1])
		h, _ := strconv.Atoi(strDimensions[2])

		dimensions := []int{l, w, h}
		sort.Ints(dimensions)

		length := 2*dimensions[0] + 2*dimensions[1] + (l * w * h)
		totalLength += length
		fmt.Printf("%vx%vx%v - %v,%v - %v\n", l, w, h, dimensions[0], dimensions[1], length)
	}

	fmt.Printf("Total area: %v\n", totalLength)
}
