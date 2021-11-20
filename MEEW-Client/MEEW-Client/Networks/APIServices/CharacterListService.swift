//
//  CharacterListService.swift
//  MEEW-Client
//
//  Created by 안현주 on 2021/11/21.
//

import Foundation
import Alamofire

struct CharacterListService {
    
    //싱글톤 객체를 선언하여, 앱 어디에서든 접근 할 수 있도록 추가
    static let shared = CharacterListService()
    
    //통신 할 함수 정의
    //GET 방식을 위한 코드 추가
    //GET,POST의 차이는 바디의 유무
    func readCharacterData(completion: @escaping (NetworkResult<Any>) -> (Void)){
                
        //요청할 url
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
                print("성공")
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeLoginStatus(by: statusCode, value)
                completion(networkResult)
                print("FF")
                
            case .failure(let err):
                print("실패")
                completion(.networkFail)
            }
        }

    }
    
    //서버통신 자체는 성공일지라도 응답 실패로 우리가 원하는 데이터를 받지 못한 상태일 때를 분기 처리하기위한 함수
    private func judgeLoginStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return isUsedPathErrData(data: data)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    
    //원하는 데이터를 decoding하기
    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        print("여기까지는 잘 들어옴")
        // JSON데이터를 LoginResponseData 구조체로 데이터를 변환
        guard let decodedData = try? decoder.decode(CharacterRequestData.self, from: data)
            else {
                print("여기서 잘못된건가??")
                return .pathErr}
        // 그 데이터를 NerworkResult success 파라미터로 전달
        return .success(decodedData)
    }
    
    
    //400 pathErr의 경우 메시지 경우 나눌때 사용
    private func isUsedPathErrData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        //LoginResponseData 형식에 맞춰 디코딩되지 않을 경우에 else문으로 빠져 pathErr를 리턴, 즉 서버로부터 LoginResponseData 형식의 데이터가 오지 않은 것이고, 경로가 잘못된것이라고 분기처리 할 수 있다. 다른 경로를 설정해도, 아예 없는 경로를 설정해도 서버에서 맞는 형식의 데이터가 오지 않기 때문에 pathErr 로!
        guard let decodedData = try? decoder.decode(CharacterRequestData.self, from: data)
            else {return .pathErr}
        // 디코딩은 성공했지만 상태코드가 400번인 경우는 클라 측의 오류이다. 요청이 잘못된 경우, 따라서 여기는 .pathErr대신 .requestErr가 적절하다.
        return .requestErr(decodedData)
    }
    
}
