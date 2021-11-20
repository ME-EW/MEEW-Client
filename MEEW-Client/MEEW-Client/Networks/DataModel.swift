//
//  DataModel.swift
//  MEEW-Client
//
//  Created by 임주민 on 2021/11/21.
//

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let images: [String]
    let todoLists: [TodoList]
}

// MARK: - TodoList
struct TodoList: Codable {
    let id, character: Int
    let todo: String
}
