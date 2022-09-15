//
//  SpecificArchiveDTO.swift
//  MEEW-Client
//
//  Created by taekki on 2022/09/15.
//

import Foundation

struct SpecificArchiveDTO: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Specific?
}

struct Specific: Codable {
    let recentEnum: Int
    let name: String
    let desc: String
    let percent: Int
    let done: [SpecificTask]?
    let fail: [SpecificTask]?
    
    enum CodingKeys: String, CodingKey {
        case recentEnum = "enum"
        case name, desc, percent, done, fail
    }
}

struct SpecificTask: Codable {
    let taskID: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case taskID = "taskId"
        case content
    }
}
