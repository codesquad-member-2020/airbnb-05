package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.dao.RoomDAO;
import com.codesquad.airbnb5.dao.RoomMapper;
import com.codesquad.airbnb5.dto.ResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.time.LocalDate;

@Service
public class RoomService {

    @Autowired
    private RoomDAO roomDao;

    public ResponseDTO getRoomSummary(int cityId, int limit, int offset, int guests, int minPrice, int maxPrice, LocalDate checkIn, LocalDate checkOut, int guestId, RoomMapper roomMapper) throws SQLException {
        Object roomDto = roomDao.findRoomSummary(cityId, limit, offset, guests, minPrice, maxPrice, checkIn, checkOut, guestId, roomMapper);
        return new ResponseDTO(200, roomDto);
    }

    public ResponseDTO getPriceFilter(int cityId, int guests, LocalDate checkIn, LocalDate checkOut) {
        Object priceDto = roomDao.findPriceFilterData(cityId, guests, checkIn, checkOut);
        return new ResponseDTO(200, priceDto);
    }

    public ResponseDTO getRoomDetail(int cityId, int roomId, int guestId, RoomMapper roomMapper) throws SQLException {
        Object roomDetailDto = roomDao.findRoomDetail(cityId, roomId, guestId, roomMapper);
        return new ResponseDTO(200, roomDetailDto);
    }
}
