//
//  GrayTextField.swift
//  SeSAC3UnsplashProject
//
//  Created by 이승현 on 2023/09/18.
//

import UIKit

class GrayTextField: UITextField {
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        borderStyle = .none
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true
        textAlignment = .center
        backgroundColor = .gray
        font = .boldSystemFont(ofSize: 15)
        
    }
    
}
