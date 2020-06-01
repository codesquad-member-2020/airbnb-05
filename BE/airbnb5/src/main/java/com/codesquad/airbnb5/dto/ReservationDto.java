package com.codesquad.airbnb5.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.time.LocalDate;

@Builder
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class ReservationDto {

    @JsonProperty("reservation_id")
    private final int reservationId;
    @JsonProperty("room_id")
    private final int roomId;
    @JsonProperty("room_name")
    private final String roomName;
    @JsonProperty("room_type")
    private final String roomType;
    @JsonProperty("original_price")
    private final int originalPrice;
    @JsonProperty("sale_price")
    private final int salePrice;
    @JsonProperty("scores")
    private final float scores;
    @JsonProperty("reviews")
    private final int reviews;
    @JsonProperty("cleaning_fee")
    private final int cleaningFee;
    @JsonProperty("tax")
    private final int tax;
    @JsonProperty("total_fee")
    private final int totalFee;
    @JsonProperty("check_in")
    private LocalDate checkIn;
    @JsonProperty("check_out")
    private LocalDate checkOut;
    @JsonProperty("nights")
    private int nights;
    @JsonProperty("guests")
    private int guests;

}
