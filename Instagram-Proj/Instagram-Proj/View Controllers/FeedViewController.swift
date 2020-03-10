//
//  FeedViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/4/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FeedViewController: UIViewController {
    
    private let feedView = FeedView()
    
    private var listener: ListenerRegistration?
    private var databaseService = DatabaseService()
    
    private var posts = [PostModel]() {
        didSet {
            DispatchQueue.main.async {
                self.feedView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = feedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedView.collectionView.delegate = self
        feedView.collectionView.dataSource = self
        feedView.collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "feedCell")
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        listener = Firestore.firestore().collection(DatabaseService.userPost).addSnapshotListener({ [weak self] (snapshot, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Firestore Error", message: "\(error.localizedDescription)")
                }
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map { PostModel($0.data())}
                self?.posts = posts
            }
        })
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemSpacing: CGFloat = 1
            let maxWidth = UIScreen.main.bounds.size.width
            let numberOfItems: CGFloat = 1
            let totalSpace: CGFloat = numberOfItems * itemSpacing
            let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
            
            return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            fatalError("could not downcast to FeedCell")
        }
        let post = posts[indexPath.row]
        cell.configureCell(for: post)
        
        return cell
    }
}
