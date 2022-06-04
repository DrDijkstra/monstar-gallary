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
    

    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
    

    
}

