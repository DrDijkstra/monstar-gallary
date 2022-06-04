//
//  AppConfig.swift
//  monstar-gallary
//
//  Created by Sanjay on 4/6/22.
//

import Foundation

public class AppConfig {
    

   
    #if PROD
        static let serverUrl = "https://api.unsplash.com"
    #endif
       
    #if DEV
        static let  serverUrl = "https://api.unsplash.com"
    #endif
    
    
    
    
}

