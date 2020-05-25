package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dto.ResponseDto;
import com.codesquad.airbnb5.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
public class RoomController {

    @Autowired
    private RoomService roomService;

    @GetMapping("/cities/{cityId}/rooms")
    public ResponseEntity<ResponseDto> showRooms(
            @PathVariable("cityId") int cityId,
            @RequestParam(value = "limit", required = false, defaultValue = "0") int limit,
            @RequestParam(value = "offset", required = false, defaultValue = "0") int offset) {
        ResponseDto responseDto = roomService.getRoomScroll(cityId, limit, offset);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("/cities/{cityId}")
    public ResponseEntity<ResponseDto> showRoom(
            @PathVariable("cityId") int cityId,
            @RequestParam(value = "guests", required = false, defaultValue = "0") int guests,
            @RequestParam(value = "minPrice", required = false, defaultValue = "0") int minPrice,
            @RequestParam(value = "maxPrice", required = false, defaultValue = "1400000") int maxPrice,
            @RequestParam(value = "checkIn", required = false, defaultValue = "1900-05-20")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkIn,
            @RequestParam(value = "checkOut", required = false, defaultValue = "2022-05-20")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkOut) {

        ResponseDto responseDto = roomService.getRoomSummary(cityId, guests, minPrice, maxPrice, checkIn, checkOut);
        return ResponseEntity.ok().body(responseDto);
    }
}
