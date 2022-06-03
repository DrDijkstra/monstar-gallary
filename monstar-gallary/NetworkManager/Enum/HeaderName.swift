//
//  HeaderName.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

enum HeaderName : String{
    case contentType = "Content-Type"
    case authToken = "X-KM-AUTH-TOKEN"
    case refreshToken = "X-KM-REFRESH-TOKEN"
    static let contentTypeJson = "application/json;UTF-8"

}
