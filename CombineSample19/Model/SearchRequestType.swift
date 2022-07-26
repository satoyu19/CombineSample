//
//  SearchRequestType.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/18.
//

import Foundation

protocol APIRequestType{
        
    associatedtype Response: Decodable
    
    var path: String{ get }
    var queryItems: [URLQueryItem]? { get }
}

struct SearchRepositoryRequest: APIRequestType{
    
    typealias Response = SearchRepositoryResponse
    
    private let apiKey = "06b438f9ea3e6be7"

    private var query: String
    let path = "/hotpepper/gourmet/v1"  //エンドポイント
    
    var queryItems: [URLQueryItem]?
    
    //range: 検索半径, order: ソート
    init(query: String){
        self.query = query
        self.queryItems = [.init(name: "key", value: apiKey), .init(name: "lat", value: "35.6983891"), .init(name: "lng", value: "139.6981327"), .init(name: "range", value: "5"), .init(name: "order", value: "4"), .init(name: "format", value: "json"), .init(name: "keyword", value: query)]
    }
}
