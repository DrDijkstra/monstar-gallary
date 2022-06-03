//
//  Data+Utf8.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

extension Data{
    func convertDataToUtf8String() -> String?{
        
        let rawString = String(data : self,encoding : .utf8) ?? ""
        if (rawString.isEmpty){
            return "{}"
        }else{
            return rawString
        }
        
    }

    
}

