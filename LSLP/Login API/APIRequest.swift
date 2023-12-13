//
//  Model.swift
//  LSLP
//
//  Created by 이승현 on 11/25/23.
//

import Foundation
import Alamofire

protocol APIRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
}

extension APIRequest {
    func asURLRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL)?.appendingPathComponent(path) else {
            throw AFError.invalidURL(url: baseURL)
        }
        
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        
        if let parameters = parameters {
            do {
                request = try JSONEncoding.default.encode(request, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return request
    }
}

// MARK: - 회원가입
struct SignUpRequest: APIRequest {
    let email: String
    let password: String
    let nick: String
    let phoneNum: String?
    let birthDay: String?

    var method: HTTPMethod { .post }
    var path: String { "/join" }
    var parameters: Parameters? {
        var params: Parameters = ["email": email, "password": password, "nick": nick]
        if let phoneNum = phoneNum { params["phoneNum"] = phoneNum }
        if let birthDay = birthDay { params["birthDay"] = birthDay }
        return params
    }
    var headers: HTTPHeaders { ["Content-Type": "application/json", "SesacKey": SesacLSLP.key] }
}

// MARK: - 이메일 중복 확인
struct EmailValidationRequest: APIRequest {
    let email: String

    var method: HTTPMethod { .post }
    var path: String { "/validation/email" }
    var parameters: Parameters? { ["email": email] }
    var headers: HTTPHeaders { ["Content-Type": "application/json", "SesacKey": SesacLSLP.key] }
}

// MARK: - 로그인
struct LoginRequest: APIRequest {
    let email: String
    let password: String

    var method: HTTPMethod { .post }
    var path: String { "/login" }
    var parameters: Parameters? { ["email": email, "password": password] }
    var headers: HTTPHeaders { ["Content-Type": "application/json", "SesacKey": SesacLSLP.key] }
}

// MARK: - AccessToken 갱신
struct AccessTokenRefreshRequest: APIRequest {
    let accessToken: String
    let refreshToken: String

    var method: HTTPMethod { .get }
    var path: String { "/refresh" }
    var parameters: Parameters? { nil }
    var headers: HTTPHeaders { ["Authorization": accessToken, "SesacKey": SesacLSLP.key, "Refresh": refreshToken] }
}

// MARK: - 탈퇴
struct WithdrawRequest: APIRequest {
    let accessToken: String

    var method: HTTPMethod { .get }
    var path: String { "/withdraw" }
    var parameters: Parameters? { nil }
    var headers: HTTPHeaders { ["Authorization": accessToken, "SesacKey": SesacLSLP.key] }
}




