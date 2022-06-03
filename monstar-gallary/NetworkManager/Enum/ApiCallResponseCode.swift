//
//  Api.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

public enum ApiCallResponseCode : String{
    case gwSuccess = "000.000.000.000"
    case responseDecodeError = "sdk:100.100.100.101"
    case requestEncodeError = "sdk:100.100.100.102"
    case unknown = "sdk:100.100.100.100"
}
