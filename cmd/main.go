package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
	"log"
	"perchfms/api/controllers"
	"perchfms/api/data"
)

var Router *gin.Engine

func main() {
	db := data.ConnectDB()
	msg := db.Ping()
	fmt.Println(msg)
	Router = gin.Default()
	memberHandlers := controllers.NewMemberHandler(db)
	members := Router.Group("/members")
	{
		members.GET("", memberHandlers.GetMemberList)
		fmt.Println("Starting service!!")
		log.Fatal(Router.Run(":8000"))
	}
}
