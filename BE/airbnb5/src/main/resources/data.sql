INSERT INTO city
    (city_id, city_name)
VALUES (1, 'Asheville'),
       (2, 'Austin'),
       (3, 'Boston'),
       (4, 'Cambridge'),
       (5, 'Chicago'),
       (6, 'New Orleans'),
       (7, 'New York'),
       (8, 'Oakland'),
       (9, 'Portland'),
       (10, 'San Francisco'),
       (11, 'Santa Cruz'),
       (12, 'Seattle');

INSERT INTO user
    (user_id, user_name, user_email)
VALUES (1, 'poogle', 'poogle@gmail.com');

INSERT INTO reservation
(reservation_id, room_id, room_name, guest_id, check_in, check_out, nights, reservation_status)
VALUES (1, 1, 'Charming Victorian home - twin beds + breakfast', 1, '2020-05-08', '2020-05-11', 2, TRUE),
       (2, 2, 'French Chic Loft', 1, '2020-05-09', '2020-05-13', 4, TRUE),
       (3, 3, 'Walk to stores/parks/downtown. Fenced yard/Pets OK', 1, '2020-05-12', '2020-05-14', 17, TRUE),
       (4, 4, 'Cottage! BonPaul + Sharky''s Hostel', 1, '2020-05-14', '2020-05-16', 17, TRUE),
       (5, 5, 'Mixed Dorm \"Top Bunk #1\" at BPS Hostel', 1, '2020-05-15', '2020-05-19', 1, TRUE),
       (6, 6, 'Historic Grove Park', 1, '2020-05-10', '2020-05-17', 4, TRUE);

insert into bookmark (guest_id, room_id)
VALUES (1, 1),
       (1, 2),
       (1, 5),
       (1, 240),
       (1, 878),
       (2, 20),
       (2, 23);
