//
//  WriteViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/30.
//

import UIKit

class WriteViewController: UIViewController {

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        initTextView()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func endWriting(_ sender: Any) {
        guard let content = textView.text, content.count > 5 else{
            print("최소 5글자 이상을 작성해주세요!")
            return
        }
        
        CommunityManager.shared.setPostCreate(model: CreateRequestModel(content: content, title: "test", userId: 1))
        self.dismiss(animated: true)
    }
    
}
extension WriteViewController: UITextViewDelegate{

    func initTextView(){
        self.textView.delegate = self
        self.textView.text = "이야기를 작성하여 공유해주세요."
        self.textView.textColor = UIColor.lightGray
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
