package com.codesquad.airbnb5.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.util.List;

@Builder
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class RoomDetailDTO {

    @JsonProperty("room_id")
    private final int roomId;
    @JsonProperty("room_name")
    private final String roomName;
    @JsonProperty("address")
    private final String address;
    @JsonProperty("room_thumbnail")
    private final String roomThumbnail;
    @JsonProperty("is_super_host")
    private final boolean isSuperHost;
    @JsonProperty("host_name")
    private final String hostName;
    @JsonProperty("host_thumbnail")
    private final String hostThumbnail;
    @JsonProperty("room_type")
    private final String roomType;
    @JsonProperty("beds")
    private final int beds;
    @JsonProperty("original_price")
    private final int originalPrice;
    @JsonProperty("sale_price")
    private final int salePrice;
    @JsonProperty("scores")
    private final float scores;
    @JsonProperty("reviews")
    private final int reviews;
    @JsonProperty("amenities")
    private final String amenities;
    @JsonProperty("cleaning_fee")
    private final int cleaningFee;
    @JsonProperty("maximum_guests")
    private final int maximumGuests;
    @JsonProperty("favorite")
    private final boolean isFavorite;
    @JsonProperty("image_lists")
    private List<String> detailImages;

}
