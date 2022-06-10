//
//  WriteViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/30.
//

import UIKit

class WriteViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    var preView: UICollectionView?
    var contentViewModel: GetPostReadOneResponseModelResponses?
    var updateFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        initTextView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func endWriting(_ sender: Any) {
        guard let content = textView.text, content.count > 4 else{
            print("최소 5글자 이상을 작성해주세요!")
            return
        }
        if updateFlag == false{
            CommunityManager.shared.setPostCreate(model: CreateRequestModel(content: content, title: "test", userId: 1))
        }else{
            if let contentViewModel = contentViewModel {
                CommunityManager.shared.updatePost(model: UpdatePostRequestModel(postId: contentViewModel.postId, content: content, title: "test"))
            }
            
        }
        self.dismiss(animated: true)
    }
    
}
extension WriteViewController: UITextViewDelegate{

    func initTextView(){
        self.textView.delegate = self
        if let contentViewModel = contentViewModel{
            self.textView.text = contentViewModel.content
        }else{
            self.textView.text = "이야기를 작성하여 공유해주세요."
            self.textView.textColor = UIColor.lightGray
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "이야기를 작성하여 공유해주세요."
            textView.textColor = UIColor.lightGray
        }
    }
}
