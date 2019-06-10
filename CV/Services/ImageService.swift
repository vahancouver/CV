//
//  ImageService.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-10.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//

import UIKit

struct ImageService {
    static func downloadImage(with urlAddress: String?, completionHandler: @escaping (UIImage?, CVError?) -> Void) {
         DispatchQueue.global(qos: .background).async {
            guard let urlAddress = urlAddress,
                let url = URL(string: urlAddress),
                let data = try? Data(contentsOf: url),
                let image: UIImage = UIImage(data: data) else {
                    completionHandler(nil, .badImage)
                    return
            }
            DispatchQueue.main.async {
                completionHandler(image, nil)
            }
        }
    }
}

