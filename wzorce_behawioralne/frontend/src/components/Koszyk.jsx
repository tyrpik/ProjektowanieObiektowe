import { useCart } from '../context/useCart';

export default function Koszyk() {
  const { cart, removeFromCart, totalAmount } = useCart();

  return (
    <div>
      <h2 style={{ padding: '20px', backgroundColor: '#8a3368', marginBottom: '20px' }} >Twój Koszyk</h2>
      {cart.length === 0 ? <p>Koszyk jest pusty</p> : (
        <>
          <ul>
            {cart.map((item) => (
              <li key={item.cartId}>
                {item.nazwa} - {item.cena} PLN 
                <button onClick={() => removeFromCart(item.cartId)} style={{ margin: '10px' }}>Usuń</button>
              </li>
            ))}
          </ul>
          <h3>Suma: {totalAmount} PLN</h3>
        </>
      )}
    </div>
  );
}