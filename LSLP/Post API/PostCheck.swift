//  PostCheck.swift
//  LSLP
//  Created by 이승현 on 12/12/23.

import Foundation
import Alamofire

class PostCheck {
    
    static let shared = PostCheck()
    
    private init() { }

    func fetchPosts(nextCursor: String? = nil, limit: Int = 50, completion: @escaping (Result<Welcome, Error>) -> Void) {
        
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token is missing")
            return
        }
        
        let baseURL = SesacLSLP.baseURL + "/post"
        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "SesacKey": SesacLSLP.key
        ]

        var parameters: [String: Any] = [
            "limit": "\(limit)",
            "product_id": "Matchelin"
        ]
        
        if let next = nextCursor {
            parameters["next"] = next
        }

        AF.request(baseURL, method: .get, parameters: parameters, headers: headers).responseDecodable(of: Welcome.self) { response in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
                return
            }

            switch statusCode {
            case 200:
                if let welcomeResponse = try? response.result.get() {
                    completion(.success(welcomeResponse))
                } else {
                    completion(.failure(response.error ?? AFError.explicitlyCancelled))
                }
            case 400:
                print("잘못된 요청")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            case 401:
                print("인증할 수 없는 액세스 토큰입니다.")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            case 403:
                print("Forbidden")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            case 419:
                print("액세스 토큰이 만료되었습니다.")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
                
            default:
                print("알 수 없음 : \(statusCode)")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            }
        }
    }
}


//struct Post: Decodable {
//   
//}
//
//struct PostsResponse: Decodable {
//    var posts: [Post]
//    var nextCursor: String?
//}




