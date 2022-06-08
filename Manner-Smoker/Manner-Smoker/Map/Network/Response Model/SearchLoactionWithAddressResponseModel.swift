//
//  SearchLoactionWithAddressResponseModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/04/03.
//

import Foundation
struct SearchLoactionWithAddressResponseModel: Decodable{
    let documents: [SearchAddressInfo]
    
    enum CodingKeys: String, CodingKey{
        case documents
    }
}
struct SearchAddressInfo: Decodable{
    
    //경도 longitude
    let x: String

    //위도 latitude
    let y: String
    
    enum CodingKeys: String, CodingKey{
        case x,y
    }
}
