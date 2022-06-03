//
//  ApiGwCallResult.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


enum ApiGwCallResult<T : ApiGwResponse>{
    case success(sc : T)
    case failure(error : ResponseStatus)
}
