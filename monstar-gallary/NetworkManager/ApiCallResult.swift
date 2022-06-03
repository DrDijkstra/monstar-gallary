//
//  ApiCallResult.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation

public enum ApiCallResult <T>{
    case success(sc : T)
    case failure(error : ResponseStatus)
}
