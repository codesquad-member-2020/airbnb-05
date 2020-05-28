package com.codesquad.airbnb5.domain;

import org.springframework.data.annotation.Id;

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
