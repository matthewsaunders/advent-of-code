package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// const fileName string = "test_input.txt"

const fileName string = "input.txt"

const AND_TOKEN = "AND"
const OR_TOKEN = "OR"
const NOT_TOKEN = "NOT"
const LSHIFT_TOKEN = "LSHIFT"
const RSHIFT_TOKEN = "RSHIFT"
const ARROW_TOKEN = "->"

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

func stripWhitespace(str string) string {
	return strings.Fields(str)[0]
}

func strIsDigit(str string) bool {
	if _, err := strconv.Atoi(str); err == nil {
		return true
	}

	return false
}

func (c *Circuit) getValue(str string) (uint16, bool) {
	val, err := strconv.Atoi(str)

	if err == nil {
		fmt.Printf(">>> %v is a NUMBER", val)
		return uint16(val), true
	}

	otherVal, ok := c.wires[str]
	return otherVal, ok
}

func (c *Circuit) alreadyHasValue(str string) bool {
	if _, ok := c.wires[str]; ok {
		return true
	}

	return false
}

type Circuit struct {
	wires map[string]uint16
}

func (c *Circuit) PrintWires() {
	fmt.Println("---WIRES---")
	for wire, value := range c.wires {
		fmt.Printf("%v: %v\n", wire, value)
	}
}

func (c *Circuit) PrintWire(wire string) {
	fmt.Printf("%v: %v\n", wire, c.wires[wire])
}

func (c *Circuit) ValueOp(left string, right string) {
	wire := stripWhitespace(right)
	value, _ := strconv.Atoi(stripWhitespace(left))

	if !c.alreadyHasValue(wire) {
		c.wires[wire] = uint16(value)
	}
}

func (c *Circuit) AndOp(left string, right string) {
	wire := stripWhitespace(right)
	sources := strings.Split(left, AND_TOKEN)

	leftSource := stripWhitespace(sources[0])
	rightSource := stripWhitespace(sources[1])

	leftValue, lok := c.getValue(leftSource)
	rightValue, rok := c.getValue(rightSource)

	if lok && rok && !c.alreadyHasValue(wire) {
		fmt.Printf(">>> %v & %v = %v\n", leftValue, rightValue, leftValue&rightValue)
		c.wires[wire] = leftValue & rightValue
	}
}

func (c *Circuit) OrOp(left string, right string) {
	wire := stripWhitespace(right)
	sources := strings.Split(left, OR_TOKEN)

	leftSource := stripWhitespace(sources[0])
	rightSource := stripWhitespace(sources[1])

	leftValue, lok := c.getValue(leftSource)
	rightValue, rok := c.getValue(rightSource)

	if lok && rok && !c.alreadyHasValue(wire) {
		fmt.Printf(">>> %v & %v = %v\n", leftValue, rightValue, leftValue|rightValue)
		c.wires[wire] = leftValue | rightValue
	}
}

func (c *Circuit) NotOp(left string, right string) {
	wire := stripWhitespace(right)
	sources := strings.Split(left, NOT_TOKEN)
	source := stripWhitespace(sources[1])

	// value, ok := c.getValue(source)
	value, _ := c.getValue(source)

	// if ok && !c.alreadyHasValue(wire) {
	// 	fmt.Printf(">>> ^%v = %v\n", value, ^value)
	// 	c.wires[wire] = ^value
	// }
	c.wires[wire] = ^value

}

func (c *Circuit) LShiftOp(left string, right string) {
	wire := stripWhitespace(right)
	sources := strings.Split(left, LSHIFT_TOKEN)

	leftSource := stripWhitespace(sources[0])
	rightSource := stripWhitespace(sources[1])

	// leftValue, ok := c.getValue(leftSource)
	leftValue, _ := c.getValue(leftSource)
	rightValue, _ := strconv.Atoi(rightSource)

	// if ok && !c.alreadyHasValue(wire) {
	// 	fmt.Printf(">>> %v << %v = %v\n", leftValue, rightValue, leftValue<<rightValue)
	// 	c.wires[wire] = leftValue << rightValue
	// }
	c.wires[wire] = leftValue << rightValue

}

func (c *Circuit) RShiftOp(left string, right string) {
	wire := stripWhitespace(right)
	sources := strings.Split(left, RSHIFT_TOKEN)

	leftSource := stripWhitespace(sources[0])
	rightSource := stripWhitespace(sources[1])

	// leftValue, ok := c.getValue(leftSource)
	leftValue, _ := c.getValue(leftSource)
	rightValue, _ := strconv.Atoi(rightSource)

	// if ok && !c.alreadyHasValue(wire) {
	// 	fmt.Printf(">>> %v << %v = %v\n", leftValue, rightValue, leftValue>>rightValue)
	// 	c.wires[wire] = leftValue >> rightValue
	// }
	c.wires[wire] = leftValue >> rightValue
}

func (c *Circuit) ProcessInstruction(inst string) {
	halves := strings.Split(inst, ARROW_TOKEN)

	if len(halves) != 2 {
		panic("Failed to parse input into halves")
	}

	if strings.Contains(inst, AND_TOKEN) {
		c.AndOp(halves[0], halves[1])
	} else if strings.Contains(inst, OR_TOKEN) {
		c.OrOp(halves[0], halves[1])
	} else if strings.Contains(inst, NOT_TOKEN) {
		c.NotOp(halves[0], halves[1])
	} else if strings.Contains(inst, LSHIFT_TOKEN) {
		c.LShiftOp(halves[0], halves[1])
	} else if strings.Contains(inst, RSHIFT_TOKEN) {
		c.RShiftOp(halves[0], halves[1])
	} else {
		c.ValueOp(halves[0], halves[1])
	}
}

func (c *Circuit) ProcessInstructions(instructions []string) {
	for _, instruction := range instructions {
		fmt.Printf("> %v\n", instruction)
		c.ProcessInstruction(instruction)
	}
}

func NewCircuit() *Circuit {
	return &Circuit{
		wires: make(map[string]uint16),
	}
}

func main() {
	input := readInput()

	circuit := NewCircuit()
	circuit.ProcessInstructions(input)
	circuit.PrintWires()
	circuit.PrintWire("a")
}
