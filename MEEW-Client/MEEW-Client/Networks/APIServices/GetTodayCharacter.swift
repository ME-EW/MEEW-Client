//
//  GetTodayCharacter.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/08/24.
//
import Foundation
import Alamofire

struct GetTodayCharacter {
  
  static let shared = GetTodayCharacter()
  
  func getTodayCharacter(completion: @escaping (NetworkResult<Any>) -> Void) {
    let URL = APIConstants.getTodayCharacterURL
    let header: HTTPHeaders = ["Content-Type" : "application/json"]
    let dataRequest = AF.request(URL,
                                 method: .get,
                                 encoding: JSONEncoding.default,
                                 headers: header)
    dataRequest.responseData { dataResponse in
      switch dataResponse.result {
      case .success:
        guard let statusCode = dataResponse.response?.statusCode else { return }
        guard let value = dataResponse.value else { return }
        let networkResult = self.judgeStatus(by: statusCode, value)
        completion(networkResult)
      case .failure(let err):
        print("fail")
        print(err)
        completion(.pathErr)
      }
    }
  }
  
  func getNewTodayCharacter(completion: @escaping (NetworkResult<Any>) -> Void) {
    let URL = APIConstants.getNewTodayCharacterURL
    let header: HTTPHeaders = ["Content-Type" : "application/json"]
    let dataRequest = AF.request(URL,
                                 method: .get,
                                 encoding: JSONEncoding.default,
                                 headers: header)
    dataRequest.responseData { dataResponse in
      switch dataResponse.result {
      case .success:
        guard let statusCode = dataResponse.response?.statusCode else { return }
        guard let value = dataResponse.value else { return }
        let networkResult = self.judgeStatus(by: statusCode, value)
        completion(networkResult)
      case .failure(let err):
        print("fail")
        print(err)
        completion(.pathErr)
      }
    }
  }
  
  func getOriginalMyCharacter(completion: @escaping (NetworkResult<Any>) -> Void) {
    let URL = APIConstants.getOriginalMyCharacterURL
    let header: HTTPHeaders = ["Content-Type" : "application/json"]
    let dataRequest = AF.request(URL,
                                 method: .get,
                                 encoding: JSONEncoding.default,
                                 headers: header)
    dataRequest.responseData { dataResponse in
      switch dataResponse.result {
      case .success:
        guard let statusCode = dataResponse.response?.statusCode else { return }
        guard let value = dataResponse.value else { return }
        let networkResult = self.judgeStatus(by: statusCode, value)
        completion(networkResult)
      case .failure(let err):
        print("fail")
        print(err)
        completion(.pathErr)
      }
    }
  }
  
  func patchToDo(taskId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    let URL = APIConstants.patchToDoURL
    let header: HTTPHeaders = ["Content-Type" : "application/json"]
    let body: Parameters = ["taskId": taskId]
    let dataRequest = AF.request(URL,
                                 method: .patch,
                                 parameters: body,
                                 encoding: JSONEncoding.default,
                                 headers: header)
    dataRequest.responseData { dataResponse in
      switch dataResponse.result {
      case .success:
        guard let statusCode = dataResponse.response?.statusCode else { return }
        guard let value = dataResponse.value else { return }
        let networkResult = self.judgeStatus(by: statusCode, value)
        completion(networkResult)
      case .failure(let err):
        print("failure")
        print("fail")
        print(err)
        completion(.pathErr)
      }
    }
  }
  
  func postEndTodayCharacter(completion: @escaping (NetworkResult<Any>) -> Void) {
    let URL = APIConstants.getTodayCharacterURL
    let header: HTTPHeaders = ["Content-Type" : "application/json"]
    let dataRequest = AF.request(URL,
                                 method: .post,
                                 encoding: JSONEncoding.default,
                                 headers: header)
    dataRequest.responseData { dataResponse in
      switch dataResponse.result {
      case .success:
        guard let statusCode = dataResponse.response?.statusCode else { return }
        guard let value = dataResponse.value else { return }
        let networkResult = self.judgeStatus(by: statusCode, value)
        completion(networkResult)
      case .failure(let err):
        print("fail")
        print(err)
        completion(.pathErr)
      }
    }
  }
  
  private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
    switch statusCode {
    case 200: return isValidData(data: data)
    case 400: return .pathErr
    case 500: return .serverErr
    default: return .networkFail
    }
  }
  
  private func isValidData(data: Data) -> NetworkResult<Any> {
    let decoder = JSONDecoder()
    guard let decodedData = try? decoder.decode(TodayCharacterRequestModel.self, from: data) else { return .pathErr }
    return .success(decodedData)
  }
}
