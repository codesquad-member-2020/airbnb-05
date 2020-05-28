package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.dao.BookmarkDao;
import com.codesquad.airbnb5.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookmarkService {

    @Autowired
    private BookmarkDao bookmarkDao;

    public ResponseDto addFavoriteStatus(int roomId, int guestId) {
        bookmarkDao.addBookmark(roomId, guestId);
        return new ResponseDto(200);
    }

    public ResponseDto deleteFavoriteStatus(int roomId, int guestId) {
        bookmarkDao.deleteBookmark(roomId, guestId);
        return new ResponseDto(200);
    }
}
