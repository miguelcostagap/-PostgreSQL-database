-- Dummy data for clients table
INSERT INTO clients (first_name, last_name, age, phone, city, street, zip_code, value_in_debt)
VALUES
    ('Joao', 'Oliveira', 30, '123-456-7890', 'Lisboa', 'Rua Augusta', '1000-001', 0),
    ('Sara', 'Lopes', 25, '987-654-3210', 'Paços de Ferreira', 'Rua da Paz', '4590-006', 10.50),
    ('Joao', 'Townsend', 40, '555-123-4567', 'Lisboa', 'Avenida da Liberdade', '1000-002', 5.75);

-- Dummy data for movies table
INSERT INTO movies (name, genre, movie_tier, launch_day, rating)
VALUES
    ('Ghost in the Shell', 'Action', 'Super', '2017-05-04', 8.1),
    ('Ready Player One', 'Adventure', 'Super', '2018-06-11', 7.9),
    ('Her', 'Romance', 'Special', '2013-06-25', 7.8),
    ('I, Robot', 'Action', 'Catalog', '2004-07-18', 9.0);

-- Dummy data for actors table
INSERT INTO actors (first_name, last_name)
VALUES
    ('Juliette', 'Binoche'),
    ('Rila', 'Fukushima'),
    ('Will', 'Smith'),
    ('Scarlett', 'Johansson'),
    ('Tye', 'Sheridan');

-- Dummy data for movies_per_client table
INSERT INTO movies_per_client (client_id, movie_id)
VALUES
    (1, 1),
    (1, 3),
    (2, 4),
    (3, 2),
    (3, 3),
    (3, 4),
    (2, 2),
    (2, 3);

-- Dummy data for actors_per_movie table
INSERT INTO actors_per_movie (actors_id, movies_id)
VALUES
    (1, 1),
    (2, 1),
    (2, 3),
    (3, 4),
    (4, 1),
    (4, 3),
    (5, 2);

-- Dummy data for attendant table
INSERT INTO attendant (name)
VALUES
    ('Gustavo Carvalho'),
    ('Andreia Pascoa');

-- Dummy data for loans table
INSERT INTO loans (client_id, start_date, due_date, return_date, attendant_id, value)
VALUES
    (1, '2023-07-19', '2023-07-26', NULL, 1, 5.00),
    (2, '2023-07-15', '2023-07-22', NULL, 1, 3.00),
    (3, '2023-07-10', '2023-07-17', NULL, 2, 2.50);

-- Dummy data for copies table
INSERT INTO copies (movies_id)
VALUES
    (1),
    (2),
    (3),
    (4),
    (4),
    (4);

-- Dummy data for copies_on_loan table
INSERT INTO copies_on_loan (loans_id, copies_id)
VALUES
    (1, 1),
    (2, 2),
    (2, 3),
    (3, 5);
