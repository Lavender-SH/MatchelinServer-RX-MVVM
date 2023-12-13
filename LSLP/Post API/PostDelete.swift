//
//  PostDelete.swift
//  LSLP
//
//  Created by 이승현 on 12/13/23.
//

import Foundation
import Alamofire

class PostDelete {
    
    static let shared = PostDelete()
    
    private init() { }
    
    func deletePost(postId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("액세스 토큰 없음")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "SesacKey": SesacLSLP.key
        ]

        let url = SesacLSLP.baseURL + "/post/\(postId)"

        AF.request(url, method: .delete, headers: headers).response { response in
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
                return
            }

            switch statusCode {
            case 200:
                completion(.success(()))
            case 401, 403, 410, 419, 445:
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            default:
                print("Unknown Error: \(statusCode)")
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            }
        }
    }
}
