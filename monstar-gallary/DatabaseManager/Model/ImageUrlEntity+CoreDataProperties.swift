//
//  ImageUrlEntity+CoreDataProperties.swift
//  monstar-gallary
//
//  Created by Sanjay on 5/6/22.
//
//

import Foundation
import CoreData


extension ImageUrlEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageUrlEntity> {
        return NSFetchRequest<ImageUrlEntity>(entityName: "ImageUrlEntity")
    }

    @NSManaged public var full: String?
    @NSManaged public var thumb: String?
    @NSManaged public var id: String?

}

extension ImageUrlEntity : Identifiable {

}
