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
    
    func getPosts(_ completion: @escaping (Result<[Product]?>,_ error: String?) -> ()) {
        
        
    }
}
