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
                request.setValue("application/", forHTTPHeaderField: <#T##String#>)
                // if the task is a request
                
            case .requestParameters(bodyParameters: let bodyParameters,
                                    urlParameters: let urlParameters):
                
                try self.configureParameters(bodyParametes: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
                // if we need to configure the parameters
                
            case .requestParametersAndHeaders(bodyParameters: <#T##Parameters?#>, urlParameters: <#T##Parameters?#>, additionHeaders: <#T##HTTPHeaders?#>)
            default:
                <#code#>
            }
        } catch {
            throw error
        }
    }
    
    // Configures the parameters by encoding them
    fileprivate func configureParameters(bodyParametes: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        
        do {
            if let bodyParameters = bodyParametes {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
}
