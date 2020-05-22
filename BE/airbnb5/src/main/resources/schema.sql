DROP TABLE IF EXISTS city, user, guest, reservation, bookmark, room;

CREATE TABLE city (
    city_id int auto_increment primary key,
    city_name varchar (64)
);

CREATE TABLE room (
    room_id int PRIMARY KEY,
    room_name varchar(255) NOT NULL,
    room_thumbnail varchar (255) NOT NULL,
    address varchar (64),
    city_name varchar (64) REFERENCES city(city_name) ON UPDATE CASCADE,
    city_id int REFERENCES city(city_id) ON UPDATE CASCADE,
    latitude float,
    room_type varchar (64),
    beds int,
    amenities varchar (255),
    original_price int,
    sale_price int,
    tax int,
    cleaning_fee int DEFAULT 0,
    maximum_guests int NOT NULL,
    reviews int DEFAULT 0,
    scores float DEFAULT 0
);

CREATE TABLE guest (
    guest_id int auto_increment primary key,
    guest_name varchar (64)
);

CREATE TABLE user (
    user_id int auto_increment primary key,
    user_name varchar (64),
    user_email varchar (64)
);

CREATE TABLE bookmark (
    room_id int REFERENCES room(room_id) ON UPDATE CASCADE,
    guest_id int REFERENCES guest(guest_id) ON UPDATE CASCADE,
    favorite_status boolean DEFAULT FALSE,
    PRIMARY KEY (room_id, guest_id)
);

CREATE TABLE reservation (
    reservation_id int auto_increment primary key,
    room_id int REFERENCES room(room_id) ON UPDATE CASCADE,
    room_name varchar (255) REFERENCES room(room_name) ON UPDATE CASCADE,
    guest_id int REFERENCES guest(guest_id) ON UPDATE CASCADE,
    check_in date,
    check_out date,
    nights int,
    reservation_status boolean
);
