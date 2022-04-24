//
//  LoginViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/03/23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func testButton(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainSegue") else{
            return
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
