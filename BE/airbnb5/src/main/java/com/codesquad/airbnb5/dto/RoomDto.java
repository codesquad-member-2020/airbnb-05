package com.codesquad.airbnb5.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

@Builder
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class RoomDto {

    @JsonProperty("room_id")
    private final int roomId;
    @JsonProperty("room_name")
    private final String roomName;
    @JsonProperty("room_thumbnail")
    private final String roomThumbnail;
    @JsonProperty("is_super_host")
    private final boolean isSuperHost;
    @JsonProperty("room_type")
    private final String roomType;
    @JsonProperty("beds")
    private final int beds;
    @JsonProperty("scores")
    private final float scores;
    @JsonProperty("reviews")
    private final int reviews;
    @JsonProperty("favorite")
    private final boolean isFavorite;

}
