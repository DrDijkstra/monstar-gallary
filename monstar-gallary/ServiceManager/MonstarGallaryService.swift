//
//  MonstarGallaryService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation



public protocol MonstarGallaryService {
    
    func checkUserStatus(mobileNumber : String, callback : @escaping (ApiCallResult<String>) -> Void) -> Void
}
