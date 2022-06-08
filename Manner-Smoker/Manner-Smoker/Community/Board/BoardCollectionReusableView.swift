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
    @IBOutlet var image: UIImageView!
    @IBOutlet var commentCount: UILabel!
    
    func updateUI(item: GetPostReadAllResponseModelResponses){
        self.contents.text = item.content
    }
}
