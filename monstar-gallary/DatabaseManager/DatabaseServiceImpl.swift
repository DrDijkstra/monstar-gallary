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
    func fetchImageUrlDataList(idList: [Int]) -> [ImgUrlData]? {
        let fetchRequest:NSFetchRequest<ImgUrlData>
        fetchRequest = ImgUrlData.fetchRequest()
        var strId:String = ""
        
        var strPredicate = ""
        for (i,id) in idList.enumerated(){
            if i == idList.count - 1{
                break
            }
            strId = String(id)
            strPredicate += "id = \"\(strId)\" OR "
            
        }
        
        strId = String(idList[idList.count - 1])
        
        strPredicate += "id = \"\(strId)\""
        //print("strPredicate ", strPredicate)
        
        
        do{
            let object = try context.fetch(fetchRequest)
           
            return object
            
        }
        catch{
            return nil
        }
        
        
    }
    
    
    
    func deleteImageUrlData(callback: @escaping (DbCallResult<String>) -> Void) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ImgUrlData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            callback(.success(sc: "successfully deleted"))
        } catch _ as NSError {
            callback(.failure(error: "can not deleted"))
        }
    }
    
    func fetchImageUrlData(id: Int)->ImgUrlData? {
        let fetchRequest:NSFetchRequest<ImgUrlData>
        fetchRequest = ImgUrlData.fetchRequest()
        let strId = String(id)

        fetchRequest.predicate = NSPredicate(
            format: "id = \"\(strId)\""
        )
        
        do{
            let object = try context.fetch(fetchRequest)
           
            return object[0]
            
        }
        catch{
            return nil
        }
        
        
    }
    
    
    static let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    
    
    func saveImageUrlData(urlData: ImageUrlData, callback: @escaping (DbCallResult<String>) -> Void) {
        
        let imageUrlData = NSEntityDescription.insertNewObject(forEntityName: "ImgUrlData", into: context) as! ImgUrlData
        imageUrlData.raw = urlData.full
        imageUrlData.thumb = urlData.thumb
        imageUrlData.heightMultiplier = urlData.heightMultiplier
        
        imageUrlData.id = String(UserDefaults.lastImageIndex)
        
        do{
            try context.save()
            UserDefaults.lastImageIndex = UserDefaults.lastImageIndex + 1
            callback(.success(sc: "data saved successfully"))
            
        }
        catch{
            callback(.failure(error: "data saving failure"))
        }
    }
    
    public init() {
        
    }
    
    
    
}
