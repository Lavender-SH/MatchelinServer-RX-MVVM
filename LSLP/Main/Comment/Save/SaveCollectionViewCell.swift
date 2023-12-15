//
//  SaveCollectionViewCell.swift
//  LSLP
//
//  Created by 이승현 on 12/13/23.
//
import UIKit

class SaveCollectionViewCell: BaseCollectionViewCell {
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    override func configureView() {
        super.configureView()
        
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(11)
            make.width.height.equalTo(20)
        }
    }
    
    @objc private func deleteButtonTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("DeleteImage"), object: nil, userInfo: ["cell": self])
    }
}



