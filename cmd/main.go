package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/signalfx/signalfx-istio-adapter/signalfx"
)

func main() {
	port := flag.String("port", "8080", "The TCP port to listen on")
	flag.Parse()

	if flag.NArg() > 0 {
		flag.PrintDefaults()
		os.Exit(1)
	}

	s, err := signalfx.NewAdapter(*port)
	if err != nil {
		fmt.Printf("unable to start server: %v", err)
		os.Exit(-1)
	}

	shutdown := make(chan error, 1)
	go func() {
		s.Run(shutdown)
	}()
	_ = <-shutdown
}
