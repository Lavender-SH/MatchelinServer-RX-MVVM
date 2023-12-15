//
//  SaveView.swift
//  LSLP
//
//  Created by 이승현 on 12/10/23.
//

import UIKit
import SnapKit

class SaveView: BaseView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(SaveCollectionViewCell.self, forCellWithReuseIdentifier: "SaveCollectionViewCell")
        return collectionView
    }()
    
    let cameraButton: UIButton = {
        let button = UIButton()
        let goldColor = UIColor(named: "gold") ?? UIColor.gold
        if let cameraImage = UIImage(systemName: "camera")?.withTintColor(goldColor, renderingMode: .alwaysOriginal) {
            button.setImage(cameraImage, for: .normal)
        }
        button.layer.borderColor = UIColor(named: "gold")?.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        return button
    }()
    
    let photoCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/5"
        label.textColor = UIColor(named: "gold")
        label.textAlignment = .center
        label.font = UIFont(name: "KCC-Ganpan", size: 12.0)
        return label
    }()
    
    //    let imageView = {
    //        let view = UIImageView()
    //        view.layer.cornerRadius = 10
    //        view.clipsToBounds = true
    //        view.backgroundColor = .lightGray
    //        view.image = UIImage(named: "food1")
    //        view.contentMode = .scaleAspectFill
    //        return view
    //    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "  제목", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "KCC-Ganpan", size: 14.0)!])
        textField.font = UIFont(name: "KCC-Ganpan", size: 14.0)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()

    let contentTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "  내용", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "KCC-Ganpan", size: 14.0)!])
        textField.font = UIFont(name: "KCC-Ganpan", size: 14.0)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()

    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록", for: .normal)
        button.titleLabel?.font = UIFont(name: "KCC-Ganpan", size: 16.0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "gold")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    
    
    
    override func configureView() {
        //addSubview(imageView)
        addSubview(titleTextField)
        addSubview(contentTextField)
        addSubview(saveButton)
        
        addSubview(collectionView)
        addSubview(cameraButton)
        addSubview(photoCountLabel)
    }
    
    override func setConstraints() {
        
        cameraButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cameraButton.snp.top)
            make.left.equalTo(cameraButton.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            //make.height.equalTo(80)
            make.bottom.equalTo(cameraButton.snp.bottom)
        }
        
        photoCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(cameraButton.snp.bottom).inset(8)
            make.centerX.equalTo(cameraButton.snp.centerX)
            make.height.equalTo(20)
        }
        //        imageView.snp.makeConstraints { make in
        //            make.top.equalToSuperview().offset(20)
        //            make.centerX.equalToSuperview()
        //            make.width.equalToSuperview().multipliedBy(0.9)
        //            make.height.equalTo(imageView.snp.width)
        //        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(cameraButton.snp.bottom).offset(20)
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

