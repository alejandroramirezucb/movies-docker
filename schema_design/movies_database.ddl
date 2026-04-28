CREATE SCHEMA IF NOT EXISTS content;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE content.genre (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    modified TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT genre_name_unique UNIQUE (name)
);

CREATE TABLE content.person (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name VARCHAR(255) NOT NULL,
    created TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    modified TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE content.film_work (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    creation_date DATE,
    rating FLOAT CHECK (rating >= 0 AND rating <= 100),
    type VARCHAR(20) NOT NULL,
    created TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    modified TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE content.genre_film_work (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    film_work_id UUID NOT NULL,
    genre_id UUID NOT NULL,
    created TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES content.genre(id) ON DELETE CASCADE,
    CONSTRAINT genre_film_work_unique UNIQUE (film_work_id, genre_id)
);

CREATE TABLE content.person_film_work (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    film_work_id UUID NOT NULL,
    person_id UUID NOT NULL,
    role VARCHAR(50) NOT NULL,
    created TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES content.person(id) ON DELETE CASCADE,
    CONSTRAINT person_film_work_unique UNIQUE (film_work_id, person_id, role)
);

CREATE INDEX film_work_creation_date_idx ON content.film_work (creation_date);
CREATE INDEX film_work_rating_idx ON content.film_work (rating);
CREATE INDEX film_work_type_idx ON content.film_work (type);

CREATE INDEX genre_name_idx ON content.genre (name);

CREATE INDEX person_full_name_idx ON content.person (full_name);

CREATE INDEX genre_film_work_film_idx ON content.genre_film_work (film_work_id);
CREATE INDEX genre_film_work_genre_idx ON content.genre_film_work (genre_id);
CREATE INDEX person_film_work_film_idx ON content.person_film_work (film_work_id);
CREATE INDEX person_film_work_person_idx ON content.person_film_work (person_id);