package com.codesquad.airbnb5.domain;

import com.codesquad.airbnb5.dto.RoomDto;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

public interface RoomRepository extends CrudRepository<RoomDto, Integer> {

    @Query("SELECT room_name FROM room WHERE room_id = :roomId")
    String findRoomNameByRoomId(int roomId);

    @Query("SELECT room_type FROM room WHERE room_id = :roomId")
    String findRoomTypeByRoomId(int roomId);

    @Query("SELECT original_price FROM room WHERE room_id = :roomId")
    int findOriginalPriceByRoomId(int roomId);

    @Query("SELECT sale_price FROM room WHERE room_id = :roomId")
    int findSalePriceByRoomId(int roomId);

    @Query("SELECT scores FROM room WHERE room_id = :roomId")
    float findScoresByRoomId(int roomId);

    @Query("SELECT reviews FROM room WHERE room_id = :roomId")
    int findReviewsByRoomId(int roomId);

    @Query("SELECT cleaning_fee FROM room WHERE room_id = :roomId")
    int findCleaningFeeByRoomId(int roomId);

    @Query("SELECT tax FROM room WHERE room_id = :roomId")
    int findTaxByRoomId(int roomId);
}
