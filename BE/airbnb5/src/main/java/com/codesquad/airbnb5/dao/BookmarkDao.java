package com.codesquad.airbnb5.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
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


    private Boolean findFavoriteByGuestIdAndRoomId(int guestId, int roomId) {

        String sql = "SELECT exists ( SELECT room_id " +
                "FROM bookmark b " +
                "WHERE b.guest_id = ? " +
                "AND b.room_id = ? )";
        return jdbcTemplate.queryForObject(sql, new Object[]{guestId, roomId}, Boolean.class);
    }
}
