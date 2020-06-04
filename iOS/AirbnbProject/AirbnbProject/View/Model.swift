//
//  Model.swift
//  AirbnbProject
//
//  Created by dev-Lena on 2020/06/02.
//  Copyright © 2020 dev-Lena. All rights reserved.
//

struct Model {
    let imageName: String
    let isFavorite: Bool
    
    init(imageName: String, isFavorite: Bool) {
        self.imageName = imageName
        self.isFavorite = isFavorite
    }
}

// MARK: 도시 리스트
struct CityListInfo: Codable {
    let status_code: Int
    let data: [CityInfo]
}

struct CityInfo: Codable {
    let city_id: Int
    let city_name: String
}

// MARK: 가격 필터링
struct PriceInfo: Codable {
    let status_code: Int
    let data : String //average_price
}

// MARK: 메인 화면, 즐겨찾기 탭
// 1. 도시 선택 후 메인화면에 표시될 Response
// 2. 날짜, 인원수 조건 필터링 요청 후 Response
// 3. 즐겨찾기 탭 목록 요청 후 Response
struct AccomodationListInfo: Codable {
    let status_code: Int
    let data : [RoomInfo]
}

struct RoomInfo: Codable {
    let room_id: Int
    let room_name: String
    let room_thumbnail: String // 이미지 URL
    let is_super_host: Bool
    let room_type: String
    let beds: Int
    let scores: Double
    let reviews: Int
    let favorite: Bool
}

struct Response: Codable {
    let status_code: String
}

// MARK: 숙소 상세 화면
struct AccomodationDetailInfo: Codable {
    let status_code: Int
    let data : [AccomodationDetail]
}

struct AccomodationDetail: Codable {
    let room_id: Int
    let room_name: String
    let address: String
    let room_thumbnail: String
    let image_lists: [String]
    let is_super_host: Bool
    let host_name: String
    let host_thumbnail: String
    let room_type: String
    let beds: Int
    let original_price: Int
    let sale_price: Int
    let scores: Double
    let reviews: Int
    let amenities: String
    let cleaning_fee: Int
    let maximum_guests: Int
    let favorite: Bool
}

// MARK: 숙소 상세 화면 - 예약하기
// 예약 요청
struct RequestBookingForm: Codable {
}

// 예약 조회
struct BookingInfo: Codable {
    let status_code: Int
    let data: BookedAccomodation
}

struct BookedAccomodation: Codable {
    let room_id: Int
    let room_name: String
    let room_type: String
    let original_price: Int
    let sale_price: Int
    let scores: Double
    let reviews: Int
    let check_in: String
    let check_out: String
    let guests: Int
    let nights: Int
    let cleaning_fee: Int
    let tax: Int
    let total_fee: Int
}
