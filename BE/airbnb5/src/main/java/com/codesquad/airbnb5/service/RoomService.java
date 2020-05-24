package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.dao.RoomDao;
import com.codesquad.airbnb5.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoomService {

    @Autowired
    private RoomDao roomDao;

    public ResponseDto getRoomSummary(int cityId, int guests, int minPrice, int maxPrice) {
        Object roomDto = roomDao.findRoomSummary(cityId, guests, minPrice, maxPrice);
        return new ResponseDto(200, roomDto);
    }

}
