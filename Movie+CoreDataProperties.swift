//
//  Movie+CoreDataProperties.swift
//  iOSDataPersistence
//
//  Created by Christian Rojas on 18/02/22.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int16
    @NSManaged public var data: String?

}
