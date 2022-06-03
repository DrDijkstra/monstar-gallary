//
//  ApiUrl.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

enum ApiUrl : String{
   
    
    case void = "/"
    case checkUserStatus = "api/user/check-user-status-for-log-in"
    


static let values = [checkUserStatus]
    
    static func getApiCallProtectionLevel(url : String)-> [ApiCallProtectionLevel]{
        switch mapToApiUrl(url: url) {
        case .checkUserStatus:
            return [.none]
        default:
            return [.none]
        }
        
    }
    
    
    
    private static func mapToApiUrl(url : String)->ApiUrl{
        
        if (url.contains(ApiUrl.checkUserStatus.rawValue)){
            return .checkUserStatus
        }
        return .void
    }
    
    
}
