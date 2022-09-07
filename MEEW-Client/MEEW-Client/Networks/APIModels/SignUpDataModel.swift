//
//  SignUpDataModel.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/09/07.
//

import Foundation

// MARK: - SignUpData
struct SignUpData: Codable {
	let status: Int
	let success: Bool
	let message: String
	let data: UserData?
}
struct UserData: Codable {
	let userId: Int
	let token: Token?
}
struct Token: Codable {
	let accessToken: String
	let refreshToken: String
}
