package api

import "github.com/gofiber/fiber"

type Record struct {
	RecordIdentifier  string `json:"Record_identifier"`
	RecordName        string `json:"Record_name"`
	RecordVersion     string `json:"Record_version"`
	RecordDescription string `json:"Record_description"`
	RecordPayload     string `json:"Record_payload"`
}

var records []Record

func StartEVProvider() {
	app := fiber.New()
	app.Get("/records", GetRecords)
	app.Get("/records/:record_id", GetRecordByID)
	app.Listen("localhost:8082")
}

func GetRecords(c *fiber.Ctx) {
	c.JSON(records)
}

func GetRecordByID(c *fiber.Ctx) {
	id := c.Params("record_id")
	for _, record := range records {
		if record.RecordIdentifier == id {
			c.JSON(record)
			return
		}
	}
	c.Status(404).Send("Record not found")
}
