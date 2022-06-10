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
    let getPostReadOneUrl = "\(Constants.BackEndAPI.BASE_URL)/api/post/"
    let setPostCreateUrl = "\(Constants.BackEndAPI.BASE_URL)/api/post"
    let DeletePostUrl = "\(Constants.BackEndAPI.BASE_URL)/api/post/"
    let UpdatePostUrl = "\(Constants.BackEndAPI.BASE_URL)/api/post/"
    let getReplyReadAllUrl = "\(Constants.BackEndAPI.BASE_URL)/api/reply/"
    let CreateReplyUrl = "\(Constants.BackEndAPI.BASE_URL)/api/reply"
    let DeleteReplyUrl = "\(Constants.BackEndAPI.BASE_URL)/api/reply/"
   
    
    
    
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
    func getPostReadOne(model: GetPostReadOneRequestModel, completion: @escaping((GetPostReadOneResponseModel)->())){
        AF.request(getPostReadOneUrl + model.postId, method: .get).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error: get statusCode")
                return
            }
            switch statusCode{
            case 200:
                do{
                    let decodeData = try JSONDecoder().decode(GetPostReadOneResponseModel.self, from: response.data!)
                    completion(decodeData)
                }catch{
                    print("Error: getPostReadOne JsonDecoding error")
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
        AF.request(getReplyReadAllUrl+model.postId, method: .get, parameters: nil).response { response in
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
                    print("Error: getReplyReadAll JsonDecoding error")
                }
            default:
                print("Error: statusCode is not 200")
            }
        }
    }
    func CreatedReply(model: CreateReplyRequestModel){
        AF.request(CreateReplyUrl, method: .post, parameters: model.parameters, encoding: JSONEncoding.default, headers: model.headers).response { response in
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
    func deleteReply(model: DeleteReplyRequestModel, completion: @escaping (()->())){
        AF.request(DeleteReplyUrl + "\(model.replyId)", method: .delete, headers: model.headers).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error: get statusCode")
                return
            }
            switch statusCode{
            case 200:
                do{
                    let _ = try JSONDecoder().decode(DeleteReplyResponseModel.self, from: response.data!)
                    completion()
                }catch{
                    print("Error: JsonDecoding error")
                }
            default:
                print("Error: statusCode is not 200")
            }
        }
    }
    func deletePost(model: DeletePostRequestModel, completion: @escaping (()->())){
        AF.request(DeletePostUrl + "\(model.postId)", method: .delete, headers: model.headers).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error: get statusCode")
                return
            }
            switch statusCode{
            case 200:
                do{
                    let _ = try JSONDecoder().decode(DeletePostResponseModel.self, from: response.data!)
                    completion()
                }catch{
                    print("Error: JsonDecoding error")
                }
            default:
                print("Error: statusCode is not 200")
            }
        }
    }
    func updatePost(model: UpdatePostRequestModel){
        AF.request(UpdatePostUrl + "\(model.postId)", method: .put, parameters: model.parameters, encoding: JSONEncoding.default , headers: model.headers).response { response in
            guard let statusCode = response.response?.statusCode else{
                print("Error: get statusCode")
                return
            }
            switch statusCode{
            case 200:
                do{
                    let _ = try JSONDecoder().decode(UpdatePostResponseModel.self, from: response.data!)
                }catch{
                    print("Error: JsonDecoding error")
                }
            default:
                print("Error: statusCode is not 200")
            }
        }
    }
}
