//
//  CustomJACKFLIX.swift
//  SeSAC Week6
//
//  Created by 이승현 on 2023/08/26.
//
import UIKit

class CustomTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.font = UIFont(name: "KCC-Ganpan", size: 15.0)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(named: "hatBakground")?.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.textAlignment = .center
        
    }
    
    
    
    
}
