//
//  EnpointTypeDelegate.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/9/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

// The protocol defines each API endpoint that the App might make requests to
protocol EndpointTypeDelegate {
    
    var baseURL: URL { get }
    var path: String { get }
    var HTTPMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
