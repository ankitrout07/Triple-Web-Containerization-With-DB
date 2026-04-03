-- Database Initialization for Triple-Web-DB
CREATE DATABASE IF NOT EXISTS app_db;
USE app_db;

-- Table for tracking site logins/audit logs
CREATE TABLE IF NOT EXISTS site_logins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
