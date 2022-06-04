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
    
    init(url: UrlInfo) {
        self.raw = url.raw
        self.full = url.full
        self.regular = url.regular
        self.small = url.small
        self.thumb = url.thumb
    }
    
}
