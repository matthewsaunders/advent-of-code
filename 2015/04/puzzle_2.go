package main

import (
	"crypto/md5"
	"fmt"
	"io"
)

func main() {
	secretKey := "ckczppom"
	number := 0

	for {
		h := md5.New()
		str := fmt.Sprintf("%v%v", secretKey, number)

		io.WriteString(h, str)
		hashedValue := fmt.Sprintf("%x", h.Sum(nil))

		token := hashedValue[0:6]
		// fmt.Println(hashedValue)

		if token == "000000" {
			break
		}

		number += 1
	}

	fmt.Printf("Answer: %v\n", number)
}
