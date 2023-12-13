//
//  LikeCollectionViewCell.swift
//  LSLP
//
//  Created by 이승현 on 12/14/23.
//

import UIKit

class LikeCollectionViewCell: BaseCollectionViewCell {
    
    let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 5.0
        return view
    }()
    
    let imageView: GradientImageView = {
        let view = GradientImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16.5
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(shadowContainerView)
        shadowContainerView.addSubview(imageView)
    }
    
    override func setConstraints() {
        
        shadowContainerView.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(shadowContainerView.snp.width).multipliedBy(1.4)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(shadowContainerView)
        }
        
        
    }
    
}

class GradientImageView: UIImageView {
    private var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.6, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func refreshGradient() {
        gradientLayer.removeFromSuperlayer()
        setupGradientLayer()
        setNeedsLayout()
    }
}
