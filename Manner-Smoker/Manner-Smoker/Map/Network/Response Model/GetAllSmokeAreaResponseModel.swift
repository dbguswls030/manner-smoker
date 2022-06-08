//
//  GetAllSmokeAreaResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/02.
//

import Foundation

struct GetAllSmokeAreaResponseModel: Decodable{
    
    let response: [AreaData]
    
    enum CodingKeys: String, CodingKey{
        case response
    }
}
struct AreaData: Decodable{
    let area: Int
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey{
        case area, latitude, longitude
    }
}

//{
//  "httpStatus": "OK",
//  "message": null,
//  "response": [
//    {
//      "longitude": "126.968881",
//      "latitude": "37.553149",
//      "area": 1
//    },
//    {
//      "longitude": "126.969662",
//      "latitude": "37.553760",
//      "area": 1
//    }
//    ]
//}
