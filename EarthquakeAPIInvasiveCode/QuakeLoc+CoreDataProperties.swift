//
//  QuakeLoc+CoreDataProperties.swift
//  EarthquakeAPIInvasiveCode
//
//  Created by Paul Wallace on 10/19/17.
//  Copyright © 2017 Paul Wallace. All rights reserved.
//
//

import Foundation
import CoreData


extension QuakeLoc {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuakeLoc> {
        return NSFetchRequest<QuakeLoc>(entityName: "QuakeLoc")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var depth: Float
    @NSManaged public var location: String?
    @NSManaged public var quakeInfo: QuakeInfo?
    @NSManaged public var quakeWeb: QuakeWeb?

}
