//
//  MapListViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/16.
//

import UIKit

class MapListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mapListView: UIView!
    var heightConstraint : NSLayoutConstraint?
    var bottomConstraint : NSLayoutConstraint?
    var currentPoint: MTMapPointGeo?
    
    var maps = [MapListViewModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
       
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        maps.removeAll()
        collectionView.reloadData()
    }
    func getMaps(maps: [Map]){
        self.maps.removeAll()
        guard let currentPoint = currentPoint else {
            print("currentPoint binding")
            return
        }

        for map in maps{
            self.maps.append(MapListViewModel(map: map, distance: getDistance(p1: currentPoint, p2: map)))
        }
        self.maps.sort { $0.distance < $1.distance }
    }
    func getCurrentPoint(point: MTMapPointGeo){
        self.currentPoint = point
    }
    func getDistance(p1: MTMapPointGeo, p2: Map) -> Double{
//        X = ( cos( 위도#1 ) * 6400 * 2 * 3.14 / 360 ) * | 경도#1 - 경도#2 |
//        Y = 111 * | 위도#1 - 위도#2 |
//        D = √ ( X² + Y² )
        let x = (cos(p1.latitude) * 6400 * 2 * 3.14 / 360) * abs(p1.longitude - p2.longitude)
        let y = 111 * abs(p1.latitude-p2.latitude)
        return Double(sqrt(pow(x,2.0) + pow(y, 2.0)))
    }
}

extension MapListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapList", for: indexPath) as? MapListViewCell else{
            return UICollectionViewCell()
        }
        
        cell.updateUI(num: indexPath.item, map: maps[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //collectionView 지우고 다시 할 수 있어야 할 듯?
        return self.maps.count
    }
}
    
extension MapListViewController: UICollectionViewDelegate{
    // 카카오맵 길찾기로 이동
    // 셀 누르면 팝업 화면, 카카오맵을 여시곘습니까?
    // 카카오맵 길찾기
    // 카카오맵 없으면 바아로 앱스토어 ㄱ
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = maps[indexPath.item]
        guard let currentPoint = currentPoint else{
            return
        }
        let url = "kakaomap://route?sp=\(currentPoint.latitude),\(currentPoint.longitude)&ep=\(item.map.latitude),\(item.map.longitude)&by=FOOT"
        
        if let openKakaoMap = URL(string: url), UIApplication.shared.canOpenURL(openKakaoMap){
            if #available(iOS 10.0, *){
                UIApplication.shared.open(openKakaoMap, options: [:], completionHandler: nil)
            }else{
                UIApplication.shared.openURL(openKakaoMap)
            }
        }else{
            // [팝업] 카카오맵이 없습니다. 앱스토어로 이동하시겠습니까 yes일 시에 이동
            if let openAppStoreForKakaoMap = URL(string: "https://apps.apple.com/us/app/id304608425"), UIApplication.shared.canOpenURL(openAppStoreForKakaoMap){
                UIApplication.shared.open(openAppStoreForKakaoMap)
            }
        }
    }
}
    
extension MapListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width - 20 - 20
        let height = CGFloat(270) // 수정 필요
        return CGSize(width: width, height: height)
    }
}

