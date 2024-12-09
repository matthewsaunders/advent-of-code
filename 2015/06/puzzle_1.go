package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const fileName string = "input.txt"
const MAX_X = 1000
const MAX_Y = 1000
const TURN_ON_PREFIX = "turn on"
const TURN_OFF_PREFIX = "turn off"
const TOGGLE_PREFIX = "toggle"
const SPLIT_STR = "through"

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

type Board struct {
	lights [][]bool
}

func NewBoard() *Board {
	lights := make([][]bool, MAX_X)
	for i := 0; i < MAX_X; i++ {
		lights[i] = make([]bool, MAX_Y)
	}

	return &Board{
		lights: lights,
	}
}

func (b *Board) NumLightsOn() int {
	count := 0

	for i := 0; i < len(b.lights); i++ {
		for j := 0; j < len(b.lights[i]); j++ {
			if b.lights[i][j] {
				count++
			}
		}
	}

	return count
}

func (b *Board) TurnOn(x0 int, y0 int, x1 int, y1 int) {
	for i := x0; i <= x1; i++ {
		for j := y0; j <= y1; j++ {
			b.lights[i][j] = true
		}
	}
}

func (b *Board) TurnOff(x0 int, y0 int, x1 int, y1 int) {
	for i := x0; i <= x1; i++ {
		for j := y0; j <= y1; j++ {
			b.lights[i][j] = false
		}
	}
}

func (b *Board) Toggle(x0 int, y0 int, x1 int, y1 int) {
	for i := x0; i <= x1; i++ {
		for j := y0; j <= y1; j++ {
			b.lights[i][j] = !b.lights[i][j]
		}
	}
}

func stripWhitespace(str string) string {
	return strings.Fields(str)[0]
}

func getCoordinateValues(input string) (int, int, int, int) {
	halves := strings.Split(input, SPLIT_STR)
	start := strings.Split(halves[0], ",")
	end := strings.Split(halves[1], ",")

	x0, _ := strconv.Atoi(stripWhitespace(start[0]))
	y0, _ := strconv.Atoi(stripWhitespace(start[1]))
	x1, _ := strconv.Atoi(stripWhitespace(end[0]))
	y1, _ := strconv.Atoi(stripWhitespace(end[1]))

	return x0, y0, x1, y1
}

func main() {
	input := readInput()

	// 1. create board
	board := NewBoard()

	// 2. operate on board
	for _, instruction := range input {
		fmt.Println(instruction)

		if strings.HasPrefix(instruction, TURN_ON_PREFIX) {
			refinedInput := strings.TrimPrefix(instruction, TURN_ON_PREFIX)
			x0, y0, x1, y1 := getCoordinateValues(refinedInput)

			board.TurnOn(x0, y0, x1, y1)
		} else if strings.HasPrefix(instruction, TURN_OFF_PREFIX) {
			refinedInput := strings.TrimPrefix(instruction, TURN_OFF_PREFIX)
			x0, y0, x1, y1 := getCoordinateValues(refinedInput)

			board.TurnOff(x0, y0, x1, y1)
		} else if strings.HasPrefix(instruction, TOGGLE_PREFIX) {
			refinedInput := strings.TrimPrefix(instruction, TOGGLE_PREFIX)
			x0, y0, x1, y1 := getCoordinateValues(refinedInput)

			board.Toggle(x0, y0, x1, y1)
		} else {
			fmt.Printf("==> Unknown instruction: %v\n", instruction)
		}

		fmt.Printf("..%v\n", board.NumLightsOn())
	}

	// 3. count lights turned on
	fmt.Printf("answer: %v\n", board.NumLightsOn())
}
