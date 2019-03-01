//
//  Loanee.swift
//  loaner
//
//  Created by Medi Assumani on 2/28/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import Foundation
import UIKit
import Contacts.CNContact

struct Loanee {
    var name: String
    var profileImage: UIImage = UIImage(named: "no profile image")!
    var contactNumber: String?
    var contactInfo: CNContact! = nil
    
    init(name: String, profileImage: UIImage, contactNumber: String?) {
        self.name = name
        self.profileImage = profileImage
        self.contactNumber = contactNumber
    }
    
    init(name: String, profileImage: UIImage, contactNumber: String?, contact: CNContact) {
        self.name = name
        self.profileImage = profileImage
        self.contactNumber = contactNumber
        self.contactInfo = contact
    }
    
    convenience init(name: String, contactInfo: Int){
        self.name = name
        self.contactInfo = contactInfo
    }
}

