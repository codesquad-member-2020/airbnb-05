package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.domain.CityRepository;
import com.codesquad.airbnb5.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CityService {

    @Autowired
    private CityRepository cityRepository;

    public ResponseDto getCityList() {
        Object cityList = cityRepository.findAll();
        return new ResponseDto(200, cityList);
    }
}
