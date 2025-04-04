DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS author;

CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    birthdate DATE,
    gender VARCHAR(10),
    country VARCHAR(50)
);

CREATE TABLE book (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    publisher VARCHAR(100),
    author_id INTEGER NOT NULL,
    rating INTEGER,
    CONSTRAINT fk_author FOREIGN KEY (author_id)
        REFERENCES author(id)
        ON DELETE RESTRICT
);

INSERT INTO author (firstname, lastname, birthdate, gender, country) VALUES
('Leo', 'Tolstoy', '1828-09-09', 'Male', 'Russia'),
('Fyodor', 'Dostoevsky', '1821-11-11', 'Male', 'Russia'),
('Anton', 'Chekhov', '1860-07-29', 'Male', 'Russia');

INSERT INTO book (name, publisher, author_id, rating) VALUES
('War and Peace', 'The Russian Messenger', 1, 10),
('Anna Karenina', 'The Russian Messenger', 1, 9),
('Crime and Punishment', 'The Russian Messenger', 2, 10),
('The Seagull', 'Modern Library', 3, 8);

