package com.codesquad.airbnb5.vo;

import lombok.Data;

import java.time.LocalDate;

@Data
public class ReservationVO {

    private int roomId;
    private LocalDate checkIn;
    private LocalDate checkOut;
    private int guests;

}
