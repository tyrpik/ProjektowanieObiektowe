const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 3001;

app.use(cors());
app.use(express.json());

const produkty = [
  { id: 1, nazwa: "Szafa", cena: 4500 },
  { id: 2, nazwa: "Krzesło", cena: 120 },
  { id: 3, nazwa: "Dywan", cena: 1800 },
];

app.get('/api/produkty', (req, res) => {
  console.log("Zapytanie o produkty...");
  res.json(produkty);
});

app.post('/api/platnosci', (req, res) => {
  const danePlatnosci = req.body;
  console.log("Otrzymano płatność:", danePlatnosci);
  
  res.status(201).json({ status: "success", message: "Płatność zarejestrowana!" });
});

app.listen(PORT, () => {
  console.log(`Serwer działa na http://localhost:${PORT}`);
});

// test husky