//
//  BoardViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/27.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var textFieldView: UIView!
    @IBOutlet var textFieldBox: NSLayoutConstraint!
    var textViewYValue = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitKeyboardNotification()
    }
    
    func initKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deinitKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification){
        if let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            self.textFieldBox.constant = -(keyboardSize.height - self.view.safeAreaInsets.bottom)
        }
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification){
            self.textFieldBox.constant = 0
    }
    
    
    
}

extension BoardViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentViewHeader", for: indexPath) as? BoardCollectionReusableView else{
                return UICollectionReusableView()
            }
            
            return header
        default: return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentViewCell", for: indexPath) as? BoardCollectionViewCell else{
            return UICollectionViewCell()
        }
        return cell
    }
}

extension BoardViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        let indexPath = IndexPath(row: 0, section: section)
        guard let header = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? BoardCollectionReusableView else{
            return CGSize(width: width, height: 401.5)
        }
        let profileImage = header.profileImage.bounds.height
        let image = header.image.bounds.height
        let content = header.contents.bounds.height
        let commentLabel = header.commentCount.bounds.height
        
        let height = 15 + profileImage + 15 + 1 + 20 + content + 15 + image + 25 + 1 + 5 + commentLabel + 5 + 1
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentViewCell", for: indexPath) as? BoardCollectionViewCell else{
            return CGSize(width: width, height: 130)
        }
        
        let image = cell.profileImage.bounds.height
        let comment = cell.comment.bounds.height
        let height = 1 + 15 + image + 15 + comment + 15 + 1
        return CGSize(width: width, height: height)
    }
}


