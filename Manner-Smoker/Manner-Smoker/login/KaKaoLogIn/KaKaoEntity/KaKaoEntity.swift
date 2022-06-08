//
//  KaKaoEntity.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/07.
//

import Foundation

struct KakaoEntity : Decodable {
    var response : getKakaoToken?
}

struct getKakaoToken : Decodable {
    var accessToken : String
    var refreshToken : String
}
