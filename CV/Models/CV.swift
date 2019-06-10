//
//  CV.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-09.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//

struct CV: Codable {
    
    struct Experience: Codable {
        let companyName: String
        let companyLogoUrlAddress: String?
        let role: String
        let from: String
        let to: String?
        let description: String
    }
    
    struct Education: Codable {
        let universityName: String
        let universityLogoUrlAddress: String?
        let degree: String
        let from: String
        let to: String?
    }
    
    let name: String
    let summary: [String]
    let experience: [Experience]
    let education: [Education]
    let skills: [String]
}
