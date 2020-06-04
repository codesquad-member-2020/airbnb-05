package com.codesquad.airbnb5.auth.vo;

import lombok.Data;

import java.time.LocalDate;

@Data
public class ReservationVo {

    private int roomId;
    private LocalDate checkIn;
    private LocalDate checkOut;
    private int guests;

}
