//
//  MapViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/03/29.
//

import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController, MTMapViewDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet var subView: UIView!
    @IBOutlet var tabbar: UITabBarItem!
    @IBOutlet var searchTextField: UITextField!
    
    var mtMapView: MTMapView!
    
    @IBAction func setCurrentPoint(_ sender: Any) {
        setCurrentMapPoint()
    }
    
    
    
//    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
//        let currentLocation = location.mapPointGeo()
//        MTMapPointGeo(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMapView()
        initTextField()
        setLoactionData()
        hideKeyboard()
        
    }
    
    func initMapView(){
        self.mtMapView = MTMapView(frame: self.subView.frame)

        mtMapView.delegate = self
        mtMapView.baseMapType = .standard

//        mtMapView.showCurrentLocationMarker = true
//        mtMapView.currentLocationTrackingMode = .onWithoutHeading
        
        self.mtMapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.566640, longitude: 126.977458)), animated: true) // 서울시청으로 좌표 초기화
       
        self.subView.addSubview(mtMapView)
        
        initMapPoint()
        setMapViewConstraint()
    }
    
    func setMapViewConstraint(){
        self.mtMapView.leadingAnchor.constraint(equalTo: self.subView.leadingAnchor).isActive = true
        self.mtMapView.trailingAnchor.constraint(equalTo: self.subView.trailingAnchor).isActive = true
        self.mtMapView.topAnchor.constraint(equalTo: self.subView.topAnchor).isActive = true
        self.mtMapView.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor).isActive = true
    }
    
    

}
extension MapViewController: CLLocationManagerDelegate{
    
    func setLoactionData(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리 정확도
        self.locationManager.requestWhenInUseAuthorization() //위치 데이터 활용 동의 요청
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func setCurrentMapPoint(){
        // CLLocation 써서 해야함
        // 위치 권한 허가 시에만 동작 가능하도록
        // 위치 권한 없을 시에 다시 권한 업하라는 메시지 추가해야함
//        let currentLocation = MTMapPoint(geoCoord: MTMapPointGeo(latitude: self.locationManager.location?.coordinate.latitude ?? 37.566640, longitude: self.locationManager.location?.coordinate.longitude ?? 126.977458))
        let currentLocation = MTMapPoint(geoCoord: .init(latitude: 37.566640, longitude: 126.977458))
        self.mtMapView.setMapCenter(currentLocation, animated: true)
    }
    
    func initMapPoint(){
        let poiItem1 = MTMapPOIItem()
        poiItem1.markerType = .bluePin
        poiItem1.mapPoint =  MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.566640, longitude: 126.977458))
        poiItem1.itemName = "서울시청"
        self.mtMapView.addPOIItems([poiItem1])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 위치 권한 "허가" 동작
        if let location = locations.first{
            print("x: \(location.coordinate.latitude)")
            print("y: \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 위치 권한 "불허가" 동작
        print("locationManager : updateLocation error")
    }
}

extension MapViewController: UITextFieldDelegate{
    func initTextField(){
        self.searchTextField.delegate = self
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.searchTextField{
            
            guard let searchKeyword = self.searchTextField.text, searchKeyword.count > 1 else{
                //팝업창
                print("두 글자 이상 입력해주세요..")
                return true
            }
            
            self.searchTextField.placeholder = self.searchTextField.text
            self.view.endEditing(true)
            let model = SearchLoactionWithAddressRequestModel(query: searchKeyword)
            MapManager.shared.requestLocationWithAddress(model: model) { response in
                
                if let item = response.documents.first{
                    let x = Double(item.x)!
                    let y = Double(item.y)!
                    // Double 캐스팅 오류 처리
                    let convertedLocation = MTMapPoint(geoCoord: MTMapPointGeo(latitude: y, longitude: x))
                    self.mtMapView.setMapCenter(convertedLocation, animated: true)
                }else{
                    // 팝업 창
                    print("검색 결과를 찾을 수 없습니다.")
                }
            }
            
            
            
        }
        return true
    }
    @IBAction func didEditingThenMoveMap(_ sender: Any) {
        
        self.searchTextField.text = ""
        self.view.endEditing(true)
        
    }
}
