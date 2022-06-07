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
        self.locationName.text = "\(num)번"
        self.distance.text = "\(String(format: "%.2f", map.distance*1000))m"
    }
}
