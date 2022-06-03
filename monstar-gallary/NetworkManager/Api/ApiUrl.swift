//
//  ApiUrl.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

enum ApiUrl : String{
   
    
    case void = "/"
    case photos = "photos"


static let values = [photos]
    
    static func getApiCallProtectionLevel(url : String)-> [ApiCallProtectionLevel]{
        switch mapToApiUrl(url: url) {
        case  .photos:
            return [.none]
        default:
            return [.none]
        }
        
    }
    
    
    
    private static func mapToApiUrl(url : String)->ApiUrl{
        
        if (url.contains(ApiUrl.photos.rawValue)){
            return .photos
        }
        return .void
    }
    
    
}
