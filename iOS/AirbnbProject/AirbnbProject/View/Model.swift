struct Model {
    let imageName: String
    let isFavorite: Bool
    
    init(imageName: String, isFavorite: Bool) {
        self.imageName = imageName
        self.isFavorite = isFavorite
    }
}

// MARK: 도시 리스트
struct CityListInfo {
    let status_code: Int
    let data : [CityInfo]
}

struct CityInfo {
    let city_id: Int
    let city_name: String
}

// MARK: 가격 필터링
struct PriceInfo {
    let status_code: Int
    let data : String //average_price
}

// MARK: 메인 화면
// 1. 도시 선택 후 메인화면에 표시될 Response
// 2. 날짜, 인원수 조건 필터링 요청 후 Response
// 3. 즐겨찾기 목록 요청 후 Response
struct AccomodationListInfo {
    let status_code: Int
    let data : [RoomInfo]
}
struct RoomInfo {
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

