//
//  SignUpService.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/09/07.
//


import Foundation
import Alamofire

class SignUpService {
	
	static let shared = SignUpService()

	func signUp(socialToken: String, socialType: String, nickname: String, personalityId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)){
				
		let url = APIConstants.signUpURL
		
		let header: HTTPHeaders = [
			"Content-Type" : "application/json"
		]
		
		let body: Parameters = [
			"socialToken": socialToken,
			"socialType": socialType,
			"nickname": nickname,
			"personalityId": personalityId
		]
		
		let dataRequest = AF.request(url,
									 method: .post,
									 parameters: body,
									 encoding: JSONEncoding.default,
									 headers: header)
		
		dataRequest.responseData {dataResponse in
			switch dataResponse.result {
			case .success:
				guard let statusCode = dataResponse.response?.statusCode else {return}
				guard let value = dataResponse.value else {return}
				let networkResult = self.judgeLoginStatus(by: statusCode, value)
				completion(networkResult)
				
			case .failure(let err):
				completion(.networkFail)
			}
		}

	}
	
	private func judgeLoginStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
		switch statusCode {
		case 200: return isValidData(data: data)
		case 400: return isUsedPathErrData(data: data)
		case 500: return .serverErr
		default: return .networkFail
		}
	}
	
	
	private func isValidData(data: Data) -> NetworkResult<Any> {
		let decoder = JSONDecoder()
		guard let decodedData = try? decoder.decode(CharacterRequestData.self, from: data)
			else {
				return .pathErr}
		return .success(decodedData)
	}
	
	
	private func isUsedPathErrData(data: Data) -> NetworkResult<Any> {
		let decoder = JSONDecoder()
		guard let decodedData = try? decoder.decode(CharacterRequestData.self, from: data)
			else {return .pathErr}
		return .requestErr(decodedData)
	}
	
}
