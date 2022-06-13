//
//  CommunityViewControllerCellCollectionViewCell.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/24.
//

import UIKit

class CommunityCollectionViewCell: UICollectionViewCell {
    @IBOutlet var contents: UILabel!
    @IBOutlet var nickName: UILabel!
    @IBOutlet var dateOfWriting: UILabel!
    @IBOutlet var commentCount: UILabel!
    
    func updateUI(item: GetPostReadAllResponseModelResponses){
        self.contents.text = item.content
        self.nickName.text = "\(item.userId)"
        self.dateOfWriting.text = convertDate(createdDate: item.createdDate)
        
    }
    
    func convertDate(createdDate: String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        guard let date = dateFormatter.date(from: createdDate) else{
            return "?"
        }
        let intervalTime = Int(floor(Date().timeIntervalSince(date) / 60)) //분
        if intervalTime < 1 {
            return "방금 전"
        }else if intervalTime < 60 {
            return "\(intervalTime)분 전"
        }else if intervalTime < 60 * 24{
            return "\(intervalTime/60)시간 전"
        }else if intervalTime < 60 * 24 * 365{
            return "\(intervalTime/60/24)일 전"
        }else{
            return "\(intervalTime/60/24/365)년 전"
        }
      
    }
}
//{
//    "httpStatus": "OK",
//    "message": null,
//    "response": [
//        {
//            "postId": 1,
//            "title": "test",
//            "content": "test",
//            "userId": 3,
//            "createdDate": "2022-06-05T23:04:10",
//            "modifiedDate": "2022-06-05T23:04:10"
//        }
//    ]
//}
