package com.codesquad.airbnb5.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.SQLException;

@Repository
public class BookmarkDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public BookmarkDAO(DataSource dataSource) {
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

    public Object findBookmarkRoom(int guestId, int roomId, RoomMapper roomMapper) throws SQLException {

        String sql = "SELECT r.room_id, r.room_name, r.room_thumbnail, h.is_super_host, " +
                "r.room_type, r.beds, r.scores, r.reviews, r.latitude, r.longitude " +
                "FROM room r " +
                "JOIN host h " +
                "ON r.host_id = h.host_id " +
                "JOIN bookmark b " +
                "ON r.room_id = b.room_id " +
                "WHERE b.guest_id = ? " +
                "AND b.room_id = ?";

        return jdbcTemplate.queryForObject(sql, new Object[]{guestId, roomId}, roomMapper.mapRow(guestId));
    }
}
