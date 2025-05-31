package main

import (
	"fmt"
)

// #include "hello/hello.h"
import "C"

func main() {
	fmt.Println("Hello world from Go!")
	C.say_hello()
}
