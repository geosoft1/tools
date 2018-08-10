// $ROOT$ lambda function
package main

import (
	"flag"
	"net/http"
)

var (
	port = flag.String("port", "8080", "port")
)

func main() {
	flag.Parse()
	http.HandleFunc("/$ROOT$", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello world from lambda $ROOT$ function!"))
	})
	http.ListenAndServe(":"+*port, nil)
}

