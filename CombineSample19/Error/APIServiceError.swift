//
//  APIServiceError.swift
//  CombineSample19
//
//  Created by cmStudent on 2022/07/18.
//

import Foundation

enum APIServiceError: Error{

    case invalidURL     //URLが不正
    
    case responseError     //githubAPIのレスポンスにエラーがある
    
    case parseError(Error)      //JSONをパースした時に発生したエラー
}

