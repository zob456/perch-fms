package controllers

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"github.com/zob456/perch-fms/api/data"
)

func GetMemberList(c *gin.Context) {
	memberList, err := data.SelectMemberList()
	if err != nil {
		log.Println(err)
		c.JSON(http.StatusNotFound, gin.H{"ERROR": "NO members found. Bad query"} )
		return
	}
	c.JSON(http.StatusOK, gin.H{"memberList": memberList})
}