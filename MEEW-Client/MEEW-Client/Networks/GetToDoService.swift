//
//  GetToDoService.swift
//  MEEW-Client
//
//  Created by 임주민 on 2021/11/21.
//

import Foundation
import Alamofire

struct GetToDoService {
    static let shared = GetToDoService()
    
    func getToDoInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        //통신할 API주소
        let URL = APIConstants.todoURL
        
        //요청헤더
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        
        //요청서
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        // 통신 request를 하는 중
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.pathErr)
            }
        }
    }
    
    //받은 statusCode를 바탕으로 어떻게 결과값을 처리할 건지 정의
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
        guard let decodedData = try? decoder.decode(DataModel.self, from: data) else { return .pathErr}
        //성공적으로 decode를 마치면 success에다가 data 부분을 담아서 completion 호출
        return .success(decodedData.data)
        
    }

}
