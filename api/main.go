package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"log"
)

var Router *gin.Engine

func main() {
	Router = gin.Default()
	lead := Router.Group("/leads")
	{
		lead.GET("", func(ctx *gin.Context) {
			ctx.JSON(200, gin.H{
				"lead": "I am a lead",
			})
		})
		fmt.Println("Starting service!!")
		log.Fatal(Router.Run(":8000"))
	}
}