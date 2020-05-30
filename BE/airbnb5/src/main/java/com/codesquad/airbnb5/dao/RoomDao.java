package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.dto.PriceDto;
import com.codesquad.airbnb5.dto.RoomDto;
import com.codesquad.airbnb5.exception.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.time.LocalDate;
import java.util.List;

@Repository
public class RoomDao {

    private JdbcTemplate jdbcTemplate;

    private RowMapper<Object> roomRowMapper = (rs, rowNum) -> {
        RoomDto roomDto = new RoomDto.Builder(rs.getInt("room_id"))
                .roomName(rs.getString("room_name"))
                .roomThumbnail(rs.getString("room_thumbnail"))
                .isSuperHost(rs.getBoolean("is_super_host"))
                .roomType(rs.getString("room_type"))
                .beds(rs.getInt("beds"))
                .scores(rs.getFloat("scores"))
                .reviews(rs.getFloat("reviews"))
                .build();
        return roomDto;
    };

    @Autowired
    public RoomDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Object findRooms(
            int cityId,
            int limit,
            int offset
    ) {

        String sql = "SELECT r.room_id, r.room_name, r.room_thumbnail, h.is_super_host, " +
                "r.room_type, r.beds, r.scores, r.reviews " +
                "FROM room r " +
                "JOIN host h " +
                "ON r.host_id = h.host_id " +
                "JOIN bookmark b " +
                "ON r.room_id = b.room_id " +
                "AND r.city_id = ? " +
                "LIMIT ? " +
                "OFFSET ? ";

        return jdbcTemplate.query(sql, new Object[]{cityId, limit, offset}, this.roomRowMapper);
    }

    public Object findRoomSummary(
            int cityId,
            int guests,
            int minPrice,
            int maxPrice,
            LocalDate checkIn,
            LocalDate checkOut
    ) {
        String sql = "SELECT r.room_id, r.room_name, r.room_thumbnail, h.is_super_host, " +
                "r.room_type, r.beds, r.scores, r.reviews " +
                "FROM room r " +
                "JOIN host h " +
                "ON r.host_id = h.host_id " +
                "AND r.city_id = ? " +
                "AND r.maximum_guests >= ? " +
                "AND r.sale_price BETWEEN ? AND ? " +
                "AND r.room_id NOT IN (" +
                "SELECT re.room_id " +
                "FROM reservation re " +
                "WHERE (check_in >= ? AND check_out <= ?) " +
                "OR (check_in <= ? AND check_out >= ?) " +
                "OR (check_in <= ? AND check_out > ?) " +
                "OR (check_out > ? AND check_in < ?))";

        return jdbcTemplate.query(sql, new Object[]{cityId, guests, minPrice, maxPrice, checkIn, checkOut, checkIn, checkOut, checkIn, checkIn, checkOut, checkOut}, this.roomRowMapper);
    }

    public PriceDto findPriceFilterData(int cityId, int guests, LocalDate checkIn, LocalDate checkOut) {

        String sql = "SELECT r.sale_price " +
                "FROM room r " +
                "WHERE r.city_id = ? " +
                "AND r.maximum_guests >= ? " +
                "AND r.room_id NOT IN (" +
                "SELECT re.room_id " +
                "FROM reservation re " +
                "WHERE (check_in >= ? AND check_out <= ?) " +
                "OR (check_in <= ? AND check_out >= ?) " +
                "OR (check_in <= ? AND check_out > ?) " +
                "OR (check_out > ? AND check_in < ?))" +
                "ORDER BY sale_price";

        RowMapper<Integer> rowMapper = (rs, rowNum) -> {
            int price = rs.getInt("sale_price");
            return rs.wasNull() ? 0 : price;
        };
        List<Integer> prices = this.jdbcTemplate.query(sql, new Object[]{cityId, guests, checkIn, checkOut, checkIn, checkOut, checkIn, checkIn, checkOut, checkOut}, rowMapper);

        int maxPrice = 1000000;
        int interval = 20000;
        int[] counts = new int[maxPrice / interval];

        for (int price : prices) {
            if (price >= maxPrice) {
                counts[(maxPrice / interval) - 1]++;
                continue;
            }
            counts[price / interval]++;
        }
        try {
            return new PriceDto(getAveragePrice(cityId, guests, checkIn, checkOut), prices, counts);
        } catch (EmptyResultDataAccessException e) {
            throw new NotFoundException("해당 필터 조건을 만족하는 숙소가 없습니다.");
        }
    }

    private float getAveragePrice(int cityId, int guests, LocalDate checkIn, LocalDate checkOut) {
        String sql = "SELECT COALESCE(AVG(sale_price), 0) AS average " +
                "FROM room r " +
                "WHERE r.city_id = ? " +
                "AND r.maximum_guests >= ? " +
                "AND r.room_id NOT IN (" +
                "SELECT re.room_id " +
                "FROM reservation re " +
                "WHERE (check_in >= ? AND check_out <= ?) " +
                "OR (check_in <= ? AND check_out >= ?) " +
                "OR (check_in <= ? AND check_out > ?) " +
                "OR (check_out > ? AND check_in < ?))";

        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{cityId, guests, checkIn, checkOut, checkIn, checkOut, checkIn, checkIn, checkOut, checkOut}, float.class);
        } catch (EmptyResultDataAccessException e) {
            throw new NotFoundException("해당 필터 조건을 만족하는 숙소가 없습니다.");
        }
    }
}
