package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.domain.CityRepository;
import com.codesquad.airbnb5.dto.ResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CityService {

    @Autowired
    private CityRepository cityRepository;

    public ResponseDTO getCityList() {
        Object cityList = cityRepository.findAll();
        return new ResponseDTO(200, cityList);
    }
}
