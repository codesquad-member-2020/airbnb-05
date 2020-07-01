package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.vo.BookingInfo;
import com.codesquad.airbnb5.dao.ReservationDAO;
import com.codesquad.airbnb5.domain.RoomRepository;
import com.codesquad.airbnb5.dto.ResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservationService {

    @Autowired
    private ReservationDAO reservationDao;
    @Autowired
    private RoomRepository roomRepository;

    public ResponseDTO addReservation(int guestId, BookingInfo bookingInfo) {
        reservationDao.addReservation(bookingInfo.getRoomId(), guestId, bookingInfo.getCheckIn(), bookingInfo.getCheckOut(), bookingInfo.getGuests());
        return new ResponseDTO(200);
    }

    public ResponseDTO deleteReservation(int reservationId) {
        reservationDao.deleteReservation(reservationId);
        return new ResponseDTO(200);
    }

    public ResponseDTO getReservationList(int guestId) {
        Object reservationDto = reservationDao.findReservationList(guestId);
        return new ResponseDTO(200, reservationDto);
    }
}
