//
//  ChracterRequestModel.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/08/27.
//

import Foundation

struct CharacterRequestModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: CharacterRequestResult?
}

struct CharacterRequestResult: Codable {
    let personalities: [Personality]
}

struct Personality: Codable {
    let id: Int
    let name, personalityDescription, createdAt, updatedAt: String
    let mainImg: String
    let imgURL: [String]

    enum CodingKeys: String, CodingKey {
        case id, name
        case personalityDescription = "description"
        case createdAt, updatedAt, mainImg
        case imgURL = "imgUrl"
    }
}
