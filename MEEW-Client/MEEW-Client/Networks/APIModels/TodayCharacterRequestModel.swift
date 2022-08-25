//
//  TodayCharacterRequestModel.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/08/24.
//

import Foundation

struct TodayCharacterRequestModel: Codable {
  let status: Int
  let success: Bool
  let message: String
  let data: TodayCharacterData?
}

struct TodayCharacterData: Codable {
  let nickname: String
  let dataEnum: Int
  let name: String
  let level: Int
  let imageURL: String
  let chance: Int
  let finished: Bool
  let todo: [TodayTodoList]
  
  enum CodingKeys: String, CodingKey {
    case nickname
    case dataEnum = "enum"
    case name, level
    case imageURL = "imageUrl"
    case chance, finished, todo
  }
}

struct TodayTodoList: Codable {
  let taskID: Int
  let content: String
  let complete: Bool
  
  enum CodingKeys: String, CodingKey {
    case taskID = "taskId"
    case content, complete
  }
}
