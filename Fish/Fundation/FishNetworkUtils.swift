//
//  FishNetworkUtils.swift
//  Fish
//
//  Created by yaoyuan on 2020/12/16.
//  Copyright © 2020 Tutor. All rights reserved.
//

import UIKit

class FishNetworkUtils {
//    https://wx1.sinaimg.cn/or360/5cfc088ely1gnyqowx8x1j20u00lfmzk.jpg size: 378*270
    class func fetchRemoteImage(downloadUrl: String, completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: downloadUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                print(error ?? "")
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}
