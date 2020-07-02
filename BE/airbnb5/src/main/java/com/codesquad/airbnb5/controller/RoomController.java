package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dao.RoomMapper;
import com.codesquad.airbnb5.dto.ResponseDTO;
import com.codesquad.airbnb5.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.time.LocalDate;

@RestController
public class RoomController {

    private final RoomService roomService;
    private final RoomMapper roomMapper;

    public RoomController(RoomService roomService, RoomMapper roomMapper) {
        this.roomService = roomService;
        this.roomMapper = roomMapper;
    }

    @GetMapping("/cities/{cityId}/rooms")
    public ResponseEntity<ResponseDTO> showRoom(
            @PathVariable("cityId") int cityId,
            @RequestParam(value = "limit", defaultValue = "10") int limit,
            @RequestParam(value = "offset", defaultValue = "0") int offset,
            @RequestParam(value = "guests", required = false, defaultValue = "1") int guests,
            @RequestParam(value = "minPrice", required = false, defaultValue = "0") int minPrice,
            @RequestParam(value = "maxPrice", required = false, defaultValue = "9227830") int maxPrice,
            @RequestParam(value = "checkIn", required = false, defaultValue = "1900-01-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkIn,
            @RequestParam(value = "checkOut", required = false, defaultValue = "2022-12-31")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkOut,
            @RequestAttribute(value = "guestId") int guestId) throws SQLException {


        ResponseDTO responseDto = roomService.getRoomSummary(cityId, limit, offset, guests, minPrice, maxPrice, checkIn, checkOut, guestId, roomMapper);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("/cities/{cityId}/prices")
    public ResponseEntity<ResponseDTO> showPriceFilter(
            @PathVariable("cityId") int cityId,
            @RequestParam(value = "guests", required = false, defaultValue = "1") int guests,
            @RequestParam(value = "checkIn", required = false, defaultValue = "1900-01-01")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkIn,
            @RequestParam(value = "checkOut", required = false, defaultValue = "2022-12-31")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkOut) {
        ResponseDTO responseDto = roomService.getPriceFilter(cityId, guests, checkIn, checkOut);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("/cities/{cityId}/rooms/{roomId}")
    public ResponseEntity<ResponseDTO> showRoomDetail(
            @PathVariable("cityId") int cityId,
            @PathVariable("roomId") int roomId,
            @RequestParam(value = "guestId", defaultValue = "1") int guestId) throws SQLException {
        ResponseDTO responseDto = roomService.getRoomDetail(cityId, roomId, guestId, roomMapper);
        return ResponseEntity.ok().body(responseDto);
    }
}
