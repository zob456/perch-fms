package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.RouteInfo{
		Method:      "GET",
		Path:        "/",
		Handler:     "",
		HandlerFunc: nil,
	}
	fmt.Println(r.Handler)
}
