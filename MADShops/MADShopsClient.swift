//
//  MADShopsClient.swift
//  MADShops
//
//  Created by Daniel Ruiz on 15/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation

struct MADShopsClient {
    
    let endpoint = "https://madrid-shops.com/json_new/getShops.php"
    let session = URLSession.shared
    
    let requestUrl: URL
    
    init() {
        requestUrl = URL(string: endpoint)!
    }
    
    func fetchShops(completion: @escaping (ShopsJSONResponse) -> ()) {
        session.dataTask(with: requestUrl, completionHandler: { (data, _, error) in
            
            if let error = error {
                print("Error while fetching shops: \(error.localizedDescription)")
            }
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! ShopsJSONResponse {
                
                completion(json)
                
                print("Done fetching shops!")

            } else {
                print("No results 🙁...")
            }
        }).resume()
    }
    
}
