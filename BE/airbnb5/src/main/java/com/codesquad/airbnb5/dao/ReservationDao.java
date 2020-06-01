package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.domain.RoomRepository;
import com.codesquad.airbnb5.dto.ReservationDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
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

    public void deleteReservation(int reservationId) {
        String sql = "DELETE FROM reservation " +
                "WHERE reservation_id = ? ";
        jdbcTemplate.update(sql, reservationId);
    }

    public Object findReservationList(int guestId) {
        String sql = "SELECT reservation_id, guest_id, room_id, room_name, room_type, original_price, sale_price, " +
                "scores, reviews, check_in, check_out, nights, guests, cleaning_fee, tax, total_fee " +
                "FROM reservation r " +
                "WHERE guest_id = ? ";

        RowMapper<Object> reservationRowMapper = (rs, rowNum) -> {
            return ReservationDto.builder()
                    .reservationId(rs.getInt("reservation_id"))
                    .roomId(rs.getInt("room_id"))
                    .roomName(rs.getString("room_name"))
                    .roomType(rs.getString("room_type"))
                    .originalPrice(rs.getInt("original_price"))
                    .salePrice(rs.getInt("sale_price"))
                    .scores(rs.getFloat("scores"))
                    .reviews(rs.getInt("reviews"))
                    .checkIn(rs.getDate("check_in").toLocalDate())
                    .checkOut(rs.getDate("check_out").toLocalDate())
                    .nights(rs.getInt("nights"))
                    .guests(rs.getInt("guests"))
                    .cleaningFee(rs.getInt("cleaning_fee"))
                    .tax(rs.getInt("tax"))
                    .totalFee(rs.getInt("total_fee"))
                    .build();
        };

        return jdbcTemplate.query(sql, new Object[]{guestId}, reservationRowMapper);
    }
}
