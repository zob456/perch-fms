package data

import (
	"database/sql"
	"perchfms/api/models"
)

func SelectMemberList(db *sql.DB) ([]*models.Member, error) {
	/*language=PostgreSQL*/
	const query = `SELECT 
       "MemberID",
       "MemberUsername",
       "MemberFirstName",
       "MemberLastName",
       "AddressLine1",
       "AddressLine2",
       "City",
       "PostalCode"
    FROM "GloboGym"."vw_MemberList"`

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
		member := &models.Member{}
		member.MemberCountry = "USA"
		err = rows.Scan(
			&member.MemberID,
			&member.MemberUsername,
			&member.MemberFirstName,
			&member.MemberLastName,
			&member.MemberAddressLine1,
			&member.MemberAddressLine2,
			&member.MemberCountry,
			&member.MemberPostalCode,
			)
		if err != nil {
			return nil, err
		}
		members = append(members, member)
	}
	return members, nil
}
