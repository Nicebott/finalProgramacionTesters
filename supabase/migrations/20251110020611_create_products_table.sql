/*
  # Create products table

  1. New Tables
    - `products`
      - `id` (uuid, primary key)
      - `name` (text, product name)
      - `description` (text, product description)
      - `price_dop` (numeric, price in Dominican pesos)
      - `image` (text, image URL)
      - `category` (text, product category)
      - `rating` (integer, product rating 0-5)
      - `created_at` (timestamptz, creation timestamp)
      - `updated_at` (timestamptz, last update timestamp)
  
  2. Security
    - Enable RLS on `products` table
    - Add policy for public read access (anyone can view products)
    - Add policy for authenticated users to insert products
    - Add policy for authenticated users to update products
    - Add policy for authenticated users to delete products
*/

CREATE TABLE IF NOT EXISTS products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text NOT NULL,
  price_dop numeric(10, 2) NOT NULL,
  image text NOT NULL,
  category text NOT NULL,
  rating integer NOT NULL DEFAULT 5 CHECK (rating >= 0 AND rating <= 5),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view products"
  ON products
  FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert products"
  ON products
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update products"
  ON products
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete products"
  ON products
  FOR DELETE
  TO authenticated
  USING (true);

-- Insert initial products
INSERT INTO products (name, description, price_dop, image, category, rating) VALUES
  ('Artesanía de Cerámica Taína', 'Hermosa pieza de cerámica inspirada en la cultura taína dominicana, hecha a mano por artesanos locales.', 2500.00, 'https://images.pexels.com/photos/1445416/pexels-photo-1445416.jpeg', 'Artesanía', 5),
  ('Café Orgánico Dominicano', 'Café premium de altura cultivado en las montañas de Jarabacoa, con notas de chocolate y caramelo.', 1350.00, 'https://images.pexels.com/photos/894695/pexels-photo-894695.jpeg', 'Alimentos', 5),
  ('Cacao Premium', 'Cacao orgánico de primera calidad, ideal para chocolatería fina y repostería gourmet.', 1025.00, 'https://images.pexels.com/photos/918327/pexels-photo-918327.jpeg', 'Alimentos', 4),
  ('Ámbar Dominicano', 'Collar artesanal con ámbar auténtico de las minas dominicanas, pieza única y elegante.', 6500.00, 'https://images.pexels.com/photos/1191531/pexels-photo-1191531.jpeg', 'Joyería', 5),
  ('Ron Premium Añejo', 'Ron dominicano añejado por 12 años en barriles de roble, sabor suave y complejo.', 3500.00, 'https://images.pexels.com/photos/602750/pexels-photo-602750.jpeg', 'Bebidas', 5),
  ('Cigarro Artesanal Premium', 'Cigarro hecho a mano con tabaco cultivado localmente, reconocido internacionalmente.', 4600.00, 'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg', 'Tabaco', 5),
  ('Miel de Abeja Natural', 'Miel pura y orgánica producida por apicultores locales, sin procesar ni aditivos.', 860.00, 'https://images.pexels.com/photos/1638280/pexels-photo-1638280.jpeg', 'Alimentos', 4),
  ('Bolso de Cuero Artesanal', 'Bolso de cuero genuino hecho a mano con diseños tradicionales dominicanos.', 4850.00, 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg', 'Accesorios', 5),
  ('Pintura al Óleo Original', 'Obra de arte original que captura la belleza del paisaje caribeño dominicano.', 13500.00, 'https://images.pexels.com/photos/1762851/pexels-photo-1762851.jpeg', 'Arte', 5);
