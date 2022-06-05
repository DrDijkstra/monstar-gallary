//
//  ImageUrlData+CoreDataProperties.swift
//  monstar-gallary
//
//  Created by Sanjay on 5/6/22.
//
//

import Foundation
import CoreData


extension ImageUrlData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageUrlData> {
        return NSFetchRequest<ImageUrlData>(entityName: "ImageUrlData")
    }

    @NSManaged public var raw: String?
    @NSManaged public var thumb: String?
    @NSManaged public var id: String?

}

extension ImageUrlData : Identifiable {

}
