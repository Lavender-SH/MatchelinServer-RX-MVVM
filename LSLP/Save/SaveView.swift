//
//  SaveView.swift
//  LSLP
//
//  Created by 이승현 on 12/10/23.
//

import UIKit
import SnapKit

class SaveView: BaseView {
    
    let imageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        view.image = UIImage(named: "food1")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleTextField = {
        let view = UITextField()
        view.placeholder = "  제목"
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let contentTextField = {
        let view = UITextField()
        view.placeholder = "  내용"
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let saveButton = {
        let view = UIButton()
        view.setTitle("등록", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .orange
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()


    
    override func configureView() {
        addSubview(imageView)
        addSubview(titleTextField)
        addSubview(contentTextField)
        addSubview(saveButton)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(imageView.snp.width)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        contentTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(150)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(contentTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        
    }
    
    
    
    
}

