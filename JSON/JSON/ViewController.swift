//
//  ViewController.swift
//  JSON
//
//  Created by Medi Assumani on 2/7/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var festivals =  [Festival](){
        didSet{
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        path(forResource: "festivals", ofType: ".json")
    }

    func path(forResource name: String?, ofType fileExtension: String){
        let path = Bundle.main.path(forResource: name, ofType: fileExtension)
        if let path = path {
            let url = URL(fileURLWithPath: path)
            let contents = try? Data(contentsOf: url, options: .alwaysMapped)
            
            decodeContents(for: contents!)
        }
    }
    
    func decodeContents(for data: Data){
        
        let decodedFestivals = try? JSONDecoder().decode([Festival].self, from: data)
        guard let unwrappedFestivals = decodedFestivals else { return }
        self.festivals = unwrappedFestivals
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return festivals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! FestivalTableViewCell
        var currentFestivale = festivals[indexPath.row]
        cell.nameLabel.text = currentFestivale.name
        cell.dateLabel.text = currentFestivale.date
        cell.countLabel.text = "\(currentFestivale.lineup!.count) Artists"
        
        return cell
    }
}

