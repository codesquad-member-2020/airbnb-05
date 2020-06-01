package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.domain.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.time.LocalDate;

@Repository
public class ReservationDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private RoomRepository roomRepository;

    public ReservationDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate();
    }

    public void addReservation(int roomId, int guestId, LocalDate checkIn, LocalDate checkOut, int guests) {

        String sql = "INSERT INTO reservation (guest_id, room_id, room_name, room_type, original_price, sale_price, " +
                "scores, reviews, check_in, check_out, nights, guests, cleaning_fee, tax, total_fee) " +
                "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, DATEDIFF(check_out, check_in), ?, ?, ?, (sale_price * DATEDIFF(check_out, check_in) + cleaning_fee + tax))";
        jdbcTemplate.update(sql, guestId, roomId, roomRepository.findRoomNameByRoomId(roomId),
                roomRepository.findRoomTypeByRoomId(roomId),
                roomRepository.findOriginalPriceByRoomId(roomId),
                roomRepository.findSalePriceByRoomId(roomId),
                roomRepository.findScoresByRoomId(roomId),
                roomRepository.findReviewsByRoomId(roomId),
                checkIn, checkOut, guests,
                roomRepository.findCleaningFeeByRoomId(roomId),
                roomRepository.findTaxByRoomId(roomId));
    }
}
