import { useState, useEffect } from 'react';
import axios from 'axios';
import { useCart } from '../context/useCart';;

export default function Produkty() {
  const [produkty, setProdukty] = useState([]);
  const { addToCart } = useCart();

  useEffect(() => {
    axios.get('http://localhost:3001/api/produkty')
      .then(res => setProdukty(res.data))
      .catch(err => console.error(err));
  }, []);

  return (
    <div style={{ border: '1px solid #ccc', padding: '1rem', margin: '1rem 0' }}>
      <h2 style={{ padding: '20px', backgroundColor: '#8a3368', marginBottom: '20px' }}>Lista Produktów</h2>
      {produkty.length === 0 ? (
        <p>Brak produktów do wyświetlenia.</p>
      ) : (
        <ul>
          {produkty.map((produkt) => (
            <div key={produkt.id}>
              <h3>{produkt.nazwa}</h3>
              <p>{produkt.cena} PLN</p>
              <button onClick={() => addToCart(produkt)}>Dodaj do koszyka</button> 
            </div>
          ))}
        </ul>
      )}
    </div>
  );
}