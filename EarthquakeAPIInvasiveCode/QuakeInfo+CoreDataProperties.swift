//
//  QuakeInfo+CoreDataProperties.swift
//  EarthquakeAPIInvasiveCode
//
//  Created by Paul Wallace on 10/19/17.
//  Copyright © 2017 Paul Wallace. All rights reserved.
//
//

import Foundation
import CoreData


extension QuakeInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuakeInfo> {
        return NSFetchRequest<QuakeInfo>(entityName: "QuakeInfo")
    }

    @NSManaged public var magnitude: Float
    @NSManaged public var title: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var quakeLoc: QuakeLoc?

}
