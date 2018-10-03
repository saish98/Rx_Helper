//
//  APIProvider.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import Moya
import Result

var plugins : [PluginType] {
    return [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter) , NetworkConsoleLogger()]
}

public func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

internal let apiProvider = MoyaProvider<APIProvider>(plugins : plugins)

public enum APIProvider {
    case create(name: String, job: String)
}

extension APIProvider : TargetType {
    public var baseURL: URL {
        return URL(string: "https://reqres.in")!
    }
    
    public var path: String {
        switch self {
        case .create(_, _):
            return "/api/users"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .create:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case let .create(name, job):
            return .requestParameters(parameters: ["name": name, "job": job], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    public var validationType: ValidationType {
        switch self {
        case .create:
            return .successCodes
        }
    }
}

class NetworkConsoleLogger : PluginType {
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("""
            API :- \(String(describing: result.value?.response?.url?.absoluteString))
            Response Code :- \(String(describing: result.value?.response?.statusCode))
            """)
    }
}
