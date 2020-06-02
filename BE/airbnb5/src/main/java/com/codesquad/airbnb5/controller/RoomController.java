package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dao.RoomMapper;
import com.codesquad.airbnb5.dto.ResponseDto;
import com.codesquad.airbnb5.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;
import java.time.LocalDate;

@RestController
public class RoomController {

    @Autowired
    private RoomService roomService;

    @Autowired
    private RoomMapper roomMapper;

    @GetMapping("/cities/{cityId}")
    public ResponseEntity<ResponseDto> showRooms(
            @PathVariable("cityId") int cityId,
            @RequestParam(value = "limit", defaultValue = "10") int limit,
            @RequestParam(value = "offset", defaultValue = "0") int offset,
            @RequestParam(value = "guestId", defaultValue = "1") int guestId) throws SQLException {
        ResponseDto responseDto = roomService.getRoomScroll(cityId, limit, offset, guestId, roomMapper);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("/cities/{cityId}/rooms")
    public ResponseEntity<ResponseDto> showRoom(
            @PathVariable("cityId") int cityId,
            @RequestParam(value = "guests", required = false, defaultValue = "1") int guests,
            @RequestParam(value = "minPrice", required = false, defaultValue = "0") int minPrice,
            @RequestParam(value = "maxPrice", required = false, defaultValue = "9227830") int maxPrice,
            @RequestParam(value = "checkIn", required = false, defaultValue = "1900-01-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkIn,
            @RequestParam(value = "checkOut", required = false, defaultValue = "2022-12-31")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkOut,
            @RequestParam(value = "guestId", defaultValue = "1") int guestId) throws SQLException {


        ResponseDto responseDto = roomService.getRoomSummary(cityId, guests, minPrice, maxPrice, checkIn, checkOut, guestId, roomMapper);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("/cities/{cityId}/prices")
    public ResponseEntity<ResponseDto> showPriceFilter(
            @PathVariable("cityId") int cityId,
            @RequestParam(value = "guests", required = false, defaultValue = "1") int guests,
            @RequestParam(value = "checkIn", required = false, defaultValue = "1900-01-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkIn,
            @RequestParam(value = "checkOut", required = false, defaultValue = "2022-12-31")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkOut) {
        ResponseDto responseDto = roomService.getPriceFilter(cityId, guests, checkIn, checkOut);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("/cities/{cityId}/rooms/{roomId}")
    public ResponseEntity<ResponseDto> showRoomDetail(
            @PathVariable("cityId") int cityId,
            @PathVariable("roomId") int roomId,
            @RequestParam(value = "guestId", defaultValue = "1") int guestId) throws SQLException {
        ResponseDto responseDto = roomService.getRoomDetail(cityId, roomId, guestId, roomMapper);
        return ResponseEntity.ok().body(responseDto);
    }
}
