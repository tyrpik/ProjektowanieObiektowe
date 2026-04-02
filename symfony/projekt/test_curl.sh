#!/bin/bash

echo "--- 1. Dodawanie Mleka (POST) ---"
curl -X POST http://127.0.0.1:8000/api/products \
     -H "Content-Type: application/json" \
     -d '{"name": "Mleko", "price": 3.99, "category": "Nabial"}'
echo -e "\n\n"

echo "--- 2. Dodawanie Chleba (POST) ---"
curl -X POST http://127.0.0.1:8000/api/products \
     -H "Content-Type: application/json" \
     -d '{"name": "Chleb", "price": 4.50, "category": "Pieczywo"}'
echo -e "\n\n"

echo "--- 3. Pobieranie wszystkich produktow (GET) ---"
curl -X GET http://127.0.0.1:8000/api/products
echo -e "\n\n"

echo "--- 4. Zmiana ceny Mleka (PUT) ---"
curl -X PUT http://127.0.0.1:8000/api/products/1 \
     -H "Content-Type: application/json" \
     -d '{"price": 4.20}'
echo -e "\n\n"

echo "--- 5. Usuwanie Chleba (DELETE) ---"
curl -X DELETE http://127.0.0.1:8000/api/products/2
echo -e "\n\n"

echo "--- 6. Ponowne pobranie produktow (GET) ---"
curl -X GET http://127.0.0.1:8000/api/products
echo -e "\n\n"