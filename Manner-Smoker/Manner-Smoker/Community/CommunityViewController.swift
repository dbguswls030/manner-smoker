//
//  CommunityViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/24.
//

import UIKit

class CommunityViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel = CommunityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getResponses {
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func writeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Write", bundle: Bundle.main)
        guard let WriteVC = storyboard.instantiateViewController(identifier: "WirteView") as? WriteViewController else{
            return
        }
        WriteVC.hidesBottomBarWhenPushed = true
        WriteVC.tabBarController?.tabBar.isHidden = true
        WriteVC.modalPresentationStyle = .fullScreen
        self.present(WriteVC, animated: true)
        
    }
}
extension CommunityViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Board", bundle: Bundle.main)
        guard let boardVC = storyboard.instantiateViewController(identifier: "BoardView") as? BoardViewController else{
            return
        }
        boardVC.hidesBottomBarWhenPushed = true
        boardVC.tabBarController?.tabBar.isHidden = true
        boardVC.contentViewModel = viewModel.response[indexPath.item]
        self.navigationController?.pushViewController(boardVC, animated: true)
    }
}
extension CommunityViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumOfCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardList", for: indexPath) as? CommunityCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.updateUI(item: viewModel.response[indexPath.item])
        return cell
    }
}
extension CommunityViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardList", for: indexPath) as? CommunityCollectionViewCell else{
            return CGSize(width: width, height: 400)
        }
        let contents = cell.contents.bounds.height
        let image = cell.image.bounds.height
        let nickName = cell.nickName.bounds.height
        let commentLabel = cell.commentCount.bounds.height
        let height = 1 + 20 + contents + 20 + image + 20 + nickName + 10 + 1 + 3 + commentLabel + 3 + 1
        return CGSize(width: width, height: height)
    }
}
