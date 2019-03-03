//
//  Item.swift
//  loaner
//
//  Created by Erick Sanchez on 8/17/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Contacts.CNContact

struct Item : Codable{
    
    var itemTitle: String
    var notes: String
    var itemImageURL: String?
    var itemImage: UIImage
    var loanee: Loanee?
    
    init(itemTitle: String) {
        self.itemTitle = itemTitle
    }
    
    init(itemTitle: String, notes: String, itemImageURL: String, loanee: Loanee?) {
        
        self.itemTitle = itemTitle
        self.notes = notes
        self.itemImageURL = itemImageURL
        self.loanee = loanee

    }
    
    // Encodes and structures the item object as a dictionary
    func toDictionary() -> [String: Any]{
        
        let data = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        
        return json as! [String: Any]
    }
    
    mutating func assignLoanee(to contact: CNContact?) {
        if let contact = contact {
            
            //contact image
            var profileImage = UIImage(named: "no profile image")!
            if let dataFromContact = contact.imageData,
                let imageFromContact = UIImage(data: dataFromContact) {
                profileImage = imageFromContact
            }
            
            //validate contact has at least one number
            guard let firstPhoneNumber = contact.phoneNumbers.first else {
                return print("this contact needed to have at least one number from the ContactPickerVc")
            }
            
            //update loanee var
            let newLoanee = Loanee(
                name: contact.givenName,
                profileImage: profileImage,
                contactNumber: firstPhoneNumber.value.stringValue,
                contact: contact
            )
            
            loanee = newLoanee
        } else {
            loanee = nil
        }
    }
}
