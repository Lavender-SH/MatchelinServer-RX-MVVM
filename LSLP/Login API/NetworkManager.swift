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

    // MARK: - 공통로직
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
    
    // MARK: - 상태코드 공통로직
    private func processResponse(_ response: AFDataResponse<Any>, completion: (Bool, String?, Int?) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            completion(false, "No status code received", nil)
            return
        }

        let message = parseResponseMessage(response.data)
        completion(statusCode == 200, message, statusCode)
    }

    private func parseResponseMessage(_ data: Data?) -> String? {
        guard let jsonData = data,
              let jsonResponse = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            return "Invalid JSON response"
        }
        return jsonResponse["message"] as? String ?? "No message available"
    }


    // MARK: - 회원가입
    func signUp(email: String, password: String, nick: String, phoneNum: String?, birthDay: String?, completion: @escaping (Bool, String?, Int?) -> Void) {
            let request = SignUpRequest(email: email, password: password, nick: nick, phoneNum: phoneNum, birthDay: birthDay)
            performRequest(request) { response, error in
                guard error == nil else {
                    completion(false, error?.localizedDescription, response.response?.statusCode)
                    return
                }
                self.processResponse(response, completion: completion)
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

            self.processResponse(response, completion: completion)
        }
    }
    
    // MARK: - 로그인
    func login(email: String, password: String, completion: @escaping (Bool, String?, String?, String?) -> Void) {
        let request = LoginRequest(email: email, password: password)
        performRequest(request) { response, error in
            guard error == nil else {
                completion(false, nil, error?.localizedDescription, nil)
                return
            }

            guard let statusCode = response.response?.statusCode,
                  let jsonData = response.data,
                  let jsonResponse = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
                completion(false, nil, "Invalid response", nil)
                return
            }

            if statusCode == 200,
               let accessToken = jsonResponse["token"] as? String,
               let refreshToken = jsonResponse["refreshToken"] as? String {
                completion(true, accessToken, refreshToken, nil)
            } else {
                let message = jsonResponse["message"] as? String ?? "No message available"
                completion(false, nil, message, nil)
            }
        }
    }

    // MARK: - AccessToken 갱신
    func refreshToken(completion: @escaping (Bool, String?) -> Void) {
        guard let currentAccessToken = UserDefaults.standard.string(forKey: "accessToken"),
              let currentRefreshToken = UserDefaults.standard.string(forKey: "refreshToken") else {
            completion(false, "현재 토큰이 없습니다.")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(currentAccessToken)",
            "SesacKey": SesacLSLP.key,
            "Refresh": currentRefreshToken
        ]

        AF.request("\(baseURL)/refresh", method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let newAccessToken = json["token"] as? String {
                    UserDefaults.standard.set(newAccessToken, forKey: "accessToken")
                    completion(true, nil)
                } else {
                    completion(false, "토큰 갱신 실패")
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
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

