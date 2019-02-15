//
//  ViewController.swift
//  DailyPlanet
//
//  Created by Thomas Vandegriff on 2/7/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var incrementNumber = 2
    @IBOutlet weak var tableview: UITableView!
    var peopleVariable = [Person](){
        didSet{
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchHeaderData()
        //fetchNasaDailyImage()
        fetchStarWars(page: 1)
        //TODO: Call function to fetch image data here
        
    }
    
    
    // ACTIVITY I
    func fetchHeaderData() {

        let defaultSession = URLSession(configuration: .default)

        // Create URL
        let url = URL(string: "https://httpbin.org/headers")

        // Create Request
        let request = URLRequest(url: url!)

        // Create Data Task
        let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

            print("data is: ", data!)
            print("response is: ", response!)

        })
        dataTask.resume()
    }

     // Activity II
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
                                    //self.nasaDailyImageView.image = image
                                }
                            }
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    
    // Activity III
    func fetchStarWars(page: Int){
        
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://swapi.co/api/people/")
        let request = URLRequest(url: url!)
        
        session.dataTask(with: request) { (data, res, err) in
            
            if err == nil {
                guard let unwrappedData = data, let unwrappedResponse = res as? HTTPURLResponse else { return }
                if unwrappedResponse.statusCode == 200{
                    
                    if let mime = unwrappedResponse.mimeType{
                        if mime == "application/json"{
                            
                            do{
                                let result = try JSONDecoder().decode(People.self, from: unwrappedData)
                                guard let people = result.results else { return }
                                self.peopleVariable = people
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleVariable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! HomePageTableViewCell
        let currPerson = peopleVariable[indexPath.row]
        
        cell.nameLabel.text = currPerson.name
        cell.genderLabel.text = currPerson.gender
        cell.heightLabel.text = currPerson.height
        
        return cell
    }
    
    // gets called everytime user scroll
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastItem = peopleVariable.count - 1
        if indexPath.row == lastItem{
            loadMoreStarWarsPeople(number: incrementNumber)
            if incrementNumber <= 8{
                incrementNumber += 1
            }
        }
    }
    
    func loadMoreStarWarsPeople(number: Int){
        
        let nextPageURL = "https://swapi.co/api/people/?page=\(number)"
        fetchStarWars(page: number)
    }
    
    func fetchMoreStarWars(with url: String){
        
        let session = URLSession(configuration: .default)
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            
            let dataTask = session.dataTask(with: request) { (data, res, err) -> Void in
                
                if err == nil{
                    guard let response = res as? HTTPURLResponse, let unwrappedata = data else { return }
                    if response.statusCode == 200{
                        
                        do{
                            let result = try JSONDecoder().decode(Person.self, from: unwrappedata)
                            
                        } catch{
                            print("Error Decoding data \(error.localizedDescription)")
                        }
                    }
                }
            }
            
            dataTask.resume()
        }
    }
}

