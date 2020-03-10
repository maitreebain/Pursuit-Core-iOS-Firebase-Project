//
//  PostsViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

enum segmentStates {
    case threeCells
    case oneCell
}

class UserViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var collectionOptions: UISegmentedControl!
    @IBOutlet weak var userPostCollection: UICollectionView!
    
    private var listener: ListenerRegistration?
    
    private var instaPost = [PostModel]() {
        didSet {
            DispatchQueue.main.async {
                self.userPostCollection.reloadData()
            }
            if instaPost.isEmpty {
                self.userPostCollection.backgroundView = EmptyView(title: "No Posts Available", message: "Consider making a post!")
            } else {
                self.userPostCollection.backgroundView = nil
            }
        }
    }
    
    private var segmentState = segmentStates.threeCells {
        didSet{
            if segmentState == .threeCells {
                 segmentState = segmentStates.threeCells
            } else {
                 segmentState = segmentStates.oneCell
            }
            userPostCollection.reloadData()
        }
    }
     
    private var selectedCVSegment: Int = 0 {
        didSet{
            switch collectionOptions.selectedSegmentIndex {
            case 0:
                segmentState = .threeCells
            case 1:
                segmentState = .oneCell
            default:
                segmentState = .threeCells
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userPostCollection.delegate = self
        userPostCollection.dataSource = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        userName.text = user.displayName
        profileImage.kf.setImage(with: user.photoURL)
        
        listener = Firestore.firestore().collection(DatabaseService.userPost).addSnapshotListener({ [weak self] (snapshot, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Firestore Error", message: "\(error.localizedDescription)")
                }
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map { PostModel($0.data())}
                self?.instaPost = posts
            }
        })

    }
    
    
    @IBAction func editProfPressed(_ sender: UIButton) {
        let profVC = ProfileViewController()
        navigationController?.pushViewController(profVC, animated: true)
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if collectionOptions.selectedSegmentIndex == 0 {
            segmentState = .threeCells
        } else {
            segmentState = .oneCell
        }
    }
}

extension UserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if segmentState == .threeCells {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 11
        let numberOfItems: CGFloat = 3
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        let itemHeight: CGFloat = maxSize.height * 0.2
        return CGSize(width: itemWidth, height: itemHeight)
        } else {
            let maxWidth = UIScreen.main.bounds.size
            let itemWidth: CGFloat = maxWidth.width * 0.90
            let itemHeight: CGFloat = maxWidth.height * 0.50
            return CGSize(width: itemWidth, height: itemHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    }
}

extension UserViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instaPost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPostCell", for: indexPath) as? UserPostCell else {
            fatalError("could not downcast to UserPostCell")
        }
        let post = instaPost[indexPath.row]
        cell.configureCell(for: post)
        return cell
    }
}
