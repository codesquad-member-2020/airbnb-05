package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dto.ResponseDTO;
import com.codesquad.airbnb5.service.ReservationService;
import com.codesquad.airbnb5.vo.BookingInfo;
import com.codesquad.airbnb5.vo.ReservationVO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/reservation")
@RestController
public class ReservationController {

    private final ReservationService reservationService;

    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @PostMapping("/{roomId}")
    public ResponseEntity<ResponseDTO> reserveRoom(
            @RequestAttribute("guestId") int guestId,
            @PathVariable("roomId") int roomId,
            @RequestBody ReservationVO reservationVo) {
        BookingInfo bookingInfo = BookingInfo.builder()
                .roomId(roomId)
                .checkIn(reservationVo.getCheckIn())
                .checkOut(reservationVo.getCheckOut())
                .guests(reservationVo.getGuests())
                .build();
        ResponseDTO responseDto = reservationService.addReservation(guestId, bookingInfo);
        return ResponseEntity.ok().body(responseDto);
    }

    @DeleteMapping("/{reservationId}")
    public ResponseEntity<ResponseDTO> cancelReservation(
            @RequestAttribute("guestId") int guestId,
            @PathVariable("reservationId") int reservationId) {
        ResponseDTO responseDto = reservationService.deleteReservation(reservationId);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("")
    public ResponseEntity<ResponseDTO> getReservationList(
            @RequestAttribute("guestId") int guestId) {
        ResponseDTO responseDto = reservationService.getReservationList(guestId);
        return ResponseEntity.ok().body(responseDto);
    }
}
