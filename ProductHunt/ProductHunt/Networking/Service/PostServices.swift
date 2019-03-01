//
//  PostServices.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

struct PostServices{
    
    static let shared = PostServices()
    let parameters = [
        "sort_by": "votes_count",
        "order": "desc",
        "per_page": "20",
        
        "search[featured]": "true"
    ]
    
    func getPosts(_ completion: @escaping (Result<[Product]>?,_ error: String?) -> ()) {
        
        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .posts, with: parameters, and: .get)
            URLSession.shared.dataTask(with: request) { (data, res, err) in
                
                if err == nil{
                    
                    if let response = res as? HTTPURLResponse {
                        let handledResponse = HTTPNetworkResponse.handleNetworkResponse(for: response)
                        switch handledResponse {

                        case .success:
                            guard let unwrappedData = data else { return completion(nil, HTTPNetworkError.noData.rawValue) }
                            
                            do{
                                let result = try? JSONDecoder().decode(ProductList.self, from: unwrappedData)
                                let posts = result?.posts
                                completion(Result.success(posts), nil)
                                
                            }catch {
                                completion(nil, HTTPNetworkError.decodingFailed.rawValue)
                            }
                            
                        case .failure(let networkFailureError):
                            completion(nil, networkFailureError)
                        }
                    }
                   
                }else{
                    // Handle data task error
                    completion(nil, HTTPNetworkError.dataTaskFailed.rawValue)
                }
            }.resume()
        } catch {
            // Handle error form NetworkRequest Struct
            completion(nil, HTTPNetworkError.badRequest.rawValue)
        }
        
    }
}
