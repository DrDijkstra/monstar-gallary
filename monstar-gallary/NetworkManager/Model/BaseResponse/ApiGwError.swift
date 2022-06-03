//
//  ApiGwError.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation
import Alamofire


enum ApiGwError: Error {
    case network(error: Error?) // Capture any underlying Error from the URLSession API
    case responseError(error:Error?, gwErrorStatus : ApiGwResponse?)
    case requestBodySerialization(error: Error?, data:Data?)
    case responseBodyDeserialization(error: Error?, data: Data?)
    case unknownError(error:Error?, httpStatusCode : Int?)
}

