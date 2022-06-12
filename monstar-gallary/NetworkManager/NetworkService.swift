//
//  NetworkService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation


protocol NetworkService {
    func getPhotosBy(request: PhotoListRequest,  gwCallback: @escaping (ApiGwCallResult<ApiPhotosResponse>) -> Void) -> Void
}
