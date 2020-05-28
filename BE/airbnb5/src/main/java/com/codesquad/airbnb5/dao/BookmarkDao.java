package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.dto.RoomDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class BookmarkDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public BookmarkDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public void addBookmark(int roomId, int guestId) {
        String sql = "INSERT INTO bookmark (room_id, guest_id) " +
                "values (?, ?)";
        jdbcTemplate.update(sql, roomId, guestId);
    }

    public void deleteBookmark(int roomId, int guestId) {
        String sql = "DELETE FROM bookmark " +
                "WHERE room_id = ? " +
                "AND guest_id = ? ";
        jdbcTemplate.update(sql, roomId, guestId);
    }

    public Object findBookmarkRoom(int guestId, int roomId) {

        String sql = "SELECT r.room_id, r.room_name, r.room_thumbnail, h.is_super_host, " +
                "r.room_type, r.beds, r.scores, r.reviews " +
                "FROM room r " +
                "JOIN host h " +
                "ON r.host_id = h.host_id " +
                "JOIN bookmark b " +
                "ON r.room_id = b.room_id " +
                "WHERE b.guest_id = ? " +
                "AND b.room_id = ?";

        RowMapper<Object> bookmarkRowMapper = (rs, rowNum) -> {
            RoomDto roomDto = new RoomDto.Builder(rs.getInt("room_id"))
                    .roomName(rs.getString("room_name"))
                    .roomThumbnail(rs.getString("room_thumbnail"))
                    .isSuperHost(rs.getBoolean("is_super_host"))
                    .roomType(rs.getString("room_type"))
                    .beds(rs.getInt("beds"))
                    .scores(rs.getFloat("scores"))
                    .reviews(rs.getFloat("reviews"))
                    .isFavorite(findFavoriteByGuestIdAndRoomId(guestId, roomId))
                    .build();
            return roomDto;
        };

        return jdbcTemplate.queryForObject(sql, new Object[]{guestId, roomId}, bookmarkRowMapper);
    }

    private Boolean findFavoriteByGuestIdAndRoomId(int guestId, int roomId) {

        String sql = "SELECT exists ( SELECT room_id " +
                "FROM bookmark b " +
                "WHERE b.guest_id = ? " +
                "AND b.room_id = ? )";
        return jdbcTemplate.queryForObject(sql, new Object[]{guestId, roomId}, Boolean.class);
    }
}
