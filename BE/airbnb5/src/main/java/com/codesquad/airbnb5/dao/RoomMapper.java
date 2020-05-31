package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.dto.RoomDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;

@Slf4j
@Repository
public class RoomMapper {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public RoomMapper(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public RowMapper<RoomDto> mapRow(int guestId) throws SQLException {
        return new RowMapper<RoomDto>() {
            @Override
            public RoomDto mapRow(ResultSet rs, int rowNum) throws SQLException {
                int roomId = rs.getInt("room_id");
                boolean bool = findFavoriteByGuestIdAndRoomId(guestId, roomId);
                log.info("bool : {}", bool);

                return new RoomDto.Builder(roomId)
                        .roomName(rs.getString("room_name"))
                        .roomThumbnail(rs.getString("room_thumbnail"))
                        .isSuperHost(rs.getBoolean("is_super_host"))
                        .roomType(rs.getString("room_type"))
                        .beds(rs.getInt("beds"))
                        .scores(rs.getFloat("scores"))
                        .reviews(rs.getFloat("reviews"))
                        .isFavorite(bool)
                        .build();
            }
        };
    }

    private Boolean findFavoriteByGuestIdAndRoomId(int guestId, int roomId) {

        String sql = "SELECT exists ( SELECT room_id " +
                "FROM bookmark b " +
                "WHERE b.guest_id = ? " +
                "AND b.room_id = ? )";
        return jdbcTemplate.queryForObject(sql, new Object[]{guestId, roomId}, Boolean.class);
    }
}
