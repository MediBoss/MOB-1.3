//
//  ViewController.swift
//  DailyPlanet
//
//  Created by Thomas Vandegriff on 2/7/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nasaDailyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //fetchHeaderData()
        //fetchNasaDailyImage()
        fetchStarWars()
        //TODO: Call function to fetch image data here
        
    }

    //MARK: Data Fetch functions
    
//    func fetchHeaderData() {
//
//        let defaultSession = URLSession(configuration: .default)
//
//        // Create URL
//        let url = URL(string: "https://httpbin.org/headers")
//
//        // Create Request
//        let request = URLRequest(url: url!)
//
//        // Create Data Task
//        let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//
//            print("data is: ", data!)
//            print("response is: ", response!)
//
//        })
//        dataTask.resume()
//    }

     // CODE BASE for In-Class Activity I
    func fetchNasaDailyImage() {
     
        //TODO: Create session configuration here
        let defaultSession = URLSession(configuration: .default)
    
     

     
        //TODO: Create URL (...and send request and process response in closure...)
        if let url = URL(string: "https://apod.nasa.gov/apod/image/1902/PlaneTrailMoon_Staiger_1555.jpg") {
     
           //TODO: Create Request here
            var request = URLRequest(url: url)
//            request.addValue("Gl9bWsrHUhkxVfxVsZLfccWDPle26X20mIDXNc9V", forHTTPHeaderField: "api_key")
//            request.setValue("true", forHTTPHeaderField: "hd")
            
     
             //Create Data Task...
            let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                
                if error == nil{
                    
                    guard let unwrappedResponse = response as? HTTPURLResponse else { return }
                    
                    if unwrappedResponse.statusCode == 200{
                        
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                
                                //TODO: Insert downloaded image into imageView
                                DispatchQueue.main.async {
                                    self.nasaDailyImageView.image = image
                                }
                            }
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    
    func fetchStarWars(){
        
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://swapi.co/api/starships/")
        let request = URLRequest(url: url!)
        
        session.dataTask(with: request) { (data, res, err) in
            
            if err == nil {
                guard let unwrappedData = data, let unwrappedResponse = res as? HTTPURLResponse else { return }
                if unwrappedResponse.statusCode == 200{
                    
                    if let mime = unwrappedResponse.mimeType{
                        if mime == "application/json"{
                            
                            do{
                                let result = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                                print(result)
                            }catch{
                                print("Error Found")
                            }
                        }
                    }
                }
                
            }
        }
        .resume()
    }
}

