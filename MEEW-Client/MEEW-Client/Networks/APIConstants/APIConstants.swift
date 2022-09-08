//
//  APIConstants.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/20.
//

import Foundation

// MARK: - 네트워크 통신에 관련된 상수를 저장합니다.
// ex. APIConstants.baseURL

enum APIConstants {
    // Base url
    static let baseURL = "https://asia-northeast3-meew-server.cloudfunctions.net/api"
    
    // MARK: - ToDo뷰
    static let getTodayCharacterURL = baseURL + "/personality/today"
    static let getNewTodayCharacterURL = baseURL + "/personality/new"
    static let getOriginalMyCharacterURL = baseURL + "/personality/me"
    static let patchToDoURL = baseURL + "/personality/check"
    static let getCharacterURL = baseURL + "/personality"

    //MARK: - SelectURL
    static let readCharacterURL = baseURL + "/personality/list"
}
