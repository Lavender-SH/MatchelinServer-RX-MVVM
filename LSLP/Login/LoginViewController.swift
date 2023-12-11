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
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func signUpButton() {
        let signUpViewController = SignUpViewController()
        present(signUpViewController, animated: true, completion: nil)
    }
    @objc func withdrawButton() {
//        let withdrawViewController = WithdrawViewController()
//        present(withdrawViewController, animated: true, completion: nil)
    }
    
    // MARK: - 로그인
    @objc func loginButtonTapped() {
        guard let email = loginView.emailTextField.text, !email.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty else {
            showAlert(with: "이메일과 비밀번호를 입력해주세요.", navigateToMain: false)
            return
        }

        NetworkManager.shared.login(email: email, password: password) { success, accessToken, refreshToken, message in
            if success {
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
                UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                print("==66", accessToken)
                print("==77", refreshToken)
                self.showAlert(with: "로그인이 완료되었습니다!", navigateToMain: true)
            } else {
                self.showAlert(with: message ?? "로그인 실패", navigateToMain: false)
            }
        }
    }


    private func showAlert(with message: String, navigateToMain: Bool) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            if navigateToMain {
                self.navigateToMain()
            }
        }))
        self.present(alert, animated: true)
    }

    private func navigateToMain() {
        let mainTBVC = MainTabBarController()
        let mainNavController = UINavigationController(rootViewController: mainTBVC)
        mainNavController.modalPresentationStyle = .fullScreen
        self.present(mainNavController, animated: true, completion: nil)
    }

    

    
    
}

