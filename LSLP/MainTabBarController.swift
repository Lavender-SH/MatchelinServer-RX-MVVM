//
//  MainTabController.swift
//  LSLP
//
//  Created by 이승현 on 11/29/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    
    func configureViewControllers() {
        let main = MainViewController()
        let search = SearchViewController()
        let save = SaveViewControlelr()
        let like = LikeViewController()
        let profile = ProfileController()
    }
    
    
}
