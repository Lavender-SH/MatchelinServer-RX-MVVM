//
//  APIModel.swift
//  SeSACRxSummery
//
//  Created by 한성봉 on 11/9/23.
//

import Foundation

struct Join: Encodable {
    let email: String
    let password: String
    let nick: String
}

struct JoinResponse: Decodable {
//    let _id: String
    let email: String
    let nick: String
}

struct Login: Encodable {
    let email: String
    let password: String
}
