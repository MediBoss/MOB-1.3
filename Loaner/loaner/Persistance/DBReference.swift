//
//  DBReference.swift
//  loaner
//
//  Created by Medi Assumani on 2/28/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import Foundation
import Firebase

struct DBReference{
    
    
    static func saveItemToDatabase(for item: Item){
        
        let mutatingItem = item
        let ref = Database.database().reference()
        let key = ref.child("Items").childByAutoId().key
        ref.child("Items").child(key!).setValue(mutatingItem.toDictionary())
        

    }
    
    static func uploadProfileImage(_ image: UIImage, key: String, completion: @escaping(_ url:URL?)->()) {
        
        let storageRef = Storage.storage().reference().child("items/\(key)")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                
                storageRef.downloadURL { url, error in
                    completion(url)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    /// Returns all the loaners objects saved on the DB
    static func index() -> [Item]{
        
        // TODO : ADD GDC TO PERFOMR THIS OPERATION CONCURENLTY
        var items = [Item]()
        var ref: DatabaseReference!
        ref = Database.database().reference().child("items")
        ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            for rest in postDict{
                guard let restDict = rest.value as? [String: String ] else { continue }
                guard let name = restDict["name"],
                    let notes = restDict["notes"],
                    let url = restDict["imageUrl"],
                    let loanee = restDict["loanee"] else { return }
                
                let person = Loanee(name: "", contactNumber: "")
                let item = Item(itemTitle: name, notes: notes, itemImageURL: url, loanee: person)
                
                items.append(item)
            }
        })
        
        return items
    }
}
