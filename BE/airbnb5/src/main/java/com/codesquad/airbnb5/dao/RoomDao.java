package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.dto.PriceDto;
import com.codesquad.airbnb5.dto.RoomDetailDto;
import com.codesquad.airbnb5.dto.RoomDto;
import com.codesquad.airbnb5.exception.NotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@Slf4j
@Repository
public class RoomDao {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public RoomDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Object findRoomSummary(
            int cityId,
            int limit,
            int offset,
            int guests,
            int minPrice,
            int maxPrice,
            LocalDate checkIn,
            LocalDate checkOut,
            int guestId,
            RoomMapper roomMapper
    ) throws SQLException {

        RowMapper<RoomDto> rowMapper = roomMapper.mapRow(guestId);
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
                "OR (check_out > ? AND check_in < ?))" +
                "LIMIT ? " +
                "OFFSET ? ";

        return jdbcTemplate.query(sql, new Object[]{cityId, guests, minPrice, maxPrice, checkIn, checkOut, checkIn, checkOut, checkIn, checkIn, checkOut, checkOut, limit, offset}, rowMapper);
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

        RowMapper<Integer> priceRowMapper = (rs, rowNum) -> {
            int price = rs.getInt("sale_price");
            return rs.wasNull() ? 0 : price;
        };
        List<Integer> prices = this.jdbcTemplate.query(sql, new Object[]{cityId, guests, checkIn, checkOut, checkIn, checkOut, checkIn, checkIn, checkOut, checkOut}, priceRowMapper);

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

    public RoomDetailDto findRoomDetail(
            int cityId,
            int roomId,
            int guestId,
            RoomMapper roomMapper
    ) throws SQLException {

        RowMapper<RoomDetailDto> rowMapper = roomMapper.mapRowDetail(roomId);
        String sql = "SELECT r.room_id, r.room_name, r.address, r.room_thumbnail, h.is_super_host, h.host_name, " +
                "h.host_thumbnail, r.room_type, r.beds, r.original_price, r.sale_price, r.scores, r.reviews, r.amenities, " +
                "r.cleaning_fee, r.maximum_guests " +
                "FROM room r " +
                "JOIN host h " +
                "ON r.host_id = h.host_id " +
                "AND r.city_id = ? " +
                "AND r.room_id = ? ";

        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{cityId, roomId}, roomMapper.mapRowDetail(guestId));
        } catch (EmptyResultDataAccessException e) {
            throw new NotFoundException("존재하지 않는 숙소입니다.");
        }
    }
}
