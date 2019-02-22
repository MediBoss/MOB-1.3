//
//  HTTPNetworkError.swift
//  PhotoMatic
//
//  Created by Medi Assumani on 2/21/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import Foundation


public enum FlickrAPIError: Error {
    case invalidJSONData
}

public enum ImageRequestError: Error {
    case imageCreationError
}
