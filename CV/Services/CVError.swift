//
//  CVError.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-10.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//

enum CVError: Error {
    case badURL
    case badConnection
    case badJSON
    case badImage
    
    var description: String {
        switch self {
        case .badURL:
            return "Url conversion failed"
        case .badConnection:
            return "Connection failed"
        case .badJSON:
            return "Parsing json failed"
        case .badImage:
            return "Image download failed"
        }
    }
}

