//
//  QuakeWeb+CoreDataProperties.swift
//  EarthquakeAPIInvasiveCode
//
//  Created by Paul Wallace on 10/19/17.
//  Copyright © 2017 Paul Wallace. All rights reserved.
//
//

import Foundation
import CoreData


extension QuakeWeb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuakeWeb> {
        return NSFetchRequest<QuakeWeb>(entityName: "QuakeWeb")
    }

    @NSManaged public var link: String?
    @NSManaged public var quakeLoc: QuakeLoc?

}
