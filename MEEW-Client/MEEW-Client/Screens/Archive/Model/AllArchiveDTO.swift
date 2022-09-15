//
//  AllArchiveDTO.swift
//  MEEW-Client
//
//  Created by taekki on 2022/09/15.
//

import Foundation

struct AllArchiveDTO: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: AllArchiveData?
}

struct AllArchiveData: Codable {
    let all: [All]?
}

struct All: Codable {
    let date: String
    let recentEnum: Int
    let name: String
    let imgURL: String
    let percent: Int
    let done: Int
    let fail: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case recentEnum = "enum"
        case name
        case imgURL = "imgUrl"
        case percent, done, fail
    }
}
