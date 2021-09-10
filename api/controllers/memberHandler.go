package controllers

import (
	"database/sql"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"perchfms/api/data"
)

type MemberHandlers struct {
	db *sql.DB
}

func NewMemberHandler(db *sql.DB) *MemberHandlers {
	return &MemberHandlers{db: db}
}

func(h *MemberHandlers) GetMemberList(c *gin.Context) {
	memberList, err := data.SelectMemberList(h.db)
	if err != nil {
		log.Println(err)
		c.JSON(http.StatusNotFound, gin.H{"ERROR": "NO members found. Bad query"} )
		return
	}
	c.JSON(http.StatusOK, gin.H{"memberList": memberList})
}