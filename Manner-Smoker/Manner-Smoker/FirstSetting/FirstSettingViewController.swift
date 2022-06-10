//
//  FirstSettingViewController.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/10.
//

import UIKit

class FirstSettingViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
