package com.codesquad.airbnb5.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;

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
    private final float reviews;

    @JsonProperty("favorite")
    private final boolean isFavorite;

    public RoomDto(Builder builder) {
        roomId = builder.roomId;
        roomName = builder.roomName;
        roomThumbnail = builder.roomThumbnail;
        isSuperHost = builder.isSuperHost;
        roomType = builder.roomType;
        beds = builder.beds;
        scores = builder.scores;
        reviews = builder.reviews;
        isFavorite = builder.isFavorite;
    }

    public static class Builder {

        private final int roomId;
        private String roomName;
        private String roomThumbnail;
        private boolean isSuperHost;
        private String roomType;
        private int beds;
        private float scores;
        private float reviews;
        private boolean isFavorite;

        public Builder(int roomId) {
            this.roomId = roomId;
        }

        public Builder roomName(String roomName) {
            this.roomName = roomName;
            return this;
        }

        public Builder roomThumbnail(String roomThumbnail) {
            this.roomThumbnail = roomThumbnail;
            return this;
        }

        public Builder isSuperHost(boolean isSuperHost) {
            this.isSuperHost = isSuperHost;
            return this;
        }

        public Builder roomType(String roomType) {
            this.roomType = roomType;
            return this;
        }

        public Builder beds(int beds) {
            this.beds = beds;
            return this;
        }

        public Builder scores(float scores) {
            this.scores = scores;
            return this;
        }

        public Builder reviews(float reviews) {
            this.reviews = reviews;
            return this;
        }

        public Builder isFavorite(boolean isFavorite) {
            this.isFavorite = isFavorite;
            return this;
        }

        public RoomDto build() {
            return new RoomDto(this);
        }
    }
}
