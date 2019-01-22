//
//  MainViewController.swift
//  MVVMBlog
//
//  Created by GILL/Samsung on 16/01/19.
//  Copyright © 2018 Gill. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty == false {
            self.makeQuery(query: searchBar.text ?? "")
        }else{
            self.makeQuery(query: "")
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.makeQuery(query: "")
    }
    func makeQuery(query:String){

    }
}
