package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.dao.ReservationDao;
import com.codesquad.airbnb5.domain.RoomRepository;
import com.codesquad.airbnb5.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class ReservationService {

    @Autowired
    private ReservationDao reservationDao;
    @Autowired
    private RoomRepository roomRepository;

    public ResponseDto addReservation(int roomId, int guestId, LocalDate checkIn, LocalDate checkOut, int guests) {
        reservationDao.addReservation(roomId, guestId, checkIn, checkOut, guests);
        return new ResponseDto(200);
    }

    public ResponseDto deleteReservation(int reservationId) {
        reservationDao.deleteReservation(reservationId);
        return new ResponseDto(200);
    }

    public ResponseDto getReservationList(int guestId) {
        Object reservationDto = reservationDao.findReservationList(guestId);
        return new ResponseDto(200, reservationDto);
    }
}
