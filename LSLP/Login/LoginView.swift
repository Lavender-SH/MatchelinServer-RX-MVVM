//
//  JackFlixViewController.swift
//  SeSAC3UnsplashProject
//
//  Created by 이승현 on 2023/09/18.
//

import Foundation
import UIKit
import SnapKit

class LoginView: BaseView {
    
    
    let titleLabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "gold")
        label.font = UIFont(name: "KCC-Ganpan", size: 25.0)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.text = "맛슐랭"
        return label
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "투명아이콘")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let emailTextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.font = UIFont(name: "KCC-Ganpan", size: 15.0)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "hatBakground")?.cgColor
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.textAlignment = .center
        return textField
    }()

    
    let passwordTextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.font = UIFont(name: "KCC-Ganpan", size: 15.0)
        textField.layer.borderColor = UIColor(named: "hatBakground")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.textAlignment = .center
        return textField
    }()
    
    let loginButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont(name: "KCC-Ganpan", size: 15.0)
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "gold")
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    let signUpButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont(name: "KCC-Ganpan", size: 15.0)
        button.layer.borderColor = UIColor(named: "hatBackground")?.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "hatBackground")
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let withdrawButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.titleLabel?.font = UIFont(name: "KCC-Ganpan", size: 15.0)
        button.layer.borderColor = UIColor(named: "withdraw")?.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "withdraw")
        button.setTitleColor(.black, for: .normal) // 버튼 타이틀 색상 설정
        return button
    }()

    
    let switchButton = {
        let switchButton = UISwitch()
        switchButton.onTintColor = .red
        return switchButton
    }()
    
    
    
    override func configureView() {
        
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(logoImageView)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(signUpButton)
        addSubview(withdrawButton)
        addSubview(switchButton)

        
    }
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
//            make.leading.equalToSuperview().offset(50)
//            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(250)
            make.centerX.equalToSuperview()
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        switchButton.snp.makeConstraints { make in
            make.top.equalTo(withdrawButton.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-53)
        }
        
    }

    
    
    
}




