package com.codesquad.airbnb5.controller;

import com.codesquad.airbnb5.dto.ResponseDTO;
import com.codesquad.airbnb5.service.CityService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CityController {

    private final CityService cityService;

    public CityController(CityService cityService) {
        this.cityService = cityService;
    }

    @GetMapping("/cities")
    public ResponseEntity<ResponseDTO> showCityList() {
        ResponseDTO responseDto = cityService.getCityList();
        return ResponseEntity.ok().body(responseDto);
    }
}
