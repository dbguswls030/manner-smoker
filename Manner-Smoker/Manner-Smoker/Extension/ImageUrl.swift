//
//  ImageUrl.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/06/14.
//


import UIKit

extension UIImageView {
    func load(url : String) {
        guard let url = URL(string: url) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
