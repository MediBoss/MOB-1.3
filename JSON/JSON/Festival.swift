//
//  Festival.swift
//  JSON
//
//  Created by Medi Assumani on 2/7/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

struct Participant: Codable{
    let name: String
    let id: String
}

struct City: Codable{
    let name: String
    let id: String
}

enum FestivalType: Codable{
    case music
    case food
    case cinema
}

struct Festival: Codable{
    let date: Date
    let name: String
    let city: City
    let lineup: [Participant]
    let type: FestivalType
}
