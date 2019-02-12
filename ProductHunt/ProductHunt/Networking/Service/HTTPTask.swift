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
    
    // Used when the task is to make an HTTP Request
    case request
    // Used when the task is to download data from a server
    case download
    // Used when the task is to upload data to a server
    case upload
    
    // Used for http request that comes with parameters only
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    // Used for http request that comes with parameters and headers
    case requestParametersAndHeaders(bodyParameters: Parameters?,urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
