//
//  CommunityManager.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/08.
//

import Foundation
import Alamofire
class CommunityManager{
    static let shared = CommunityManager()
    
    let getPostReadAllUrl = "\(Constants.BackEndAPI.BASE_URL)/api/post"
    let setPostCreateUrl = "\(Constants.BackEndAPI.BASE_URL)/api/post"
    let getReplyReadAllUrl = "\(Constants.BackEndAPI.BASE_URL)/api/reply/"
    
    func getPostReadAll(model: GetPostReadAllRequestModel, completion: @escaping ((GetPostReadAllResponseModel)->())){
        AF.request(getPostReadAllUrl, method: .get, parameters: nil, headers: model.headers).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error: get statusCode")
                return
            }
            switch statusCode{
            case 200:
                do{
                    let decodeData = try JSONDecoder().decode(GetPostReadAllResponseModel.self, from: response.data!)
                    completion(decodeData)
                }catch{
                    print("Error: JsonDecoding error")
                }
            default:
                print("Error: statusCode is not 200")
            }
        }
    }
    
    func setPostCreate(model: CreateRequestModel){
        AF.request(setPostCreateUrl, method: .post, parameters: model.parameters, encoding: JSONEncoding.default, headers: model.headers).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error: get statusCode")
                return
            }
            switch statusCode{
            case 200:
                do{
                    let _ = try JSONDecoder().decode(CreateResponseModel.self, from: response.data!)
                }catch{
                    print("Error: JsonDecoding error")
                }
            default:
                print("Error: statusCode is not 200")
            }
        }
    }
    
    func getReplyReadAll(model: GetReplyReadAllRequestModel, completion: @escaping ((GetReplyRaedAllResponseModel)->())){
        AF.request(getReplyReadAllUrl+model.query, method: .get, parameters: nil).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error: get statusCode")
                return
            }
            switch statusCode{
            case 200:
                do{
                    let decodeData = try JSONDecoder().decode(GetReplyRaedAllResponseModel.self, from: response.data!)
                    completion(decodeData)
                }catch{
                    print("Error: JsonDecoding error")
                }
            default:
                print("Error: statusCode is not 200")
            }
        }
    }
}
