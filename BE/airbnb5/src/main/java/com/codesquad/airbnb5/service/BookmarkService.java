package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.dao.BookmarkDao;
import com.codesquad.airbnb5.domain.BookmarkRepository;
import com.codesquad.airbnb5.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BookmarkService {

    @Autowired
    private BookmarkDao bookmarkDao;
    @Autowired
    private BookmarkRepository bookmarkRepository;

    public ResponseDto addFavoriteStatus(int roomId, int guestId) {
        bookmarkDao.addBookmark(roomId, guestId);
        return new ResponseDto(200);
    }

    public ResponseDto deleteFavoriteStatus(int roomId, int guestId) {
        bookmarkDao.deleteBookmark(roomId, guestId);
        return new ResponseDto(200);
    }

    public ResponseDto getBookmarkList(int guestId) {
        List<Object> bookmarks = new ArrayList<>();
        List<Integer> roomList = bookmarkRepository.findBookmarkRoomByGuestId(guestId);
        for (int roomId : roomList) {
            Object roomDto = bookmarkDao.findBookmarkRoom(guestId, roomId);
            bookmarks.add(roomDto);
        }
        return new ResponseDto(200, bookmarks);
    }
}
