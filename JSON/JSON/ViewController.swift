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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "Stephen is blind"
        
        return cell
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        path(forResource: "festivals", ofType: ".json")
    }

    func path(forResource name: String?, ofType fileExtension: String){
        
        let path = Bundle.main.path(forResource: "locations", ofType: ".json")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            let contents = try? Data(contentsOf: url, options: .alwaysMapped)
            
            print(contents)
        }
    }
    
}

