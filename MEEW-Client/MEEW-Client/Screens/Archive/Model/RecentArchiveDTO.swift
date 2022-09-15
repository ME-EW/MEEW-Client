//
//  RecentArchiveDTO.swift
//  MEEW-Client
//
//  Created by taekki on 2022/09/15.
//


import Foundation

struct RecentArchiveDTO: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: RecentArchiveData?
}

struct RecentArchiveData: Codable {
    let today: Today?
    let recent: [Recent]?
}

struct Today: Codable {
    let todayEnum: Int
    let name: String
    let desc: String
    
    enum CodingKeys: String, CodingKey {
        case todayEnum = "enum"
        case name, desc
    }
}

struct Recent: Codable {
    let date: String
    let recentEnum: Int
    let name: String
    let imgURL: String
    let percent: Int
    let done: [Task]?
    let fail: [Task]?
    
    enum CodingKeys: String, CodingKey {
        case date
        case recentEnum = "enum"
        case name
        case imgURL = "imgUrl"
        case percent, done, fail
    }
}

struct Task: Codable {
    let taskID: Int
    let content: String

    enum CodingKeys: String, CodingKey {
        case taskID = "taskId"
        case content
    }
}
