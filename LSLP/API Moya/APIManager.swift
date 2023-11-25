//
//  APIManager.swift
//  SeSACRxSummery
//
//  Created by 한성봉 on 11/9/23.
//

import Foundation
import Alamofire
import Moya

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    let provider = MoyaProvider<SeSACAPI>()
    
    func signUp() {
        let data = Join(email: "123@naver.com", password: "1234", nick: "새싹")
        provider.request(.signUp(model: data)) { result in
            switch result {
            case .success(let value):
                print("success", value.statusCode, value.data)
                let result = try! JSONDecoder().decode(JoinResponse.self, from: value.data)
                print(result)
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
