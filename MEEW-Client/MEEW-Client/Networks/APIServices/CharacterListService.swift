//
//  CharacterListService.swift
//  MEEW-Client
//
//  Created by 안현주 on 2021/11/21.
//

import Foundation
import Alamofire

class CharacterListService {
    
    static let shared = CharacterListService()

    func readCharacterData(completion: @escaping (NetworkResult<Any>) -> (Void)){
                
        let url = APIConstants.readCharacterURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let dataRequest = AF.request(url,
                                     method: .get,
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
