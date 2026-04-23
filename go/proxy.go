package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"gorm.io/gorm"
)

// Wspólny interfejs dla  API i Proxy
type WeatherService interface {
	GetWeather(city string) (Weather, error)
}

type RealWeatherAPI struct{}

func (r *RealWeatherAPI) GetWeather(city string) (Weather, error) {
	coords := map[string]string{
		"Warszawa": "latitude=52.2298&longitude=21.0118",
		"Krakow":   "latitude=50.0614&longitude=19.9366",
		"Gdansk":   "latitude=54.352&longitude=18.6466",
	}

	coord, exists := coords[city]
	if !exists {
		return Weather{}, fmt.Errorf("nieznane miasto: %s", city)
	}

	url := fmt.Sprintf("https://api.open-meteo.com/v1/forecast?%s&current_weather=true", coord)
	resp, err := http.Get(url)
	if err != nil {
		return Weather{}, err
	}
	defer resp.Body.Close()

	var result struct {
		CurrentWeather struct {
			Temperature float64 `json:"temperature"`
		} `json:"current_weather"`
	}
	json.NewDecoder(resp.Body).Decode(&result)

	return Weather{City: city, Temperature: result.CurrentWeather.Temperature}, nil
}

// 4.0 Klasa Proxy pobierająca dane z serwisu zewnętrznego podczas zapytania do naszego kontrolera
type WeatherProxy struct {
	RealService WeatherService
	DB *gorm.DB
}

// 4.5 Zapis pobranych danych do bazy danych
func (p *WeatherProxy) GetWeather(city string) (Weather, error) {
	weather, err := p.RealService.GetWeather(city)
	if err != nil {
		return Weather{}, err
	}
	p.DB.Create(&weather)
	return weather, nil
}