//
//  AlamoFireApiService.swift
//  Lesson10
//
//  Created by Thomas Vandegriff on 2/26/19.
//  Copyright © 2019 Make School. All rights reserved.
//

    /*** AlamoFireApiService.swift is an API Service client designed to fetch, post and process data to and from the JSONPlaceholder web service:
 
        - Using Alamofire
            https://github.com/Alamofire/Alamofire
    ***/

import Alamofire
import Foundation

class AlamoFireApiService {
    
    // TODO: Create a function that implements a POST request using Using Alamofire
    static func getAlamoFire(){
        
        Alamofire.request("https://jsonplaceholder.typicode.com/todos/1").responseJSON { (response) in
            if response.result.error == nil {
                let data = response.result.value as? [String: Any]
                let title = data!["title"] as? String
            
            }else{
                print("Error Found : \(response.result.error?.localizedDescription)")
            }
        }
    }

    static func postAlamofire(){
        let parameters: [String: Any] = ["userID": 123, "title": "Eat Lunch", "completed": true]
        Alamofire.request("https://jsonplaceholder.typicode.com/todos" , method: .post, parameters: parameters).responseJSON { (response) in
            
            if response.result.error == nil {
                let data = response.result.value as? [String: Any]
                
            }else{
                print("Error Found : \(response.result.error?.localizedDescription)")
            }
        }
    }
}
