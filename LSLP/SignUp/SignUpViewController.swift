//
//  SignUpViewController.swift
//  LSLP
//
//  Created by 이승현 on 11/25/23.
//

import UIKit
import SnapKit

class SignUpViewController: BaseViewController {
    
    let signUpView = SignUpView()
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "loginBackground")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        signUpView.signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signUpView.validationButton.addTarget(self, action: #selector(handleValidation), for: .touchUpInside)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    // MARK: - 회원가입
    @objc func handleSignUp() {
        guard let email = signUpView.emailTextField.text,
              let password = signUpView.passwordTextField.text,
              let nick = signUpView.nickTextField.text else {
            showAlert(with: "필수 값 없음", isSignUpSuccess: false)
            return
        }

        let phoneNum = signUpView.phoneNumTextField.text
        let birthDay = signUpView.birthDayTextField.text

        NetworkManager.shared.signUp(email: email, password: password, nick: nick, phoneNum: phoneNum, birthDay: birthDay) { success, message, statusCode in
            switch statusCode {
            case 200:
                self.showAlert(with: "회원가입이 완료되었습니다!", isSignUpSuccess: true)
            case 400:
                self.showAlert(with: "필수값을 입력해주세요!", isSignUpSuccess: false)
            case 409:
                self.showAlert(with: "이미 가입한 유저입니다!", isSignUpSuccess: false)
            default:
                self.showAlert(with: message ?? "알 수 없는 오류", isSignUpSuccess: false)
            }
        }
    }
    
    private func showAlert(with message: String, isSignUpSuccess: Bool) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            if isSignUpSuccess {
                self.navigateToLogin()
            }
        }))
        self.present(alert, animated: true)
    }
    
    //가입이 완료되면 로그인화면으로 이동
    private func navigateToLogin() {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    // MARK: - 이메일 중복 확인
    @objc func handleValidation() {
        guard let email = signUpView.emailTextField.text else {
            showAlert(with: "이메일 없음")
            return
        }
        NetworkManager.shared.validateEmail(email: email) { success, message, statusCode in
            switch statusCode {
            case 200:
                self.showAlert(with: "사용 가능한 이메일입니다!")
            case 400:
                self.showAlert(with: "이메일을 적어주세요!")
            case 409:
                self.showAlert(with: "사용이 불가능한 이메일입니다!")
            default:
                self.showAlert(with: message ?? "알 수 없는 오류")
            }
        }
    }

    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
}

