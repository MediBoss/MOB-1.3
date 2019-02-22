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
    
}

