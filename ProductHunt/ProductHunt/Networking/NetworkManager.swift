//
//  ProductServices.swift
//  ProductHunt
//
//  Created by Medi Assumani on 1/25/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

class NetworkManager{
    
    static let shared =  NetworkManager()
    
    let urlSession = URLSession.shared
    enum Result<T> {
        case success(T)
        case failure(Error)
    }
    
    enum EndPointError: Error {
        case couldNotParse
        case noData
        case HTTPResponseError
        case FragmentResponse
    }
    
    
    enum EndPoints {
        case posts
        case comments(postId: Int)
        
        func getPath() -> String{
            switch self {
            case .posts:
                return "posts/all"
            case .comments:
                return "comments"
            }
        }
        
        func getHttpMethod() -> String{
            return "GET"
        }
        
        func getHeaders() -> [String: String]{
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "Bearer \(Constant.TOKEN)",
                "Host": "api.producthunt.com"
            ]
        }
        
        func getParameters() -> [String: String]{
            
            switch self {
            case .posts:
                return [
                    "sort_by": "votes_count",
                    "order": "desc",
                    "per_page": "20",
                    
                    "search[featured]": "true"
                ]
                
            case let .comments(postId):
                return [
                    "sort_by": "votes",
                    "order": "asc",
                    "per_page": "20",
                    
                    "search[post_id]": "\(postId)"
                ]
            }
        }
        
        func paramsToString() -> String {
            let parameterArray = getParameters().map { key, value in
                return "\(key)=\(value)"
            }
            
            return parameterArray.joined(separator: "&")
        }
    }
    
    
    private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        
        let stringParams = endPoint.paramsToString()
        let path = endPoint.getPath()
        let fullURL = URL(string: Constant.PRODUCT_HUNT_API_BASE_URL.appending("\(path)?\(stringParams)"))!
        var request = URLRequest(url: fullURL)
        request.httpMethod = endPoint.getHttpMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders()
        
        return request
    }
    
    
    func getPosts(_ completion: @escaping (Result<[Product]>) -> Void) {
        
        
        let request = makeRequest(for: .posts)
        let task = urlSession.dataTask(with: request) { data, response, error in
            // Check for errors.
            if let error = error {
                return completion(Result.failure(error))
            }
            
            if error == nil{
                
                guard let unwrappedData = data, let unwrappedResponse = response as? HTTPURLResponse else { return completion(Result.failure(EndPointError.noData)) }
                
                switch unwrappedResponse.statusCode{
                    
                case 200:
                    
                    let results = try? JSONDecoder().decode(ProductList.self, from: unwrappedData)
                    guard let products = results?.posts else { return completion(Result.failure(EndPointError.FragmentResponse))}
                    completion(Result.success(products))
                    
                case 400:
                    print("Bad Request")
                case 401:
                    print("Unauthorize Request")
                    
                default:
                    print("Server Side error")
                }
                
            }else{
                
                // If an erro was found during the API Request
                return completion(Result.failure(error!))
            }
            
        }
        
        task.resume()
    }
    
    
    func getComments(_ postId: Int, completion: @escaping (Result<[Comment]>) -> Void) {
        
        let commentsRequest = makeRequest(for: .comments(postId: postId))
        let task = urlSession.dataTask(with: commentsRequest) { data, response, error in
            if let error = error {
                return completion(Result.failure(error))
            }
            
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            
            guard let result = try? JSONDecoder().decode(CommentApiResponse.self, from: data) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            
            DispatchQueue.main.async {
                completion(Result.success(result.comments))
            }
        }
        
        task.resume()
    }
}
