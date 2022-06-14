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
    
    var preView: UIViewController?
    
    var delete: (()->()) = {}
    @IBAction func DeletReply(_ sender: Any) {
        let alert = UIAlertController(title: "댓글을 삭제하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        let confirm = UIAlertAction(title: "삭제", style: .default) { action in
            self.delete()
            
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        preView?.present(alert, animated: true)
        
    }
    
    func updateUI(item: GetReplyReadAllResponseModelResponses){
        
        self.comment.text = item.replyContent
        self.nickName.text = item.nickname
        self.profileImage.load(url: item.thumbnailURL)
        if item.userId == Constants.SERVER_USER_ID{
            deleteButton.isHidden = false
        }
    }
}
