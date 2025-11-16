package main

import (
	"fmt"
	"log"
	"os"
)

func main() {
	log.Println("[Project Name] starting...")

	if err := run(); err != nil {
		log.Printf("Fatal error: %v\n", err)
		os.Exit(1)
	}

	log.Println("[Project Name] ready!")
}

func run() error {
	// Your application logic here
	fmt.Println("Hello from [Project Name]!")

	return nil
}
