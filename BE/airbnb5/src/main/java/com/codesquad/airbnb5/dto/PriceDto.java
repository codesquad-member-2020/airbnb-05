package com.codesquad.airbnb5.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class PriceDto {

    @JsonProperty("average")
    private Object average;

    @JsonProperty("sale_prices")
    private List<Integer> salePrices;

    @JsonProperty("count_list")
    private int[] priceList;

}
