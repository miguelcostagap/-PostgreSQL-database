/*
FACTS FOR A VIDEO STORE DATABASE;

A. The AREA being modelled is:
    a. Video store;

B. The THINGS_OF_INTEREST include:
    b1. Clients;
    b2. Movies;
    b3. Actors;
    b4. Attendants;
    b5. Loans;

C. THESE THINGS_OF_INTEREST are related as follows:
    c1. A client can rent many movies;
    c2. A movie can be rented by many clients;
    c3. There can be one or more copies of a movie;
    c4. A movie can have many actors in it;
    c5. Actors can perform in more than one movie;
    c6. A client can be associated with zero or many loans;
    c7. A loan must be associated with one and only one user;
    c8. A loan must be associated with one or more copies;
    c9. A movie has a specific genre and a specific tier;
    c10. A movie can have different pricing depending on the movie tier it is in;
    c11. A movie can modify its tier from ´Super -> Special -> Catalog´ depending on the time passed after its launch;
    c12. An attendant is responsible for each loan;


D. ENQUIRIES:
    d1. How much does "Sara Lopes" owe?
    d2. What are the names of the action movies with a rating higher than 8.5?
    d3. What is the street, city and zipcode of client "Joao Townsend"?
    d4. Update the phone number of Sara Lopes to "999867874".
    d5. How many movies/copies are out on loan?
    d6. Show the names and ratings of the 3 movies with the highest rating.
    d7. Find the total rating for each movie tier.
    d8. How much is it to rent "Ready Player One"?
    d9. Do you have any movies that "Scarlett Johansson" acts in?
    d10. Which attendants took care of the loans of the clients who owe more than 6.00 euros?
    d11. What is the average age of the clients who rented the "Ghost in the Shell" movie?
    d12. Is there a copy of "I, Robot" that is not out on loan?
    d13. Find the names of clients who have either rented a movie from the "Super" tier or have a debt value greater than 5.00.
    d14. A client lost a copy of "I, Robot", update your database accordingly.
    d15. "Joao Townsend" wants to know which movies with "Scarlett Johansson" he hasn't watched yet.
    d16. What movies does "Joao Oliveira" have at his house right now? When is their due date?
    d17. How much revenue has "Ghost in the Shell" generated from loans in the last 2 weeks?
*/

CREATE SEQUENCE clients_id_seq;
CREATE SEQUENCE movies_id_seq;
CREATE SEQUENCE dependents_id_seq;
CREATE SEQUENCE attendant_id_seq;
CREATE SEQUENCE loans_id_seq;
CREATE SEQUENCE actors_id_seq;
CREATE SEQUENCE copy_id_seq;

CREATE TABLE clients (
    id INTEGER DEFAULT nextval('clients_id_seq'),
    first_name CHAR(15),
    last_name CHAR(15),
    age INTEGER,
    phone CHAR(15),
    city CHAR(25),
    street CHAR(30),
    zip_code CHAR(10),
    value_in_debt DOUBLE PRECISION,
    PRIMARY KEY (id)
);

CREATE TYPE movie_genre AS ENUM ('Action', 'Comedy', 'Drama', 'Sci-Fi', 'Horror', 'Romance', 'Adventure', 'Animation', 'Thriller');
CREATE TYPE tier AS ENUM ('Super', 'Special', 'Catalog');

CREATE TABLE prices(
    movie_tier tier,
    price numeric(10, 2),
    PRIMARY KEY (movie_tier)
);

INSERT INTO prices (movie_tier, price) VALUES ('Super', 5.00), ('Special', 3.00),('Catalog', 1.00);

CREATE TABLE movies (
    id INTEGER DEFAULT nextval('movies_id_seq'),
    name CHAR(50),
    genre movie_genre,
    movie_tier tier,
    launch_day DATE,
    rating NUMERIC(4,2),
    PRIMARY KEY (id)
);

CREATE TABLE movies_per_client(
    client_id INTEGER,
    movie_id INTEGER,
    PRIMARY KEY(movie_id, client_id),
    FOREIGN KEY(client_id) REFERENCES clients(id),
    FOREIGN KEY(movie_id) REFERENCES movies(id)
);

CREATE TABLE actors (
    id INTEGER DEFAULT nextval('actors_id_seq'),
    first_name CHAR(15),
    last_name CHAR(15),
    PRIMARY KEY(id)
);

CREATE TABLE actors_per_movie(
    actors_id INTEGER,
    movies_id INTEGER,
    PRIMARY KEY (actors_id, movies_id),
    FOREIGN KEY (actors_id) REFERENCES actors(id) ON DELETE CASCADE,
    FOREIGN KEY (movies_id) REFERENCES movies(id) ON DELETE CASCADE
);

CREATE TABLE attendant(
    id INTEGER DEFAULT nextval('attendant_id_seq'),
    name VARCHAR(50),
    PRIMARY KEY (id)
);

CREATE TABLE loans(
    id INTEGER DEFAULT nextval('loans_id_seq'),
    client_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    attendant_id INTEGER NOT NULL,
    value DOUBLE PRECISION,
    PRIMARY KEY(id),
    FOREIGN KEY(client_id) REFERENCES clients(id),
    FOREIGN KEY(attendant_id) REFERENCES attendant(id)
);

CREATE TABLE copies(
    id INTEGER DEFAULT nextval('copy_id_seq'),
    movies_id INTEGER NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (movies_id) REFERENCES movies(id) ON DELETE CASCADE
);

CREATE TABLE copies_on_loan(
    loans_id INTEGER,
    copies_id INTEGER,
    PRIMARY KEY(loans_id, copies_id),
    FOREIGN KEY(loans_id) REFERENCES loans(id) ON DELETE CASCADE,
    FOREIGN KEY(copies_id) REFERENCES copies(id) ON DELETE CASCADE
);
