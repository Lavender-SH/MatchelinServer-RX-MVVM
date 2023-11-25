//
//  NetworkManager.swift
//  LSLP
//
//  Created by 이승현 on 11/25/23.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = SesacLSLP.baseURL
    
    private init() { }

    private func performRequest(_ request: APIRequest, completion: @escaping (AFDataResponse<Any>, Error?) -> Void) {
        do {
            let urlRequest = try request.asURLRequest(baseURL: baseURL)
            AF.request(urlRequest).validate().responseJSON { response in
                completion(response, response.error)
            }
        } catch {
            completion(AFDataResponse<Any>(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: .failure(error as! AFError)), error)
        }
    }

    // MARK: - 회원가입
    func signUp(email: String, password: String, nick: String, phoneNum: String?, birthDay: String?, completion: @escaping (Bool, String?, Int?) -> Void) {
        let request = SignUpRequest(email: email, password: password, nick: nick, phoneNum: phoneNum, birthDay: birthDay)
        performRequest(request) { response, error in
            guard error == nil else {
                completion(false, error?.localizedDescription, response.response?.statusCode)
                return
            }

            if let statusCode = response.response?.statusCode {
                if let jsonData = response.data, let jsonResponse = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                    let message = jsonResponse["message"] as? String ?? "No message available"
                    completion(statusCode == 200, message, statusCode)
                } else {
                    completion(false, "Invalid JSON response", statusCode)
                }
            }
        }
    }


    // MARK: - 이메일 중복 확인
    func validateEmail(email: String, completion: @escaping (Bool, String?, Int?) -> Void) {
        let request = EmailValidationRequest(email: email)
        performRequest(request) { response, error in
            guard error == nil else {
                completion(false, error?.localizedDescription, response.response?.statusCode)
                return
            }

            if let statusCode = response.response?.statusCode {
                if let jsonData = response.data, let jsonResponse = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                    let message = jsonResponse["message"] as? String ?? "No message available"
                    completion(statusCode == 200, message, statusCode)
                } else {
                    completion(false, "Invalid JSON response", statusCode)
                }
            }
        }
    }
    
    // MARK: - 로그인
    func login(email: String, password: String, completion: @escaping (Bool, String?, String?) -> Void) {
        let request = LoginRequest(email: email, password: password)
        performRequest(request) { response, error in
            guard error == nil, let data = response.data else {
                completion(false, nil, error?.localizedDescription)
                return
            }

        }
    }

    // MARK: - AccessToken 갱신
    func refreshToken(accessToken: String, refreshToken: String, completion: @escaping (Bool, String?) -> Void) {
        let request = AccessTokenRefreshRequest(accessToken: accessToken, refreshToken: refreshToken)
        performRequest(request) { response, error in
            guard error == nil, let data = response.data else {
                completion(false, error?.localizedDescription)
                return
            }

        }
    }

    // MARK: - 탈퇴
    func withdraw(accessToken: String, completion: @escaping (Bool, String?) -> Void) {
        let request = WithdrawRequest(accessToken: accessToken)
        performRequest(request) { response, error in
            guard error == nil else {
                completion(false, error?.localizedDescription)
                return
            }
            completion(true, nil)
        }
    }
}

