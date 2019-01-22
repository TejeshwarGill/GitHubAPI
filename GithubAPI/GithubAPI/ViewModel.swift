//
//  ViewModel.swift
//  MVVMBlog
//
//  Created by GILL/Samsung on 16/01/19..
//  Copyright © 2018 Gill. All rights reserved.
//

import UIKit

class ViewModel: NSObject {

    var apiClient: APIClient!
    
    var apps: [NSDictionary]?
    
    //This function is what directly accesses the apiClient to make the API call
    func getApps(_ query:String, completion: @escaping () -> Void) {
        
        //call on the apiClient to fetch the apps
        apiClient.fetchAppList(query) { (arrayOfAppsDictionaries) in
            
            //Put this block on the main queue because our completion handler is where the data display code will happen and we don't want to block any UI code.
            DispatchQueue.main.async {
                
                //assign our local apps array to our returned json
                self.apps = arrayOfAppsDictionaries
                
                //call our completion handler because it is in this completion that we will reload data in our view controller collectionView
                completion()
            }
        }
    }
    
    // MARK: - values to display in our collection view controller
    func numberOfItemsToDisplay(in section: Int) -> Int {
        return apps?.count ?? 0
    }
    
    func appTitleToDisplay(for indexPath: IndexPath) -> String {
        return apps?[indexPath.row].value(forKeyPath: "name") as? String ?? ""
    }
    
    func appDescriptionToDisplay(for indexPath: IndexPath) -> String {
        return apps?[indexPath.row].value(forKeyPath: "description") as? String ?? ""
    }
    
    func appImageDisplay(for indexPath: IndexPath) -> String {
        guard let owner = apps?[indexPath.row].value(forKeyPath: "owner") as? [String:AnyObject] else {
            return ""
        }
        return owner["avatar_url"] as? String ?? ""
    }
}














