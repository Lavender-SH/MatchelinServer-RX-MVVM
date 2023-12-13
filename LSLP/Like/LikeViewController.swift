//
//  LikeViewController.swift
//  LSLP
//
//  Created by 이승현 on 11/29/23.
//

import UIKit

class LikeViewController: BaseViewController {
    
    let likeView = LikeView()
    var likedItems: [Datum] = []
    var nextCursor: String?
    private let refreshControl = UIRefreshControl()
    
    override func loadView() {
        self.view = likeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationUI()
        view.backgroundColor = .white
        likeView.collectionView.dataSource = self
        likeView.collectionView.delegate = self
        
        setupRefreshControl()
        fetchLikedPostsData()
    }
    
    func makeNavigationUI() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        let logo = UIImage(named: "투명로고")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        navigationItem.titleView = imageView
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        likeView.collectionView.addSubview(refreshControl)
        likeView.collectionView.alwaysBounceVertical = true
    }
    
    @objc private func refreshData(_ sender: Any) {
        nextCursor = nil
        fetchLikedPostsData(isRefreshing: true)
    }
    
    func fetchLikedPostsData(isRefreshing: Bool = false) {
        if isRefreshing {
            likedItems.removeAll()
        }

        LikeMe.shared.fetchLikedPosts(limit: 50) { [weak self] result in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing() // Stop the refresh control animation

                switch result {
                case .success(let welcomeResponse):
                    if isRefreshing {
                        self?.likedItems = welcomeResponse.data
                    } else {
                        self?.likedItems.append(contentsOf: welcomeResponse.data)
                    }
                    self?.likeView.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching liked posts: \(error)")
                }
            }
        }
    }

    
    
}

extension LikeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCollectionViewCell", for: indexPath) as! LikeCollectionViewCell
        
        let item = likedItems[indexPath.row]
        if let firstImageUrlString = item.image.first, let url = URL(string: "\(SesacLSLP.baseURL)/\(firstImageUrlString)") {
            cell.imageView.kf.setImage(with: url)
        }
        
        
        return cell
    }
}
