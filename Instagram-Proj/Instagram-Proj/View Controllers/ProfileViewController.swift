//
//  ProfileViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

class ProfileViewController: UIViewController {
    
    let profView = ProfView()
    
    override func loadView() {
        view = profView
        
    }
    private let storageService = StorageService()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(updateUserImage))
        return gesture
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profView.userImage.addGestureRecognizer(tapGesture)
        profView.updateProfButton.addTarget(self, action: #selector(updateProf(_:)), for: .touchUpInside)
        
        profView.backgroundColor = .systemGroupedBackground
        profView.userName.delegate = self
        updateUI()
    }
    
    @objc private func updateProf(_ sender: UIButton){
        guard let displayName = profView.userName.text, !displayName.isEmpty, let selectedImage = profView.selectedImage, let bioText = profView.bioText.text, !bioText.isEmpty else {
            self.showAlert(title: "Missing Fields", message: "Please check all fields")
            return
        }
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: profView.userImage.bounds)
        
        print("orig \(selectedImage.size) not orig \(resizedImage)")
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        storageService.uploadImage(userID: user.uid, image: resizedImage) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error uploading photo", message: "\(error.localizedDescription)")
                    print("\(error.localizedDescription)")
                }
            case .success(let url):
                let request = Auth.auth().currentUser?.createProfileChangeRequest()
                request?.displayName = displayName
                request?.photoURL = url
                request?.commitChanges(completion: { [weak self] error in
                    
                    if let error = error {
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Error updating profile", message: "Error changing profile error: \(error.localizedDescription)")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Profile Update", message: "Profile successfully updated")
                        }
                    }
                })
            }
        }
        
    }
    
    func updateUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        profView.emailLabel.text = user.email
        profView.userName.text = user.displayName
        
        profView.userImage.kf.setImage(with: user.photoURL)
    }
    
    @objc private func updateUserImage() {
        let alertController = UIAlertController(title: "Choose photo option", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {
            alertAction in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        let photolibraryAction = UIAlertAction(title: "Photo Library", style: .default) {
            alertAction in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photolibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        profView.selectedImage = image
        dismiss(animated: true)
    } 
}


