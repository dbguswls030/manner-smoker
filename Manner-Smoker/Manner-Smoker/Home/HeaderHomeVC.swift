//
//  HeaderHomeVC.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/05/20.
//

import UIKit

class HeaderHomeVC: UIViewController {
    
    var daySmokeAmount : Int = 0
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var statusImg: UIImageView!
    @IBOutlet var stausLbl: UILabel!
    
    @IBOutlet var notSmokingTerm: UILabel!
    @IBOutlet var retrenchMoney: UILabel!
    @IBOutlet var smokingTerm: UILabel!
    @IBOutlet var spendMoney: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.CURRENT_YEAR = getYear(Date())
        Constants.CURRENT_MONTH = getMonth(Date())
        Constants.CURRENT_DAY = getDay(Date())
        
        setBackGround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBackGround()
    }
    
    func setBackGround() {
        HomeDataManager().getDaySmokeAmountHome(Constants.CURRENT_YEAR, Constants.CURRENT_MONTH, Constants.CURRENT_DAY, viewController: self)
        
        setNotSmokingView()
        setSmokingView()
    }
    
    func setNotSmokingView() {
        var money = 0
        
        let myDateComponents = DateComponents(year: getYear(Constants.RECENTLY_SMOKE_TIME), month: getMonth(Constants.RECENTLY_SMOKE_TIME), day: getDay(Constants.RECENTLY_SMOKE_TIME))
        
        let startDate = Calendar.current.date(from: myDateComponents)!
        let offsetComps = Calendar.current.dateComponents([.year,.month,.day], from: startDate, to: Date())
        
        if case let (y?, m?, d?) = (offsetComps.year, offsetComps.month, offsetComps.day) {
            notSmokingTerm.text = "\(y)년 \(m)개월 \(d)일"
            money = (((y * 365) + (m * 30) + d) * Constants.STANDARD_SMOKE_AMOUNT) * 225
        }
        
        let value: NSNumber = money as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let resultValue = formatter.string(from: value) else { return }
        
        retrenchMoney.text = "\(resultValue)원"
    }
    
    func setSmokingView() {
        var money = 0
    
        let myDateComponents = DateComponents(year: getYear(Constants.START_SMOKE_DATE!), month: getMonth(Constants.START_SMOKE_DATE!), day: getDay(Constants.START_SMOKE_DATE!))
        
        let startDate = Calendar.current.date(from: myDateComponents)!
        
        let offsetComps = Calendar.current.dateComponents([.year,.month,.day], from: startDate, to: Date())
        
        if case let (y?, m?, d?) = (offsetComps.year, offsetComps.month, offsetComps.day) {
            smokingTerm.text = "\(y)년 \(m)개월 \(d)일"
            money = (((y * 365) + (m * 30) + d) * Constants.STANDARD_SMOKE_AMOUNT) * 225
        }
        
        let value: NSNumber = money as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let resultValue = formatter.string(from: value) else { return }
        
        spendMoney.text = "\(resultValue)원"
    }
    
    // 일 구하기
    func getDay(_ date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        let day = Int(formatter.string(from: date))
        
        return day!
    }
    
    // 월 구하기
    func getMonth(_ date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        
        let month = Int(formatter.string(from: date))
        
        return month!
    }
    
    // 년도 구하기
    func getYear(_ date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        let year = Int(formatter.string(from: date))
        
        return year!
    }
    
    
}




