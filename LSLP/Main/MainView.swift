//
//  MainView.swift
//  LSLP
//
//  Created by 이승현 on 11/29/23.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        view.collectionViewLayout = collectionViewLayout()
        view.backgroundColor = UIColor(named: "White")//UIColor(cgColor: .init(red: 0.05, green: 0.05, blue: 0.05, alpha: 1))
        return view
    }()
    
    override func configureView() {
        addSubview(collectionView)
    }
    
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        return layout
    }
        
        
    
}

