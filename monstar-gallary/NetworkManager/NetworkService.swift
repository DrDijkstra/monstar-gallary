//
//  NetworkService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


protocol NetworkService {
    func getPhotosBy(pageNumber:String,  gwCallback: @escaping (ApiGwCallResult<ApiPhotosResponse>) -> Void) -> Void
}
