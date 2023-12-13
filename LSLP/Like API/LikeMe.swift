//
//  LikeMe.swift
//  LSLP
//
//  Created by 이승현 on 12/14/23.
//

import Foundation
import Alamofire
 //좋아요 조회
class LikeMe {
    
    static let shared = LikeMe()
    
    private init() { }

    func fetchLikedPosts(nextCursor: String? = nil, limit: Int = 50, completion: @escaping (Result<Welcome, Error>) -> Void) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token is missing")
            return
        }

        let url = "\(SesacLSLP.baseURL)/post/like/me"
        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "SesacKey": SesacLSLP.key
        ]

        var parameters: [String: Any] = [
            "limit": "\(limit)"
        ]
        
        if let next = nextCursor {
            parameters["next"] = next
        }

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: Welcome.self) { response in
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

            default:
                print("Unhandled status code: \(statusCode)")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            }
        }
    }
}

