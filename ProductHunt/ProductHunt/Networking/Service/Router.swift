//
//  Router.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/12/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

class Router<Endpoint: EndpointTypeDelegate>: NetworkRouterDelegate{
    
    private var task: URLSessionTask?
    
    func request(_ route: Router<Endpoint>.Endpoint, completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared
        do{
            
        }catch {
            completion(nil, nil, error)
        }
    }
    
    func cancel() {
        // code to cancel a network request
    }
    
    private func buildRequest(from endpoint: EndpointTypeDelegate) throws -> URLRequest {
        
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path),
                                 cachePolicy: .reloadIgnoringLocalCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = endpoint.HTTPMethod.rawValue
        
        do{
            
            switch endpoint.task {
            case .request:
                
                // if the task is a request
                
            case .requestParameters(bodyParameters: <#T##Parameters?#>, urlParameters: <#T##Parameters?#>):
                // if we need to configure the parameters
                
            case .requestParametersAndHeaders(bodyParameters: <#T##Parameters?#>, urlParameters: <#T##Parameters?#>, additionHeaders: <#T##HTTPHeaders?#>)
            default:
                <#code#>
            }
        } catch {
            throw error
        }
    }
}
