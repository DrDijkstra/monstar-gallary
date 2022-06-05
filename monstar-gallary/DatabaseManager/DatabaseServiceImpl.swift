//
//  DatabaseServiceImpl.swift
//  monstar-gallary
//
//  Created by Sanjay on 5/6/22.
//

import Foundation
import UIKit
import CoreData

class DatabaseServiceImpl: DatabaseService {
    func deleteImageUrlData(callback: @escaping (DbCallResult<String>) -> Void) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ImgUrlData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            callback(.success(sc: "successfully deleted"))
        } catch let error as NSError {
            callback(.failure(error: "can not deleted"))
        }
    }
    
    func fetchImageUrlData(id: Int, callback: @escaping (DbCallResult<ImageUrlData>) -> Void) {
        let fetchRequest:NSFetchRequest<ImageUrlData>
        fetchRequest = ImageUrlData.fetchRequest()
        let strId = String(id)
        fetchRequest.predicate = NSPredicate(
            format: "id = %@", strId
        )
        
        do{
            let object = try context.fetch(fetchRequest)
            callback(.success(sc: object[0]))
            
        }
        catch{
            callback(.failure(error: "data saving failure"))
        }
        
        
    }
    
    
    static let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    
    
    func saveImageUrlData(urlData: ImgUrlData, callback: @escaping (DbCallResult<String>) -> Void) {
        
        let imageUrlData = NSEntityDescription.insertNewObject(forEntityName: "ImageUrlData", into: context) as! ImageUrlData
        imageUrlData.raw = urlData.full
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
    
    public init() {
        
    }
    
    
    
}
