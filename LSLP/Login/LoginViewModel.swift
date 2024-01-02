//
//  LoginViewModel.swift
//  Matchelin MVVM
//
//  Created by 이승현 on 12/29/23.
//

//import Foundation
//
//class LoginViewModel {
//    
//    var networkManager: NetworkManagerProtocol
//    
//    init(networkManager: NetworkManagerProtocol) {
//        self.networkManager = networkManager
//    }
//    
//    var onLoginSuccess: (() -> Void)?
//    var onLoginFailure: ((String) -> Void)?
//
//    func login(email: String, password: String) {
//            networkManager.login(email: email, password: password) { [weak self] success, accessToken, refreshToken, message in
//                if success {
//                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
//                    UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
//                    print("==66", accessToken)
//                    print("==77", refreshToken)
//                    self?.onLoginSuccess?()
//                } else {
//                    self?.onLoginFailure?(message ?? "Login failed")
//                }
//            }
//        }
//    
//    
//}

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LoginViewModel {
    
    private var networkManager: NetworkManagerProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - RxSwift Subjects
    let loginSuccess = PublishSubject<Void>()
    let loginFailure = PublishSubject<String>()

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func login(email: String, password: String) {
        
        Observable.create { [weak self] observer in
            self?.networkManager.login(email: email, password: password) { success, accessToken, refreshToken, message in
                if success {
                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                    observer.onNext(())
                    observer.onCompleted()
                } else {
                    observer.onError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message ?? "Login failed"]))
                }
            }
            return Disposables.create()
        }
        .subscribe(
            onNext: { [weak self] _ in
                self?.loginSuccess.onNext(())
            },
            onError: { [weak self] error in
                self?.loginFailure.onNext(error.localizedDescription)
            }
        )
        .disposed(by: disposeBag)
    }
    
}


