//
//  MapListViewCell.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/16.
//

import Foundation

class MapListViewCell: UICollectionViewCell{
    @IBOutlet var locationImage: UIImageView!
    @IBOutlet var locationName: UILabel!
    @IBOutlet var distance: UILabel!
    
    func updateUI(num: Int, map: MapListViewModel){
        self.locationName.text = "\(num+1)번째로 가까운 곳"
        if map.distance*1000 < 1000{
            self.distance.text = "\(String(format: "%.f", map.distance*1000))m"
        }else{
            self.distance.text = "\(String(format: "%.2f", map.distance))km"
        }
        
    }
}
