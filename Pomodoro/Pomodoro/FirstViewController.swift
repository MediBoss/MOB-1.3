//
//  FirstViewController.swift
//  Pomodoro
//
//  Created by Medi Assumani on 1/21/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    var completedCycles = 0
    @IBOutlet weak var messageLabel: UILabel!
    
    deinit {
        //ACTION: Remove observers
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ACTION: Add observers
        
        
    }
    
    @objc func receivedNotification(_ notification:Notification) {
        // ACTION: Update value of completed cycles
        // ACTION: Update message label
        
    }
}
