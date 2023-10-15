package main

import (
	"bytes"
	"fmt"
	"log"
	"os"

	"gopkg.in/yaml.v2"
)

func main() {
	// Get files from arguments
	if len(os.Args) < 2 {
		log.Fatal("No files provided")
	}
	files := os.Args[1:]

	namespaces := make(map[string]bool)

	for _, file := range files {
		content, err := os.ReadFile(file)
		if err != nil {
			log.Fatalf("Error reading file %s: %v", file, err)
		}

		// Split the content into multiple documents
		docs := splitYAML(content)

		for _, doc := range docs {
			manifest := make(map[interface{}]interface{})
			err = yaml.Unmarshal(doc, &manifest)
			if err != nil {
				log.Printf("Error parsing YAML in file %s: %v", file, err)
				continue
			}

			if metadata, ok := manifest["metadata"].(map[interface{}]interface{}); ok {
				if ns, ok := metadata["namespace"].(string); ok {
					namespaces[ns] = true
				}
			}
		}
	}

	for ns := range namespaces {
		fmt.Println(ns)
	}
}

// splitYAML splits a multi-document YAML into individual documents
func splitYAML(content []byte) [][]byte {
	separator := []byte("\n---\n")
	return bytes.Split(content, separator)
}
