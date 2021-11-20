//
//  CharacterRequestDataModel.swift
//  MEEW-Client
//
//  Created by 안현주 on 2021/11/21.
//

import Foundation
import Metal

// MARK: - LoginResponsData
struct CharacterRequestData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [CharacterRequestResultData]?
}

// MARK: - LoginResultData
struct CharacterRequestResultData: Codable {
    let id: Int
    let name, description: String
    let images: [String]
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case images, createdAt, updatedAt
    }
}

