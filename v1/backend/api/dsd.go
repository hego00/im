package api

import "github.com/gofiber/fiber"

// define a struct to represent a data provider
type Provider struct {
	ProviderIdentifier string `json:"provider_identifier"`
	Country            string `json:"country"`
	Jurisdiction       string `json:"jurisdiction"`
	Name               string `json:"provider_name"`
	Version            string `json:"provider_version"`
	Description        string `json:"provider_description"`
}

// define a slice to store the data providers
var providers []Provider

// function to start the api handler
func StartDSD() {
	app := fiber.New()
	app.Get("/providers", GetProviders)
	app.Get("/providers/:country/:jurisdiction/:ev_id", GetProviderByArea)
	app.Listen("localhost:8081")
}

func GetProviders(c *fiber.Ctx) {
	c.JSON(providers)
}

func GetProviderByArea(c *fiber.Ctx) {
	country := c.Params("country")
	jurisdiction := c.Params("jurisdiction")
	ev_id := c.Params("ev_id")

	for _, provider := range providers {
		if provider.Country == country &&
			provider.Jurisdiction == jurisdiction &&
			provider.ProviderIdentifier == ev_id {
			c.JSON(provider)
			return
		}
	}
	c.Status(404).Send("Provider not found")
}
