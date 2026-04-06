

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

