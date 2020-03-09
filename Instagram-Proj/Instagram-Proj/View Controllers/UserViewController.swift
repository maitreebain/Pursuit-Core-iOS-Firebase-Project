//
//  PostsViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseFirestore

class UserViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var collectionOptions: UISegmentedControl!
    @IBOutlet weak var userPostCollection: UICollectionView!
    
    private var listener: ListenerRegistration?
    
//    private var instaPost = [PostModel]() {
//        self.userPostCollection.reload
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userPostCollection.delegate = self
        userPostCollection.dataSource = self
    }
    
    
    @IBAction func editProfPressed(_ sender: UIButton) {
        let profVC = ProfileViewController()
        present(profVC, animated: true)
    }
}

extension UserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 3
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
    }
}

extension UserViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPostCell", for: indexPath)
        return cell
    }
}
