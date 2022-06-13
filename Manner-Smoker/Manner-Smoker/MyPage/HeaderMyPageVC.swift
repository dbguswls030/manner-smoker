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
    
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var myPageTableView: UITableView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var plusBtn: UIButton!
    
    @IBOutlet var selectedDateLbl: UILabel!
    @IBOutlet var selectedDaySmokeAmountLbl: UILabel!
    
    var check = 0
    let dateFormatter = DateFormatter()
    var smokeInfo : [DayResponse] = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserInfo()
        todaySetup()
        
        //profileView.layer.borderWidth = 1
        //profileView.layer.borderColor = UIColor.systemIndigo.cgColor
        plusBtn.layer.cornerRadius = 19
        dateFormatter.dateFormat = "yyyy-MM-dd"
        calendarView.delegate = self
        calendarView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
    }
    
    @IBAction func plusSmokeCount(_ sender: UIButton) {
        DispatchQueue.main.async {
            SmokeAmountDataManager().addSmokeAmount()
        }
        Constants.RECENTLY_SMOKE_TIME = Date()
        
        todaySetup()
    }
    
    @IBAction func goToDetail(_ sender: UIButton) {
        let detailVC = MyPageDetailVC()
        detailVC.modalPresentationStyle = .overFullScreen
        self.present(detailVC, animated: true, completion: nil)
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
    
    // 초기화면 오늘 날짜로 된 설정
    func todaySetup() {
        
        selectedDateLbl.text = "\(Constants.CURRENT_YEAR)년\(Constants.CURRENT_MONTH)월\(Constants.CURRENT_DAY)일"
       
        DaySmokeDataManager().getDaySmokeAmount(Constants.CURRENT_YEAR, Constants.CURRENT_MONTH, Constants.CURRENT_DAY, viewController: self)
        DaySmokeDataManager().getDaySmokeInfo(Constants.CURRENT_YEAR, Constants.CURRENT_MONTH, Constants.CURRENT_DAY, viewController: self)
        
//        for _ in 0 ..< 7 {
//            MyPageDetailDataManager().getDaySmokeResult(year, month, day, viewController: MyPageDetailVC())
//        }
        
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
        let year = HeaderHomeVC().getYear(date)
        let month = HeaderHomeVC().getMonth(date)
        let day = HeaderHomeVC().getDay(date)
        
        selectedDateLbl.text = "\(year)년\(month)월\(day)일"
       
        DaySmokeDataManager().getDaySmokeAmount(year, month, day, viewController: self)
        DaySmokeDataManager().getDaySmokeInfo(year, month, day, viewController: self)
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
        
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HeaderMyPageVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smokeInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderMyPageTableCell", for: indexPath) as? HeaderMyPageTableCell  else {
            return UITableViewCell()
        }
        
        let time = smokeInfo[indexPath.row].createdDate
        
        var firstIndex = time.index(time.startIndex, offsetBy: 0)
        var lastIndex = time.index(time.startIndex, offsetBy: 10)
        
        cell.title.text = "\(time[firstIndex..<lastIndex])"
        
        firstIndex = time.index(time.startIndex, offsetBy: 11)
        lastIndex = time.index(time.endIndex, offsetBy: 0)
        
        cell.smokeTime.text = "\(time[firstIndex..<lastIndex])"
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if indexPath.row == 4 && titleData[4] == "로그아웃" {
//            UserApi.shared.logout {(error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    DispatchQueue.main.async {
//                        self.profileImage.image = UIImage(systemName: "person")
//                        self.userName.text = "사용자"
//                        self.check = 1
//                        tableView.reloadData()
//                    }
//                }
//            }
//        }
//        else {
//            self.dismiss(animated: true)
//        }
//    }
    
}

