//
//  NetworkService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


protocol NetworkService {
    func checkUserStatus(moibleNumber:String,  gwCallback: @escaping (ApiGwCallResult<ApiPhotosResponse>) -> Void) -> Void
}
