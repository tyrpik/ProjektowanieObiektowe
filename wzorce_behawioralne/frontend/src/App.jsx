import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import { CartProvider } from './context/CartProvider';
import Produkty from './components/Produkty';
import Koszyk from './components/Koszyk';
import Platnosci from './components/Platnosci';

function App() {
  return (
    <CartProvider>
      <Router>
        <nav style={{ padding: '20px', backgroundColor: '#8a3368', marginBottom: '20px' }}>
          <Link to="/" style={{ marginRight: '15px' }}>Sklep</Link>
          <Link to="/koszyk" style={{ marginRight: '15px' }}>Koszyk</Link>
          <Link to="/platnosci">Płatność</Link>
        </nav>

        <div style={{ padding: '0 20px' }}>
          <Routes>
            <Route path="/" element={<Produkty />} />
            <Route path="/koszyk" element={<Koszyk />} />
            <Route path="/platnosci" element={<Platnosci />} />
          </Routes>
        </div>
      </Router>
    </CartProvider>
  );
}

export default App;