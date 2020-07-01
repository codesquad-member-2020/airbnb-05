package com.codesquad.airbnb5.vo;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class BookingInfo {

    int roomId;
    LocalDate checkIn;
    LocalDate checkOut;
    int guests;

}
