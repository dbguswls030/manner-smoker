//
//  Constant.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/04/03.
//

import Foundation
import Alamofire

struct Constants{
    struct KaKaoAPI{
        static let REST_API_KEY = "2f9978736131f89473157ecacebce150"
        
    }
    struct BackEndAPI{
        static let BASE_URL = "http://ec2-3-37-250-127.ap-northeast-2.compute.amazonaws.com:8080"
    }
    
    static var MY_TOKEN : String = ""
    static var ACESS_TOKEN : String = ""
    //static var CREDENTIAL : Oa
    static var MY_USER_ID : Int64 = 0
    static var SERVER_USER_ID : Int = 0
    
    static var START_SMOKE_DATE : Date?
    static var STANDARD_SMOKE_AMOUNT : Int = 0
    
    static var CURRENT_YEAR : Int = 0
    static var CURRENT_MONTH : Int = 0
    static var CURRENT_DAY : Int = 0
    
    static var RECENTLY_SMOKE_TIME : Date = Date()
    
    static var headerJSON: HTTPHeaders = [
                "Content-Type": "application/json",
            ]
}
