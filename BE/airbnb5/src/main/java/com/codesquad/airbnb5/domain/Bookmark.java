package com.codesquad.airbnb5.domain;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import org.springframework.data.annotation.Id;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class Bookmark {

    @Id
    private final int roomId;

    public Bookmark(int roomId) {
        this.roomId = roomId;
    }

    @Override
    public String toString() {
        return "Bookmark{" +
                "roomId=" + roomId +
                '}';
    }
}
