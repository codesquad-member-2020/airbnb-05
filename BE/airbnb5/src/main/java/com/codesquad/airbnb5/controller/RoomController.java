package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dto.ResponseDto;
import com.codesquad.airbnb5.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RoomController {

    @Autowired
    private RoomService roomService;

    @GetMapping("/cities/{cityId}")
    public ResponseEntity<ResponseDto> showRoom(
            @PathVariable("cityId") int cityId,
            @RequestParam(value = "guests", required = false, defaultValue = "0") int guests,
            @RequestParam(value = "minPrice", required = false, defaultValue = "0") int minPrice,
            @RequestParam(value = "maxPrice", required = false, defaultValue = "1400000") int maxPrice) {

        ResponseDto responseDto = roomService.getRoomSummary(cityId, guests, minPrice, maxPrice);
        return ResponseEntity.ok().body(responseDto);
    }
}
