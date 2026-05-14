import { createContext, useState } from 'react';

export const CartContext = createContext();

export const CartProvider = ({ children }) => {
  const [cart, setCart] = useState([]);

  const addToCart = (product) => {
    setCart((prev) => [...prev, { ...product, cartId: Date.now() + Math.random() }]);
  };

  const removeFromCart = (cartId) => {
    setCart((prev) => prev.filter(item => item.cartId !== cartId));
  };

  const clearCart = () => setCart([]);
  const totalAmount = cart.reduce((acc, item) => acc + item.cena, 0);

  return (
    <CartContext.Provider value={{ cart, addToCart, removeFromCart, totalAmount, clearCart }}>
      {children}
    </CartContext.Provider>
  );
};