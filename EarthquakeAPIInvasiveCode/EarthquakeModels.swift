//
//  EarthquakeModels.swift
//  EarthquakeAPIInvasiveCode
//
//  Created by Paul Wallace on 10/19/17.
//  Copyright © 2017 Paul Wallace. All rights reserved.
//

import Foundation

struct Earthquake : Codable {
    let title: String
    let magnitude: String
    let latitude: String
    let longitude: String
    let depth: String
    let location: String
    let link: String
    let date: Date
    
    enum CodingKeys : String, CodingKey {
        case title
        case magnitude
        case latitude
        case longitude
        case depth
        case location
        case link
        case date = "date_time"
    }
}
