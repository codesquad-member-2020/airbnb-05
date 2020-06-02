package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dao.RoomMapper;
import com.codesquad.airbnb5.dto.ResponseDto;
import com.codesquad.airbnb5.service.BookmarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RequestMapping("/bookmarks")
@RestController
public class BookmarkController {

    @Autowired
    private RoomMapper roomMapper;

    @Autowired
    private BookmarkService bookmarkService;

    @PostMapping("/{roomId}")
    public ResponseEntity<ResponseDto> addBookmark(
            @PathVariable("roomId") int roomId,
            @RequestParam("guestId") int guestId) {
        ResponseDto responseDto = bookmarkService.addFavoriteStatus(roomId, guestId);
        return ResponseEntity.ok().body(responseDto);
    }

    @DeleteMapping("/{roomId}")
    public ResponseEntity<ResponseDto> deleteBookmark(
            @PathVariable("roomId") int roomId,
            @RequestParam("guestId") int guestId) {
        ResponseDto responseDto = bookmarkService.deleteFavoriteStatus(roomId, guestId);
        return ResponseEntity.ok().body(responseDto);
    }

    @GetMapping("")
    public ResponseEntity<ResponseDto> getBookmarks(
            @RequestParam("guestId") int guestId) throws SQLException {
        ResponseDto responseDto = bookmarkService.getBookmarkList(guestId, roomMapper);
        return ResponseEntity.ok().body(responseDto);
    }
}
