//
//  ProductServices.swift
//  ProductHunt
//
//  Created by Medi Assumani on 1/25/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

class NetworkManager{
    
    
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
    }
    
    static func getProducts(completion: @escaping([Product]) -> ()){
        
        let urlSession = URLSession.shared
        var baseURL = "https://api.producthunt.com/v1/posts"
        //let query = "posts/all?sort_by=votes_count&order=desc&search[featured]=true&per_page=20"
        let fullURL = URL(string: baseURL)!
        var request = URLRequest(url: fullURL)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(Constant.TOKEN)",
            "Host": "api.producthunt.com"
        ]
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            if error == nil{
                
                guard let unwrappedData = data, let unwrappedResponse = response as? HTTPURLResponse else { return }
                
                switch unwrappedResponse.statusCode{
                    
                case 200:
                    
                    let results = try? JSONDecoder().decode(ProductList.self, from: unwrappedData)
                    guard let unwrappedProducts = results?.posts else { return }
                    completion(unwrappedProducts)
                    
                default:
                    print("Error with status code \(unwrappedResponse.statusCode)")
                }
                
            }else{
                print(error?.localizedDescription)
            }
        }
        task.resume()
    }
    
}
