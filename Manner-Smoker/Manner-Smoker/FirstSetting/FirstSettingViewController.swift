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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
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
