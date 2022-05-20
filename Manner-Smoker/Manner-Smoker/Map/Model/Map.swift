//
//  Map.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/16.
//

import Foundation
class Map{ //codable
    var locationImage: UIImage?
    let locationName: String
    let distance: Int
    let x: Double
    let y: Double
    
    init(locationImage: UIImage, locationName: String, distance: Int, x: Double, y: Double){
        self.locationImage = UIImage(named: "noimage.png")
        self.locationName = locationName
        self.distance = distance
        self.x = x
        self.y = y
    }
    
}

