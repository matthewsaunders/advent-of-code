package main

import (
	"bufio"
	"fmt"
	"os"
)

// const fileName string = "puzzle_input_sample_2.txt"

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

func getUniqueValues(values []int) []int {
	uniqueVals := make(map[int]bool)

	for _, val := range values {
		uniqueVals[val] = true
	}

	uniqueSlice := []int{}
	for num, _ := range uniqueVals {
		uniqueSlice = append(uniqueSlice, num)
	}

	return uniqueSlice
}

func isStrNice(s string) bool {
	fmt.Printf("\n%v\n", s)

	// test for letter pairs
	pairs := make(map[string][]int)
	for i := 0; i < len(s)-1; i++ {
		// Use the letters as the key and the indicies of the letters as values
		pair := s[i : i+2]
		pairs[pair] = append(pairs[pair], i)
		pairs[pair] = append(pairs[pair], i+1)
	}

	hasMultiplePairs := false
	for _, indicies := range pairs {
		uniqueIndicies := getUniqueValues(indicies)

		// If there aren't more than 2 indicies present, than the pair only appeared once
		if len(indicies) > 2 {
			// Either non of the indicies overlap, or they overlap but there were
			// enough inidicies that there had to be at least 2 non overlapping
			// pairs. The smallest possible case is "xxxx". If you look at the
			// uniique indicies there should be at least 4.
			if len(uniqueIndicies) == len(indicies) || (len(uniqueIndicies) != len(indicies) && len(uniqueIndicies) >= 4) {
				hasMultiplePairs = true
				break
			}
		}
	}

	if !hasMultiplePairs {
		fmt.Printf("==> FAIL - missing multiple pairs\n")
		return false
	}

	// test for letter repeats
	hasThreeLetterPattern := false
	for i := 0; i <= len(s)-3; i++ {
		first := s[i : i+1]
		third := s[i+2 : i+3]

		if first == third {
			hasThreeLetterPattern = true
			break
		}
	}

	if !hasThreeLetterPattern {
		fmt.Printf("==> FAIL - missing 3 letter pattern\n")
		return false
	}

	fmt.Printf("==> NICE!!\n")
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

	fmt.Printf("\nAnswer: %v\n", numNiceStrs)
}
