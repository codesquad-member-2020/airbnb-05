package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.dto.RoomDetailDto;
import com.codesquad.airbnb5.dto.RoomDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

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

    public RowMapper<RoomDetailDto> mapRowDetail(int guestId) throws SQLException {
        return new RowMapper<RoomDetailDto>() {
            @Override
            public RoomDetailDto mapRow(ResultSet rs, int rowNum) throws SQLException {
                int roomId = rs.getInt("room_id");
                boolean bool = findFavoriteByGuestIdAndRoomId(guestId, roomId);

                return RoomDetailDto.builder()
                        .roomId(rs.getInt("r.room_id"))
                        .roomName(rs.getString("room_name"))
                        .address(rs.getString("address"))
                        .roomThumbnail(rs.getString("room_thumbnail"))
                        .detailImages(findDetailImage(roomId))
                        .isSuperHost(rs.getBoolean("is_super_host"))
                        .hostName(rs.getString("host_name"))
                        .hostThumbnail(rs.getString("host_thumbnail"))
                        .roomType(rs.getString("room_type"))
                        .beds(rs.getInt("beds"))
                        .originalPrice(rs.getInt("original_price"))
                        .salePrice(rs.getInt("sale_price"))
                        .scores(rs.getFloat("scores"))
                        .reviews(rs.getFloat("reviews"))
                        .amenities(rs.getString("amenities"))
                        .cleaningFee(rs.getInt("cleaning_fee"))
                        .maximumGuests(rs.getInt("maximum_guests"))
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

    private List<String> findDetailImage(int roomId) {

        String sql = "SELECT d.detail_url " +
                "FROM detail_image d " +
                "WHERE room_id = ? ";

        return jdbcTemplate.query(sql, new Object[]{roomId}, ((rs, rowNum) -> {
            return rs.getString("detail_url");
        }));
    }
}
