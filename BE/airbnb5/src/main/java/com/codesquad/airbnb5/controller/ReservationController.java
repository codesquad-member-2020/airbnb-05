package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dto.ResponseDto;
import com.codesquad.airbnb5.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@RequestMapping("/reservation")
@RestController
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @PostMapping("/{roomId}")
    public ResponseEntity<ResponseDto> reserveRoom(
            @PathVariable("roomId") int roomId,
            @RequestParam("guestId") int guestId,
            @RequestParam(value = "checkIn") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkIn,
            @RequestParam(value = "checkOut") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate checkOut,
            @RequestParam("guests") int guests) {
        ResponseDto responseDto = reservationService.addReservation(roomId, guestId, checkIn, checkOut, guests);
        return ResponseEntity.ok().body(responseDto);
    }

    @DeleteMapping("")
    public ResponseEntity<ResponseDto> cancelReservation(
            @RequestParam("guestId") int guestId,
            @RequestParam("reservationId") int reservationId) {
        ResponseDto responseDto = reservationService.deleteReservation(reservationId);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("")
    public ResponseEntity<ResponseDto> getReservationList(
            @RequestParam("guestId") int guestId) {
        ResponseDto responseDto = reservationService.getReservationList(guestId);
        return ResponseEntity.ok().body(responseDto);
    }
}
