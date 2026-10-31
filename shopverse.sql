CREATE DATABASE IF NOT EXISTS shopverse CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shopverse;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('customer','admin') NOT NULL DEFAULT 'customer',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE products (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  category VARCHAR(80) NOT NULL,
  description TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL DEFAULT 0,
  stock INT UNSIGNED NOT NULL DEFAULT 0,
  image_url VARCHAR(1000) NULL,
  badge VARCHAR(30) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_products_category (category),
  INDEX idx_products_active (is_active)
) ENGINE=InnoDB;

CREATE TABLE orders (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  full_name VARCHAR(120) NOT NULL,
  phone VARCHAR(30) NOT NULL,
  address VARCHAR(500) NOT NULL,
  city VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20) NOT NULL,
  payment_method ENUM('cod') NOT NULL DEFAULT 'cod',
  total DECIMAL(10,2) NOT NULL,
  status ENUM('Placed','Processing','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Placed',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
  INDEX idx_orders_user_date (user_id, created_at)
) ENGINE=InnoDB;

CREATE TABLE order_items (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  order_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NULL,
  product_name VARCHAR(160) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  quantity INT UNSIGNED NOT NULL,
  CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO products (name, category, description, price, stock, image_url, badge) VALUES
('Studio Wireless Headphones','Electronics','Comfort-first wireless headphones with a clean look, punchy sound, and all-day listening comfort. A versatile everyday pick for work, travel, and downtime.','2499.00',18,'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=85','BESTSELLER'),
('Everyday Canvas Tote','Lifestyle','A lightweight everyday carry bag for books, groceries, and spontaneous plans. Minimal styling that works with almost everything.','699.00',35,'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=900&q=85','EASY PICK'),
('Minimal Desk Lamp','Home & Living','A modern desk lamp for focused work sessions and cosy evenings. Designed to look great on a desk, bedside table, or reading nook.','1299.00',12,'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&w=900&q=85','NEW'),
('Ceramic Coffee Cup','Home & Living','A simple ceramic cup for slow mornings and late-night ideas. A thoughtful addition to your daily coffee or tea ritual.','449.00',50,'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?auto=format&fit=crop&w=900&q=85',NULL),
('Classic Analog Watch','Accessories','A timeless everyday watch with a refined silhouette. Easy to dress up or down, from a regular workday to a weekend outing.','1899.00',14,'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=900&q=85','POPULAR'),
('Daily Carry Backpack','Lifestyle','A practical backpack with room for your daily essentials. Great for campus, commuting, short trips, and getting things done on the go.','1599.00',20,'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=85',NULL),
('Soft Knit Throw','Home & Living','A cosy textured throw for movie nights, reading corners, and quiet afternoons. Soft styling makes it an easy home refresh.','999.00',16,'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=900&q=85',NULL),
('Everyday Sunglasses','Accessories','A versatile frame for sunny commutes and weekend plans. A simple accessory that adds a little extra personality to your look.','799.00',27,'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=900&q=85','TRENDING');
