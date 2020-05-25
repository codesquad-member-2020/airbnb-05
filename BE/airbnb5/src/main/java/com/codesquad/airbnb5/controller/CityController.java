package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dto.ResponseDto;
import com.codesquad.airbnb5.service.CityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CityController {

    @Autowired
    private CityService cityService;

    @GetMapping("/cities")
    public ResponseEntity<ResponseDto> showCityList() {
        ResponseDto responseDto = cityService.getCityList();
        return ResponseEntity.ok().body(responseDto);
    }
}
