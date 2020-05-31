package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.dao.RoomDao;
import com.codesquad.airbnb5.dao.RoomMapper;
import com.codesquad.airbnb5.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.time.LocalDate;

@Service
public class RoomService {

    @Autowired
    private RoomDao roomDao;

    public ResponseDto getRoomScroll(int cityId, int limit, int offset, int guestId, RoomMapper roomMapper) throws SQLException {
        Object roomDto = roomDao.findRooms(cityId, limit, offset, guestId, roomMapper);
        return new ResponseDto(200, roomDto);
    }

    public ResponseDto getRoomSummary(int cityId, int guests, int minPrice, int maxPrice, LocalDate checkIn, LocalDate checkOut, int guestId, RoomMapper roomMapper) throws SQLException {
        Object roomDto = roomDao.findRoomSummary(cityId, guests, minPrice, maxPrice, checkIn, checkOut, guestId, roomMapper);
        return new ResponseDto(200, roomDto);
    }

    public ResponseDto getPriceFilter(int cityId, int guests, LocalDate checkIn, LocalDate checkOut) {
        Object priceDto = roomDao.findPriceFilterData(cityId, guests, checkIn, checkOut);
        return new ResponseDto(200, priceDto);
    }
}
