//
//  JSONParameterEncoder.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/9/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder{
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do{
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-TYPE")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
