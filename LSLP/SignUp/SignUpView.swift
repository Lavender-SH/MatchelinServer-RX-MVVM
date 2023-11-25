//
//  SignUpView.swift
//  LSLP
//
//  Created by 이승현 on 11/25/23.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

class SignUpView: BaseView {
    
    // titleLabel, logoImageView와 유사한 구성
    let titleLabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "gold")
        label.font = UIFont(name: "KCC-Ganpan", size: 25.0)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.text = "회원가입"
        return label
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "투명아이콘")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // 필수 입력 필드: 이메일, 비밀번호, 닉네임
    let emailTextField = {
        let textField = CustomTextField()
        textField.placeholder = "이메일 *필수"
        return textField
    }()
    
    let validationButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "KCC-Ganpan", size: 13.0)
        button.layer.cornerRadius = 8
        button.layer.cornerCurve = .continuous
        button.backgroundColor = UIColor.lightGray
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        return button
    }()
    
    let passwordTextField = {
        let textField = CustomTextField()
        textField.placeholder = "비밀번호 *필수"
        return textField
    }()

    let nickTextField = {
        let textField = CustomTextField()
        textField.placeholder = "닉네임 *필수"
        return textField
    }()

    // 선택 입력 필드: 전화번호, 생년월일
    let phoneNumTextField = {
        let textField = CustomTextField()
        textField.placeholder = "전화번호 '-' 없이 입력"
        return textField
    }()

    let birthDayTextField = {
        let textField = CustomTextField()
        textField.placeholder = "생년월일 ex) 19990101"
        return textField
    }()

    // 회원가입 버튼
    let signUpButton = {
        let button = UIButton()
        button.setTitle("회원가입 완료", for: .normal)
        button.layer.cornerRadius = 16.5
        button.layer.cornerCurve = .continuous
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        return button
    }()

    override func configureView() {
        addSubview(titleLabel)
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(validationButton)
        addSubview(passwordTextField)
        addSubview(nickTextField)
        addSubview(phoneNumTextField)
        addSubview(birthDayTextField)
        addSubview(signUpButton)
    }

    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).inset(15)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        
        validationButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField.snp.centerY)
            make.trailing.equalTo(emailTextField.snp.trailing).inset(10)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        nickTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        phoneNumTextField.snp.makeConstraints { make in
            make.top.equalTo(nickTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        birthDayTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(birthDayTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }

    }
}

