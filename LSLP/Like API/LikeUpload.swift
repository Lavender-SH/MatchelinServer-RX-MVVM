//
//  Like.swift
//  LSLP
//
//  Created by 이승현 on 12/13/23.
//

import Foundation
import Alamofire
//좋아요 등록, 취소
class LikeUpload {
    
    static let shared = LikeUpload()
    
    private init() { }

    func toggleLike(postId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token is missing")
            return
        }

        let url = "\(SesacLSLP.baseURL)/post/like/\(postId)"
        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "SesacKey": SesacLSLP.key
        ]

        AF.request(url, method: .post, headers: headers).responseJSON { response in
            guard response.error == nil else {
                completion(.failure(response.error!))
                return
            }
            
            if let data = response.data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let likeStatus = json["like_status"] as? Bool {
                completion(.success(likeStatus))
            } else {
                completion(.failure(AFError.explicitlyCancelled))
            }
        }
    }
}

