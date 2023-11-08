package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// const fileName string = "puzzle_input_sample.txt"

const fileName string = "puzzle_input.txt"

var vowels []string = []string{"a", "e", "i", "o", "u"}
var illegalStrings []string = []string{"ab", "cd", "pq", "xy"}
var minVowelCount int = 3

func contains(arr []string, s string) bool {
	for _, val := range arr {
		if val == s {
			return true
		}
	}

	return false
}

func isStrNice(s string) bool {
	fmt.Printf("%v - ", s)

	// test for illegal substrings
	for _, substr := range illegalStrings {
		if strings.Contains(s, substr) {
			fmt.Printf("found illegal string\n")
			return false
		}
	}

	// test for vowel count
	vowelCount := 0
	for _, letter := range s {
		if contains(vowels, string(letter)) {
			vowelCount += 1
		}
	}

	if vowelCount < 3 {
		fmt.Printf("not enough vowels\n")
		return false
	}

	// test for consectuive letters
	hasConsecutiveLetters := false
	previousLetter := s[0:1]

	for i := 1; i < len(s); i++ {
		letter := s[i : i+1]
		if letter == previousLetter {
			hasConsecutiveLetters = true
			break
		}

		previousLetter = letter
	}

	if !hasConsecutiveLetters {
		fmt.Printf("no consecutive letters\n")
		return false
	}

	fmt.Printf("NICE!!\n")
	return true
}

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
	numNiceStrs := 0

	for _, input := range data {
		if isStrNice(input) {
			numNiceStrs += 1
		}
	}

	fmt.Printf("Answer: %v\n", numNiceStrs)
}
