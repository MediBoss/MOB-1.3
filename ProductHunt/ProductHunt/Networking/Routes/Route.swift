//
//  PostEndPoint.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public typealias HTTPParameters = [String: Any]
public typealias HTTPHeaders = [String: String]


public enum Route: String{
    
    case posts = "posts/all"
    case comments = "comments"
    

    
    func getParameters() -> HTTPParameters {
        
        switch self {
        case .posts:
            return [
                "sort_by": "votes_count",
                "order": "desc",
                "per_page": "20",
                "search[featured]": "true"
            ]
            
        case let .comments:
            return [
                "sort_by": "votes",
                "order": "asc",
                "per_page": "20",
//                "search[post_id]": "\(postId)"
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

