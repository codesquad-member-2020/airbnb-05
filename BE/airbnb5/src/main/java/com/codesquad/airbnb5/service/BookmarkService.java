package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.dao.BookmarkDAO;
import com.codesquad.airbnb5.dao.RoomMapper;
import com.codesquad.airbnb5.domain.BookmarkRepository;
import com.codesquad.airbnb5.dto.ResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Service
public class BookmarkService {

    @Autowired
    private BookmarkDAO bookmarkDao;
    @Autowired
    private BookmarkRepository bookmarkRepository;

    public ResponseDTO addFavoriteStatus(int roomId, int guestId) {
        bookmarkDao.addBookmark(roomId, guestId);
        return new ResponseDTO(200);
    }

    public ResponseDTO deleteFavoriteStatus(int roomId, int guestId) {
        bookmarkDao.deleteBookmark(roomId, guestId);
        return new ResponseDTO(200);
    }

    public ResponseDTO getBookmarkList(int guestId, RoomMapper roomMapper) throws SQLException {
        List<Object> bookmarks = new ArrayList<>();
        List<Integer> roomList = bookmarkRepository.findBookmarkRoomByGuestId(guestId);
        for (int roomId : roomList) {
            Object roomDto = bookmarkDao.findBookmarkRoom(guestId, roomId, roomMapper);
            bookmarks.add(roomDto);
        }
        return new ResponseDTO(200, bookmarks);
    }
}
