package models

type Instructor struct {
	InstructorID int
	InstructorUsername string
	InstructorFirstName string
	InstructorLastName string
	InstructorAddressLine1 string
	InstructorAddressLine2 *string
	InstructorCity string
	InstructorState string
	InstructorPostalCode int
	InstructorCountry string
}
