DROP TABLE IF EXISTS city, user, guest, reservation, bookmark, room;

CREATE TABLE city
(
    city_id   int auto_increment primary key,
    city_name varchar(64)
);

CREATE TABLE room
(
    room_id        int PRIMARY KEY,
    room_name      varchar(255) NOT NULL,
    host_id        int REFERENCES host (host_id) ON UPDATE CASCADE,
    city_name      varchar(64) REFERENCES city (city_name) ON UPDATE CASCADE,
    city_id        int REFERENCES city (city_id) ON UPDATE CASCADE,
    room_thumbnail varchar(255) NOT NULL,
    address        varchar(64),
    latitude       float,
    longitude      float,
    room_type      varchar(64),
    beds           int,
    amenities      varchar(255),
    original_price int,
    sale_price     int,
    tax            int,
    cleaning_fee   int   DEFAULT 0,
    maximum_guests int   DEFAULT 1,
    reviews        int   DEFAULT 0,
    scores         float DEFAULT 0
);

INSERT room (room_id, room_name, host_id, city_name, city_id, room_thumbnail, address, latitude, longitude, room_type,
             beds, amenities, original_price, sale_price, tax, cleaning_fee, maximum_guests, reviews, scores)
SELECT p.room_id,
       p.room_name,
       p.host_id,
       p.city_name,
       p.city_id,
       p.room_thumbnail,
       p.address,
       p.latitude,
       p.longitude,
       p.room_type,
       p.beds,
       p.amenities,
       p.original_price,
       p.sale_price,
       p.tax,
       p.cleaning_fee,
       p.maximum_guests,
       p.reviews,
       p.scores
FROM property p;


CREATE TABLE guest
(
    guest_id   int auto_increment primary key,
    guest_name varchar(64)
);

CREATE TABLE user
(
    user_index int auto_increment primary key,
    github_id varchar(64) UNIQUE,
    github_name varchar(64),
    github_email varchar(64)
);

CREATE TABLE bookmark
(
    room_id  int REFERENCES room (room_id) ON UPDATE CASCADE,
    guest_id int REFERENCES guest (guest_id) ON UPDATE CASCADE,
    PRIMARY KEY (room_id, guest_id)
);

CREATE TABLE reservation
(
    reservation_id int auto_increment primary key,
    guest_id       int REFERENCES guest (guest_id) ON UPDATE CASCADE,
    room_id        int REFERENCES room (room_id) ON UPDATE CASCADE,
    room_name      varchar(255),
    room_type      varchar(255),
    original_price int,
    sale_price     int,
    scores         float,
    reviews        int,
    check_in       date,
    check_out      date,
    nights         int,
    guests         int,
    cleaning_fee   int,
    tax            int,
    total_fee      int
);
