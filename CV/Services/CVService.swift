//
//  CVService.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-10.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//

import Foundation

struct CVService {
    static func loadCV(with urlAddress: String, completionHandler: @escaping (CV?, CVError?) -> Void) {
        guard let url = URL(string: urlAddress) else
        {
            completionHandler(nil, .badURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (jsonData, response, error) -> Void in
            guard error == nil, let jsonData = jsonData else {
                completionHandler(nil, .badConnection)
                return
            }
            do {
                let decoder = JSONDecoder()
                let cv = try decoder.decode(CV.self, from: jsonData)
                completionHandler(cv, nil)
                
            } catch {
                completionHandler(nil, .badJSON)
            }
            }.resume()
    }
}
