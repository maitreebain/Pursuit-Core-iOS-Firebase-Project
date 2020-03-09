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
        profView.userImage.addGestureRecognizer(tapGesture)
        profView.backgroundColor = .systemGroupedBackground
    }
    
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
        
        profView.userName.delegate = self
        updateUI()
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
        
    }
}

