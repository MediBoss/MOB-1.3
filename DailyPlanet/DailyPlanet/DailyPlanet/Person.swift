//
//  Person.swift
//  DailyPlanet
//
//  Created by Medi Assumani on 2/12/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import Foundation

struct Person: Codable{
    
    var name: String?
    var gender: String?
    var height: String?
}


struct People: Codable{
    var results: [Person]?
}
