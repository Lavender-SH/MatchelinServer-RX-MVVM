//
//  PostUpload.swift
//  LSLP
//
//  Created by 이승현 on 12/14/23.
//

import Alamofire
import UIKit

class PostUpload {
    
    static let shared = PostUpload()
    
    private init() { }

    func uploadPost(with title: String, content: String, images: [UIImage], completion: @escaping (Result<String, Error>) -> Void) {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Access token is missing")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "Content-type": "multipart/form-data",
            "SesacKey": SesacLSLP.key
        ]

        AF.upload(multipartFormData: { multipartFormData in
            images.forEach { image in
                if let imageData = image.jpegData(compressionQuality: 0.3) {
                    multipartFormData.append(imageData, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")
                }
            }
            multipartFormData.append(Data(title.utf8), withName: "title")
            multipartFormData.append(Data(content.utf8), withName: "content")
            multipartFormData.append(Data("Matchelin".utf8), withName: "product_id")
            
        }, to: SesacLSLP.baseURL + "/post", method: .post, headers: headers)
        .responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
                return
            }

            switch statusCode {
            case 200:
                if let value = response.value as? String {
                    completion(.success(value))
                } else {
                    completion(.failure(AFError.explicitlyCancelled))
                }
            default:
                completion(.failure(response.error ?? AFError.explicitlyCancelled))
            }
        }
    }
}

