//
//   CommentsView.swift
//  ProductHunt
//
//  Created by Medi Assumani on 1/25/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//
import Foundation
import UIKit

class CommentsView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var comments: [Comment] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var productID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        anchorCommentsTableView()
        updateComments()
    }
    
    
    private func anchorCommentsTableView(){
        
        tableView.anchor(top: view.topAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 0,
                              enableInsets: false)
    }
    
    func updateComments() {
        NetworkManager.shared.getComments(productID) { result in
            switch result {
            case let .success(comments):
                self.comments = comments
            case let .failure(error):
                print(error)
            }
        }
    }
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delegate = self as! UITableViewDelegate
        tableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: CommentsTableViewCell.id)
        
        return tableView
    }()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.id, for: indexPath) as! CommentsTableViewCell
        
        let comment = comments[indexPath.row]
        cell.commentBody.text = comment
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
