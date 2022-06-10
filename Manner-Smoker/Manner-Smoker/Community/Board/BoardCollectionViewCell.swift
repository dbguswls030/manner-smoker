//
//  BoardViewCellCollectionViewCell.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/27.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nickName: UILabel!
    @IBOutlet var dateOfWriting: UILabel!
    @IBOutlet var comment: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    var delete: (()->()) = {}
    @IBAction func DeletReply(_ sender: Any) {
        delete()
    }
    
    func updateUI(item: GetReplyReadAllResponseModelResponses){
        self.comment.text = item.replyContent
        if item.userId == 1{
            deleteButton.isHidden = false
        }
    }
}
