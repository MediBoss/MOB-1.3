//
//  HTTPNetworkRequest.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

struct HTTPNetworkRequest {
    
    static let headers = [
        
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(Constant.TOKEN)",
        "Host": "api.producthunt.com"
        
    ]
    
    static func configureHTTPRequest(from route: Route, with parameters: HTTPParameters, and method: HTTPMethod) throws -> URLRequest {
        
        guard let url = URL(string: "\(Constant.PRODUCT_HUNT_API_BASE_URL)\(route.rawValue)") else { fatalError("Erro while unwrapping url")}
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        try configureParameters(parameters: parameters, headers: headers, request: &request)
        
        return request
    }
    
    // Configures the parameters by encoding them
    static func configureParameters(parameters: HTTPParameters?,
                                         headers: HTTPHeaders?,
                                         request: inout URLRequest) throws {

        do {

            if let headers = headers, let parameters = parameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: parameters)
                
                request.allHTTPHeaderFields = headers
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }

    // Appends additional http headers besides application/headers
//    fileprivate func addAdditionalHeaders(for headers: HTTPHeaders?, request: inout URLRequest){
//
//        guard let unwrappedHeaders = headers else { return }
//        for (key,value) in unwrappedHeaders{
//            request.setValue(value, forHTTPHeaderField: key)
//        }
//    }
}
