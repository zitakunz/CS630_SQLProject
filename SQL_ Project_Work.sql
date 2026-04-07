

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

INSERT INTO Users (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com'),
('David', 'david@example.com');
CREATE TABLE Reviews (
    review_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (review_id),
    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),
    CONSTRAINT fk_review_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
) ENGINE=InnoDB;
# - Insert sample reviews
INSERT INTO Reviews (user_id, product_id, review_text) VALUES
(1, 1, 'Amazing phone with great battery life.'),
(2, 1, 'Good value for the price.'),
(3, 2, 'Laptop is fast but a bit heavy.'),
(4, 3, 'Blender works perfectly for smoothies.');
#- ==========================================
#-- 5️⃣ Ratings Table
#-- ==========================================
CREATE TABLE Ratings (
    rating_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    rating_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (rating_id),
    CONSTRAINT fk_rating_user
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),
    CONSTRAINT fk_rating_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id),
    CONSTRAINT uq_user_product UNIQUE(user_id, product_id) -- prevent duplicate ratings
) ENGINE=InnoDB;
# -- Insert sample ratings
INSERT INTO Ratings (user_id, product_id, rating) VALUES
(1, 1, 5),
(2, 1, 4),
(3, 2, 4),
(4, 3, 5);
-- Average rating per product
SELECT p.product_name, AVG(r.rating) AS avg_rating
FROM Products p
JOIN Ratings r ON p.product_id = r.product_id
GROUP BY p.product_name;
-- Reviews with ratings per user/product
SELECT p.product_name, u.name AS user_name, rv.review_text, ra.rating
FROM Reviews rv
JOIN Users u ON rv.user_id = u.user_id
JOIN Products p ON rv.product_id = p.product_id
LEFT JOIN Ratings ra 
    ON rv.user_id = ra.user_id AND rv.product_id = ra.product_id;

-- Count of reviews per product
SELECT p.product_name, COUNT(rv.review_id) AS review_count
FROM Products p
LEFT JOIN Reviews rv ON p.product_id = rv.product_id
GROUP BY p.product_name;
-- Top-rated products (average rating)
SELECT p.product_name, AVG(r.rating) AS avg_rating
FROM Products p
JOIN Ratings r ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY avg_rating DESC
LIMIT 5;



