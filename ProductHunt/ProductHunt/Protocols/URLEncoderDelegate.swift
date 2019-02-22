//
//  ParameterEncoderDelegate.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/9/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

protocol URLEncoderDelegate {
    static func encodeParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters) throws
    static func setHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders) throws
}
