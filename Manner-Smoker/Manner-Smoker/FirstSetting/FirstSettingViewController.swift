//
//  FirstSettingViewController.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/10.
//

import UIKit

class FirstSettingViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var standardSmoke: UITextField!
    
    @IBOutlet var enterBtn: UIButton!
    @IBOutlet var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterBtn.layer.cornerRadius = 10
        submitBtn.layer.cornerRadius = 15
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
        setKeyboardObserver()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        
        let sheet = UIAlertController(title: "알림", message: "흡연시작일과 기준흡연갯수 설정을 다 하셨나요?", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "Yes!", style: .destructive, handler: { _ in self.moveToMain() }))
        sheet.addAction(UIAlertAction(title: "No!", style: .cancel, handler: { _ in print("NO") }))
        
        
        present(sheet, animated: true)
        
    }
    
    @IBAction func enterStandardSmoke(_ sender: UIButton) {
        
        Constants.STANDARD_SMOKE_AMOUNT = Int(self.standardSmoke.text!)!
    
        let sheet = UIAlertController(title: "알림", message: "기준흡연 갯수가 : \(standardSmoke.text!)개비가 맞으신가요?", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "Yes!", style: .destructive, handler: { _ in print("YES") }))
        sheet.addAction(UIAlertAction(title: "No!", style: .cancel, handler: { _ in print("NO") }))

        present(sheet, animated: true)
        //view.endEditing(true)
    }
    
    
    @objc func changed() {
        
        let date = datePicker.date
        Constants.START_SMOKE_DATE = date
    }
    
    func moveToMain() {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}

//MARK: - 키보드 설정

extension FirstSettingViewController {

    func setKeyboardObserver() {
            NotificationCenter.default.addObserver(self, selector: #selector(FirstSettingViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(FirstSettingViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
        }
        
        @objc func keyboardWillShow(notification: NSNotification) {
              if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                      let keyboardRectangle = keyboardFrame.cgRectValue
                      let keyboardHeight = keyboardRectangle.height
                  UIView.animate(withDuration: 1) {
                      self.view.window?.frame.origin.y -= keyboardHeight
                  }
              }
          }
        
        @objc func keyboardWillHide(notification: NSNotification) {
            if self.view.window?.frame.origin.y != 0 {
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                        let keyboardRectangle = keyboardFrame.cgRectValue
                        let keyboardHeight = keyboardRectangle.height
                    UIView.animate(withDuration: 1) {
                        self.view.window?.frame.origin.y += keyboardHeight
                    }
                }
            }
        }
}
