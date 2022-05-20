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

   
    // MapManager에서 맵 받아서 거리순으로 Map List 받기
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
       
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension MapListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapList", for: indexPath) as? MapListViewCell else{
            return UICollectionViewCell()
        }
        
        cell.updateUI()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //collectionView 지우고 다시 할 수 있어야 할 듯?

        //return MapManager.shared.mapList.count
        return 5
    }
}
    
extension MapListViewController: UICollectionViewDelegate{
    
}
    
extension MapListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let height = CGFloat(285) // 수정 필요
        return CGSize(width: width, height: height)
    }
}

