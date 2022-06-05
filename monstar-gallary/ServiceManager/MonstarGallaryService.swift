//
//  MonstarGallaryService.swift
//  monstar-gallary
//
//  Created by Sanjay on 3/6/22.
//

import Foundation



public protocol MonstarGallaryService {
    func getPhotosBy(page: String, callback: @escaping (ApiCallResult<ImageUrlListEntity>) -> Void) -> Void
}
