//
//  LoginViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/03/23.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func kakaoLoginButton(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            loginWithApp()
        } else {
            // 만약, 카카오톡이 깔려있지 않을 경우에는 웹 브라우저로 카카오 로그인함.
            loginWithWeb()
        }
    }
    
}

//MARK: - 카카오로그인 관련

extension LoginViewController {
    // 카카오톡 앱으로 로그인
    func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk {( OAuthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {

                        UserDefaults.standard.set(user?.id, forKey: "UserID")
                        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        Constants.MY_USER_ID = (user?.id)!
                        Constants.MY_TOKEN = OAuthToken!.accessToken
                        KaKaoDataManager().transferToken()
                        
                        self.presentToMain()
                        
                        _ = OAuthToken

                        self.presentToMain()

                    }
                }
            }
        }
    }
    
    // 카카오톡 웹으로 로그인
    func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount {(OAuthToken, error) in

            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {

                        UserDefaults.standard.set(user?.id, forKey: "UserID")
                        Constants.MY_USER_ID = (user?.id)!
                        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        Constants.MY_TOKEN = OAuthToken!.accessToken
                        KaKaoDataManager().transferToken()
                        
                        
                        self.presentToMain()
                        
                        _ = OAuthToken

                        self.presentToMain()

                    }
                }
            }
        }
    }
    
    func presentToMain() {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        let vc = FirstSettingViewController()
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }

}
