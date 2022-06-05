//
//  UserDefaultsManager.swift
//  monstar-gallary
//
//  Created by Sanjay on 5/6/22.
//

import Foundation

extension UserDefaults {
    class var lastImageIndex : Int64 {
        get {
            if let index = UserDefaults.standard.value(forKey: "com.monstar.gallary.lastImageIndex") as? Int64 {
                return index
            }
            return 0
        }
        
        set (lastIndexImage) {
            UserDefaults.standard.set(lastIndexImage, forKey: "com.monstar.gallary.lastImageIndex")
            UserDefaults.standard.synchronize()
        }
    }
}
