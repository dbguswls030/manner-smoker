//
//  HeaderNewsVC.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/05/20.
//

import UIKit
import SafariServices

class HeaderNewsVC: UIViewController {

    @IBOutlet var newsCV: UICollectionView!
    
    let newsImage : [UIImage] = [UIImage(named: "news1")!, UIImage(named: "news2")!, UIImage(named: "news3")!, UIImage(named: "news1")!, UIImage(named: "news2")!]
    let newsURL : [NSURL?] = [NSURL(string: "https://m.post.naver.com/viewer/postView.naver?volumeNo=33117035&memberNo=49031850"), NSURL(string: "https://brunch.co.kr/@dbwogy/11"), NSURL(string: "https://brunch.co.kr/@sat09am/19") ]
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let blogSafariView : SFSafariViewController = SFSafariViewController(url: newsURL[indexPath.row % 3]! as URL)
        self.present(blogSafariView, animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: newsCV.frame.size.width  , height:  newsCV.frame.height)
        }
    
}
