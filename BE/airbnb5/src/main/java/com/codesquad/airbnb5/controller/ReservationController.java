package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.auth.vo.BookingInfo;
import com.codesquad.airbnb5.auth.vo.ReservationVo;
import com.codesquad.airbnb5.dto.ResponseDto;
import com.codesquad.airbnb5.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/reservation")
@RestController
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @PostMapping("/{roomId}")
    public ResponseEntity<ResponseDto> reserveRoom(
            @RequestAttribute("guestId") int guestId,
            @PathVariable("roomId") int roomId,
            @RequestBody ReservationVo reservationVo) {
        BookingInfo bookingInfo = BookingInfo.builder()
                .roomId(roomId)
                .checkIn(reservationVo.getCheckIn())
                .checkOut(reservationVo.getCheckOut())
                .guests(reservationVo.getGuests())
                .build();
        ResponseDto responseDto = reservationService.addReservation(guestId, bookingInfo);
        return ResponseEntity.ok().body(responseDto);
    }

    @DeleteMapping("/{reservationId}")
    public ResponseEntity<ResponseDto> cancelReservation(
            @RequestAttribute("guestId") int guestId,
            @PathVariable("reservationId") int reservationId) {
        ResponseDto responseDto = reservationService.deleteReservation(reservationId);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("")
    public ResponseEntity<ResponseDto> getReservationList(
            @RequestAttribute("guestId") int guestId) {
        ResponseDto responseDto = reservationService.getReservationList(guestId);
        return ResponseEntity.ok().body(responseDto);
    }
}
