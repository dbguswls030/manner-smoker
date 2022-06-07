//
//  MapListViewModel.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/06/07.
//

import Foundation
struct MapListViewModel{
    let map: Map
    let distance: Double
    init(map: Map, distance: Double){
        self.map = map
        self.distance = distance
    }
}
