//
//  BoardViewController.swift
//  Manner-Smoker
//
//  Created by 유현진 on 2022/05/27.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var textViewBox: UIView!
    @IBOutlet var textViewBottom: NSLayoutConstraint!
    @IBOutlet var textHeightConstraint: NSLayoutConstraint!
    @IBOutlet var textView: UITextView!
    @IBOutlet var textEditFinishButton: UIButton!
    var postId: Int?
    var userId: Int?
    var boardViewModel = BoardViewModel()
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
        initTextView()
        initBoardViewModel()
        initNavigationBarItem()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitKeyboardNotification()
        
    }
    func initBoardViewModel(){
        if let postId = postId {
            boardViewModel.postId = postId
            boardViewModel.getPost {
                self.boardViewModel.getReley {
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func commentEditFinish(_ sender: Any) {
        if let postId = postId {
            CommunityManager.shared.CreatedReply(model: CreateReplyRequestModel(postId: postId, replyContent: textView.text, userId: 1))
            self.textView.text = ""
            self.textView.resignFirstResponder()
            self.textEditFinishButton.isHidden = true
            initBoardViewModel()
//            self.collectionView.reloadData()
        }
        
    }
    func initNavigationBarItem(){
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(back))
        backButton.tintColor = .darkGray
        self.navigationItem.leftBarButtonItem = backButton
        
        if let userId = userId, userId == 1 {
            let deleteButton = UIBarButtonItem(title: "삭제", style: .done, target: self, action: #selector(postDelete))
            //        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(postDelete))
            deleteButton.tintColor = .darkGray
            
            let updateButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(postUpdate))
            updateButton.tintColor = .darkGray
            self.navigationItem.rightBarButtonItems = [deleteButton, updateButton]
        }
        
    }
    @objc func postDelete(){
        CommunityManager.shared.deletePost(model: DeletePostRequestModel(postId: boardViewModel.getPostId())) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func postUpdate(){
        // Write 으로 넘어가면서 글 내용 복사
        let storyboard = UIStoryboard(name: "Write", bundle: Bundle.main)
        guard let updateVC = storyboard.instantiateViewController(identifier: "WirteView") as? WriteViewController else{
            return
        }
        updateVC.hidesBottomBarWhenPushed = true
        updateVC.tabBarController?.tabBar.isHidden = true
        updateVC.modalPresentationStyle = .fullScreen
        updateVC.contentViewModel = boardViewModel.postResponse
        updateVC.updateFlag = true
//        WriteVC.preView = self.collectionView
        self.present(updateVC, animated: true)
    }
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
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
            self.textViewBottom.constant = -(keyboardSize.height - self.view.safeAreaInsets.bottom)
        }
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification){
            self.textViewBottom.constant = 0
    }

}
extension BoardViewController: UITextViewDelegate{
    func initTextView(){
        self.textEditFinishButton.isHidden = true
        self.textView.delegate = self
        self.textView.text = "댓글을 입력해주세요."
        self.textView.textColor = UIColor.lightGray
        self.textView.layer.cornerRadius = 10
        self.textView.isScrollEnabled = false
        self.textView.sizeToFit()
        self.textView.textContainerInset = .init(top: CGFloat(8), left: CGFloat(8), bottom: CGFloat(8), right: self.textEditFinishButton.bounds.size.width+CGFloat(8))
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "댓글을 입력해주세요."
            textView.textColor = UIColor.lightGray
        }
        
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty{
            if textEditFinishButton.isHidden == false{
                textEditFinishButton.isHidden = true
            }
        }else{
            if textEditFinishButton.isHidden == true{
                textEditFinishButton.isHidden = false
            }
        }
           
        
        let size = CGSize(width: self.textView.bounds.size.width, height: .infinity)
        let estimatedSize = self.textView.sizeThatFits(size)
        let isMaxHeight = estimatedSize.height >= 100
        if !isMaxHeight{
            self.textHeightConstraint.constant = estimatedSize.height
        }
        guard isMaxHeight != self.textView.isScrollEnabled else { return }
        self.textView.isScrollEnabled = isMaxHeight
        self.textView.reloadInputViews()
        self.textView.setNeedsUpdateConstraints()
    }
    
}

extension BoardViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentViewHeader", for: indexPath) as? BoardCollectionReusableView else{
                return UICollectionReusableView()
            }
//            if let viewModel = self.contentViewModel{
//                header.updateUI(item: viewModel)
//            }
            if let item = boardViewModel.postResponse{
                header.updateUI(item: item)
            }
            
            return header
        default: return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardViewModel.numOfCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentViewCell", for: indexPath) as? BoardCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.delete = { [unowned self] in
            CommunityManager.shared.deleteReply(model: DeleteReplyRequestModel(replyId: boardViewModel.replyResponse[indexPath.item].replyId)){ [unowned self] in
                self.initBoardViewModel()
//                self.collectionView.reloadData()
            }
        }
        cell.updateUI(item: boardViewModel.replyResponse[indexPath.item])
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
        
        let height = 15 + profileImage + 15 + 1 + 20 + content + 15 + image + 25 + 1 + 3 + commentLabel + 3 + 1
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentViewCell", for: indexPath) as? BoardCollectionViewCell else{
            return CGSize(width: width, height: 130)
        }
        
        let image = cell.profileImage.bounds.height
        let comment = cell.comment.bounds.height
        let height = 1 + 15 + image + 5 + comment + 5 + 1
        return CGSize(width: width, height: height)
    }
}


