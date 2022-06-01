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
    
    @IBOutlet var kakaoMapView: UIView!
    @IBOutlet var tabbar: UITabBarItem!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var currentButton: UIButton!
    @IBOutlet var zoomInButton: UIButton!
    @IBOutlet var zoomOutButton: UIButton!
    @IBOutlet var mapListButton: UIButton!
    
    var mtMapView: MTMapView!
    var tapped = false
    
    @IBAction func setCurrentPoint(_ sender: Any) {
        setCurrentMapPoint()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initMapView()
        initTextField()
        initStyle()
        setLoactionData()
        hideKeyboard()
        self.tabBarController?.hidesBottomBarWhenPushed = true
        
    }
    func initStyle(){
        self.currentButton.layer.cornerRadius = 3
        self.zoomInButton.layer.cornerRadius = 3
        self.zoomOutButton.layer.cornerRadius = 3
        self.mapListButton.layer.cornerRadius = 3
    }

    func initMapView(){
        self.mtMapView = MTMapView(frame: self.kakaoMapView.frame)
        mtMapView.delegate = self
        mtMapView.baseMapType = .standard
        mtMapView.showCurrentLocationMarker = true
        mtMapView.currentLocationTrackingMode = .onWithoutHeading
//        self.mtMapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.566640, longitude: 126.977458)), animated: true)
        self.kakaoMapView.addSubview(mtMapView)
        initMapPoint()
        setMapViewConstraint()
    }
    
    func setMapViewConstraint(){
        self.mtMapView.leadingAnchor.constraint(equalTo: self.kakaoMapView.leadingAnchor).isActive = true
        self.mtMapView.trailingAnchor.constraint(equalTo: self.kakaoMapView.trailingAnchor).isActive = true
        self.mtMapView.topAnchor.constraint(equalTo: self.kakaoMapView.topAnchor).isActive = true
        self.mtMapView.bottomAnchor.constraint(equalTo: self.kakaoMapView.bottomAnchor).isActive = true
    }
    //    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
    //        let currentLocation = location.mapPointGeo()
    //        MTMapPointGeo(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
    //    }
    
    
    @IBAction func showMapList(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MapListView", bundle: Bundle.main)
        let bottomSheetVC = storyboard.instantiateViewController(identifier: "MapListView")
        
        guard let sheet = bottomSheetVC.presentationController as? UISheetPresentationController else{
            return
        }
        sheet.detents = [.medium(), .large()]
        sheet.largestUndimmedDetentIdentifier = .large
        sheet.prefersGrabberVisible = true
        
        self.present(bottomSheetVC, animated: true)
        
    }
    
    
    @IBAction func zoomIn(){
        mtMapView.zoomIn(animated: true)
    }
    @IBAction func zoomOut(){
        mtMapView.zoomOut(animated: true)
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        if self.searchTextField.isFirstResponder {
            searchTextField.resignFirstResponder()
        }else{
            if tapped == false{
                hideUI()
                tapped = true
            }else{
                displayUI()
                tapped = false
            }
        }

    }
    func hideUI(){
        UIView.animate(withDuration: 0.5){
            self.searchTextField.alpha = 0
            self.zoomInButton.alpha = 0
            self.zoomOutButton.alpha = 0
            self.currentButton.alpha = 0
            self.mapListButton.alpha = 0
            self.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
        }
    }
    func displayUI(){
        UIView.animate(withDuration: 0.5){
            self.searchTextField.alpha = 1
            self.zoomInButton.alpha = 1
            self.zoomOutButton.alpha = 1
            self.currentButton.alpha = 1
            self.mapListButton.alpha = 1
            let heigh = self.tabBarController?.tabBar.frame.height ?? 0
            self.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - heigh)
        }
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
        if let locations = locationManager.location{
            let currentLocation = MTMapPoint(geoCoord: MTMapPointGeo(latitude: locations.coordinate.latitude, longitude: locations.coordinate.longitude))
            self.mtMapView.setMapCenter(currentLocation, animated: true)
        }else{
            //현재 위치 불가능
        }
    }
    
    func initMapPoint(){ // 벡엔드에서 받아와서 마커 표시
        let poiItem1 = MTMapPOIItem()
        poiItem1.markerType = .bluePin
        poiItem1.mapPoint =  MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.566640, longitude: 126.977458))
        poiItem1.itemName = "서울시청"
        self.mtMapView.addPOIItems([poiItem1])
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        // 위치 권한 "허가" 동작
////        if let location = locations.first{
////            print("x: \(location.coordinate.latitude)")
////            print("y: \(location.coordinate.longitude)")
////        }
//        print("locationManager : updateLocation success")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        // 위치 권한 "불허가" 동작
//        print("locationManager : updateLocation error")
//    }
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
