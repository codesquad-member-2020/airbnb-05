package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.auth.vo.BookingInfo;
import com.codesquad.airbnb5.dao.ReservationDao;
import com.codesquad.airbnb5.domain.RoomRepository;
import com.codesquad.airbnb5.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservationService {

    @Autowired
    private ReservationDao reservationDao;
    @Autowired
    private RoomRepository roomRepository;

    public ResponseDto addReservation(int guestId, BookingInfo bookingInfo) {
        reservationDao.addReservation(bookingInfo.getRoomId(), guestId, bookingInfo.getCheckIn(), bookingInfo.getCheckOut(), bookingInfo.getGuests());
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
