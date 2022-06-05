//
//  DataabaseService.swift
//  monstar-gallary
//
//  Created by Sanjay on 5/6/22.
//

import Foundation


protocol DatabaseService {
    func saveImageUrlData(urlData:ImgUrlData,  callback: @escaping (DbCallResult<String>) -> Void) -> Void
    func fetchImageUrlData(id: Int, callback:  @escaping (DbCallResult<ImageUrlEntity>) -> Void) -> Void
    func deleteImageUrlData( callback:  @escaping (DbCallResult<String>) -> Void) -> Void
    
}
