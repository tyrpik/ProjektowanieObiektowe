package main

import "gorm.io/gorm"

// 3.5 Model Pogoda wykorzystujący GORM
type Weather struct {
	gorm.Model
	City string  `json:"city"`
	Temperature float64 `json:"temperature"`
}