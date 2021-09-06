package models

type Member struct {
	MemberID int
	MemberUsername string
	MemberFirstName string
	MemberLastName string
	MemberAddressLine1 string
	MemberAddressLine2 *string
	MemberCity string
	MemberState string
	MemberPostalCode int
	MemberCountry string
}
