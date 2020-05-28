package com.codesquad.airbnb5.domain;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface BookmarkRepository extends CrudRepository<Bookmark, Integer> {

    @Query("SELECT room_id FROM bookmark WHERE guest_id = :guestId")
    List<Integer> findBookmarkRoomByGuestId(int guestId);
}
