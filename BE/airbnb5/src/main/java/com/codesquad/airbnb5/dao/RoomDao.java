package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.dto.RoomDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class RoomDao {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public RoomDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Object findRoomSummary(
            int cityId,
            int guests,
            int minPrice,
            int maxPrice
    ) {
        String sql = "SELECT r.room_id, r.room_name, r.room_thumbnail, h.is_super_host, " +
                "r.room_type, r.beds, r.scores, r.reviews " +
                "FROM room r " +
                "JOIN city c " +
                "ON c.city_id = r.city_id " +
                "JOIN host h " +
                "ON r.host_id = h.host_id " +
                "WHERE c.city_id = ? " +
                "AND r.maximum_guests >= ? " +
                "AND r.sale_price BETWEEN ? AND ?";

        RowMapper<Object> roomSummaryRowMapper = (rs, rowNum) -> {
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
        return jdbcTemplate.query(sql, new Object[]{cityId, guests, minPrice, maxPrice}, roomSummaryRowMapper);
    }
}
