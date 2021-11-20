//
//  NetworkResult.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/20.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
