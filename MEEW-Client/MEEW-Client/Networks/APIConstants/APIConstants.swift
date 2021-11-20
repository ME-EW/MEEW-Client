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
    static let baseURL = "https://asia-northeast3-sopt-hackathon.cloudfunctions.net/api"
    
    //MARK: - SelectURL
    static let readCharacterURL = baseURL + "/character/list"
    
    
}
