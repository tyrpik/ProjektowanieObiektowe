#!/bin/bash

echo "--- Dodawanie Pracownikow ---"
curl -X POST http://127.0.0.1:8000/api/employees \
     -H "Content-Type: application/json" \
     -d '{"name": "Anna Nowak", "position": "Kasjerka"}'

echo -e "\n"

curl -X POST http://127.0.0.1:8000/api/employees \
     -H "Content-Type: application/json" \
     -d '{"name": "Jan Kowalski", "position": "Kierownik Sklepu"}'

echo -e "\n\n--- Dodawanie Dostawcow ---"
curl -X POST http://127.0.0.1:8000/api/suppliers \
     -H "Content-Type: application/json" \
     -d '{"company": "Hurtownia Nabialu Krasula", "phone": "123 456 789"}'

echo -e "\n"

curl -X POST http://127.0.0.1:8000/api/suppliers \
     -H "Content-Type: application/json" \
     -d '{"company": "Piekarnia Zloty Klos", "phone": "987 654 321"}'