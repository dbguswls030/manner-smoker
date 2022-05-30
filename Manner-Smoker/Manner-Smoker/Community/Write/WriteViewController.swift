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
    
    func initTextView(){
        self.textView.delegate = self
        self.textView.text = "이야기를 작성하여 공유해주세요."
        self.textView.textColor = UIColor.lightGray
    }
    
    @IBAction func endWriting(_ sender: Any) {
        //글 작성 완료 팝업 yes or no
        //팝업 yes 시 업로드
        self.dismiss(animated: true)
    }
    
}
extension WriteViewController: UITextViewDelegate{

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
