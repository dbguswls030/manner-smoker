//
//  BoardContentCollectionReusableView.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/27.
//

import UIKit

class BoardCollectionReusableView: UICollectionReusableView {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nickName: UILabel!
    @IBOutlet var dateOfWriting: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var commentCount: UILabel!
    
    func updateUI(item: GetPostReadOneResponseModelResponses){
        DispatchQueue.main.async {
            self.contents.text = item.content
            self.nickName.text = item.nickname
            self.profileImage.load(url: item.thumbnailURL)
            self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.width/2
        }
        
    }
}
