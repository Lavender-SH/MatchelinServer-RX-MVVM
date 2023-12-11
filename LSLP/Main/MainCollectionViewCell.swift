//
//  MainCollectionViewCell.swift
//  LSLP
//
//  Created by 이승현 on 11/30/23.
//

import UIKit

class MainCollectionViewCell: BaseCollectionViewCell {
    
    private let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 5.0
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16.5
        view.clipsToBounds = true
        //view.backgroundColor = .green
        view.isUserInteractionEnabled = true
        view.image = UIImage(named: "오스테리아")
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 40 / 2
        //view.backgroundColor = .blue
        view.image = UIImage(named: "matfill")
        return view
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Lavender", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "KCC-Ganpan", size: 13.0)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(imageLiteralResourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(imageLiteralResourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
//    private let likesLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "KCC-Ganpan", size: 12.0)
//        label.text = "1 like"
//        return label
//    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "KCC-Ganpan", size: 12.0)
        label.text = "Some test 맛슐랭 title for now..."
        return label
    }()
    
//    private let postTimeLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .lightGray
//        label.font = UIFont(name: "KCC-Ganpan", size: 12.0)
//        label.text = "2 days ago"
//        return label
//    }()

    
    override func configureView() {
        contentView.addSubview(shadowContainerView)
        shadowContainerView.addSubview(imageView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        //contentView.addSubview(likesLabel)
        contentView.addSubview(titleLabel)
        //contentView.addSubview(postTimeLabel)
        
    }
    
    override func setConstraints() {
        
        shadowContainerView.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(15)
            make.right.equalTo(contentView).inset(15)
            make.top.equalTo(contentView).inset(50)
            make.height.equalTo(contentView).multipliedBy(0.7)
        }

        imageView.snp.makeConstraints { make in
            make.edges.equalTo(shadowContainerView)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        usernameButton.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.centerY.equalTo(profileImageView)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(shadowContainerView.snp.bottom).offset(10)
            make.left.equalTo(contentView).inset(15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(shadowContainerView.snp.bottom).offset(10)
            make.left.equalTo(likeButton.snp.right).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.left.equalTo(contentView).inset(15)
            
//            make.height.equalTo(30)
//            make.width.equalTo(30)
        }



        
    }
    
    @objc func didTapUsername() {
        print("Debug")
    }
    
    
}


// MARK: - 그라디언트 효과
//class GradientImageView: UIImageView {
//    private var gradientLayer: CAGradientLayer!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupGradientLayer()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupGradientLayer()
//    }
//    
//    private func setupGradientLayer() {
//        gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradientLayer.locations = [0.6, 1.0]
//        layer.insertSublayer(gradientLayer, at: 0)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = bounds
//    }
//    
//    func refreshGradient() {
//        gradientLayer.removeFromSuperlayer()
//        setupGradientLayer()
//        setNeedsLayout()
//    }
//}
