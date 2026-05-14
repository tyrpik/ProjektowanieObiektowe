import { useState } from 'react';
import axios from 'axios';
import { useCart } from '../context/useCart';

export default function Platnosci() {
  const { totalAmount, clearCart } = useCart();
  const [status, setStatus] = useState('');

  const handlePayment = async (e) => {
    e.preventDefault();
    if (totalAmount === 0) return setStatus('Koszyk jest pusty!');
    
    setStatus('Przetwarzanie płatności...');

    try {
      const response = await axios.post('http://localhost:3001/api/platnosci', {
        kwota: totalAmount
      });
      
      setStatus(response.data.message);
      clearCart();
    } catch (error) {
      setStatus('Błąd płatności.' + error.message);
    }
  };

  return (
    <div style={{ border: '1px solid #ccc', padding: '1rem' }}>
      <h2 style={{ padding: '20px', backgroundColor: '#8a3368', margin: '20px' }}>Bramka Płatności</h2>
      <p>Kwota do zapłaty: <strong>{totalAmount} PLN</strong></p>
      
      <form onSubmit={handlePayment}>
        <button 
          type="submit" 
          disabled={totalAmount === 0}
          style={{ backgroundColor: totalAmount === 0 ? '#8a3368' : '#af4c91', color: 'white', padding: '10px', marginTop:'10px' }}
        >
          Zapłać teraz
        </button>
      </form>
      
      {status && <p><strong>Status:</strong> {status}</p>}
    </div>
  );
}