//
//  HTTPNewtorkResponse.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

enum HTTPNetworkResponse: String, Error{
    
    case success = "Successful Network Request"
    case authenticationError = "Error Found : You must be Authenticated"
    case badRequest = "Error Found : Bad Request"
    case failed = "Error Found : Network Request failed"
    case serverSideError = "Error Found : Server error"
    
    // Properly checks and handles the status code of the response
    func handleNetworkResponse(for response: HTTPURLResponse) -> Result<String>{
        
        switch response.statusCode {
        case 200...299: return Result.success(HTTPNetworkResponse.success.rawValue)
        case 401: return Result.failure(HTTPNetworkResponse.authenticationError.rawValue)
        case 400...499: return Result.failure(HTTPNetworkResponse.badRequest.rawValue)
        case 500...599: return Result.failure(HTTPNetworkResponse.serverSideError.rawValue)
        default: return Result.failure(HTTPNetworkResponse.failed.rawValue)
        }
    }
}
