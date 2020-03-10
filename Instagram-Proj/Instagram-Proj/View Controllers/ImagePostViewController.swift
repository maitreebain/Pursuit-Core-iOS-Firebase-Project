//
//  ImagesViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ImagePostViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postDescript: UITextField!
    
    private let dbService = DatabaseService()
    private let storageService = StorageService()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private var selectedImage: UIImage? {
        didSet{
            postImage.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func photoLibraryPressed(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true)
        } else {
            showAlert(title: "No camera available!", message: "")
        }
    }
    
    
    @IBAction func makePostButtonPressed(_ sender: UIButton) {
        
        guard let postDescript = postDescript.text,
            !postDescript.isEmpty,
            let post = selectedImage else {
                showAlert(title: "Missing Fields", message: "Please add a description and an image")
                return
        }
        
        let resizedImage = UIImage.resizeImage(originalImage: post, rect: postImage.bounds)
        
        guard let displayName = Auth.auth().currentUser?.displayName else {
            DispatchQueue.main.async {
                self.showAlert(title: "Incomplete Profile", message: "Please complete your Profile")
            }
            return
        }
        
        dbService.createUserPost(description: postDescript, displayName: displayName) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error creating post", message: "Error: \(error.localizedDescription)")
                }
            case .success(let postID):
                self?.uploadPost(image: resizedImage, postID: postID)
            }
        }
    }
    
    private func uploadPost(image: UIImage, postID: String) {
        storageService.uploadImage(postID: postID, image: image) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error uploading post", message: "\(error.localizedDescription)")
                }
            case .success(let url):
                self?.updateImageURL(imageURL: url, postID: postID)
            }
        }
    }
    
    private func updateImageURL(imageURL: URL, postID: String) {
        Firestore.firestore().collection(DatabaseService.userPost).document(postID).updateData(["postImageURL" : imageURL.absoluteURL]) { [weak self] (error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Could not update post", message: "\(error.localizedDescription)")
                }
            } else {
                print("image was updated")
                DispatchQueue.main.async {
                    self?.showAlert(title: "Success!", message: "Updated post")
                }
            }
        }
    }
    
}

extension ImagePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("could not attain original image")
        }
        selectedImage = image
        dismiss(animated: true)
    }
}
