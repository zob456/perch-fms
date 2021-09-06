package data

import (
	"../models"
	"database/sql"
)

var db *sql.DB

func SelectMemberList() ([]*models.Member, error) {
	/*language=PostgreSQL*/
	const query = `SELECT "MemberFirstName" FROM "GloboGym"."vw_MemberList"`

	var members []*models.Member
	stmt, err := db.Prepare(query)
	if err != nil {
		return nil, err
	}
	rows, err := stmt.Query()
	if err != nil {
		return nil, err
	}
	for rows.Next() {
		var member *models.Member
		err = rows.Scan(&members)
		if err != nil {
			return nil, err
		}
		members = append(members, member)
	}
	return members, nil
}
