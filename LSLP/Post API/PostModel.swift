//
//  PostModel.swift
//  LSLP
//
//  Created by 이승현 on 12/12/23.
//

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    let data: [Datum]
    let nextCursor: String

    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}

// MARK: - Datum
struct Datum: Decodable {
    let likes: [String]
    let image: [String]
    let hashTags, comments: [String]
    let id: String
    let creator: Creator
    let time, title, content, productID: String

    enum CodingKeys: String, CodingKey {
        case likes, image, hashTags, comments
        case id = "_id"
        case creator, time, title, content
        case productID = "product_id"
    }
}

// MARK: - Creator
struct Creator: Codable {
    let id, nick: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nick
    }
}
