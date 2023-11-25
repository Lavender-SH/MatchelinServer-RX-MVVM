//
//  JackFlixViewModel.swift
//  SeSAC3UnsplashProject
//
//  Created by 이승현 on 2023/09/18.
//
import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    
    let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "loginBackground")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    
    override func configureView() {
        loginView.signUpButton.addTarget(self, action: #selector(signUpButton), for: .touchUpInside)
        loginView.withdrawButton.addTarget(self, action: #selector(withdrawButton), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func signUpButton() {
//        let signUpViewController = SignUpViewController()
//        present(signUpViewController, animated: true, completion: nil)
    }
    @objc func withdrawButton() {
//        let withdrawViewController = WithdrawViewController()
//        present(withdrawViewController, animated: true, completion: nil)
    }
    @objc func loginButton() {
//        let mainViewController = MainViewController()
//        present(mainViewController, animated: true, completion: nil)
    }
    
    
    
}

