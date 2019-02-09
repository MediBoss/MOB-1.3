//
//  HTTPTask.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/9/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public enum HTTPTask {
    
    case request
    case download
    case upload
    
    case requestParameters(bodyParameters: Parameters?), urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
