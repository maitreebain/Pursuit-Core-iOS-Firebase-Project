//
//  SignInViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

enum AccountState {
    case existingUser
    case newUser
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var accountActivateButton: UIButton!
    @IBOutlet weak var userAccountPromptButton: UIButton!
    @IBOutlet weak var userPrompt: UILabel!
    
    private var accountState = AccountState.existingUser
    
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            DispatchQueue.main.async {
                self.showAlert(title: "Missing Fields", message: "Please enter your e-mail/password")
            }
            return
        }
        
        //call email/pass func here
        continueLogin(email: email, password: password)
    }
    
    private func continueLogin(email: String, password: String) {
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { (result) in
                switch result{
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error logging in", message: "\(error.localizedDescription)")
                    }
                case .success:
                    self.navigateToMainView()
                }
            }
        } else {
            authSession.createNewUser(email: email, password: password) { (result) in

                switch result{
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error creating account", message: "\(error.localizedDescription)")
                    }
                case .success:
                    self.navigateToMainView()
                }
            }
        }
    }
    
    private func navigateToMainView() {
        //user tab bar controller here (user sees all tabs and info)
        //instance of vc and then present maybe?
        let tabBarVC = MainViewController()
        present(tabBarVC, animated: true)
        print("info processed")
    }
    
    
    @IBAction func toggleAccountPressed(_ sender: UIButton) {
        
        accountState = accountState == .existingUser ? .newUser : .existingUser
        
        let duration: TimeInterval = 0.8
        
        if accountState == .existingUser {
            UIView.transition(with: self.view, duration: duration, options: [.transitionCrossDissolve], animations: {
                self.accountActivateButton.setTitle("Login", for: .normal)
                self.userPrompt.text = "Don't have an account?"
                self.userAccountPromptButton.setTitle("Sign up", for: .normal)
            }, completion: nil)
        } else {
            UIView.transition(with: self.view, duration: duration, options: [.transitionCrossDissolve], animations: {
                self.accountActivateButton.setTitle("Sign up", for: .normal)
                self.userPrompt.text = "Already have an account?"
                self.userAccountPromptButton.setTitle("Log in", for: .normal)
            }, completion: nil)
        }
        
    }
    
}
