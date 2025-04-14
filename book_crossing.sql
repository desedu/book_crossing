CREATE DATABASE book_crossing;

CREATE TABLE book_category (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE genres (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE readers (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    registration_date DATETIME,
    rating DECIMAL(5,2)
);

CREATE TABLE books (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    id_category INT,
    isbn VARCHAR(20),
    publication_year INT,
    description TEXT,
    FOREIGN KEY (id_category) REFERENCES book_category(id)
);

CREATE TABLE book_deposit (
    id INT PRIMARY KEY,
    reader_id INT NOT NULL,
    deposit_date DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (reader_id) REFERENCES readers(id)
);

CREATE TABLE book_deposit_item (
    id INT PRIMARY KEY,
    deposit_id INT NOT NULL,
    book_id INT NOT NULL,
    deposit_condition VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (deposit_id) REFERENCES book_deposit(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

CREATE TABLE book_take (
    id INT PRIMARY KEY,
    reader_id INT NOT NULL,
    deposit_item_id INT NOT NULL,
    take_date DATETIME,
    return_date DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (reader_id) REFERENCES readers(id),
    FOREIGN KEY (deposit_item_id) REFERENCES book_deposit_item(id)
);

CREATE TABLE book_review (
    id INT PRIMARY KEY,
    book_id INT NOT NULL,
    reader_id INT NOT NULL,
    rating INT NOT NULL,
    review_text TEXT,
    review_date DATETIME,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (reader_id) REFERENCES readers(id)
);

CREATE TABLE book_genre (
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

INSERT INTO book_category (id, name, description) VALUES
(1, 'Роман', 'Художественная литература, которая описывает вымышленных персонажей и события'),
(2, 'Фантастика', 'Литература, которая описывает фантастические события и миры'),
(3, 'Детективы', 'Литаратура, описывающий процесс исследования загадочного происшествия');

INSERT INTO genres (id, name) VALUES
(1, 'Фантастика'),
(2, 'Роман'),
(3, 'Детектив');

INSERT INTO books (id, title, author, id_category, isbn, publication_year, description) VALUES
(1, 'Идиот', 'Фёдор Достоевский', 2, '978-5-17-080604-4', 1869, 'Роман писателя впервые опубликованный в номерах журнала «Русский вестник»'),
(2, 'Евгений Онегин', 'Александр Пушкин', 2, '978-5-17-080601-3', 1833, 'Роман в стихах русского поэта Александра Сергеевича Пушкина'),
(3, 'Мёртвые души', 'Николай Гоголь', 2, '978-5-17-080600-6', 1842, 'Произведение Николая Васильевича Гоголя, жанр которого сам автор обозначил как «поэма».'),
(4, 'Доктор Живаго', 'Борис Пастернак', 2, '978-5-17-080599-3', 1957, 'Роман о любви на фоне революционных событий');

INSERT INTO book_genre (book_id, genre_id) VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 1);