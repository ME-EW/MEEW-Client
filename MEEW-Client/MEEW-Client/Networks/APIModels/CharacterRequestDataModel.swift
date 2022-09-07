//
//  CharacterRequestDataModel.swift
//  MEEW-Client
//
//  Created by 안현주 on 2021/11/21.
//

import Foundation

// MARK: - CharacterData
struct CharacterRequestData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: PersonalityData?
}
struct PersonalityData : Codable {
	let personalities: [CharacterRequestResultData]?
}

// MARK: - CharacterResultData
struct CharacterRequestResultData: Codable {
    let id: Int
    let name, description, createdAt, updatedAt, mainImg: String
	let imgUrl : [String]
	
}

