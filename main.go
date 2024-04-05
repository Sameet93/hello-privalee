package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, Privilee!")
	})
	e.GET("/health", func(c echo.Context) error {
		return c.String(http.StatusOK, "Healthy")
	})
	e.GET("/ready", func(c echo.Context) error {
		return c.String(http.StatusOK, "ready")
	})
	e.Logger.Fatal(e.Start(":1323"))
}
