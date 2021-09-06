package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"log"
)

var Router *gin.Engine

func main() {
	Router = gin.Default()
	members := Router.Group("/members")
	{
		members.GET("", func(context *gin.Context) {
			context.JSON(200, gin.H{"Message": "Test"})
		})
		fmt.Println("Starting service!!")
		log.Fatal(Router.Run(":8000"))
	}
}