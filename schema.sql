/* Juan */
CREATE TABLE labels (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    titile VARCHAR NOT NULL,
    color VARCHAR NOT NULL
);

CREATE TABLE books (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    publish_date DATE NOT NULL,
    archived BOOLEAN NOT NULL,
    publisher VARCHAR NOT NULL,
    label_id INT,
    genre_id INT,
    author_id INT,
    source_id INT,
    CONSTRAINT fk_book_label
      FOREIGN KEY(label_id) 
	  REFERENCES labels(id)
	  ON DELETE SET NULL,
    CONSTRAINT fk_book_genre
      FOREIGN KEY(genre_id) 
	  REFERENCES genres(id)
	  ON DELETE SET NULL,
    CONSTRAINT fk_book_author
      FOREIGN KEY(author_id) 
	  REFERENCES authors(id)
	  ON DELETE SET NULL,
    CONSTRAINT fk_book_source
      FOREIGN KEY(source_id) 
	  REFERENCES sources(id)
	  ON DELETE SET NULL
);

CREATE INDEX IDX_book_label ON books(label_id);
CREATE INDEX IDX_book_genre ON books(genre_id);
CREATE INDEX IDX_book_author ON books(author_id);
CREATE INDEX IDX_book_source ON books(source_id);

/* Saadat */

/* Chris */
CREATE TABLE games (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  multiplayer BOOLEAN NOT NULL,
  last_played DATE NOT NULL,
  author_id INT,
  genre_id INT,
  label_id INT,
  source_id INT,
  CONSTRAINT fk_game_label
    FOREIGN KEY(label_id) 
  REFERENCES labels(id)
  ON DELETE SET NULL,
  CONSTRAINT fk_game_genre
    FOREIGN KEY(genre_id) 
  REFERENCES genres(id)
  ON DELETE SET NULL,
  CONSTRAINT fk_game_author
    FOREIGN KEY(author_id) 
  REFERENCES authors(id)
  ON DELETE SET NULL,
  CONSTRAINT fk_game_source
    FOREIGN KEY(source_id) 
  REFERENCES sources(id)
  ON DELETE SET NULL
);

CREATE TABLE authors (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL
);

CREATE INDEX game_label ON game(label_id);
CREATE INDEX game_genre ON game(genre_id);
CREATE INDEX game_author ON game(author_id);
CREATE INDEX game_source ON game(source_id);

/* Alejandro */
