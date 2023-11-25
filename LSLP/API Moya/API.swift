//
//  API.swift
//  SeSACRxSummery
//
//  Created by 한성봉 on 11/9/23.
//

import Foundation
import Moya
import Alamofire

enum SeSACAPI {
    case signUp(model: Join)
    case login(email: String, password: String)
    case withdraw
    case refresh
}

extension SeSACAPI: TargetType {
    
    var baseURL: URL {
        let baseURL = URL(string: "http://192.168.20.192:32735/")!
        return baseURL
    }
    
    var path: String {
        // 열거형 rawValue와 엔드포인트 string이 같다면 switch문 말고 다른 방법을 활용해볼 수 있을 것 같음.
        switch self {
        case .signUp:
            return "join"
        case .login:
            return "login"
        case .withdraw:
            return "withdraw"
        case .refresh:
            return "refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        case .login:
            return .post
        case .withdraw:
            return .post
        case .refresh:
            return .get
        }
    }
    
    var task: Moya.Task {
        // query parameter
//        return .requestParameters(
//            parameters: [
//                "id": "",
//                "password": ""
//            ],
//            encoding: URLEncoding.httpBody
//        )
        
        // json
        switch self {
        case .signUp(let data):
            return .requestJSONEncodable(data)
        case .login(let email, let password):
            let data = Login(email: email, password: password)
            return .requestJSONEncodable(data)
        //
        case .withdraw:
            let data = Login(email: "123@naver.com", password: "1234")
            return .requestJSONEncodable(data)
        case .refresh:
            let data = Login(email: "123@naver.com", password: "1234")
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        [
            "Content-Type": "application/json",
            "SesacKey": "Ge9CmDbvuM" // "wNJd9EDtIR"
        ]
    }
    
}
