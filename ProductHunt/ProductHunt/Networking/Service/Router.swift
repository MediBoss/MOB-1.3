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
    
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared
        do{
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            
        }catch {
            completion(nil, nil, error)
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from endpoint: EndpointTypeDelegate) throws -> URLRequest {
        
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path),
                                 cachePolicy: .reloadIgnoringLocalCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = endpoint.HTTPMethod.rawValue
        
        do{
            
            switch endpoint.task {
            case .request:
                // set the header value if the task is a request
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(bodyParameters: let bodyParameters,
                                    urlParameters: let urlParameters):
                
                try self.configureParameters(bodyParametes: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
                // if we need to configure the parameters
                
            case .requestParametersAndHeaders(bodyParameters: let bodyParameters,
                                              urlParameters: let urlParameters,
                                              additionHeaders: let additionalParameters):
                
                self.addAdditionalHeaders(for: additionalParameters, request: &request)
                try self.configureParameters(bodyParametes: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            default:
                print("Unknown error occured when building the request")
            }
            
            return request
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
    
    // Appends additional http headers besides application/headers
    fileprivate func addAdditionalHeaders(for headers: HTTPHeaders?, request: inout URLRequest){
        
        guard let unwrappedHeaders = headers else { return }
        for (key,value) in unwrappedHeaders{
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
