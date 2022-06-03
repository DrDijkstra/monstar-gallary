//
//  ResponseStatus.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

public class ResponseStatus{
    public var code :String
    public var message:String?
    public var devMessage:String?
    public var responseRawString: String?
    public var response: Any?
    
    public init(responseCode:String, message:String?, devMessage:String?, response: Any? = nil) {
        self.code = responseCode
        self.message = message
        self.devMessage = devMessage
        self.response = response
        
    }
}
