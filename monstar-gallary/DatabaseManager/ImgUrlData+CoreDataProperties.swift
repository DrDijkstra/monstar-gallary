//
//  ImgUrlData+CoreDataProperties.swift
//  Monstar Lab
//
//  Created by Sanjay on 5/6/22.
//
//

import Foundation
import CoreData


extension ImgUrlData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImgUrlData> {
        return NSFetchRequest<ImgUrlData>(entityName: "ImgUrlData")
    }

    @NSManaged public var id: String?
    @NSManaged public var raw: String?
    @NSManaged public var thumb: String?

}

extension ImgUrlData : Identifiable {

}
