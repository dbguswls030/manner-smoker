//
//  HeaderMyPageVC.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/05/19.
//

import FSCalendar
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import UIKit

class HeaderMyPageVC: UIViewController {
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var myPageTableView: UITableView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    
    var check = 0
    let dateFormatter = DateFormatter()
    var titleData : [String] = ["설정", "위치정보", "친구초대", "알림", "로그아웃"]
    var selectedDate : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserInfo()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        calendarView.delegate = self
        calendarView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
    }
    
    @IBAction func plusSmokeCount(_ sender: UIButton) {
        //dateFormatter.string(from: date)
    }
    
    
    func setUserInfo() {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            } else {
                print("me() success")
                _ = user
                let url = user?.kakaoAccount?.profile?.profileImageUrl
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage(data: data!)
                        self.userName.text = user?.kakaoAccount?.profile?.nickname
                    }
                }
            }
        }
    }
    
}

//MARK: - FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource
extension HeaderMyPageVC : FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource {
    
    func setCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scope = .month
        
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
        calendarView.appearance.headerTitleColor = UIColor.link
        calendarView.appearance.headerTitleAlignment = .left
        calendarView.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
        calendarView.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendarView.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendarView.appearance.titleTodayColor = UIColor(red: 220/225, green: 185/225, blue: 45/225, alpha: 1.0)
        calendarView.appearance.todayColor = UIColor.green.withAlphaComponent(0.0)
        calendarView.placeholderType = .none
        
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .horizontal
        
        if UIScreen.main.bounds.width < 400 {
            calendarView.appearance.headerTitleOffset = CGPoint(x: calendarView.frame.origin.x - 85 , y: calendarView.frame.origin.y)
        } else {
            calendarView.appearance.headerTitleOffset = CGPoint(x: calendarView.frame.origin.x - 95 , y: calendarView.frame.origin.y)
        }
        
        calendarView.layer.zPosition = 999
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
        
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? { // 나중에 이걸로 일별 흡연량 하단에 표시
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return "5/20"
        case "2022-04-02":
            return "10/20"
        case "2022-04-06":
            return "12/20"
        case "2022-04-08":
            return "13/20"
        default:
            return nil
        }
    }
    
    @IBAction func toggleClicked(_ sender: UIButton) {
        print("토글")
        if self.calendarView.scope == .month {
            self.calendarView.setScope(.week, animated: true)
        } else {
            self.calendarView.setScope(.month, animated: true)
        }
        calendarView.reloadData()
    }
    
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HeaderMyPageVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderMyPageTableCell", for: indexPath) as? HeaderMyPageTableCell  else {
            return UITableViewCell()
        }
        
        if check == 1 {
            titleData[4] = "로그인"
        }
        
        cell.title.text = titleData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 4 && titleData[4] == "로그아웃" {
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage(systemName: "person")
                        self.userName.text = "사용자"
                        self.check = 1
                        tableView.reloadData()
                    }
                }
            }
        }
        else {
            self.dismiss(animated: true)
        }
    }
    
}

