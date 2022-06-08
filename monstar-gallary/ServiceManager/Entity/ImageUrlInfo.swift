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
    let width:String?
    let height:String?
    
    init(photoInfo: PhotoInfo) {
        self.raw = photoInfo.urls?.raw
        self.full = photoInfo.urls?.full
        self.regular = photoInfo.urls?.regular
        self.small = photoInfo.urls?.small
        self.thumb = photoInfo.urls?.thumb
        self.width = photoInfo.width
        self.height = photoInfo.height
    }
    
}
