//
//  ArchiveService.swift
//  MEEW-Client
//
//  Created by taekki on 2022/09/15.
//

import Alamofire

protocol ArchiveServiceRepository: AnyObject {
    func fetchRecentArchive(completion: @escaping (NetworkResult<Any>) -> Void)
    func fetchAllArchive(page: Int, completion: @escaping (NetworkResult<Any>) -> Void)
    func fetchSpecificArchive(for date: String, completion: @escaping (NetworkResult<Any>) -> Void)
}

final class ArchiveService: ArchiveServiceRepository {
    
    static let shared = ArchiveService()
    private init() {}
    
    func fetchRecentArchive(completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.recentArchiveURL
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
                let networkResult = self.judgeStatusForRecent(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.pathErr)
            }
        }
    }
    
    func fetchAllArchive(page: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.allArchiveURL + "?page=\(page)"
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
                let networkResult = self.judgeStatusForAll(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.pathErr)
            }
        }
    }
    
    func fetchSpecificArchive(for date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let URL = APIConstants.archiveForDateURL + "?date=\(date)"
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
                let networkResult = self.judgeStatusForSpecific(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.pathErr)
            }
        }
    }
    
    private func judgeStatusForRecent(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidDataForRecent(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func judgeStatusForAll(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidDataForAll(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func judgeStatusForSpecific(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidDataForSpecific(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidDataForRecent(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(RecentArchiveDTO.self, from: data) else { return .pathErr }
        return .success(decodedData)
    }
    
    private func isValidDataForAll(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(AllArchiveDTO.self, from: data) else { return .pathErr }
        return .success(decodedData)
    }
    
    private func isValidDataForSpecific(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(SpecificArchiveDTO.self, from: data) else { return .pathErr }
        return .success(decodedData)
    }
}
