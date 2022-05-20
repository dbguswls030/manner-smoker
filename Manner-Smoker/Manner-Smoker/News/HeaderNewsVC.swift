//
//  HeaderNewsVC.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/05/20.
//

import UIKit

class HeaderNewsVC: UIViewController {

    @IBOutlet var newsCV: UICollectionView!
    
    let newsImage : [UIImage] = [UIImage(named: "news1")!, UIImage(named: "news2")!, UIImage(named: "news3")!, UIImage(named: "news1")!, UIImage(named: "news2")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        newsCV.delegate = self
        newsCV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    private func registerNib() {
        let nibName = UINib(nibName: "NewsCollectionViewCell", bundle: nil)
        newsCV.register(nibName, forCellWithReuseIdentifier: "NewsCell")
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension  HeaderNewsVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newsCV.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
        cell.newsImage.image = newsImage[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: newsCV.frame.size.width  , height:  newsCV.frame.height)
        }
    
}
