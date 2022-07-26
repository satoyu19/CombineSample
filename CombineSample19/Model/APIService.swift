//
//  APIService.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/18.
//

import Foundation
import Combine

protocol APIServiceType{
    
    func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType{
    
    private let baseURLString: String
    
    init(baseURLString: String = "https://webservice.recruit.co.jp"){
        self.baseURLString = baseURLString
    }
    
    func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request : APIRequestType {
        
        guard let pathURL = URL(string: request.path, relativeTo: URL(string: baseURLString)) else {
            return Fail(error: APIServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        //URL構築
        var urlCompopnents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        
        urlCompopnents.queryItems = request.queryItems
        let request = URLRequest(url: urlCompopnents.url!)
        
        print(request)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase     //スネークケースが変えるため使用
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, URLRequest in  //オペレーター
                data
            }
            .mapError { _ in
                APIServiceError.responseError
            }
            .decode(type: Request.Response.self, decoder: decoder)
            .mapError { error in
                APIServiceError.parseError(error)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()  //Publisherの単純化
    }
}
