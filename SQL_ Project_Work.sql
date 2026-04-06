

-- ==========================================
-- DROP DATABASE IF EXISTS to start fresh
-- ==========================================
DROP DATABASE IF EXISTS review_platform;
CREATE DATABASE review_platform;
USE review_platform;

-- ==========================================
-- 1️⃣ Categories Tables
-- ==========================================
CREATE TABLE Categories (
    category_id INT NOT NULL,
    category_name VARCHAR(100),
    PRIMARY KEY (category_id)
) ENGINE=InnoDB;

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Appliances');
CREATE TABLE Products (
    product_id INT NOT NULL,
    product_name VARCHAR(100),
    category_id INT NOT NULL,
    price DECIMAL(10,2),
    PRIMARY KEY (product_id),
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
) ENGINE=InnoDB;
-- Insert sample products
INSERT INTO Products (product_id, product_name, category_id, price) VALUES
(1, 'Smartphone', 1, 699.99),
(2, 'Laptop', 1, 1299.99),
(3, 'Blender', 3, 89.99);
# - ==========================================
-- 3️⃣ Users Table
# -- ==========================================
CREATE TABLE Users (
    user_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
) ENGINE=InnoDB;

