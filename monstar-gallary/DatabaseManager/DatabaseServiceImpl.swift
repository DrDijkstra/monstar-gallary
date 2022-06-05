//
//  DatabaseServiceImpl.swift
//  monstar-gallary
//
//  Created by Sanjay on 5/6/22.
//

import Foundation
import UIKit
import CoreData

class DatabaseServiceImpl: DataabaseService {
    func fetchImageUrlData(id: Int, callback: @escaping (DbCallResult<ImgUrlData>) -> Void) {
        
    }
    
    
    static let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    
    
    func saveImageUrlData(urlData: ImgUrlData, callback: @escaping (DbCallResult<String>) -> Void) {
        
        let imageUrlData = NSEntityDescription.insertNewObject(forEntityName: "ImgUrlData", into: context) as! ImageUrlData
        imageUrlData.raw = urlData.raw
        imageUrlData.thumb = urlData.thumb
        UserDefaults.lastImageIndex = UserDefaults.lastImageIndex + 1
        imageUrlData.id = String(UserDefaults.lastImageIndex)
        
        do{
            try context.save()
            callback(.success(sc: "data saved successfully"))
            
        }
        catch{
            callback(.failure(error: "data saving failure"))
        }
    }
    
    
    
    
}
