//
//  NetworkRouter.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/9/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
protocol NetworkRouter: class {
    
    associatedtype Endpoint: EnpointType
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
