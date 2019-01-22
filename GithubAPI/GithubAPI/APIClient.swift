//
//  APIClient.swift
//  MVVMBlog
//
//  Created by GILL/Samsung on 16/01/19..
//  Copyright © 2018 Gill. All rights reserved.
//

import UIKit

// This APIClient will be called by the viewModel to get our top 100 app data.
class APIClient: NSObject {
    
    // the completion handler will be executed after our top 100 app data is fetched
    // our completion handler will include an optional array of NSDictionaries parsed from our retrieved JSON object
    func fetchAppList(_ query:String, completion: @escaping ([NSDictionary]?) -> Void) {
        var urlStr = "https://api.github.com/search/repositories?sort=stars&order=desc"
        urlStr = urlStr + "&q=language:" + query
        print(urlStr)
        // unwrap our API endpoint
        guard let url = URL(string: urlStr) else {
            print("Error unwrapping URL"); return }
        
        // create a session and dataTask on that session to get data/response/error
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            // unwrap our returned data
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                // create an object for our JSON data and cast it as a NSDictionary
                // .allowFragments specifies that the json parser should allow top-level objects that aren't NSArrays or NSDictionaries.
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    // create an array of dictionaries from
                    if let apps = responseJSON.value(forKeyPath: "items") as? [NSDictionary] {
                        
                        // set the completion handler with our apps array of dictionaries
                        completion(apps)
                    }
                }
            } catch {
                // if we have an error, set our completion with nil
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }

}
