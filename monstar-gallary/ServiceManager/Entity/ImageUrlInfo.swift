//
//  ImageUrlEntity.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


public class ImageUrlData{
    let raw: String?
    let full:String?
    let regular:String?
    let small:String?
    let thumb:String?
    let heightMultiplier:String?
    
    init(res: PhotoInfo) {
        self.raw = res.urls?.raw
        self.full = res.urls?.full
        self.regular = res.urls?.regular
        self.small = res.urls?.small
        self.thumb = res.urls?.thumb
        
       
        
        let width = res.width?.doubleValue ?? 1
        let height = res.height?.doubleValue ?? 1
        
        let heightMultiplier:Double = height/width
        
        self.heightMultiplier = String(heightMultiplier)
    }
    
}
