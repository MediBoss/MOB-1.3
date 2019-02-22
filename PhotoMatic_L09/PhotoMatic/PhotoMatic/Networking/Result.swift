//
//  Result.swift
//  PhotoMatic
//
//  Created by Medi Assumani on 2/21/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import Foundation
import UIKit

enum PhotoFetchResult {
    case success([Photo])
    case failure(Error)
}

public enum ImageFetchResult {
    case success(UIImage)
    case failure(Error)
}
