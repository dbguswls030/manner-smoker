//
//  MyPageDetailVC.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/09.
//

import UIKit
import Charts

class MyPageDetailVC: UIViewController {

    @IBOutlet var dayBarGraphView: BarChartView!
    @IBOutlet var monthBarGraphView: BarChartView!
    @IBOutlet var yearBarGraphView: BarChartView!
    
    var xDayAxis : [String] = []
    var xDay : [Int] = []
    var dayEntries : [BarChartDataEntry] = []
    var xMonthAxis : [String] = []
    var monthEntries : [BarChartDataEntry] = []
    var xYearAxis : [String] = []
    var yearEntries : [BarChartDataEntry] = []
    var dayValueR : [DayResponse] = []
    var monthValueR : [MonthResponse] = []
    var yearValueR : [YearResponse] = []
    var dayValue : [Int] = [0, 2, 3, 17, 0]
    var monthValue : [Int] = [0, 0, 0, 22, 0, 0]
    var yearValue : [Int] = [0, 0, 0, 22, 0, 0]
    var values : [Int] = [2,6,1,3,6,1,4]
    
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDays()
        getXday()
        getMonth()
        getYear()
        setDayGraph()
        setMonthGraph()
        setYearGraph()
        // Do any additional setup after loading the view.
    }
    


    @IBAction func backToMyPage(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // 오늘 날짜부터 일주일 날짜 구하기
    func getDays() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        
        for i in -3 ..< 4 {
            xDayAxis.append(formatter.string(from: Date() + TimeInterval(i * 86400)))
        }
    }
    
    func getXday() {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        for i in -3 ..< 4 {
            let day = Int(formatter.string(from: Date() + TimeInterval(i * 86400)))
            xDay.append(day!)
        }
        print("$$$$$$$$$$$$$$$")
        print(xDay)
        getDayValues()
    }
    
    // 월 구하기
    func getMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        
        for i in -3 ..< 4 {
            xMonthAxis.append(formatter.string(from: Date() + TimeInterval(i * 86400 * 31)))
        }
        getMonthValues()
    }
    
    // 년도 구하기
    func getYear() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        for i in -3 ..< 4 {
            xYearAxis.append(formatter.string(from: Date() + TimeInterval(i * 86400 * 365)))
        }
        getYearValues()
    }
    
    // dayValue 값 세팅
    func getDayValues() {
        for day in xDay {
            let year = HeaderMyPageVC().getYear(Date())
            let month = HeaderMyPageVC().getMonth(Date())
            print(day)
            print(year)
            print(month)
            print(xDay)
            
            MyPageDetailDataManager().getDaySmokeResult(year, month, day, viewController: self)
            dayValue.append(dayValueR.count)
            
        }
        print(dayValue)
    }
    
    // monthValue 값 세팅
    func getMonthValues() {
        for month in xMonthAxis {
            let year = HeaderMyPageVC().getYear(Date())
            
            MyPageDetailDataManager().getMonthSmokeResult(year, Int(month)!, viewController: self)
            monthValue.append(monthValueR.count)
        }
    }
    
    // yearValue 값 세팅
    func getYearValues() {
        for year in xYearAxis {
           
            MyPageDetailDataManager().getYearSmokeResult(Int(year)!, viewController: self)
            yearValue.append(yearValueR.count)
        }
    }
    
    // day 그래프 세팅
    func setDayGraph() {
        for i in 0 ..< xDayAxis.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dayValue[i]))
            dayEntries.append(dataEntry)
        }
        
        let valFormatter = NumberFormatter()
        valFormatter.generatesDecimalNumbers = false
    
        let chartDataSet = BarChartDataSet(entries:dayEntries, label: "일별 흡연량")
        chartDataSet.colors = [.systemIndigo]
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        dayBarGraphView.doubleTapToZoomEnabled = false
        
        let chartData = BarChartData(dataSet: chartDataSet)
        //chartData.setValueFormatter(formatter)
        dayBarGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
                
        dayBarGraphView.data = chartData
        dayBarGraphView.xAxis.labelPosition = .bottom
        dayBarGraphView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xDayAxis)
        dayBarGraphView.xAxis.setLabelCount(xDayAxis.count, force: false)
        dayBarGraphView.rightAxis.enabled = false
        dayBarGraphView.leftAxis.enabled = false
        dayBarGraphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        dayBarGraphView.backgroundColor = .systemGray6
        dayBarGraphView.xAxis.drawGridLinesEnabled = false
        dayBarGraphView.leftAxis.drawGridLinesEnabled = false
        //dayBarGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: valFormatter) // y축 정수
    }
    
    // 월별 그래프 세팅
    func setMonthGraph() {
        for i in 0 ..< xMonthAxis.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(monthValue[i]))
            monthEntries.append(dataEntry)
        }
        
        let valFormatter = NumberFormatter()
        valFormatter.generatesDecimalNumbers = false
    
        let chartDataSet = BarChartDataSet(entries:monthEntries, label: "월별 흡연량")
        chartDataSet.colors = [.systemIndigo]
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        monthBarGraphView.doubleTapToZoomEnabled = false
        
        let chartData = BarChartData(dataSet: chartDataSet)
        //chartData.setValueFormatter(formatter)
        monthBarGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
                
        monthBarGraphView.data = chartData
        monthBarGraphView.xAxis.labelPosition = .bottom
        monthBarGraphView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xMonthAxis)
        monthBarGraphView.xAxis.setLabelCount(xDayAxis.count, force: false)
        monthBarGraphView.rightAxis.enabled = false
        monthBarGraphView.leftAxis.enabled = false
        monthBarGraphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        monthBarGraphView.backgroundColor = .systemGray6
        monthBarGraphView.xAxis.drawGridLinesEnabled = false
        monthBarGraphView.leftAxis.drawGridLinesEnabled = false
        //dayBarGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: valFormatter) // y축 정수
    }
    
    // 년도별 그래프 세팅
    func setYearGraph() {
        for i in 0 ..< xYearAxis.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(yearValue[i]))
            yearEntries.append(dataEntry)
        }
        
        let valFormatter = NumberFormatter()
        valFormatter.generatesDecimalNumbers = false
    
        let chartDataSet = BarChartDataSet(entries:yearEntries, label: "년별 흡연량")
        chartDataSet.colors = [.systemIndigo]
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        yearBarGraphView.doubleTapToZoomEnabled = false
        
        let chartData = BarChartData(dataSet: chartDataSet)
        //chartData.setValueFormatter(formatter)
        yearBarGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
                
        yearBarGraphView.data = chartData
        yearBarGraphView.xAxis.labelPosition = .bottom
        yearBarGraphView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xYearAxis)
        yearBarGraphView.xAxis.setLabelCount(xDayAxis.count, force: false)
        yearBarGraphView.rightAxis.enabled = false
        yearBarGraphView.leftAxis.enabled = false
        yearBarGraphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        yearBarGraphView.backgroundColor = .systemGray6
        yearBarGraphView.xAxis.drawGridLinesEnabled = false
        yearBarGraphView.leftAxis.drawGridLinesEnabled = false
        //dayBarGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: valFormatter) // y축 정수
    }

}
