-- Создание базы данных
CREATE DATABASE IF NOT EXISTS user_profile_db 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE user_profile_db;

-- Таблица пользователей
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    reset_token VARCHAR(512),
    reset_token_expiry DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Таблица типов профилей (замена ENUM)
CREATE TABLE profile_types (
    id TINYINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

INSERT INTO profile_types (name) VALUES 
('business'), ('creative'), ('media');

-- Таблица жанров (замена ENUM)
CREATE TABLE genres (
    id TINYINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

INSERT INTO genres (name) VALUES 
('music'), ('art'), ('cosplay');

-- Таблица профилей
CREATE TABLE profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    profile_type_id TINYINT NOT NULL,
    avatar_url VARCHAR(512),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    middle_name VARCHAR(100),
    phone VARCHAR(20),
    -- Бизнес-поля
    company VARCHAR(255),
    niche VARCHAR(255),
    position VARCHAR(100),
    linkedin VARCHAR(512),
    services TEXT,
    address TEXT,
    slogan TEXT,
    -- Творческие поля
    nickname VARCHAR(100),
    genre_id TINYINT,
    tiktok VARCHAR(512),
    instagram VARCHAR(512),
    youtube VARCHAR(512),
    twitter VARCHAR(512),
    telegram VARCHAR(512),
    whatsapp VARCHAR(512),
    portfolio VARCHAR(512),
    events TEXT,
    donations VARCHAR(512),
    -- Медиа-поля
    blog VARCHAR(512),
    topics TEXT,
    free_resources VARCHAR(512),
    -- Системные поля
    public_url VARCHAR(512) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (profile_type_id) REFERENCES profile_types(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
) ENGINE=InnoDB;

-- Таблица восстановления паролей
CREATE TABLE password_resets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(512) NOT NULL,
    expires_at DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Индексы для оптимизации
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_profiles_public_url ON profiles(public_url);
CREATE INDEX idx_profiles_user_id ON profiles(user_id);
CREATE INDEX idx_password_resets_user_id ON password_resets(user_id);