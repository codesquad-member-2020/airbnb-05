package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dto.ResponseDto;
import com.codesquad.airbnb5.service.BookmarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/bookmarks")
@RestController
public class BookmarkController {

    @Autowired
    private BookmarkService bookmarkService;

    @PostMapping("/cities/{cityId}/rooms/{roomId}")
    public ResponseEntity<ResponseDto> addBookmark(
            @PathVariable("cityId") int cityId,
            @PathVariable("roomId") int roomId, @RequestParam("guestId") int guestId) {
        ResponseDto responseDto = bookmarkService.addFavoriteStatus(roomId, guestId);
        return ResponseEntity.ok().body(responseDto);
    }

    @DeleteMapping("/cities/{cityId}/rooms/{roomId}")
    public ResponseEntity<ResponseDto> deleteBookmark(
            @PathVariable("cityId") int cityId,
            @PathVariable("roomId") int roomId, @RequestParam("guestId") int guestId) {
        ResponseDto responseDto = bookmarkService.deleteFavoriteStatus(roomId, guestId);
        return ResponseEntity.ok().body(responseDto);
    }
}
