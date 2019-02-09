//
//  ParametersEncoding.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/9/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

protocol ParameterEncoder {
    
    /// Method to encode the parameters of a url request
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
