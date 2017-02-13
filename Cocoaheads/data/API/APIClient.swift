//
//  APIClient.swift
//  Cocoaheads
//
//  Created by Vitor Mesquita on 13/02/17.
//  Copyright © 2017 Vitor Mesquita. All rights reserved.
//


import Moya
import RxSwift
import Moya_ObjectMapper

let APIProvider = RxMoyaProvider<APITarget>(endpointClosure: { (target) -> Endpoint<APITarget> in
    let endpoint: Endpoint<APITarget> = Endpoint<APITarget>(url: "\(target.baseURL)\(target.path)", sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding, httpHeaderFields: ["Accept": "application/json; charset=utf-8"])
    
    var httpHeaderFields = [String: String]()
    return endpoint
    
}, plugins: [NetworkLoggerPlugin(verbose: true)])

enum APITarget {
    case getRepositories(name: String)
}

extension APITarget: TargetType {
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    var baseURL: URL { return APIClient.baseURL}
    
    var method: Moya.Method {
        switch self {
        case .getRepositories:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var path: String {
        switch self {
        case .getRepositories(let query):
            return "/search/repositories?q=\(query)"
        }
    }
    
    var sampleData: Data {return Data()}
    var task: Task {return .request}
}

class APIClient {
    
    static var baseURL: URL { return URL(string: "https://api.github.com")!}
    
    static func getRepositories(byName name: String) -> Observable<[Repository]?> {
        return APIProvider.request(.getRepositories(name: name))
            .mapObject(RepositoriesResponse.self)
            .map({ (repositoriesResponse) -> [Repository]? in
                return repositoriesResponse.repositories
            })
    }
}
