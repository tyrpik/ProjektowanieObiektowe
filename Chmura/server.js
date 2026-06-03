const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.json());
app.use(express.static('public'));

// In-memory lista zakupów
let items = [
  { id: 1, name: 'Mleko', done: false },
  { id: 2, name: 'Chleb', done: false },
  { id: 3, name: 'Masło', done: false },
];
let nextId = 4;

// GET - pobierz listę
app.get('/api/items', (req, res) => {
  res.json(items);
});

// POST - dodaj produkt
app.post('/api/items', (req, res) => {
  const { name } = req.body;
  if (!name || !name.trim()) {
    return res.status(400).json({ error: 'Nazwa nie może być pusta' });
  }
  const item = { id: nextId++, name: name.trim(), done: false };
  items.push(item);
  res.status(201).json(item);
});

// PATCH - oznacz jako kupione/nie kupione
app.patch('/api/items/:id', (req, res) => {
  const item = items.find(i => i.id === parseInt(req.params.id));
  if (!item) return res.status(404).json({ error: 'Nie znaleziono' });
  item.done = !item.done;
  res.json(item);
});

// DELETE - usuń produkt
app.delete('/api/items/:id', (req, res) => {
  items = items.filter(i => i.id !== parseInt(req.params.id));
  res.status(204).send();
});

app.listen(PORT, () => {
  console.log(`Serwer działa na http://localhost:${PORT}`);
});