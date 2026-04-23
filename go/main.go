package main

import (
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

// 3.0 kontroler pogody
type WeatherController struct {
	Service WeatherService
}

// 5.0 Endpoint obsługujący GET i POST, pozwalający na więcej niż jedną lokalizację
func (wc *WeatherController) HandleWeather(c echo.Context) error {
	var cities []string

	if c.Request().Method == http.MethodGet {
		// Pobieranie z parametru query, np. ?cities=Warszawa,Krakow
		citiesParam := c.QueryParam("cities")
		if citiesParam != "" {
			cities = strings.Split(citiesParam, ",")
		}
	} else if c.Request().Method == http.MethodPost {
		// Pobieranie z body JSON: {"cities": ["Warszawa", "Krakow"]}
		var body struct {
			Cities []string `json:"cities"`
		}
		if err := c.Bind(&body); err == nil {
			cities = body.Cities
		}
	}

	if len(cities) == 0 {
		// Domyślne miasto, jeśli nic nie podano
		cities = []string{"Warszawa"}
	}

	var results []Weather
	for _, city := range cities {
		w, err := wc.Service.GetWeather(city)
		if err != nil {
			continue
		}
		results = append(results, w)
	}

	// 5.0 zwraca JSON z danymi dla wszystkich miast
	return c.JSON(http.StatusOK, results)
}

func main() {
	// Konfiguracja bazy danych SQLite
	db, err := gorm.Open(sqlite.Open("weather.db"), &gorm.Config{})
	if err != nil {
		panic("Nie udało się połączyć z bazą danych")
	}

	db.AutoMigrate(&Weather{})

	// 3.5 Ładowanie początkowych danych przy uruchomieniu aplikacji
	var count int64
	db.Model(&Weather{}).Count(&count)
	if count == 0 {
		initialData := []Weather{
			{City: "Szczecin", Temperature: 15.5},
			{City: "Gdynia", Temperature: 20.0},
		}
		db.Create(&initialData)
	}

	// Inicjalizacja serwisów (Wzorzec Proxy)
	realAPI := &RealWeatherAPI{}
	proxy := &WeatherProxy{
		RealService: realAPI,
		DB: db,
	}

	// Inicjalizacja kontrolera
	controller := &WeatherController{
		Service: proxy,
	}

	e := echo.New()

	//3.0 Endpoint obsługujący GET i POST
	e.GET("/weather", controller.HandleWeather)
	e.POST("/weather", controller.HandleWeather)

	e.Logger.Fatal(e.Start(":8080"))
}